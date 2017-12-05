<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
use Think\Controller;

/**
 * Class DevicesController
 * @package Admin\Controller
 * @author 陈昌平 <chenchangping@foxmail.com>
 */
class DevicesController extends CommonController
{
    /**
     * 显示设备列表
     */
    public function devicesList()
    {
        $map = '';
        if(!empty($_GET['name'])) $map['name'] = array('like',"%{$_GET['name']}%");
        $devices = M('Devices');
        $count = $devices
                ->where($map)
                ->join('xp_devices_statu ON xp_devices.device_code = xp_devices_statu.DeviceID')
                  ->join('xp_crew ON xp_devices.device_code = xp_crew.dcode')
                  ->join('xp_device_type ON xp_devices.type_id = xp_device_type.id')
                  ->join('xp_binding ON xp_crew.id = xp_binding.cid')
                  ->join('xp_vendors ON xp_binding.vid = xp_vendors.id')
                  ->field('xp_devices.*,xp_device_type.typename,xp_crew.dcode,xp_crew.cname,xp_vendors.name,xp_devices_statu.updatetime')
                ->count();
        $Page   = new \Think\Page($count,25);
        $show   = $Page->show();

        $vendor = $devices
                  ->where($map)
                  ->join('xp_devices_statu ON xp_devices.device_code = xp_devices_statu.DeviceID')
                  ->join('xp_crew ON xp_devices.device_code = xp_crew.dcode')
                  ->join('xp_device_type ON xp_devices.type_id = xp_device_type.id')
                  ->join('xp_binding ON xp_crew.id = xp_binding.cid')
                  ->join('xp_vendors ON xp_binding.vid = xp_vendors.id')
                  ->field('xp_devices.*,xp_device_type.typename,xp_crew.dcode,xp_crew.cname,xp_vendors.name,xp_devices_statu.updatetime')
                  ->limit($Page->firstRow.','.$Page->listRows)
                  ->select();
        $array = array('正常', '冲洗','缺水', '漏水', '检修','欠费', '关机');
        foreach ($vendor as $key => $value) {
            $vendor[$key]['device_status'] = $array[$value['device_status']];
        }

        $this->assign('deviceInfo', $vendor);
        $this->assign('page',$show);
        $this->display('devicesList');
    }

    // 查询设备详情
    public function deviceDetail()
    {
        $code        = I('post.code');
        $devices     = D('devices');
        $res         = $devices->getInfoBydecode($code);
        $res['flow'] = M('consume')->where('did='.$res['id'])->sum('flow');
        $this->ajaxReturn($res, 'json');
    }

    /**
     * 显示设备添加页面
     */
    public function show_add_device()
    {
        $res = M('DeviceType')->select();
        $this->assign('res', $res);
        $this->display('show_add_device');
    }

    /**
     * 设备添加处理
     */
    public function add_device( $code=null )
    {
        $devices = D('Devices');
        $code = I('post.');

        if(!$devices->create()){
            $this->error($devices->getError(), 'show_add_device');
        }
        if(!$devices->add()){
            $this->error('添加失败', 'show_add_device');
        } else {
            $this->success('添加成功', 'show_add_device', 3);
        }


    }

    /**
     * 批量上传
     * @return [type] [description]
     */
    public function upload()
    {   
        header("Content-Type:text/html;charset=utf-8");
        $upload = new \Think\Upload(); // 实例化上传类
        $upload->maxSize = 3145728; // 设置附件上传大小
        $upload->exts = array(
            'xls',
            'xlsx'
        ); // 设置附件上传类
        $upload->savePath = '/'; // 设置附件上传目录
        // 上传文件
        $info = $upload->uploadOne($_FILES['batch']);
        $filename = './Uploads' . $info['savepath'] . $info['savename'];
        $exts = $info['ext'];

        if (! $info) { 
            // 上传错误提示错误信息
            $this->error($upload->getError());
        } else { 
            // 上传成功
            $this->goods_import($filename, $exts);
        }
    }

    public function save_import($data)
    {   
        $i = 0;
        foreach ($data as $key => $val) {
            $_POST['device_code'] = $val['A'];
            $_POST['type_id'] = (string)$val['B'];
            $datas['addtime'] = time();
            $Devices = D('Devices'); 
            $res = D('Devices')->getCate();
            $info = $Devices->create();
            if($info){
                if(!in_array($_POST['type_id'], $res)){
                    $this->error('已导入' . $i . '条数据<br>' . $_POST['device_code'] . '设备类型不存在');
                }
                $res = $Devices->add();
                if (!$res) {
                    
                    $this->error('导入失败啦！');
                }
            } else {
                $this->error('已导入' . $i . '条数据<br>' . $_POST['device_code'] . '不正确');
            }   
            $i ++;
        }

        $this->success($i . '条数据导入成功');
    }

    private function getExcel($fileName, $headArr, $data)
    {
        vendor('PHPExcel');
        $date = date("Y_m_d", time());
        $fileName .= "_{$date}.xls";
        $objPHPExcel = new \PHPExcel();
        $objProps = $objPHPExcel->getProperties();
        // 设置表头
        $key = ord("A");
        foreach ($headArr as $v) {
            $colum = chr($key);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue($colum . '1', $v);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue($colum . '1', $v);
            $key += 1;
        }
        $column = 2;
        $objActSheet = $objPHPExcel->getActiveSheet();

        foreach ($data as $key => $rows) { 
            // 行写入
            $span = ord("A");
            foreach ($rows as $keyName => $value) { 
                // 列写入
                $j = chr($span);
                $objActSheet->setCellValue($j . $column, $value);
                $span ++;
            }
            $column ++;
        }
        
        $fileName = iconv("utf-8", "gb2312", $fileName);
        // 重命名表
        // 设置活动单指数到第一个表,所以Excel打开这是第一个表
        $objPHPExcel->setActiveSheetIndex(0);
        header('Content-Type: application/vnd.ms-excel');
        header("Content-Disposition: attachment;filename=\"$fileName\"");
        header('Cache-Control: max-age=0');
        
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output'); // 文件通过浏览器下载
        exit();
    }

    protected function goods_import($filename, $exts = 'xls')
    {
        // 导入PHPExcel类库，因为PHPExcel没有用命名空间，只能inport导入
        vendor('PHPExcel');
        // 创建PHPExcel对象，注意，不能少了\
        $PHPExcel = new \PHPExcel();
        // 如果excel文件后缀名为.xls，导入这个类
        if ($exts == 'xls') {
            $PHPReader = new \PHPExcel_Reader_Excel5();
        } else 
            if ($exts == 'xlsx') {
                $PHPReader = new \PHPExcel_Reader_Excel2007();
            }
        
        // 载入文件
        $PHPExcel = $PHPReader->load($filename);
        // 获取表中的第一个工作表，如果要获取第二个，把0改为1，依次类推
        $currentSheet = $PHPExcel->getSheet(0);
        // 获取总列数
        $allColumn = $currentSheet->getHighestColumn();
        // 获取总行数
        $allRow = $currentSheet->getHighestRow();
        // 循环获取表中的数据，$currentRow表示当前行，从哪行开始读取数据，索引值从0开始
        for ($currentRow = 2; $currentRow <= $allRow; $currentRow ++) {
            // 从哪列开始，A表示第一列
            for ($currentColumn = 'A'; $currentColumn <= $allColumn; $currentColumn ++) {
                // 数据坐标
                $address = $currentColumn . $currentRow;
                // 读取到的数据，保存到数组$arr中
                $data[$currentRow][$currentColumn] = $currentSheet->getCell($address)->getValue();
            }
        }
        $this->save_import($data);
    }
}