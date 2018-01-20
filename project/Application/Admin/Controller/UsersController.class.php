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
	/**
     * 前台用户列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
        // 查询条件
        $map = '';
        // if(!empty($_GET['code'])) $map['device_code'] = array('like',"%{$_GET['code']}%");
        if (!empty($_GET['key']) && !empty($_GET['value'])) {
            switch ($_GET['key']) {
                case '1':
                    $map['d.name'] = array('like',"%{$_GET['value']}%");
                    break;
                case '2':
                    $map['d.phone'] = array('like',"%{$_GET['value']}%");                  
                    break;
                case '3':
                    $map['d.address'] = array('like',"%{$_GET['value']}%");
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
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->field('u.*,d.device_code,d.name,d.address,d.phone')
            ->count();
        $page  = new \Think\Page($total,10);
        $pageButton =$page->show();

        $userlist = $user
            ->where($map)
            ->alias('u')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->field('u.*,d.device_code,d.name,d.address,d.phone')
            ->limit($page->firstRow.','.$page->listRows)
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
        $map['u.id'] = I('get.id');

        // 用户信息
        $user = M('users')
            ->alias('u')
            ->where($map)
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->find();

        $maps['u.id'] = $user['uid'];

        // 充值记录
        $flow = M('flow')
            ->alias('f')
            ->where($maps)
            ->join('__DEVICES__ d ON f.did=d.id', 'LEFT')
            ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
            ->field('f.*,d.*')
            ->select();

        $assign = [
            'user' => json_encode($user),
            'flow' => json_encode($flow),
            // 'consume' => json_encode($consume),
            'show' => $show,
        ];
        /*
         * 用户及设备绑定和当前绑定详情
         * 
         * */
        // 用户详情
        $id = $maps['u.id'];

        $userinfo = M('users')
            ->find($id);
        // 用户当前绑定设备
        $current_devices = M('current_devices')
            ->where('cd.uid='.$id)
            ->alias('cd')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->field('d.*')
            ->limit($page->firstRow.','.$page->listRows)
            ->select();
        // 用户绑定设备信息
        $devices = M('devices')
            ->where('uid='.$id)
            ->select();
        foreach ($devices as $key => $value) {
            $device_codes[] = $value['device_code'];
        }

        // 用户绑定设备信息详情
        $device_statu = M('devices_statu')
            ->where(['DeviceID' => ['in',$device_codes]])
            ->alias('ds')
            ->field('ds.*')
            ->limit($page->firstRow.','.$page->listRows)
            ->select();
        $data = ['userinfo'=>$userinfo];
        $data['userinfo']['devices'] = $devices;
        $data['userinfo']['current_devices'] = $current_devices;
        foreach ($data['userinfo']['devices'] as $key => $value) {
            foreach ($device_statu as $key2 => $value2) {
                if ($value['device_code'] == $value2['deviceid']) {
                   $data['userinfo']['devices']["$key"]['device_statu'] = $device_statu["$key2"];
                }
            }            
        }
        
        $assign['userinfo'] = json_encode($data);
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
        $map = '';
        if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");

        $flow = M('flow');
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

    /**
     * 用户消费记录列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    // public function consume()
    // {
    //     // 根据用户昵称进行搜索
    //     $map = '';
    //     if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");

    //     $consume = M('consume');
    //     $total = $consume->where($map)
    //         ->alias('c')
    //         ->where($map)
    //         ->join('__DEVICES__ d ON c.did=d.id', 'LEFT')
    //         ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
    //         ->count();
    //     $page  = new \Think\Page($total,8);
    //     $pageButton =$page->show();

    //     $list = $consume->where($map)->limit($page->firstRow.','.$page->listRows)
    //         ->alias('c')
    //         ->where($map)
    //         ->join('__DEVICES__ d ON c.did=d.id', 'LEFT')
    //         ->join('__USERS__ u ON d.uid=u.id', 'LEFT')
    //         ->select();
    //     // dump($list);die;
    //     $this->assign('list',$list);
    //     $this->assign('button',$pageButton);
    //     $this->display();        
    // }   
}
