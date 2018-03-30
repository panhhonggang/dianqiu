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

            //设备产品类型
            $data['type_id'] = $_POST['type_id'] ? $_POST['type_id']:'';

            //经销商id
            $vdata['vid'] = $_POST['uid'] ? $_POST['uid']:'';

            $vdata['addtime'] = time();

            
            //判断库里有没有这个设备编码
            $did = $devices->where('device_code = '.$data['device_code'])->field('id')->find()['id'];


            if ($did) {

                //查找经销商是否存在
                $vid = M('Binding')->where('did = '.$did)->field('vid')->find()['vid'];

                if ($vid) {
                    $bool = M('Binding')->where('did = '.$did)->save($vdata);
                    $bool = $devices->where('device_code = '.$data['device_code'])->save($data);

                } else {
                    //数据进行修改
                    $vdata['did'] = $did;
                    $bool = M('Binding')->add($vdata);
                    // echo M('Binding')->getLastSql();
                    // dump($bool);die;
                    $bool = $devices->where('device_code = '.$data['device_code'])->save($data);
                }
                
            } else {

                // echo 111;die;
                //数据写入
                $bool = $devices->add($data);
                
                $vdata['did'] = $devices->where('device_code = '.$data['device_code'])->field('id')->find()['id'];
                
                $bool = M('Binding')->add($vdata);
                
            }

            //返回个安卓的数据
            $ndata['device_code'] = $data['device_code'];
            $ndata['uid'] = $vdata['vid'];
            $ndata['type_id'] = $data['type_id'];

            //去除空值
            array_filter($ndata);

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
