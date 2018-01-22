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
        // 根据用户昵称进行搜索
        $map = '';
    	if(!empty($_GET['nickname'])) $map['nickname'] = array('like',"%{$_GET['nickname']}%");

        $user = D('users');
        $total = $user
            ->where($map)
            ->alias('u')
            ->join('__WECHAT__ w ON u.open_id=w.open_id', 'LEFT')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->field('d.device_code,d.name,d.address,d.phone,w.*,u.*')
            ->count();
        $page  = new \Think\Page($total,10);
        $pageButton =$page->show();

        $userlist = $user
            ->where($map)
            ->alias('u')
            ->join('__WECHAT__ w ON u.open_id=w.open_id', 'LEFT')
            ->join('__CURRENT_DEVICES__ cd ON u.id=cd.uid', 'LEFT')
            ->join('__DEVICES__ d ON cd.did=d.id', 'LEFT')
            ->field('d.device_code,d.name,d.address,d.phone,w.*,u.*')
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
        foreach ($userinfo as $key => $value) {
            $did[] = $value['id'];
        }
        $flow = M('flow')->where(['did' => ['in',$did]])->select();
        dump($userinfo);
        // 分配数据
        $assign = [
            'userinfo'        => json_encode($userinfo),
            'user'            => json_encode($user),
            'flow'            => json_encode($flow),
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

    
    // 解除用户绑定
    public function unbind()
    {
        $code['device_code'] = I('post.device_code');
        $msg = "";
        $data = [
            'uid' => null,
            'name' => null,
            'address' => null,
            'phone' => null,
        ];
        $device = M('devices');
        $did = $device->where($code)->find()['id'];
        $current_device = M('current_devices')->where('did='.$did)->find();
        $device->startTrans();
        if(!empty($current_device)){
            $res = M('current_devices')->where('did='.$did)->delete();
            $msg = '当前设备';
        }
        $result = M('devices')->where($code)->save($data);
        if($res && $result){
            $device->commit();
            $this->ajaxReturn(['code' => 200, 'msg' => $msg.'解除绑定成功']);
        } else {
            $device->rollback();
            $this->ajaxReturn(['code' => 202, 'msg' => '解除绑定失败']);
        }
    }  


    // $(".unb").click(function(){
    //     var userId = $(this).attr('userId');
    //     layui.use('layer', function(){
    //         var layer = layui.layer;
    //         layer.confirm('确定解除绑定?', {icon: 3, title:'温馨提示'}, function(index){
    //             window.location.href='?id='+userId;
    //             layer.close(index);
                
    //         });
    //     });
    // });
}
