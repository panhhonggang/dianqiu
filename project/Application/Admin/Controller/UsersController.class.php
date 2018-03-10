<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 前台用户控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class UsersController extends CommonController 
{
    public function get_map()
    {
        if($this->get_level()){
            $ma['bd.vid'] = $_SESSION['adminuser']['id'];
            $users=M('devices')
            ->where($ma)
            ->alias('d')
            ->join('pub_binding bd ON d.id=bd.did', 'LEFT')
            ->field('d.uid')
            ->select();
            $ids = array_column($users,'uid');
            $ids = empty($ids)?['-1']:$ids;
            return ['u.id'=> ['in',$ids]];
        }
    }

	/**
     * 前台用户列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
        // 根据用户昵称进行搜索
        $map = [];
        $map=array_merge($map,$this->get_map());
        if (!empty($_GET['key']) && !empty($_GET['value'])) {
            switch ($_GET['key']) {
                case '1':
                    $map['nickname'] = array('like',"%{$_GET['value']}%");
                    break;
                case '2':
                    $map['d.device_code'] = array('like',"%{$_GET['value']}%");
                    break;
                case '3':
                    $map['phone'] = array('like',"%{$_GET['value']}%");
                    break;
                default:
                    # code...
                    break;
            }
        }
        $user = D('users');

        $total = $user
            ->where($map)
            ->alias('u')
            ->join('__WECHAT__ w ON u.open_id=w.open_id', 'LEFT')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->field('d.device_code,d.name,d.address,d.phone,w.*,u.*,cd.uid,cd.did')
            ->count();
        $page  = new \Think\Page($total,10);
        $pageButton =$page->show();

        $userlist = $user
            ->where($map)
            ->alias('u')
            ->join('__WECHAT__ w ON u.open_id=w.open_id', 'LEFT')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->field('d.device_code,d.name,d.address,d.phone,w.*,u.*,cd.uid,cd.did')
            ->limit($page->firstRow.','.$page->listRows)
            ->select();
            // ->getAll();
        // dump($userlist);
        $this->assign('list',$userlist);
        $this->assign('button',$pageButton);
        $this->display();
    }

    /**
     * 推送信息方法
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function message($id)
    {   
        if (IS_POST) {
 
            // 接收数据
            // 尊敬的${content}，测试喝水建议。
            $phone = $_POST['phone'];
            $content = '用户' . $_POST['name'] . '您好！'.$_POST['content'];

            // 开始接口代码
            $sms = new \Org\Util\SmsDemo;
            $response = $sms::sendSms(
                "阿里云短信测试专用", // 短信签名
                "SMS_112475574", // 短信模板编号
                $phone, // 短信接收者
                Array(  // 短信模板中字段的值
                    "content"=>$content,
                    "product"=>"dsd"
                ),
                "123"   // 流水号,选填
            );

            // 信息推送状态判断
            if($response->Code=='OK'){
                $this->error('消息推送成功！');
            }else{
                $this->error('消息推送失败，错误码：' . $response->Code);
            }

        }else{
            $user = M('users');
            $userinfo = $user->where('id='.$id)->select();
            $this->assign('list',$userinfo);
            $this->display();
        }
    }

    public function user_info()
    {
        $map['open_id'] = I('get.open_id');
        // 微信用户信息
        $user = M('wechat')->where($map)->find();

        // 显示用户基础信息
        $userinfo = M('users')
            ->alias('u')
            ->where($map)
            ->join('__DEVICES__ d ON u.id=d.uid', 'LEFT')
            ->select();

        // 充值记录
        $did = array();
        $code = array();
        foreach ($userinfo as $key => $value) {
            $did[]  = $value['id'];
            $code[] = $value['device_code'];
        }
        $where['_query'] = "status=1";
        $where['did']    = array('in',$did);
        $flow    = M('flow')->where($where)->order('addtime desc')->select();
        $balance = M('devices_statu')
            ->where(['DeviceID' => ['in',$code]])
            ->field('DeviceID,ReFlow')
            ->select();
        // 分配数据
        $assign = [
            'userinfo' => json_encode($userinfo),
            'user'     => json_encode($user),
            'flow'     => json_encode($flow),
            'balance'  => json_encode($balance),
        ];
        $this->assign($assign);
        $this->display();

    }


    /**
     * 编辑用户方法
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function edit($id,$status)
    {
        $users = M("users");
        $data['status'] = $_GET['status'];
        $res = $users->where('id='.$id)->save($data); 
        if ($res) {
             $this->redirect('users/index');
        } else {
            $this->error('修改失败啦！');
        }
    }

    /**
     * 用户充值流水列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function flow()
    {
        // 根据用户昵称进行搜索
        $map = [];
        $map=array_merge($map,$this->get_map());

        if (!empty($_GET['key']) && $_GET['key'] == 1 && strlen($_GET['value'])) {
            $map['d.name'] = array('like',"%{$_GET['value']}%");
        }
        if (strlen($_GET['mode'])) {
           $map['mode'] = $_GET['mode'];
        }
        $flow = M('flow');
        $map['_query'] = "status=1";
        $total = $flow->where($map)
            ->alias('f')
            ->join('__DEVICES__ d ON f.did=d.id','LEFT')
            ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
            ->field('f.*,d.name,u.balance')
            ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list = $flow->where($map)->limit($page->firstRow.','.$page->listRows)
            ->alias('f')
            ->join('__DEVICES__ d ON f.did=d.id','LEFT')
            ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
            ->field('f.*,d.name,u.balance')
            ->select();
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();        
    }

    
    // 解除用户绑定
    public function unbind()
    {
        $code['device_code'] = I('post.device_code');
        $data = [
            'uid' => null,
            'name' => null,
            'address' => null,
            'phone' => null,
        ];
        $device = M('devices');
        $current_devices = M('current_devices');

        $deviceInfo = $device->where($code)->find();
        $did = $deviceInfo['id'];
        $uid = $deviceInfo['uid'];
        $device->startTrans();
        $current_devices->startTrans();
        $current_device = $current_devices->where('did='.$did)->find();
        if(!empty($current_device)){
            $bind_device = $device->where('uid='.$uid)->select();
            if(count($bind_device) == 1){
                $current_status = $current_devices->where('did='.$did)->delete();
            } else {
                foreach ($bind_device as $key => $value) {
                    $device_tmp[$key] = $value['id'];
                    if($value['id'] == $did){
                        unset($device_tmp[$key]);
                    }
                    $device_tmp[0] = $device_tmp[$key];
                }
                $current_status = $current_devices->where('uid='.$uid)->save(['did'=>$device_tmp[0]]);
            }
            if($current_status){
                $current_devices->commit();
            } else {
                $current_devices->rollback();
                $this->ajaxReturn(['code'=>203,'msg'=>'解绑失败']);
            }
        }

        $status['status'] = 0;
        $orders = M('orders')->where('device_id='.$deviceInfo['id'])->find();
        $flow = M('flow')->where('did='.$deviceInfo['id'])->find();
        // 订单记录判断回滚
        if($order){
            $orders_status = M('orders')->where('device_id='.$deviceInfo['id'])->save($status);
        } else {
            $orders_status = true;
        }

        if($flow){
            $flow_status = M('flow')->where('did='.$deviceInfo['id'])->save($status);
        } else {
            $flow_status = true;
        }

        $device_status = $device->where('id='.$deviceInfo['id'])->save($data);
        // 设备状态判断回滚
        if($device_status && $orders_status){
            $device->commit();
            $this->ajaxReturn(['code'=>200,'msg'=>'解绑成功']);
        } else {
            $device->rollback();
            $this->ajaxReturn(['code'=>203,'msg'=>'解绑失败']);
        }
    }
}
