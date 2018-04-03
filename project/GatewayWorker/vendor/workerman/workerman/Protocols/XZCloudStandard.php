<?php
/**
 * This file is part of workerman.
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the MIT-LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @author    walkor<walkor@workerman.net>
 * @copyright walkor<walkor@workerman.net>
 * @link      http://www.workerman.net/
 * @license   http://www.opensource.org/licenses/mit-license.php MIT License
 */
namespace Workerman\Protocols;

use Workerman\Connection\TcpConnection;

//define("MODE",     "mode");
/**
 * Protocol interface
 */
class XZCloudStandard
{
    /**
     * Check the integrity of the package.
     * Please return the length of package.
     * If length is unknow please return 0 that mean wating more data.
     * If the package has something wrong please return false the connection will be closed.
     *
     * @param ConnectionInterface $connection
     * @param string              $recv_buffer
     * @return int|false
     */



    static $serNum=0;
    
    const MODE='LeasingMode';  //租赁模式
    const AliveStause='AliveStause'; //激活状态
    const DeviceStause='DeviceStause'; // 设备状态
    const ReFlow='ReFlow'; // 剩余流量 租赁用
    const Reday='Reday'; // 剩余天数 租赁用
    const SumFlow='SumFlow'; // 累计流量 
    const SumDay='SumDay'; // 累计天数
    const FilterMode='FilterMode'; // 滤芯模式
    const RawTDS='RawTDS';  //纯水
    const PureTDS='PureTDS'; //原水
    const Temperature='Temperature'; // 温度
    const FilerNum='FilerNum'; // 滤芯个数

    const ReFlowFilter1='ReFlowFilter1'; // 滤芯1剩余流量 
    const ReDayFilter1='ReDayFilter1'; // 滤芯1剩余天数
    const FlowLifeFilter1='FlowLifeFilter1'; // 滤芯1流量寿命
    const DayLifeFiter1='DayLifeFiter1'; //滤芯1时间寿命


    const ReFlowFilter2='ReFlowFilter2';
    const ReDayFilter2='ReDayFilter2';
    const FlowLifeFilter2='FlowLifeFilter2';
    const DayLifeFiter2='DayLifeFiter2';

    const ReFlowFilter3='ReFlowFilter3';
    const ReDayFilter3='ReDayFilter3';
    const FlowLifeFilter3='FlowLifeFilter3';
    const DayLifeFiter3='DayLifeFiter3';

    const ReFlowFilter4='ReFlowFilter4';
    const ReDayFilter4='ReDayFilter4';
    const FlowLifeFilter4='FlowLifeFilter4';
    const DayLifeFiter4='DayLifeFiter4';

    const ReFlowFilter5='ReFlowFilter5';
    const ReDayFilter5='ReDayFilter5';
    const FlowLifeFilter5='FlowLifeFilter5';
    const DayLifeFiter5='DayLifeFiter5';

    const ReFlowFilter6='ReFlowFilter6';
    const ReDayFilter6='ReDayFilter6';
    const FlowLifeFilter6='FlowLifeFilter6';
    const DayLifeFiter6='DayLifeFiter6';

    const ReFlowFilter7='ReFlowFilter7';
    const ReDayFilter7='ReDayFilter7';
    const FlowLifeFilter7='FlowLifeFilter7';
    const DayLifeFiter7='DayLifeFiter7';

    const ReFlowFilter8='ReFlowFilter8';
    const ReDayFilter8='ReDayFilter8';
    const FlowLifeFilter8='FlowLifeFilter8';
    const DayLifeFiter8='DayLifeFiter8';



    const Vison='Vison'; // 协议版本
    const DeviceType='DeviceType'; // 设备类型 
    const DeviceID='DeviceID'; // 设备 ID
    const ICCID='ICCID'; // SIM 卡ID
    const CSQ='CSQ'; // 无线信号强度

    const Loaction='Loaction'; // 小区位置 
    const Device='Device'; // 无线模式 GPRS WIFI
    static $TableSetCmd=
    [
        [self::MODE,'C'],
        [self::AliveStause,'C'],
        [self::DeviceStause,'C'],
        [self::ReFlow,'n'],
        [self::Reday,'n'],
        [self::SumFlow,'n'],
        [self::SumDay,'n'],
        ["SumPump",'N'],
        ['CurTime','N'],
        [self::FilterMode,'C'],
        [self::FilerNum,'C'],
        
        [self::ReFlowFilter1,'n'],
        [self::ReDayFilter1,'n'],
        [self::FlowLifeFilter1,'n'],
        [self::DayLifeFiter1,'n'],

        [self::ReFlowFilter2,'n'],
        [self::ReDayFilter2,'n'],
        [self::FlowLifeFilter2,'n'],
        [self::DayLifeFiter2,'n'],

        [self::ReFlowFilter3,'n'],
        [self::ReDayFilter3,'n'],
        [self::FlowLifeFilter3,'n'],
        [self::DayLifeFiter3,'n'],

        [self::ReFlowFilter4,'n'],
        [self::ReDayFilter4,'n'],
        [self::FlowLifeFilter4,'n'],
        [self::DayLifeFiter4,'n'],

        [self::ReFlowFilter5,'n'],
        [self::ReDayFilter5,'n'],
        [self::FlowLifeFilter5,'n'],
        [self::DayLifeFiter5,'n'],

        [self::ReFlowFilter6,'n'],
        [self::ReDayFilter6,'n'],
        [self::FlowLifeFilter6,'n'],
        [self::DayLifeFiter6,'n'],

        [self::ReFlowFilter7,'n'],
        [self::ReDayFilter7,'n'],
        [self::FlowLifeFilter7,'n'],
        [self::DayLifeFiter7,'n'],

        [self::ReFlowFilter8,'n'],
        [self::ReDayFilter8,'n'],
        [self::FlowLifeFilter8,'n'],
        [self::DayLifeFiter8,'n'],
    ];
    static $TableReadStruct=
    [
        [self::MODE,'C'],
        [self::DeviceStause,'C'],
        [self::ReFlow,'n'],
        [self::Reday,'n'],
        [self::SumFlow,'n'],
        [self::SumDay,'n'],
        ["SumPump",'N'],
        [self::RawTDS,'n'],
        [self::PureTDS,'n'],
        [self::Temperature,'C'],
        [self::FilerNum,'C'],
    ];
       
    
    static function  crc16($string) 
    {
        $crc = 0xFFFF;
        for ($x = 0; $x < strlen ($string); $x++) 
        {
            $crc = $crc ^ ord($string[$x]);
            for ($y = 0; $y < 8; $y++) 
            {
                if (($crc & 0x0001) == 0x0001) 
                {
                    $crc = (($crc >> 1) ^ 0xA001);
                } 
                else 
                { 
                    $crc = $crc >> 1; 
                }
            }
        }
        return $crc;
    }
    public static function input($recv_buffer, TcpConnection $connection)
    {
        file_put_contents('filename', $recv_buffer);
        $decodeData=unpack('nHeader/CPackNum/CVison/nLenth/nDataCmd', $recv_buffer);
        if(($decodeData['Header']==0xddaa)||($decodeData['Header']==0xddBB))
        {
            return $decodeData['Lenth'];
        }
        else
        {
            return 0;
        }
    }
    
    /**
     * Decode package and emit onMessage($message) callback, $message is the result that decode returned.
     *
     * @param ConnectionInterface $connection                  
     * @param string              $recv_buffer
     * @return mixed
     */
    public static function decode($recv_buffer)
    {
        $decodeData=unpack('nHeader/CPackNum/CVison/nLenth/nDataCmd', $recv_buffer);

        if(($decodeData['Header']==0xddaa))
        {
            $crc_ReciveStr=substr($recv_buffer,$decodeData['Lenth']-2,2);
            $crc_Recive=unpack('nCrc',  $crc_ReciveStr);
            $CrcCheck=XZCloudStandard::crc16(substr($recv_buffer,0,$decodeData['Lenth']-2));
            if($crc_Recive['Crc']!=$CrcCheck)
            {
                $decodeData['PackType']='CRCerrPack';

                return $decodeData;
            }
        }
        else
        {
            $decodeData['PackType']='errPack';
            return $decodeData;
        }

        $recv_buffer=substr($recv_buffer,8);
        if($decodeData['DataCmd']==0x0000)//登录包
        {
            if($decodeData['Lenth']==25)
            {
                $decodeData[self::Device]='WIFI';
                $decodeData['PackType']='login';
                $lognData=unpack('CAliveStause/CDeviceType/c12Mac/CCSQ',  $recv_buffer);
                $decodeData[self::AliveStause]=$lognData['AliveStause'];
                $decodeData[self::DeviceType]=$lognData['DeviceType'];
                $decodeData[self::DeviceID]=substr($recv_buffer,2,12);
                $decodeData[self::CSQ]=$lognData['CSQ'];
     
            }
            else if($decodeData['Lenth']==58)
            {
                $decodeData[self::Device]      = 'GPRS';
                $decodeData['PackType']        = 'login';
                $lognData                      = unpack('CAliveStause/CDeviceType/c15IMEI/c20ICCID/c10Loaction/CCSQ',  $recv_buffer);
                $decodeData[self::AliveStause] = $lognData['AliveStause'];
                $decodeData[self::DeviceType]  = $lognData['DeviceType'];
                $decodeData[self::DeviceID]    = substr($recv_buffer,2,15);
                $decodeData[self::ICCID]       = substr($recv_buffer,17,20);
                $decodeData[self::Loaction]    = substr($recv_buffer,37,10);
                $decodeData[self::CSQ]         = $lognData['CSQ'];
                
            }
        }
        else if($decodeData['DataCmd']==0x8002)
        {
            $decodeData['PackType']='Select';
            $SourData=$recv_buffer;
            $table=XZCloudStandard::$TableReadStruct;
            $unpackStr=$table[0][1];
            $unpackStr.=$table[0][0];
            for($i=1;$i<count(self::$TableReadStruct);$i++)
            {
                $unpackStr.='/';
                $unpackStr.=$table[$i][1];
                $unpackStr.=$table[$i][0];
            }
            $Device=unpack($unpackStr, $recv_buffer);            
            for($i=0;$i<count(self::$TableReadStruct);$i++)
            {
                $decodeData[$table[$i][0]]=$Device[$table[$i][0]];
                if($table[$i][1]=='n')
                {
                    if($decodeData[$table[$i][0]]==65535)
                    {
                        $decodeData[$table[$i][0]]=-1;
                    }
                }
                else if($table[$i][1]=='C')
                {
                    if($decodeData[$table[$i][0]]==255)
                    {
                        $decodeData[$table[$i][0]]=-1;
                    }
                }
                else if($table[$i][1]=='N')
                {
                    if($decodeData[$table[$i][0]]==4294967295)
                    {
                        $decodeData[$table[$i][0]]=-1;
                    }
                }
            }
            $FilterDataStr = substr($recv_buffer,20);
            for($i=1; $i<=$decodeData[self::FilerNum]; $i++)
            {
                $filterData                      = unpack('nReDayFilter/nReFlowFilter', $FilterDataStr);
                $decodeData['ReFlowFilter' . $i] = $filterData['ReFlowFilter'] == 65535?-1:$filterData['ReFlowFilter'];
                $decodeData['ReDayFilter' . $i]  = $filterData['ReDayFilter'] == 65535?-1:$filterData['ReDayFilter'];
                $FilterDataStr                   = substr($FilterDataStr, 4);
            }

        }
        else if($decodeData['DataCmd']==0x8003)
        {
            $decodeData['PackType']  = 'SetData';
            $IsSuccess               = unpack('C*',  $recv_buffer);
            
            $decodeData['IsSuccess'] = $IsSuccess['1'];
        }
        else if($decodeData['DataCmd']==0x0001)
        {
            $decodeData['PackType']='heartbeat';
        }
        else if($decodeData['DataCmd'] == 0x8004)
        {
            $decodeData['PackType']='Outwater';
        }
        else if($decodeData['DataCmd'] == 5)
        {

            $decodeData['PackType'] = 'Requestwater';
            $decodeData['iccard'] = substr($recv_buffer, 0, 20);

        }
        else if($decodeData['DataCmd'] == 6)
        {
            $decodeData['PackType'] = 'Stopwater';
            $water = unpack('n*', $recv_buffer); 
            $decodeData['water'] = $water['1'];
            $decodeData['iccard'] = substr($recv_buffer, 2, 20);
        }
        else
        {
            $decodeData['PackType']='errPack';
        }

        return $decodeData;
    }

    /**
     * Encode package brefore sending to client.
     *
     * @param ConnectionInterface $connection
     * @param mixed               $data
     * @return string
     */
    public static function encode($data)
    {
       // return $data;
        if(isset($data['PackType']))
        {
            $PackLenth=0;
            $DataPack='';
            $CheckCode='';
           
            if(isset($data['DataCmd']))
            {
                if(($data['DataCmd']&0x8000)==0x8000)
                {
                    return '';
                }
            }
            if($data['PackType']=='login')
            {
                $PackLenth=4;
                $data['DataCmd']=$data['DataCmd']|0x8000;
                $DataPack=pack('N',time());
            }
            else if($data['PackType']=='heartbeat')
            {
                $data['DataCmd']=$data['DataCmd']|0x8000;
            }
            else if($data['PackType']=='Select')
            {
                $data['DataCmd']=2;
            }
            else if($data['PackType']=='SetData')
            {
                $data['DataCmd']=3;
                $i=count(XZCloudStandard::$TableSetCmd)-1;
                $cmd=XZCloudStandard::$TableSetCmd;
                $data['CurTime']=time();

                for(;$i>=0;$i--)
                {
                    if(isset($data[$cmd[$i][0]]))
                    {
                        break;
                    }
                }
                // if(isset($data[self::AliveStause]))
                // {
                //$data['CurTime']=time();
                // }
                $DataPack='';
                for($j=0;$j<=$i;$j++)
                {
                    $dataNum=0;
                   
                    if( isset($data[$cmd[$j][0]]) && $data[$cmd[$j][0]] != -1 )
                    {
                        $dataNum=$data[$cmd[$j][0]];
                    }
                    else
                    {
                        if($cmd[$j][1]=='C')
                        {
                            $dataNum=0xff;
                        }
                        else if($cmd[$j][1]=='n')
                        {
                            $dataNum=0xffff;
                        }
                        else if($cmd[$j][1]=='N')
                        {
                             $dataNum=0xffffffff;
                        }
                    }
                    if($cmd[$j][1]=='C')
                    {
                        $PackLenth+=1;
                    }
                    else if($cmd[$j][1]=='n')
                    {
                       $PackLenth+=2;
                    }
                    else if($cmd[$j][1]=='N')
                    {
                        $PackLenth+=4;
                    }
                    $DataPack.=pack($cmd[$j][1],$dataNum);
                }
            }

            else if($data['PackType']=='Outwater')
            {
                $data['DataCmd']=4;
                $DataPack.=pack('cnc',$data['EnOut'],$data['OutWaterFlow'],$data['MaxTime']);
            }
            else if($data['PackType']=='Requestwater')
            {
                $data['DataCmd']=$data['DataCmd']|0x8000;
                $DataPack.=pack('cnc',$data['EnOut'],$data['OutWaterFlow'],$data['MaxTime']);
            }




            $PackNum=0;
            if(($data['DataCmd']&0x8000)==0x0000)
            {
                if(isset($data['PackNum']))
                {
                   $PackNum=$data['PackNum']; 
                }
                else
                {
                    XZCloudStandard::$serNum=XZCloudStandard::$serNum+1;
                    if(XZCloudStandard::$serNum>=256)
                    {
                        XZCloudStandard::$serNum=0;
                    }
                    $PackNum=XZCloudStandard::$serNum;
                }
            }
            else
            {
                $PackNum=$data['PackNum'];
            }
            if($PackLenth>0||$data['PackType']!='SetData'){
                $PackLenth+=10;
                $req_Data=pack('nCCnn',0xddaa,$PackNum,$data[self::Vison],$PackLenth,$data['DataCmd']);
                $req_Data.=$DataPack;
                $CheckCode=pack('n',XZCloudStandard::crc16($req_Data));
                $req_Data.=$CheckCode;
                return $req_Data;
            }

        }
        else
        {
            return $data;
        }
       
    }
}
