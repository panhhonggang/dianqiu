<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;

class CardController extends CommonController 
{
    public function index()
    {
        // 查询用户IC卡号 xp_card
        $uid = $_SESSION['homeuser']['id'];
        // 查询用户名下已绑定的卡号
        $icid = M('Card')->field('iccard,status')->where('`uid`='.$uid)->select();

        //分配数据        
        $this->assign('icid',$icid);

        // 显示模板
        $this->display();
    }

    //更新
    //IC卡必须后台存在
    public function add()
    {
    	//判断是否更新IC卡
    	if(IS_POST){	
    		$user = D('Card');
    		
            $info = $user->getIccard();

    		if($info){
                //获取IC卡状态
                $status = $info['status'];
                if($status==0){
                    $res = $user->create();
                    if($res){
                        $data['name'] = $res['name'];
                        $data['studentcode'] = $res['studentcode'];
                        $data['school'] = $res['school'];
                        $data['uid'] = $_SESSION['homeuser']['id'];
                        $data['status'] = 1;
                        $info = $user->where('iccard="'.$_POST['iccard'].'"')->save($data);
                        
                        if($info){
                           //跳转到用户中心
                            $this->success('添加成功',U('Users/mine')); 
                        }else{
                            $this->error('添加失败');
                        }
                    }else{
                        //返回自动验证提示信息
                        $this->error($user->getError());
                    }

                }elseif($status==1){
                    $this->error('该卡已被绑定');
                }else{
                    $this->error('该卡已被挂失');
                }

    		}else{
                $this->error('IC卡号不存在');
            }

    	}else{
            //调用微信JS-SDK类获取签名需要用到的数据
            $weixin = new WeixinJssdk;
            $signPackage = $weixin->getSignPackage();   

            // 分配数据
            $this->assign('signPackage',$signPackage);
    		$this->display();	
    	}
    	
    }

    //解绑
    //解挂后:IC卡处于未绑定状态 ，持卡用户为 null
    public function relieveIC()
    {
        // 接收要修改的卡号
        $iccard = I('numVal');
        $data['status'] = 0;
        $data['uid'] = null;
        $res = M('Card')->where('`iccard`="'.$iccard.'"')->save($data);

        // 检查是否解绑成功
        if($res){
            // 成功返回
            echo 1;
        }else{
            // 失败返回
            echo -1;
        }
    } 

    //挂失
    //挂失：IC卡处于绑定状态
    public function reportTheLossOf()
    {
        // IC卡卡号
        // 接收要修改的卡号
        $iccard = I('numVal');
        $data['status'] = 2;   
        $res = M('Card')->where('`iccard`="'.$iccard.'"')->save($data);

        // 检查是否挂失成功
        if($res){
            // 成功返回
            echo 1;
        }else{
            // 失败返回
            echo -1;
        }

    }

    //解挂
    //解挂后:IC卡处于绑定状态
    public function hangingSolution()
    {
        // IC卡卡号
        // 接收要修改的卡号
        $iccard = I('numVal');
        $data['status'] = 1;   
        $res = M('Card')->where('`iccard`="'.$iccard.'"')->save($data);

        // 检查是否解挂成功
        if($res){
            // 成功返回
            echo 1;
        }else{
            // 失败返回
            echo -1;
        }
    }    

}