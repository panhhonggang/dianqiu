<?php
namespace Admin\Model;
use Think\Model;

/**
 * Class DevicesModel
 * @package Admin\Model
 * 设备添加操作
 * @author 陈昌平 <chenchangping@foxmail.com>
 */
class DevicesModel extends Model
{
    // 自动验证
    protected $_validate = array(
        array('device_code', '15', '请输入正确的设备编码', '3', 'length'),
        array('device_code', '/^\d{15}$/', '设备编码只能是数字', '2', 'regex'),
        array('device_code', '', '请不要重复录入', '1', 'unique'),
        array('type_id','require','设备类型不能为空'),

    );

    // 自动完成
    protected $_auto = array(
        array('device_statu', '1'),
        array('addtime', 'time', 1, 'function'),
    );

    // 获取产品类型
    public function getCate()
    {
        $data = M('DeviceType')->field('id')->select();
        $res = array_column( $data, 'id' );
        return $res;
    }

    /**
     * 获取信息
     * @return [type] [description]
     */
    public function getInfoBydecode($code)
    {
        $data = $this
            ->where('device_code='.$code)
            ->join('xp_devices_statu on xp_devices.device_code = xp_devices_statu.DeviceID')
            // ->join('xp_consume on xp_devices.id = xp_consume.did')
            ->join('xp_crew on xp_devices.device_code = xp_crew.dcode')
            ->join('xp_binding on xp_crew.id = xp_binding.cid')
            ->join('xp_vendors on xp_binding.vid = xp_vendors.id')
            ->field('xp_vendors.name,xp_devices_statu.*,xp_devices.id')
            ->find();

        return $data;
    }

}