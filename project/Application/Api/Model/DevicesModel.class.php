<?php
namespace Api\Model;
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
        array('device_code', '15', '请输入正确的设备编码', '0', 'length'),
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
    // 
    public function getDevicesInfo($map)
    {
        // 分页
        $count = $this
            ->where($map)
            ->alias('d')
            ->join("__DEVICES_STATU__ statu ON d.device_code=statu.DeviceID", 'LEFT')
            ->join("__BINDING__ bind ON d.id=bind.did", 'LEFT')
            ->join("__VENDORS__ vendors ON bind.vid=vendors.id", 'LEFT')
            ->join("__DEVICE_TYPE__ type ON d.type_id=type.id", 'LEFT')
            ->join('__USERS__ u ON u.id=d.uid', 'LEFT')
            ->field("statu.*,bind.*,d.id,d.device_code,type.*,vendors.*,d.name dname,d.phone,d.address,d.uid")
            ->order('d.id asc')
            ->limit($page->firstRow.','.$page->listRows)
            ->count();
        $page = new \Think\Page($count, 10);
        $page->rollPage = 10;
        $this->getPageConfig($page);
        $show = $page->show();

        // 查询数据
        $data = $this
            ->where($map)
            ->alias('d')
            ->join("__DEVICES_STATU__ statu ON d.device_code=statu.DeviceID", 'LEFT')
            ->join("__BINDING__ bind ON d.id=bind.did", 'LEFT')
            ->join("__VENDORS__ vendors ON bind.vid=vendors.id", 'LEFT')
            ->join("__DEVICE_TYPE__ type ON d.type_id=type.id", 'LEFT')
            ->join('__USERS__ u ON u.id=d.uid', 'LEFT')
            ->field("statu.*,bind.*,d.device_code,type.*,vendors.*,d.name dname,d.phone,d.address,d.id,d.uid,u.open_id")
            ->order('d.id asc')
            ->limit($page->firstRow.','.$page->listRows)
            ->select();
        // 分配返回数据
        $assign = [
            'show' => $show,
            'data' => $data,
        ];
        return $assign;
    }

    // 分页配置
    public function getPageConfig($page){
        $page -> setConfig('header','共%TOTAL_ROW%条');
        $page -> setConfig('first','首页');
        $page -> setConfig('last','共%TOTAL_PAGE%页');
        $page -> setConfig('prev','上一页');
        $page -> setConfig('next','下一页');
        $page -> setConfig('link','indexpagenumb');//pagenumb 会替换成页码
        $page -> setConfig('theme','%HEADER% %FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');
    }
}