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
        // 搜索功能
        if(trim(I('post.address'))){
            $map['d.address'] = array('like','%'.trim(I('post.address')).'%');
        }
        trim(I('post.nickname')) ? $map['w.nickname'] = array('like','%'.trim(I('post.nickname')).'%'): '';
        trim(I('post.device_code')) ? $map['d.device_code'] = array('like','%'.trim(I('post.device_code')).'%'): '';
        trim(I('post.phone')) ? $map['d.phone'] = array('like','%'.trim(I('post.phone')).'%'): '';
        trim(I('post.login_ip')) ? $map['u.login_ip'] = array('like','%'.trim(I('post.login_ip')).'%'): '';
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });
        $minupdatetime = strtotime(trim(I('post.mincreated_at')));
        $maxupdatetime = strtotime(trim(I('post.maxcreated_at')));
        if (!empty($maxupdatetime) && !empty($maxupdatetime)) {
            $map['u.created_at'] = array(array('egt',$minupdatetime),array('elt',$maxupdatetime+24*60*60));
        }
        // if (empty($maxupdatetime) && $maxupdatetime < 0) {
        //     $map['u.created_at'] = array(array('egt',$minupdatetime));
        // }
        if($this->get_level()){
            $map['bd.vid'] = $_SESSION['adminuser']['id'];

        }
        $user = D('users');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $user
            ->where($map)
            ->alias('u')
            ->join('__WECHAT__ w ON u.open_id=w.open_id', 'LEFT')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->join('__BINDING__ bd ON d.id = bd.did ', 'LEFT')
            ->field('u.id,w.nickname,d.device_code,d.phone,d.address,u.login_time,u.login_ip,d.updatetime')
            ->order('u.created_at desc')
            ->select();
            $arr = ['updatetime'=>['date','Y-m-d H:i:s'],'login_time'=>['date','Y-m-d H:i:s']];
            $data = replace_array_value($data,$arr);
            $filename = '用户列表数据';
            $title = '用户列表';
            $cellName = ['用户id','姓名','当前设备id','手机号','地址','最后登录时间','登录IP','更新日期'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }        

        $total = $user
            ->where($map)
            ->alias('u')
            ->join('__WECHAT__ w ON u.open_id=w.open_id', 'LEFT')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->join('__BINDING__ bd ON d.id = bd.did ', 'LEFT')
            ->field('d.device_code,d.name,d.address,d.phone,w.*,u.*,cd.uid,cd.did,d.updatetime')
            ->count();
        $page  = new \Think\Page($total,10);
        $pageButton =$page->show();

        $userlist = $user
            ->where($map)
            ->alias('u')
            ->join('__WECHAT__ w ON u.open_id=w.open_id', 'LEFT')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->join('__BINDING__ bd ON d.id = bd.did ', 'LEFT')
            ->field('d.device_code,d.name,d.phone,w.*,u.*,d.address,cd.uid,cd.did,d.updatetime')
//            ->field('d.device_code,.name,d.address,d.phone,u.*,w.nickname,cd.uid,cd.did,d.updatetime')
            ->limit($page->firstRow.','.$page->listRows)
            ->order('u.created_at desc')
            ->select();
            // ->getAll();

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
//        dump(I(''));die;
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
        if(!empty($did)){
            $where['did']    = array('in',$did);
        }
        $flow    = M('flow')->where($where)->order('addtime desc')->select();


        $balance=[];
        if(!empty($code)){
             $balance = M('devices_statu')
            ->where(['DeviceID' => ['in',$code]])
            ->field('DeviceID,ReDay')
            ->select();
        }

        $flow[0]['reday'] = $balance['0']['reday'];

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
        // 搜索功能
        $map = array(
            'f.mode' => trim(I('get.mode')),
            'f.status' => "1",
        );
        $map['d.name'] = trim(I('get.name')) ? array('like','%'.trim(I('get.name')).'%'): '';
        // 充值金额范围搜索
        $minmoney = trim(I('get.minmoney'))?:false;
        $maxmoney = trim(I('get.maxmoney'))?:false;
        if (is_numeric($maxmoney)) {
            $map['f.money'][] = array('elt',$maxmoney*100);
        }
        if (is_numeric($maxmoney )) {
            $map['f.money'][] = array('egt',$minmoney*100);
        }
        // 充值量搜索
        $minflow = trim(I('get.minflow'))?:false;
        $maxflow = trim(I('get.maxflow'))?:false;
        if (is_numeric($maxflow)) {
            $map['f.flow'][] = array('elt',$maxflow);
        }
        if (is_numeric($maxflow)) {
            $map['f.flow'][] = array(array('egt',$minflow));
        }
        // 当前余量搜索
        $mincurrentflow = trim(I('get.mincurrentflow'))?:false;
        $maxcurrentflow = trim(I('get.maxcurrentflow'))?:false;
        if ($maxcurrentflow) {
            $map['f.currentflow'][] = array('elt',$maxcurrentflow);
        }
        if ($mincurrentflow) {
            $map['f.currentflow'][] = array('egt',$mincurrentflow);
        }
        // 充值时间
        $minaddtime = strtotime(trim(I('get.minaddtime')))?:false;
        $maxaddtime = strtotime(trim(I('get.maxaddtime')))?:false;
        if (is_numeric($maxaddtime)) {
            $map['f.addtime'][] = array('elt',$maxaddtime);
        }
        if (is_numeric($minaddtime)) {
            $map['f.addtime'][] = array('egt',$minaddtime);
        }

        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        if($this->get_level()){
            $map['bd.vid'] = $_SESSION['adminuser']['id'];
        }

        $flow = M('flow');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $flow->where($map)
                ->alias('f')
                ->join('__DEVICES__ d ON f.did=d.id','LEFT')
//                ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
                ->join('__DEVICES_STATU__ ds ON d.device_code=ds.DeviceID','LEFT')
                ->join('__BINDING__ bd ON f.did = bd.did ','LEFT')
                ->field('f.id,d.name,f.money,f.flow,ds.reday,f.mode,f.addtime')
                ->order('f.addtime desc')
                ->select();
//            dump($data);exit;
            $arr = [
                'addtime'=>['date','Y-m-d H:i:s'],
                'mode' => ['系统赠送','微信','支付宝'],
                'money'=>['price']

            ];
            $data = replace_array_value($data,$arr);

            $filename = '充值记录数据';
            $title = '充值记录';
            $cellName = ['充值流水id','用户昵称','充值金额','充值流量（天）','账户余量（天）','充值方式','充值时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        $total = $flow->where($map)
            ->alias('f')
            ->join('__DEVICES__ d ON f.did=d.id','LEFT')
//            ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
            ->join('__BINDING__ bd ON d.id = bd.did ','LEFT')
            ->field('f.*,d.name,u.balance')
            ->count();
        $page  = new \Think\Page($total,8);
//        foreach ($map as $k=>$v){
//            $page->parameter .="$k=".urlencode($v);
//        }
        $pageButton =$page->show();

        $list = $flow->where($map)
            ->alias('f')
            ->join('__DEVICES__ d ON f.did=d.id','LEFT')
            ->join('__DEVICES_STATU__ ds ON d.device_code=ds.DeviceID','LEFT')
//            ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
            ->join('__BINDING__ bd ON f.did = bd.did ','LEFT')
            ->limit($page->firstRow.','.$page->listRows)
            ->field('f.*,d.name,ds.reday,bd.vid')
            ->order('f.addtime desc')
            ->select();
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }


    /*
        设备解绑流程：
            1. 获取设备编号
            3.     
        


     */
    // 解除用户绑定
    public function unbind()
    {
        $code['device_code'] = I('post.device_code');
        // $code['device_code'] = 992833445596778;
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
        // print_r($current_device);die;
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
                $this->ajaxReturn(['code'=>201,'msg'=>'解绑失败']);
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
