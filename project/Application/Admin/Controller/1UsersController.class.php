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
    	if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");

        $user = D('users');
        $total = $user->where($map)->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $userlist = $user->where($map)->limit($page->firstRow.','.$page->listRows)->getAll();
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
        $map['id'] = I('get.id');

        // 用户信息
        $user = M('users')->where($map)->find();

        $maps['uid'] = $user['id'];
        // 充值记录
        $flow = M('flow')->where($maps)->find();

        // 消费记录
        $consume = M('consume')->where($maps)->find();
        $assign = [
            'user' => json_encode($user),
            'flow' => json_encode($flow),
            'consume' => json_encode($consume),
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
                                ->join('pub_users ON pub_flow.uid = pub_users.id')
                                ->field('pub_flow.*,pub_users.name,pub_users.balance')
                                ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list = $flow->where($map)->limit($page->firstRow.','.$page->listRows)
                                ->join('pub_users ON pub_flow.uid = pub_users.id')
                                ->field('pub_flow.*,pub_users.name,pub_users.balance')
                                ->select();
        // dump($list);die;
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();        
    }

    /**
     * 用户消费记录列表
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function consume()
    {
        // 根据用户昵称进行搜索
        $map = '';
        if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");

        $consume = M('consume');
        $total = $consume->where($map)
                                ->join('pub_users ON pub_consume.uid = pub_users.id')
                                // ->join('pub_card ON pub_consume.icid = pub_card.id')
                                ->field('pub_consume.*,pub_users.name')
                                ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list = $consume->where($map)->limit($page->firstRow.','.$page->listRows)
                                ->join('pub_users ON pub_consume.uid = pub_users.id')
                                // ->join('pub_card ON pub_consume.icid = pub_card.id')
                                ->field('pub_consume.*,pub_users.name,pub_users.balance')
                                ->select();
        // dump($list);die;
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();        
    }   
}
