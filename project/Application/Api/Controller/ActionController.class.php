<?php
namespace Api\Controller;
use Think\Controller;
use Think\Log;
use Org\Util\Gateway;

class ActionController extends Controller
{
    public function __construct()
    {
        Gateway::$registerAddress = '127.0.0.1:9504';
    }
    // 接收信息
    public function receive()
    {
        $message = I('post.');
        $client_id = $message['client_id'];
        unset($message['client_id']);

        Log::write(json_encode($message), '接收信息');
        if( $message['soure']=='TCP'){
            if( empty( Gateway::getSession($client_id) ) ){
                Gateway::setSession($client_id, $message);
            } else {
                $res = Gateway::getSession($client_id);

                $message['DeviceID'] = $res['DeviceID'];
            }
            
            if($message['PackType'] == 'login'){
                
                Gateway::bindUid($client_id, $message['DeviceID']);

            }

            Log::write(json_encode($message), '设备发送消息');

            switch ($message['PackType']) {
                case 'login':
                    $this->loginAction($message);
                    break;

                // 设备设置
                case 'Select':
                    $this->selectAction($message);
                    break;
                case 'Requestwater':
                    $message = $this->RequesAction($client_id, $message);
                    break;
                case 'Stopwater':
                Log::write(json_encode($message), '停水处理');
                    $this->stopAction($client_id, $message);
                    break;
                default:
                    # code...
                    break;
            }

            if( isset($message['DeviceID']) ){
                if( Gateway::getClientCountByGroup($message['DeviceID']) > 0 ){
                    Gateway::sendToGroup( $message['DeviceID'], json_encode($message) );
                }
            }
            if(!Gateway::isOnline($client_id)){
                return "设备已离线";
            }
            Gateway::sendToClient($client_id, $message);
        } else {
            /*$message = file_get_contents('message');
            $ReviveArray=json_decode($message, true);
            Log::write(json_encode($ReviveArray), 'web发送消息');*/
            /*if( $ReviveArray['PackType'] == 'login' ){
                Gateway::joinGroup( $client_id, $ReviveArray['DeviceID'] );
            } else {
                Gateway::sendToUid($ReviveArray['DeviceID'], $ReviveArray);
            }*/

            if( $message['PackType'] == 'login' ){
                Gateway::joinGroup( $client_id, $message['DeviceID'] );
            } else {
                Gateway::sendToUid($message['DeviceID'], $message);
            }
            
            if(!Gateway::isUidOnline($ReviveArray['DeviceID'])){
                return "设备已离线";
            }
        }

    }

    // 出水请求
    public function RequesAction($client_id, $message)
    {
        // 查询IC卡的类型
        $icCard = M('card')->where('iccard='.$message['iccard'])->find();
        if( !empty($icCard) && $icCard['type'] == 0 ){
            $message['EnOut'] = -1;
            $message['OutWaterFlow'] = -1;
            $message['MaxTime'] = -1;
            return $message;
        }

        
        if( !empty($icCard) && $icCard['type'] == 1){
            // 计算出水量
            $user = M('users')->where('id='.$icCard['uid'])->find();
            $outwater = $user['balance'] / 1.5;
            Gateway::updateSession( $client_id , [$client_id . $user['id'] => $outwater]);

            $message['EnOut'] = -1;
            $message['OutWaterFlow'] = $outwater;
            $message['MaxTime'] = -1;
            return $message;
        }

    }

    // 停水处理
    public function stopAction($client_id, $message)
    {
        $icCard = M('card')->where('iccard='.$message['iccard'])->find();
        if( !empty($icCard) && $message['water'] > 0 ){
            $user = M('users')->where('id='.$icCard['uid'])->find();

            // 计算使用水量消费的金额
            $totalWater = $message['water'] * 1.5;

            // 计算余额
            $balance = $user['balance'] - $totalWater;

            Gateway::updateSession($client_id, [$client_id . $user['id']=>$totalWater]);

            $res = $this->saveConsume($user['id'],$message['DeviceID'], $icCard['id'], $message['water']);

            $this->updateBalance($user['id'], $balance);
        }
    }


    // 保存消费记录
    public function saveConsume($uid, $code, $icid, $flow)
    {
        $res = M('devices')->where('device_code='.$code)->getField('id');

        // 指定数据库需要的字段
        $data = array(
            'uid' => $uid,
            'did' => $res,
            'icid' => $icid,
            'flow' => $flow,
            'address' => 'aaaa',
            'time' => time(),
        );

        // 执行添加
        M('consume')->add($data);

    }

    // 更新用户余额
    public function updateBalance($uid, $balance)
    {
        $data['balance'] = $balance;
        M('users')->where('id='.$uid)->save($data);
    }

    // 登陆数据处理
    public function loginAction($message)
    {
        $data = [
                    'DataCmd'      => $message['DataCmd'],
                    'Device'       => $message['Device'],
                    'PackType'     => $message['PackType'],
                    'AliveStause'  => $message['AliveStause'],
                    'DeviceType'   => $message['DeviceType'],
                    'DeviceID'     => $message['DeviceID'],
                    'ICCID'        => $message['ICCID'],
                    'CSQ'          => $message['CSQ'],
                    'Loaction'     => $message['Loaction']
                ];
        $devices_id = M('devices')->where("device_code={$message['DeviceID']}")->getField('id');
        $status_id  = M('devices_statu')->where("DeviceID={$message['DeviceID']}")->getField('id');
        
        if( empty($status_id) ){
            $res = $this->saveData($data);
            if($res){
                $data['updatetime'] = time();
                $data['device_status'] = 1;
                $result = M('devices')->where('device_code=' . $message['DeviceID'])->save($data);
            }
        } else {
            $res = $this->updateData($status_id, $data);
        }

    }

    // 数据处理
    public function selectAction($message)
    {
        $data = [
            'DeviceStause' => $message['DeviceStause'],
            'ReFlow'       => $message['ReFlow'],
            'Reday'        => $message['Reday'],
            'SumFlow'      => $message['SumFlow'],
            'SumDay'       => $message['SumDay'],
            'RawTDS'       => $message['RawTDS'],
            'PureTDS'      => $message['PureTDS'],
            'Temperature'  => $message['Temperature'],
            'FilerNum'     => $message['FilerNum'],
            'LeasingMode'  => $message['LeasingMode'],
        ];

        if( $message['FilerNum'] != null ){
            $res = $this->filterAction($message);

            $data = array_merge( $data, $res );
        }

        $status_id = M('devices_statu')->where("DeviceID=" . $message['DeviceID'])->getField('id');
        $this->updateData($status_id, $data);
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
        return $data;
    }

}