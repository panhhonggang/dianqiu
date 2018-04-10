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
        // 搜索功能
        $map = array(
            'w.type' => trim(I('post.type')),
            'w.result' => trim(I('post.result')),
        );
        $map['w.number'] = trim(I('post.number')) ? array('like','%'.trim(I('post.number')).'%'): '';
        $map['pub_personnel.name'] = trim(I('post.name')) ?  array('like','%'.trim(I('post.name')).'%'): '';
        $map['pub_personnel.phone'] = trim(I('post.phone')) ? array('like','%'.trim(I('post.phone')).'%'):'';
        /* 修改搜索地址失败的 */
        $map['w.address|w.province|w.city|w.district|pub_repair.address'] = trim(I('post.address')) ? array('like','%'.trim(I('post.address')).'%'):'';
        // $map['w.province'] = trim(I('post.address')) ? array('like','%'.trim(I('post.address')).'%'):'';
        // $map['w.city'] = trim(I('post.address')) ? array('like','%'.trim(I('post.address')).'%'):'';
        // $map['w.district'] = trim(I('post.address')) ? array('like','%'.trim(I('post.address')).'%'):'';
        // $map['_logic'] = 'OR';


        $mintime = strtotime(trim(I('post.mintime')));
        $maxtime = strtotime(trim(I('post.maxtime')));

        // dump($map);die;
        $updatetime_arr=[];
        if($maxtime){
            $updatetime_arr[]=array('elt',$maxtime);
        }
        if($mintime){
            $updatetime_arr[]=array('egt',$mintime);
        }
        if(!empty($updatetime_arr)){
            $map['w.time']=$updatetime_arr;
        }

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
                ->join('pub_devices ON w.device_code = pub_devices.device_code','LEFT')
                ->join('pub_binding ON pub_devices.id = pub_binding.did ','LEFT')
                ->join('pub_personnel ON w.personnel_id = pub_personnel.id ','LEFT')
                ->join('pub_repair ON w.repair_id = pub_repair.id ','LEFT')
                ->field('w.number,pub_personnel.name,pub_personnel.phone,w.type,w.content,w.address,w.result,w.create_at,w.time,pub_repair.address raddress,w.province,w.city,w.district')
                ->getAll();
            $arr = [
                'time'=>['date','Y-m-d H:i:s'],
                'create_at'=>['date','Y-m-d H:i:s'],
            ];
            foreach ($data as $key => $value) {
                if($value['type'] === '维修' ){
                    $data[$key]['address'] = $value['raddress'];                    
                }
                unset($data[$key]['raddress']);
                    unset($data[$key]['province']);
                    unset($data[$key]['city']);
                    unset($data[$key]['district']);
            }
        //    replace_value($data,$arr,'');
            $data = replace_array_value($data,$arr);
            $filename = '工单列表数据';
            $title = '工单列表';
            $cellName = ['工单编号','处理人','处理人电话','维护类型','工作内容','地址','处理结果','创建时间','处理时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }

        $total =$type->where($map)
            ->alias('w')
            ->join('pub_devices ON w.device_code = pub_devices.device_code','LEFT')
            ->join('pub_binding ON pub_devices.id = pub_binding.did ','LEFT')
            ->join('pub_personnel ON w.personnel_id = pub_personnel.id ','LEFT') 
            ->join('pub_repair ON w.repair_id = pub_repair.id ','LEFT')           
            ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();
        // echo M()->getLastSql();
        $data = $type->where($map)
            ->alias('w')
            ->join('pub_devices ON w.device_code= pub_devices.device_code','LEFT')
            ->join('pub_binding ON pub_devices.id = pub_binding.did ','LEFT')
            ->join('pub_personnel ON w.personnel_id = pub_personnel.id ','LEFT')
            ->join('pub_repair ON w.repair_id = pub_repair.id ','LEFT')
            ->field('pub_devices.*,pub_binding.*,w.*,pub_personnel.name pname,pub_personnel.phone pphone,pub_repair.address raddress')
            ->order('w.result asc,w.create_at desc')
            ->limit($page->firstRow.','.$page->listRows)->getAll();
        //exit();
        $this->assign('list',$data);
        $this->assign('button',$pageButton);
        $this->display();
    }

    public function add()
    {
        if (IS_POST) {
            I('repair_id') ? $data['repair_id'] = I('repair_id'):'';
            $data['device_code'] = I('dcode');
            I('personnel_id') ? $data['personnel_id'] = I('personnel_id'):'';
            $data['type'] = I('type');
            $data['content'] = I('content');
            I('s_province') ? $data['province'] = I('s_province'):'';
            I('s_city') ? $data['city'] = I('s_city'):'';
            I('s_county') ? $data['district'] = I('s_county'):'';
            I('add_ress') ? $data['address'] = I('add_ress'):'';
            I('time') ? $data['time'] = strtotime(I('time')):'';
            $data['create_at'] = time();


            // dump(I('post.'));die;
            $device_type = D('work');
            
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
        $data['name'] = $_SESSION['adminuser']['name'];
        $data['phone'] = $_SESSION['adminuser']['phone'];
        $data['time'] = time();
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
            if($res_repair){
                $this->success('修改成功',U('admin/work/index'));
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