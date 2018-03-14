<?php
namespace Home\Controller;
use Think\Controller;

/**
 * 客户报修控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class RepairController extends CommonController 
{
	/**
     * 报修页面
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
        $id = array('id' => $_SESSION['homeuser']['did']);
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
                    'picpath' => $picpath[0],
                    'did' => $_SESSION['homeuser']['did']
                );
                // dump(I('post'));die;
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
            $vid = M('binding')->where('did='.$_SESSION['homeuser']['did'])->field('vid')->find()['vid'];
            $phone=M('vendors')->where('id='.$vid)->field('phone,csphone')->find();
            $this->assign('code',$device_code);
            $this->assign('phone',$phone);
            $this->display();
        }
    }

    // 图片上传
    public function upload()
    {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     5242880 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath  =     './Public/'; // 设置附件上传根目录
        $upload->savePath  =     '/Pic/'; // 设置附件上传（子）目录
        // 上传文件 
        $info   =   $upload->upload();
        if(!$info) {// 上传错误提示错误信息
            return false;
            // $this->error($upload->getError());
        }else{
            // 上传成功
            foreach ($info as $file) {
                // dump($info);die;
                $pic[] = $file['savepath'].$file['savename'];
            }
            // $this->success('上传成功！');
            return $pic;
        }
    }

    
    
}