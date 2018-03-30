<?php
namespace Api\Controller;
use Admin\Controller\CommonController;
use Think\Controller;

/**
 * Class DevicesController
 * @package Admin\Controller
 * @author 梁康伦 <470907311@qq.com>
 */
class DevicesController extends Controller
{

    /**
     * 设备添加处理
     */
    public function add_device()
    {

        if (IS_POST) {


            $devices = M('Devices');

            //接收安卓端数据
            //设备code码
            $data['device_code'] = $_POST['device_code'];
            //经销商id
            $data['uid'] = $_POST['uid'];
            //设备产品类型
            $data['type_id'] = $_POST['type_id'];

            //去除可能为空的值
            $ndata = array_filter($data);

            //判断库里有没有这个设备编码
            $boolean = $devices->where('device_code = '.$data['device_code'])->find();

            if ($boolean) {
                //数据进行修改
                $bool = $devices->where('device_code = '.$data['device_code'])->save($ndata);
            } else {
                //数据写入
                $bool = $devices->add($ndata);
            }

            if($bool) {
                echo json_encode($ndata);
            } else {
                echo json_encode('0');
            }
        } else {
            echo json_encode('2');
        }
       
    }

}
