<?php
namespace Api\Controller;
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

            //设备产品类型
            if(empty($_POST['type_id'])){
                exit(json_encode('2'));
            }

            if(empty($_POST['type_id']) && empty($_POST['vid'])){
                exit(json_encode('2'));
            }

            //设备code码
            $data['device_code'] = trim($_POST['device_code']);
            $data['type_id'] = $_POST['type_id'];
            $data['adtime'] = time();
            //经销商
            $vdata['vid'] = $_POST['uid'] ? $_POST['uid']:'';
            $vdata['addtime'] = time();

            // Log::write(json_encode($_POST), '接口设备入库');
            $devices_model = M('Devices');

            //判断库里有没有这个设备编码
            $where['device_code']=$data['device_code'];
            $devices = $devices_model->where($where)->find();

            //设备添加和更新
            if(!empty($devices)){
                $did = $devices['id'];
                $devices_model->where($where)->save($data);
            }else{
                $did = $devices_model->add($data);
            }

            $vs=false;
            //绑定 添加和更新
            if ($did) {
                $is_bd = M('Binding')->where('did = '.$did)->find();   //经设备是否被绑定
                if (!empty($is_bd)) {
                    if(!empty($vdata['vid'])){
                        $vs=M('Binding')->where('did = '.$did)->save($vdata);
                    } else {
                        $vs=M('Binding')->where('did = '.$did)->delete();
                    }
                } else {
                    if(!empty($vdata['vid'])){   //无经销商 不添加
                        $vdata['did'] = $did;
                        $vs=M('Binding')->add($vdata);
                    }
                }
            }

            //返回个安卓的数据
            $ndata['device_code'] = $did;
            if($vs){
                $ndata['uid'] = $vdata['vid'];
            }
            $ndata['type_id'] = $data['type_id'];

            //去除空值
            array_filter($ndata);
            // Log::write(json_encode($ndata), '接口设备入库');

            if($did) {
                echo json_encode($ndata);
            } else {
                echo json_encode('0');
            }
        } else {
            echo json_encode('2');
        }

    }

}