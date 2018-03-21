<?php
namespace Admin\Controller;
use Think\Controller;
use Org\Util\Date;
use Org\Util\Strings;
/**
 * 工单控制器
 * 用来添加工单，浏览工单列表等
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class WorkController extends CommonController 
{
	/**
     * 工单列表
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
        // dump($phpExcel);
        // 搜索功能
        $map = array(
            'pub_work.type' => trim(I('post.type')),
            'pub_work.result' => trim(I('post.result')),
        );
        $map['pub_work.number'] = trim(I('post.number')) ? array('like','%'.trim(I('post.number')).'%'): '';
        $map['pub_work.name'] = trim(I('post.name')) ?  array('like','%'.trim(I('post.name')).'%'): '';
        $map['pub_work.phone'] = trim(I('post.phone')) ? array('like','%'.trim(I('post.phone')).'%'):'';
        $map['pub_work.address'] = trim(I('post.address')) ? array('like','%'.trim(I('post.address')).'%'):'';
//         $mintime = strtotime(trim(I('post.mintime')))?:0;
//        $maxtime = strtotime(trim(I('post.maxtime')))?:-1;
//        if (is_numeric($maxtime)) {
//            $map['pub_work.time'] = array(array('egt',$mintime),array('elt',$maxtime));
//        }
//        if ($maxtime < 0) {
//            $map['pub_work.time'] = array(array('egt',$mintime));
//        }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        if($this->get_level()){
            $map['pub_binding.vid'] = $_SESSION['adminuser']['id'];

        }

        $type = D('work');
        // PHPExcel 导出数据 
        if (I('output') == 1) {
            $data = $type->where($map)
                ->alias('w')
                ->join('pub_devices ON w.dcode = pub_devices.device_code')
                ->join('pub_binding ON pub_devices.id = pub_binding.did ')
                ->field('w.id,w.dcode,w.number,w.name,w.phone,w.type,w.content,w.address,w.result,w.time')
                ->getAll();
            $arr = ['time'=>'Y-m-d H:i:s'];
//            replace_value($data,$arr,'');
            $filename = '工单列表数据';
            $title = '工单列表';
            $cellName = ['id','设备号','工单编号','处理人','处理人电话','维护类型','工作内容','地址','处理结果','处理时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        $total =$type->where($map)
            ->join('pub_devices ON pub_work.dcode = pub_devices.device_code')
            ->join('pub_binding ON pub_devices.id = pub_binding.did ')
            ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();
        $list = $type->where($map)
            ->join('pub_devices ON pub_work.dcode = pub_devices.device_code')
            ->join('pub_binding ON pub_devices.id = pub_binding.did ')
            ->field('pub_devices.*,pub_binding.*,pub_work.*')
            ->order('pub_work.result asc')
            ->limit($page->firstRow.','.$page->listRows)->getAll();
        //exit();

        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }

    public function add()
    {
        if (IS_POST) {
            // dump($_POST);die;
            $device_type = D('work');
            $data = I('post.');
            $data['address'] = $data['address'].$data['add_ress'];
            $data['number'] = $this->getWorkNumber();
            $info = $device_type->create();
            if($info){
                if($data['type'] == 1){
                    $status = ['status'=>2];
                    M('repair')->where('id='.$data['repair_id'])->save($status);
                }
                $res = $device_type->add($data);
                if ($res) {
                    $this->success('工单添加成功啦！！！',U('work/index'));
                } else {
                    $this->error('工单添加失败啦！');
                }
            
            } else {
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($device_type->getError());
            }

        }else{
            $map['id'] = I('id');
            $repairData = M('Repair')->where($map)->field('device_code,address')->find();
            $where['v_id'] = session('adminuser.id');
            $personnelData = M('personnel')->where($where)->field('id,name,phone')->select();
            // dump($repairData);
            $assign = [
                'repairId' => $map['id'],
                'repairData' => $repairData,
                'personnelData' => $personnelData,
            ];
            $this->assign($assign);
            $this->display();
        }
    }

    public function edit($id,$result)
    {
        $work = M("work");
        $repair = M('repair');
        $data['result'] = $_GET['result'];
        $res = $work->where('id='.$id)->save($data); 
        // dump($id);
        if ($res) {
            $repair_id = $work->where('id='.$id)->getField('repair_id');
            if (!$repair_id){
                $this->success('修改成功',U('admin/work/index'));
                return;
            }
            // dump($repair_id);
            if($result == 1){
                $status = ['status'=>3];
            } elseif($result == 2) {
                $status = ['status'=>1];
            } else {
                $status = ['status'=>2];
            }
            $res_repair = $repair->where('id='.$repair_id)->save($status);
            dump($res_repair);
            if($res_repair){
                $this->redirect('work/index');
            }
            // echo 1111;
        } else {
            $this->error('修改失败啦！');
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

    }

    public function personnel()
    {
        try {
            $map['id'] = I('post.id');
            $phone = M('Personnel')->where($map)->getField('phone');
            echo $phone;
        } catch (\Exception $e) {
            $err = [
                'code' => $e->getCode(),
                'msg' => $e->getMessage(),
            ];
            $this->ajaxReturn($err);
        }
    }

    /**
     * 生成工单编号
     * @return [type] [description]
     */
    protected function getWorkNumber()
    {

        do {

            $workNumber =  date('Ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);

        } while(D('work')->where('number='.$workNumber)->getField('id'));
        return $workNumber;
    }
}