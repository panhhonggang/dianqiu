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

        // 查询条件
        $map = '';
        // if(!empty($_GET['code'])) $map['device_code'] = array('like',"%{$_GET['code']}%");
        if (!empty($_GET['key']) && !empty($_GET['value'])) {
            switch ($_GET['key']) {
                case '1':
                    $map['device_code'] = array('like',"%{$_GET['value']}%");
                    break;
                case '2':
                    $map['vendors.name'] = array('like',"%{$_GET['value']}%");
                    break;
                case '3':
                    $map['type.typename'] = array('like',"%{$_GET['value']}%");
                    break;
                default:
                    # code...
                    break;
            }
        }
        if($this->get_level()){
            $map['vendors.id'] = $_SESSION['adminuser']['id'];
        }
        $devices = D('Devices')->getDevicesInfo($map);

        $arr = [
            'netstause'=>['0'=>'未链接','1'=>'链接中','n'=>'未链接']
        ];
        replace_value($devices['data'],$arr);
//

        $assign = [
            'deviceInfo' => $devices,
        ];

        //dump($devices['data']);
        
        $this->assign($assign);
        $this->display('devicesList');
    }

    public function userBindDvice()
    {
        
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

    // 设备详情
    public function deviceDetail()
    {
        $map['device_code'] = I('get.code');
        // 状态信息
        $data['statu'] = D('devices')
            ->where($map)
            ->alias('d')
            ->join("__DEVICES_STATU__ statu ON d.device_code=statu.DeviceID", 'LEFT')
            ->join("__BINDING__ bind ON d.id=bind.did", 'LEFT')
            ->join("__VENDORS__ vendors ON bind.vid=vendors.id", 'LEFT')
            ->join("__DEVICE_TYPE__ type ON d.type_id=type.id", 'LEFT')
            ->field("statu.*,bind.*,vendors.*,type.*,d.*")
            ->find();

        // 滤芯信息
        $filter = D('devices')
            ->where($map)
            ->alias('d')
            ->join("__DEVICE_TYPE__ type ON d.type_id=type.id", 'LEFT')
            ->field('type.*') 
            ->find();
        $data['filterInfo'] = $this->getFilterDetail($filter);

        // 获取经销商信息
        $data['vendor'] = D('devices')
            ->where($map)
            ->alias('d')
            ->join('__BINDING__ bind ON d.id=bind.did', 'LEFT')
            ->join('__VENDORS__ v ON bind.vid=v.id', 'LEFT')
            ->field('v.*')
            ->find();
        // 获取使用记录
        // $data['list'] = D('devices')
        //     ->where($map)
        //     ->alias('d')
        //     ->join('__CONSUME__ c ON d.id=c.did', 'LEFT')
        //     ->select();
        $this->ajaxReturn($data);
    }

    // 查询滤芯详情
    public function getFilterDetail($sum)
    {
        unset($sum['id'],$sum['typename'],$sum['addtime']);
        $sum = array_filter($sum);
        foreach ($sum as $key => $value) {
            $str = stripos($value,'-');
            $map['filtername'] = substr($value, 0,$str);
            $map['alias'] = substr($value, $str+1);
            $res[] = M('filters')->where($map)->find();
        }
        return $res;
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
            $code = $Devices->where("device_code='{$_POST['device_code']}'")->find();
            if(!empty($code)) $this->error( '已导入' . $i . '条数据<br>' . $_POST['device_code'] . '已存在');
            if($info){
                if(!in_array($_POST['type_id'], $res)){
                    $this->error('已导入' . $i . '条数据<br>' . $_POST['device_code'] . '设备类型不存在');
                }
                $res = $Devices->add();
                if (!$res) {
                    
                    $this->error('导入失败啦！');
                }
            } else {
                $this->error('已导入' . $i . '条数据<br>');
            }   
            $i ++;
        }
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

    // 解除绑定
    public function remove()
    {
        $code = I('get.');
        if(empty($code)){
            $this->error('设备编码错误');
        }
        $res = M('devices')->where($code)->find();
        if($res['uid']) $this->error("已绑定了用户，不可解除绑定");
        if($res) $delBind = M('binding')->where('did='.$res['id'])->delete();
        if($res || $delBind){
            $data['binding_statu'] = 0;
            $data = M('devices')->where($code)->save($data);
        }
        if(!$data) $this->error('解绑失败');
        $this->success('解绑成功');

    }

}