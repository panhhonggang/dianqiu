<?php
namespace Admin\Controller;
use Think\Controller;
use Common\Controller\MYExcel;
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
        /*
            Excel导出
         */
        require_once VENDOR_PATH.'PHPExcel.php';
        $phpExcel = new \PHPExcel();
//         dump($_POST);
        // 搜索功能
        $map = array(
            'typename' => trim(I('post.typename')),
            'remodel' => trim(I('post.remodel')),
            'flow' => trim(I('post.flow')),
//
        );
        if (trim(I('post.describe'))) {
            $map['pub_setmeal.describe'] =  array('like','%'.trim(I('post.describe')).'%');
        }
        $minmoney = trim(I('post.minmoney'))?:false;
        $maxmoney = trim(I('post.maxmoney'))?:false;
        if (is_numeric($maxmoney)) {
            $map['pub_setmeal.money'][] = array('elt',$maxmoney*100);
        }
        if (is_numeric($minmoney)) {
            $map['pub_setmeal.money'][] = array('egt',$minmoney*100);
        }
         $minaddtime = strtotime(trim(I('post.mintime')))?:false;
         $maxaddtime = strtotime(trim(I('post.maxtime')))?:false;
         if (is_numeric($maxaddtime)) {
             $map['pub_setmeal.addtime'][] = array('elt',$maxaddtime);
         }
         if (is_numeric($minaddtime)) {
             $map['pub_setmeal.addtime'][] = array('egt',$minaddtime);
         }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        $type = M('setmeal');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $type->where($map)
                    ->join('pub_device_type ON pub_setmeal.tid = pub_device_type.id')
                    ->field('pub_setmeal.id,pub_device_type.typename,remodel,money,flow,describe,pub_setmeal.addtime')
                    ->order('pub_setmeal.addtime desc')
                    ->select();
            $filename = '套餐列表';
            $title = '套餐列表';
            $cellName = ['id','产品类型','充值模式','套餐金额','套餐量(天)','套餐描述','创建时间'];

            // 数组中枚举数值替换
            $arr = [
                'addtime'=>['date','Y-m-d H:i:s'],
                'remodel'=>[
                    '0'=>'流量',
                    '1'=>'时长'
                ],
                'money'=>['price']
            ];
            $data = replace_array_value($data,$arr);

            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }
//        dump($map);
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
                    ->order('pub_setmeal.addtime desc')
                    ->select();
//        dump($list);
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

    public function test()
    {
        $filename = '套餐列表';
        $title = '套餐列表1';
        $cellName = ['id','工单编号','工单标题','电话','类型','内容','地址','结果','时间'];
        $data = D('work')->select();
        // dump($data);die;
        $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
        $myexcel->output();
    }
}
