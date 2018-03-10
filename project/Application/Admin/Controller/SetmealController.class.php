<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 充值套餐控制器
 * 后台用来设置充值套餐和浏览充值套餐的控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class SetmealController extends CommonController 
{
	/**
     * 套餐列表
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
        require_once VENDOR_PATH.'PHPExcel.php';
        $phpExcel = new \PHPExcel();
        // dump($phpExcel);
        $map = array(
            'typename' => trim(I('post.typename')),
            'money' => trim(I('post.money'))*100,
            'flow' => trim(I('post.flow')),
            'describe' => trim(I('post.describe'))
        );
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });
        
        $type = M('setmeal');
        
        $total =$type->where($map)
                    ->join('pub_device_type ON pub_setmeal.tid = pub_device_type.id')
                    ->field('pub_setmeal.*,pub_device_type.typename')
                    ->count();
        $page  = new \Think\Page($total,8);
        D('devices')->getPageConfig($page);
        $pageButton =$page->show();

        $list = $type->where($map)
                    ->limit($page->firstRow.','.$page->listRows)
                    ->join('pub_device_type ON pub_setmeal.tid = pub_device_type.id')
                    ->field('pub_setmeal.*,pub_device_type.typename')
                    ->select();
        // dump($list);die;
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }

    public function add()
    {
        if (IS_POST) {
            // dump($_POST);die;
            $setmeal = D('setmeal');
            $info = $setmeal->create();
           
            if($info){

                $res = $setmeal->add();
                if ($res) {
                    $this->success('套餐设置成功啦！！！',U('setmeal/index'));
                } else {
                    $this->error('套餐设置失败啦！');
                }
            
            } else {
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($setmeal->getError());
            }

        }else{
            $type = M('device_type');
            $list = $type->select();
            $this->assign('list',$list);
            $this->display();
        }
    }

    /**
     * 删除类型方法（废除）
     * 不做删除，只做隐藏，如果要做删除产品类型，请确保产品类型没有被设备所用 
     *
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function del()
    {
        $map['id'] = I("get.id");
        $res = M('setmeal')->where($map)->delete();
        if($res) {
            $this->success("删除成功");
        } else {
            $this->error("删除失败");
        }
    }

    

}