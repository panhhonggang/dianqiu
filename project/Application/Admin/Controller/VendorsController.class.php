<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 经销商控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class VendorsController extends CommonController 
{
	/**
     * 经销商列表（本质就是后台用户）
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {
        // dump($phpExcel);
        // 搜索功能
        $map = array(
            'user' => array('like','%'.trim(I('post.user')).'%'),
            'name' => array('like','%'.trim(I('post.name')).'%'),
            'phone' => array('like','%'.trim(I('post.phone')).'%'),
            'email' => array('like','%'.trim(I('post.email')).'%'),
            'address' => array('like','%'.trim(I('post.address')).'%'),
            'idcard' => array('like','%'.trim(I('post.idcard')).'%'),
            'leavel' => trim(I('post.leavel')),
        );
        $minaddtime = strtotime(trim(I('post.minaddtime')))?:0;
        $maxaddtime = strtotime(trim(I('post.maxaddtime')))?:-1;
        if (is_numeric($maxaddtime)) {
            $map['addtime'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
        }
        if ($maxaddtime < 0) {
            $map['addtime'] = array(array('egt',$minaddtime));
        }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        $user = D('vendors');
        // PHPExcel 导出数据
        if (I('output') == 1) {
            $data = $user->where($map)
                        ->field('id,user,name,phone,email,address,idcard,leavel,addtime')
                        ->select();
            $arr = [
                'addtime'=>'Y-m-d H:i:s',
                'leavel' => ['超级管理员','一级经销商','二级经销商']
            ];
            replace_value($data,$arr);
            $filename = '经销商列表数据';
            $title = '经销商列表';
            $cellName = ['用户Id','账号','昵称','手机号','邮箱','地址','身份证号','管理级别','最新添加时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }



        $total = $user->where($map)->count();
        $page  = new \Think\Page($total,8);
        D('devices')->getPageConfig($page);
        $pageButton =$page->show();

        $userlist = $user->where($map)->limit($page->firstRow.','.$page->listRows)->order('addtime desc')->getAll();

        $this->assign('list',$userlist);
        $this->assign('button',$pageButton);
        $this->display();
    }

    /**
     * 添加经销商方法
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function add()
    {
        if(IS_POST){

            
            //将三级联动地址拼接具体地址再写入数据库
            $_POST['address'] = $_POST['address'].$_POST['detail'];
            
            $user = D('vendors');
            $info = $user->create();

            if($info){

                $res = $user->add();
                if ($res) {
                    $this->success('添加经销商成功啦！！！',U('Vendors/index'));
                } else {
                    $this->error('添加经销商失败啦！');
                }
            
            } else {
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($user->getError());
            }
        }else{
            $this->display();
        }
    }

    /**
     * 编辑经销商方法
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function edit($id)
    {
        if(IS_POST){

            
            //将三级联动地址拼接具体地址再写入数据库
            $_POST['address'] = $_POST['address'].$_POST['addr'];

            // dump($_POST);die;


            $user = D('vendors');
            if(empty($_POST['password'])) {
                unset($_POST['password']);
            } else {
                $_POST['password'] = md5($_POST['password']);
            }
            // empty($_POST['password'])?unset($_POST['password']):$_POST['password'];
            $userinfo = $user->create();
            if ($userinfo) {
                $res = $user->save();
                if($res && $_SESSION['adminuser']['id'] == $_POST['id']) {
                    $this->success('编辑经销商成功啦！！！',U('Login/login'));
                    exit;
                }
                if ($res) {
                    $this->success('编辑经销商成功啦！！！',U('Vendors/index'));
                } else {
                    $this->error('编辑经销商失败啦！');
                }                
            }else{
                $this->error($user->getError());
            }

        } else {
            $info[] = D('vendors')->find($id);
            $this->assign('info',$info);
            $this->display();
        }
    }
    
    /**
     * 删除经销商方法
     * 需保证其没有下级，没有设备与之挂钩
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function del($id)
    {
        $userinfo = M('vendors')->where("id=".$id)->select();

        if ($userinfo[0]['leavel'] == 0 ) {
            $this->error('不能删除超级管理员！');
        }else{
            $res = M('binding')->where("vid=".$id)->select();
            if(!empty($res)){
                $this->error('已绑定设备，不可删除');
                return false;
            }
            // 查
            $res = D('vendors')->delete($id);
            if($res){
                $this->success('删除成功',U('index'));
            }else{
                $this->error('删除失败');
            }

        }
    }

    /**
     * 机组绑定经销商方法
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function devices_add()
    {
        if (IS_POST) {

            //查找设备的id
            $did1 = M('devices')->where('device_code='.$_POST['dcode'])->field('id')->find();

            // dump($did1);die;
            if ($did1) {
                if ($_POST['vid']) {
                    $arr = array(
                        'vid' => I('vid'),
                        'did' => $did1['id'],
                        'operator' => $_SESSION['adminuser']['name'],
                        'addtime' => time(),
                    );
                    
                    // dump($arr);die;
                    // 添加
                    $binding = M('binding');
                    if($binding->where('did='.$did1['id'])->find()){
                        return $this->error('设备已绑定过经销商');
                    }
                    if ($binding->add($arr)) {
                        // 更改设备的绑定状态
                        $devices = M('devices');  
                        $devices->where($did)->setField('binding_statu','1');

                        $this->success('添加成功',U('bindinglist'));
                    }else{
                        $this->error('添加失败啦');
                    }

                }else{
                    $this->error('经销商不存在！请在经销商管理中添加经销商后尝试！正在为您跳转至经销商管理',U('index')); 
                }

            }else{
                $this->error('设备不存在或已无未绑定设备！请在设备管理中添加设备后尝试！正在为您跳转至设备管理',U('Devices/show_add_device'),5);
            }   

        }else{

            if(!empty($_SESSION['adminuser'])){
                // 获取经销商信息
                $case = $_SESSION['adminuser']['leavel'];

                switch ($case) {
                    
                    case '0':
                        $user = D('vendors')->getAll();
                        break;

                    case '1':
                    // 一级经销商只能给二级经销商绑定设备，如需再往下分级，则case '2' leavel=3
                        $user = M('vendors')->where('leavel=2')->select();

                        break;    
                    
                    default:
                        # code...
                        break;
                }

                // 获取设备信息
                $devices = M('devices')->where('binding_statu=0')->select();

                $this->assign('user',$user);
                $this->assign('devices',$devices);
                $this->display();
            }else{
                $this->error('登录失效，请重新登陆！',U('Login/login'));
            }
            
        }

    }

    /**
     * 设备所属经销商列表
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function bindinglist()
    {
        // 搜索功能
        $map = array(
            'pub_devices.device_code' => array('like','%'.trim(I('post.device_code')).'%'),
            'pub_vendors.phone' => array('like','%'.trim(I('post.phone')).'%'),
            'pub_vendors.name' => array('like','%'.trim(I('post.name')).'%'),
        );
        if($this->get_level()){
            $map['pub_vendors.id'] = $_SESSION['adminuser']['id'];
        }
         $minaddtime = strtotime(trim(I('post.minaddtime')))?:0;
         $maxaddtime = strtotime(trim(I('post.maxaddtime')))?:-1;
         if (is_numeric($maxaddtime)) {
             $map['pub_binding.addtime'] = array(array('egt',$minaddtime),array('elt',$maxaddtime));
         }
         if ($maxaddtime < 0) {
             $map['pub_binding.addtime'] = array(array('egt',$minaddtime));
         }
        // 删除数组中为空的值
        $map = array_filter($map, function ($v) {
            if ($v != "") {
                return true;
            }
            return false;
        });

        $binding = M('binding');
        // PHPExcel 导出数据
        if (I('output') == 1) {
            $data = $binding->where($map)
                ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                ->join('pub_devices ON pub_binding.did = pub_devices.id')
                ->field('pub_vendors.id,pub_binding.did,pub_devices.device_code,pub_vendors.name,pub_vendors.phone,pub_binding.addtime')
                ->select();
            $arr = ['addtime'=>'Y-m-d H:i:s'];
            replace_value($data,$arr);
            $filename = '设备归属列表数据';
            $title = '设备归属列表';
            $cellName = ['经销商id','设备id','设备编码','经销商姓名','经销商手机','添加时间'];
            // dump($data);die;
            $myexcel = new \Org\Util\MYExcel($filename,$title,$cellName,$data);
            $myexcel->output();
            return ;
        }


        
        $total =$binding->where($map)
                    ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                    ->join('pub_devices ON pub_binding.did = pub_devices.id')
                    ->field('pub_binding.*,pub_vendors.name,pub_vendors.phone,pub_devices.device_code')
                    ->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $bindinglist = $binding->where($map)
                                ->limit($page->firstRow.','.$page->listRows)
                                ->join('pub_vendors ON pub_binding.vid = pub_vendors.id')
                                ->join('pub_devices ON pub_binding.did = pub_devices.id')
                                ->field('pub_binding.*,pub_vendors.name,pub_vendors.phone,pub_devices.device_code')
                                ->order('pub_binding.addtime desc')
                                ->select();
//        dump($map);
        $this->assign('list',$bindinglist);
        $this->assign('button',$pageButton);
        $this->display(); 
    }

    /**
     * 解除绑定方法
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function bindingdel($id,$did)
    {
        
        if ($_SESSION['adminuser']['leavel'] == 0) {
            
            $res = D('binding')->delete($id);
            if($res){
                // 更新设备绑定状态
                $devices = M('devices');  
                $devices->where('id='.$did)->setField('binding_statu','0');
                $this->success('解除成功',U('bindinglist'));
            }else{
                $this->error('解除失败');
            }

        }else{
           $this->error('对不起，您没有权限解除绑定！',U('bindinglist'));
        }
    }

    /**
     * 修改密码方法
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function password()
    {
        if (IS_POST) {
            $old = md5(I('oldpassword')); 
            $new = md5(I('newpassword')); 
            $re = md5(I('repassword'));
            $id = I('id');
            if($old === $new) $this->error('新密码与旧密码一致');
            if ($new == $re) {
                $user = M('Vendors');
                $info = $user->where('id='.$id)->getField('password');
                
                if ($old == $info) {
                    $res = $user->where('id='.$id)->setField('password',$new);
                    if ($res) {
                        $this->success('修改密码成功，请重新登录！',U('Login/logout'));
                    }else{
                        $this->error('修改密码失败！');
                    }

                }else{
                    $this->error('原密码错误，请重新输入！');
                }

            }else{
                $this->error('两次密码不一样，请重新输入！');
            }

        }else{
            $this->display();
        }
    }



    /**
     * 批量设置设备归属
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
        $info = $upload->uploadOne($_FILES['file']);
        $filename = './Uploads' . $info['savepath'] . $info['savename'];
        $exts = $info['ext'];
        // dump($_POST);
        // dump($_FILES);die;
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
        // dump($data);die;
        $device = D('devices');
        $bind = M('binding');
        $device->startTrans();
        $arr = I('post.');
        $arr['operator'] = session('adminuser.name');
        foreach ($data as $key => $val) {
            $map['device_code'] = $val['A'];
            $res = $device->where($map)->field('id,binding_statu')->find();
            if(empty($res)){
                $this->error($map['device_code'].'设备不存在，请检查后再重新设置');
            } else {
                $bind_res = $bind->where('did='.$res['id'])->find();
                if( $res['binding_statu'] || $bind_res ) $this->error($map['device_code'].'已设置归属');
            }
            $arr['did'] = $res['id'];
            $arr['addtime'] = time();
            $statu['binding_statu'] = 1;
            $bind->add($arr);
            $device_statu = $device->where('id='.$arr['did'])->save($statu);
            if( !$device_statu ) {
                $device->rollback();
                $this->error('设置失败');
            }
        }
        $device->commit();
        $this->success('设置成功');
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