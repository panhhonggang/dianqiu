<?php
namespace Home\Controller;
use Think\Controller;

/**
 * 客户报修控制器
 * 
 * @author 陈昌平 <619328391@qq.com>
 */

class MineController extends CommonController 
{
	/**
     * 报修页面
     * @author 陈昌平 
     */
    public function index()
    {	
        $id = ['id' => $_SESSION['homeuser']['did']];
        $device_code = M('devices')->where($id)->find();
        if (IS_POST) {
            // 先处理图片
            $picpath = $this->upload();
            if ($picpath) {
                // 接收用户输入数据
                $repair = D('repair');
                if(!$repair->create()){
                    $this->error($repair->getError());
                };
                $arr = array(
                    'device_code' => I('device_code'),
                    'date' => I('date'),
                    'begin_time' => I('begin_time'),
                    'over_time' => I('over_time'),
                    'name' => I('name'),
                    'phone' => I('phone'),
                    'content' => I('content'),
                    'uid' => $_SESSION['homeuser']['id'],
                    'address' => I('address'),
                    'addtime' => time(),
                    'picpath' => $picpath[0]
                );

            }else{
                $this->error('您没有上传图片，请重新上传');
            }

            // 实例化
            $repair = M('repair');
            if ($repair->add($arr)) {
                $this->success('感谢您的建议，我们会仔细阅读并做出相应调整，谢谢！',U('Index/index'));
            }else{
                $this->error('一不小心服务器偷懒了~');
            }
        }else{
            // 查出该用户昵称和地址等信息显示在页面

            $this->assign('code',$device_code);
            $this->display();
        }
    }    
}