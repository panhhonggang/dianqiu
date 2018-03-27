<?php
namespace Api\Controller;
use Think\Controller;
use Think\Log;
use Org\Util\Gateway;

class ActionController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        Gateway::$registerAddress = '127.0.0.1:9504';
    }

    public function test()
    {

        $message['DeviceID'] = '868575025659121';

        $this->get_filter_info('868575025659121');

//        $this->check_info(94);
//        $this->sendMsg($message['DeviceID'],$message);
    }

    /**
     * 接收信息 信息分发
     */
    public function receive()
    {
        $message = I('post.');
        $client_id = $message['client_id'];
        unset($message['client_id']);
        if(empty($message['DeviceID'])){
            $mes  = Gateway::getSession($client_id);
            $message['DeviceID']  = $mes['DeviceID'];
        }
        // 判断数据传输的对象
        if( $message['soure']=='Close')
        {
            $this->Close($message['DeviceID']);
        }
        else if( $message['soure']=='TCP'){
            $this->gettcp($client_id, $message);
           
        } else {
            $this->getws($client_id, $message);
        }
    }


    /**
     * web端信息 数据处理
     */
    public function getws($client_id, $message)
    {
        if( $message['PackType'] == 'login' ){
            Gateway::joinGroup( $client_id, $message['DeviceID'] );
        } else {
            Gateway::sendToUid($message['DeviceID'], $message);
        }
    }

    /**
     * 设备消息处理
     */
    public function gettcp($client_id, $message)
    {
        if( empty( Gateway::getSession($client_id) ) ){
            Gateway::setSession($client_id, $message);
        } else {
            $res = Gateway::getSession($client_id);

            $message['DeviceID'] = $res['DeviceID'];
        }
        
        if($message['PackType'] == 'login'){
            Gateway::bindUid($client_id, $message['DeviceID']);
        }

        // 信息正常回复
        if( isset($message['DeviceID']) ){
            if( Gateway::getClientCountByGroup($message['DeviceID']) > 0 ){
                Gateway::sendToGroup( $message['DeviceID'], json_encode($message) );
            }
        }
        Gateway::sendToClient($client_id, $message);

        switch ($message['PackType']) {
            case 'login':
                $this->loginAction($message);
                break;

            case 'SetData':
                $this->setdataAction($message);
                break;

            case 'Select':
                $this->selectAction($message);
                break;

            default:
                $data['NetStause']=1;

                M('devices_statu')->where("DeviceID=" . $DeviceID)->save($data);
                break;
        }
    }

    /**
     * 设备连接关闭
     */
    public function Close($DeviceID)
    {
        $DeviceID=trim($DeviceID);

        $status_id = M('devices_statu')->where("DeviceID=" . $DeviceID)->getField('id');

        if($status_id){
            $data = ['NetStause'   => 0];
            $this->updateData($status_id, $data);
        }
    }

    // 登陆数据处理
    public function loginAction($message)
    {

        $data = [
            'Device'      => $message['Device'],
            'ICCID'       => $message['ICCID'],
            'CSQ'         => $message['CSQ'],
            'Loaction'    => $message['Loaction'],
            'NetStause'   =>1,
        ];

        $dcode=trim($message['DeviceID']);

        $status_id  = M('devices_statu')->where("DeviceID={$dcode}")->getField('id');

        if( empty($status_id) ){
            $res = $this->saveData($data);
            if($res){
                $data['updatetime'] = time();
                $data['device_status'] = 1;
                M('devices')->where('device_code=' . $message['DeviceID'])->save($data);
            }
        } else {
            if($this->check_info($status_id)){
                $this->updateData($status_id, $data);
            }
        }
    }



    /**
     * 设备查询包处理
     * @param $message
     * @return array
     */
    public function selectAction($message)
    {
        $data = [
            'DeviceStause' => $message['DeviceStause'],
            'NetStause'    =>1,
            'SumFlow'      => $message['SumFlow'],
            'SumDay'       => $message['SumDay'],
            'RawTDS'       => $message['RawTDS'],
            'PureTDS'      => $message['PureTDS'],
            'Temperature'  => $message['Temperature'],
        ];

        if( $message['FilerNum'] != null ){
            $res = $this->filterAction($message);

            $data = array_merge( $data, $res );
        }
        $dcode=trim($message['DeviceID']);

        $ds = M('devices_statu')->where("DeviceID=" . $dcode)->find();

        if ($ds) {
            if( $ds['data_statu'] == 0 ){
                $data['ReFlow'] = $message['ReFlow'];
                $data['ReDay']  = $message['Reday'];
                $data['FilerNum']  = $message['FilerNum'];
            }

            $this->updateData($ds['id'], $data);
        }
    }

    /**
     * 设备设置包处理
     * @param $message
     * @return array
     */
    public function setdataAction($message)
    {
        if (isset($message['PackNum'])) {

            $DeviceID=trim($message['DeviceID']);

            if ($message['PackNum'] == 6) {//激活
                $data['data_statu']  = 0;
                $data['AliveStause'] = 1;
            }

            if ($message['PackNum'] == 5) {//更新
                $data['data_statu'] = 0;
                $data['ReDay']      = $message['ReDay'];
                $data['ReFlow']     = $message['ReFlow'];
                $data['FilerNum']   = $message['FilerNum'];
            }

            $status_id = M('devices_statu')->where("DeviceID=" . $DeviceID)->getField('id');

            if (!empty($data)) {
                $this->updateData($status_id, $data);
            }
        }
    }

    /**
     * 推送信息到设备
     * @param $dcode
     */
    public function sysnc($dcode)
    {
        $status_id = M('devices_statu')->where("DeviceID=" . $dcode)->getField('id');
        $this->check_info($status_id);
    }
    /**
     * 库数据检查  单向推送到设备
     * $id  数据串的id
     * 数据状态 0正常 1更新 2 需要激活
     */
    public function check_info($id)
    {
        $data = M('devices_statu')->find($id);
        if (isset($data['data_statu']) && $data['data_statu'] > 0 ){
            $msg = $this->get_data($data);

            if($msg) $this->sendMsg($msg);

            return false;
        }
        return true;
    }

    /**
     * 处理数据结构
     */
    public function get_data($data)
    {
        if(!isset($data['deviceid'])){
            return false;
        }
        $msg['DeviceID'] = $data['deviceid'];
        $msg['PackType'] = "SetData";
        $msg['Vison']    = 0;

        $PackNumArr      = ['1'=>5,'2'=>6];//设备传输包标识 5更新 6激活 用于回调请求时数据处理

        $msg['PackNum']  = $PackNumArr[$data['data_statu']]?:0;

        //设备模式
        $msg['LeasingMode'] = $data['leasingmode'];
        $msg['FilterMode']  = $data['filtermode'];

        //剩余
        $msg['ReFlow'] = empty($data['reflow'])? 0 : $data['reflow'];
        $msg['Reday']  = empty($data['reday'])? 0 : $data['reday'];

        $filter_life=$this->get_filter_info($data['deviceid']);
        if(empty($filter_life)) return false;

        if ($msg['PackNum'] == 5) { //设备更新
            for ($i=1; $i<9; $i++){
                if( !empty($data['reflowfilter'.$i]) or !empty($data['redayfilter'.$i])){
                    $msg['ReFlowFilter'. $i]     = $data['reflowfilter'.$i];
                    $msg['ReDayFilter'. $i]      = $data['redayfilter'.$i];
                    $msg['FlowLifeFilter'. $i]   = $filter_life[$i-1]['flowlife'];
                    $msg['DayLifeFiter'. $i]     = $filter_life[$i-1]['timelife'];
                }
            }

        }

        if ($msg['PackNum']==6 && $data['alivestause'] == 0) {//设备激活
            $msg['AliveStause'] = 1;
            $msg['SumFlow']     = 0;
            $msg['SumDay']      = 0;

            $filenum=0;
            for ($i=1; $i<9; $i++){
                if( !empty($data['reflowfilter'.$i]) or !empty($data['redayfilter'.$i])){
                    $filenum++;
                    $msg['ReFlowFilter'. $i]     = $data['reflowfilter'.$i];
                    $msg['ReDayFilter'. $i]      = $data['redayfilter'.$i];
//                    $msg['FlowLifeFilter'. $i]   = $data['reflowfilter'.$i];
//                    $msg['DayLifeFiter'. $i]     = $data['redayfilter'.$i];
                    $msg['FlowLifeFilter'. $i]   = $filter_life[$i-1]['flowlife'];
                    $msg['DayLifeFiter'. $i]     = $filter_life[$i-1]['timelife'];
                }
            }
            $msg['FilerNum'] = $filenum;

        }
        return $msg;
    }

    /**
     * sendMsg 向设备发送信息 信息推送
     * @param   array $message     信息串
     * @return
     */
    public function sendMsg($message)
    {
        Log::write(json_encode($message), 'AAAAAAA');

        if(isset($message['DeviceID'])){
            Gateway::sendToUid($message['DeviceID'], $message);
        }
    }


    // 存储数据 将数据存到 devices_statu表中
    public function saveData($data)
    {
        $data['addtime'] = time();
        return M('devices_statu')->add($data);
    }

    // 更新数据
    public function updateData($id, $data)
    {

        $data['updatetime'] = time();
        return M('devices_statu')->where("id={$id}")->save($data);
    }

    // 滤芯处理
    public function filterAction($message)
    {
        $data = array();
        for( $i = 1; $i <= $message['FilerNum']; $i ++)
        {
            $data['ReFlowFilter' . $i]   = $message['ReFlowFilter' . $i];
            $data['ReDayFilter' . $i]    = $message['ReDayFilter' . $i];
        }
        if ($data['ReFlowFilter1']==-1) {
            $data['FilterMode']=0;
        }
        if ( $data['ReDayFilter1']==-1 ){
            $data['FilterMode']=1;
        }
        if ($data['ReDayFilter1']>=0 and  $data['ReFlowFilter1']>=0) {
            $data['FilterMode']=2;
        }


        return $data;
    }


    public function get_filter_info($dcode)
    {
        $code = M('devices')->where("device_code={$dcode}")->find();
//        $status = M('devices_statu')->where("DeviceID='{$dcode}'")->find();
        $type = M('device_type')->where("id={$code['type_id']}")->find();

        unset($type['id'], $type['typename'], $type['addtime']);
        $sum = array_filter($type);
        foreach ($sum as $key => $value) {
            $str = stripos($value,'-');
            $map['filtername'] = substr($value, 0,$str);
            $map['alias'] = substr($value, $str+1);
//            $res[] = M('filters')->where($map)->field('timelife,flowlife')->find();
            $res[] = M('filters')->where($map)->field('timelife,flowlife')->find();
        }
        return $res;
    }

//    public function updateNetStase($DeviceID,$NetStause)
//    {
//        $status_id = M('devices_statu')->where("DeviceID=" . $DeviceID)->getField('id');
//
//        $data = [
//            'NetStause'   => $NetStause,
//        ];
//        $this->updateData($status_id, $data);
//    }

}