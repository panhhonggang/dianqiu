<?php
namespace Home\Controller;
use Think\Controller;
use \Org\Util\WeixinJssdk;
use Org\Util\Gateway;
/**
 * 安装人员系统
 */
class PersonnelController extends Controller
{

    function _initialize(){

        if (session('pid') == null) {
            $this->error('你未登陆',U('home/users/login'),2);
        }

    }
    public function dcode() {
        $data = I('post.');

        $info = M('devices')->where(['devices_code'=>$data['dcode']])->find();
        if ($info) {
            return $this->ajaxReturn(['code'=>200]);
        } else {
            return $this->ajaxReturn(['code'=>404,'message'=>'查询不到该设备']);
        }
    }
    /*
     * 安装人员登录成功首页
     */
    public function index()
    {
//        $sc = A('Api/Action');
//
//        $status = $sc->haihai('868575025659121');
//        // $map['DeviceID'] = '868575025659121';
//        // $info = M('devices_statu')->($map)->save(['FilterMode'=>1,['LeasingMode']=>2,'updatetime'=>time()]);
//        // if ($info) {
//        //     $message = ['DeviceID'=>'868575025672751','PackType'=>'SetData','Vison'=>0,'AliveStause'=>1,'FilterMode'=>0,'SumDay'=>0,'SumFlow'=>0,'ReFlow'=>5,'Reday'=>100,'ReFlowFilter1'=>200,'ReDayFilter1'=>100,'FlowLifeFilter1'=>200,'DayLifeFiter1'=>200,'LeasingMode'=>2,'FilerNum'=5];
//        //     $sta = Gateway::sendToUid('868575025659121' $message);
//
//        //         }
//        if ($status) {
//            $map['DeviceID'] = '868575025659121';
//            // $info = M('devices_statu')->($map)->save(['FilterMode'=>1,['LeasingMode']=>2,'updatetime'=>time()]);
//
//
//            $message = ['DeviceID'=>'868575025672751','PackType'=>'SetData','Vison'=>0,'AliveStause'=>1,'FilterMode'=>1,'SumDay'=>0,'SumFlow'=>0,'ReFlow'=>5,'Reday'=>100,'ReFlowFilter1'=>200,'ReDayFilter1'=>100,'FlowLifeFilter1'=>200,'DayLifeFiter1'=>200,'LeasingMode'=>2,'FilerNum'=>5];
//            $sta = Gateway::sendToUid('868575025659121',$message);
//            dump($sta);
//        }
        $this->display('index');

    }
    /*
     * 点击安装之后页面
     */
    public function personal(){
        //个人资料
        $user= M('personnel')->field('name,phone')->where(['id'=>session('pid')])->find();
        //未安装统计
        $not_install= M('work')->where(['result'=>0,'type'=>0,'personnel_id'=>session('pid')])->count();
        //安装统计
        $install= M('work')->where(['result'=>2,'type'=>0,'personnel_id'=>session('pid')])->count();
        $this->assign('user', $user);
        $this->assign('not_install', $not_install);
        $this->assign('install', $install);
        $this->display();
    }
    /*
     * 安装设备列表
     */
    public function dutyList(){

        //处理结果(0：未处理 1：正在处理 2：已处理)
        $where['result'] = I('get.result');
        //工单类型(0：安装 1：维修 2：维护)
        $where['type'] = 0;
        //安装人
        $where['personnel_id'] = session('pid');
        $list = M('work')->field('number,device_code,id')->where($where)->select();

        $this->assign('where',$where);
        $this->assign('list', $list);
        $this->display();
    }
    /*
     * 安装设备添加
     */
    public function infoDetail($id)
    {
        $map = I('post.');
        $map['personnel_id'] = session('pid');
        $map['id'] = $id;
        $perSonnel_info = D('Personnel');
        $info = $perSonnel_info->per_detail($map);
        if (IS_POST) {
            //查询数据

            $status = $perSonnel_info->status($map);
            if ($status['code']==403) {
                $this->error($status['message']);
            } else {
                $vid = $status['data'];
            }
            $data = I('post.');
            $data['pid'] = $map['personnel_id'];
            $data['vid'] = $vid;
            $data['wid'] = $id;
            $data['create_time'] = date('Y-m-d H:i:s');
            //查询产品类型
            $type_info = M('devices')->field('type_id')->where(['device_code'=>$data['dcode']])->find();
            $status_info = M('devices_statu')->field('AliveStause')->where(['DeviceID'=>$data['dcode']])->find();
            if ($status_info['alivestause'] == 1) {
                $this->error('此设备正常 无需安装');
            }

            //查找产品对应的滤芯
            $type_name = M('device_type')->where(['id'=>$type_info['type_id']])->find();
            unset($type_name['id'], $type_name['typename'], $type_name['addtime']);
            $sum = array_filter($type_name);
            foreach ($sum as $key => $value) {
                $str = stripos($value,'-');
                $map_filters['filtername'] = substr($value, 0,$str);
                $map_filters['alias'] = substr($value, $str+1);
                $res[] = M('filters')->field('flowlife,timelife')->where($map_filters)->find();

            }


            $work_info = M('work')->where(['id'=>$map['id'],'personnel_id'=>$map['personnel_id']])->save(['dcode'=>$map['dcode'],'result'=>2]);
            if ($work_info) {

                $add_info = M('install')->add($data);

                if ( $add_info) {
                    $device_status['DeviceID'] = $data['dcode'];
                    $device_status['LeasingMode'] = $data['lease'];
                    $device_status['FilterMode'] = $data['filter'];
//                    $device_status['AliveStause'] = $data['dcode'];
                    $device_status['addtime'] =  time();
                    $num = 1;
                    $co  = 1;
                    $fnum = 1;
                    $dnum = 1;
                    foreach ($res as $k => $v) {
                        $device_status['ReFlowFilter'.$num++] = $v['flowlife'];
                        $device_status['ReDayFilter'.$co++] = $v['timelife'];
                        $device_status['FlowLifeFilter'.$fnum++] = $v['flowlife'];
                        $device_status['DayLifeFiter'.$dnum++] = $v['timelife'];

//                        M('devices_statu')->where(['DeviceID'=>$data['dcode']])->save($statu);
                    }


                    M('devices_statu')->add($device_status);
                    M('devices')->where(['device_code'=>$data['dcode']])->save(['device_statu'=>2]);
                    $num = 1;
                    $co  = 1;
                    $fnum = 1;
                    $dnum = 1;
                    foreach ($res as $k => $v) {
                        $statu['ReFlowFilter'.$num++] = $v['flowlife'];
                        $statu['ReDayFilter'.$co++] = $v['timelife'];
                        $statu['FlowLifeFilter'.$fnum++] = $v['flowlife'];
                        $statu['DayLifeFiter'.$dnum++] = $v['timelife'];

//                        M('devices_statu')->where(['DeviceID'=>$data['dcode']])->save($statu);
                    }

//                    $status_info = M('devices_statu')->where(['DeviceID'=>$data['dcode']])->save(['ReFlow'=>0,'Reday'=>0,'LeasingMode'=>$data['lease']
//                    ,'FilterMode'=>$data['filter'],'SumFlow'=>0,'SumDay'=>0,'AliveStause'=>1,'updatetime'=>time()]);
                    $statu['DeviceID'] = $data['dcode'];
                    $statu['PackType'] = 'SetData';
//                    $statu['ReFlow'] = 0;
//                    $statu['Reday'] = 0;
                    $statu['LeasingMode'] = $data['lease'];
                    $statu['FilterMode'] = $data['filter'];
                    $statu['SumFlow'] = 0;
                    $statu['SumDay'] = 0;
                    $statu['AliveStause'] = 1;
                    $statu['FilerNum'] = count($res);
                    $message['PackNum'] = 6;//激活
                    $sc = A('Api/Action');
//                    $status = $sc->Initialize($data['dcode']);
//                    $sta = Gateway::sendToUid('868575025659121',$status);
//                    if ($status) {
////                        $map['DeviceID'] = '868575025659121';
////                        // $info = M('devices_statu')->($map)->save(['FilterMode'=>1,['LeasingMode']=>2,'updatetime'=>time()]);
////                        $message = ['DeviceID' => '868575025672751', 'PackType' => 'SetData', 'Vison' => 0, 'AliveStause' => 1, 'FilterMode' => 1, 'SumDay' => 0, 'SumFlow' => 0, 'ReFlow' => 5, 'Reday' => 100, 'ReFlowFilter1' => 200, 'ReDayFilter1' => 100, 'FlowLifeFilter1' => 200, 'DayLifeFiter1' => 200, 'LeasingMode' => 2, 'FilerNum' => 5];
//                        $sta = Gateway::sendToUid($data['dcode'], $statu);
//
//                    } else {
//                        unset($statu['PackType']);
//                        unset($statu['DayLifeFiter']);
//                        unset($statu['DayLifeFiter']);
//
//                    }
//                    $status_info = M('devices_statu')->add();
                        M('devices_statu')->where(['DeviceID'=>$data['dcode']])->save(['data_statu'=>2]);
                        Gateway::sendToUid($data['dcode'], $statu);
                        $this->success('安装成功',U('home/Personnel/personal'),2);




                } else {
                    $this->error('安装失败');
                }
            } else {
                    $this->error('失败');
            }
        } else {

            $this->assign('info',$info);

            $this->display();
        }

    }
    /*
     * 完成安装
     */
    public function to_success($device_code) {
        // echo $device_code;die;
        // $map['personnel_id'] = session('pid');
        // $map['id'] = $id;
        $work_info = M('install')->where('dcode = '.$device_code)->find();
        // echo M('install')->getLastSql();
        // if (!$work_info) {
        //     $this->error('数据有误');
        // }
        $this->assign('work_info',$work_info);
        $this->display('success');
    }

    /*
     * 充值
     */
    public function topup() {
        $this->display('chongzhi');
    }
}