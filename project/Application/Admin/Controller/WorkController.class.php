<?php
namespace Admin\Controller;
use Think\Controller;

/**
 * 工单控制器
 * 用来添加工单，浏览工单列表等
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class WorkController extends CommonController 
{
	/**
     * 工单列表
     * 
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {	
       // 根据名称进行搜索
         $map = '';
      if(strlen($_GET['number'])) $map['number'] = array('like',"%{$_GET['number']}%");
        if (!empty($_GET['key']) && !empty($_GET['value'])) {
            switch ($_GET['key']) {
                case '1':
                    $map['name'] = array('like',"%{$_GET['value']}%");
                    break;
                case '2':
                    $map['phone'] = array('like',"%{$_GET['value']}%");                  
                    break;
                case '3':
                    $map['address'] = array('like',"%{$_GET['value']}%");
                    break;
                default:
                    # code...
                    break;
            }
        }      
        $type = D('work');
        if($this->get_level()){
            //$map['pub_binding.vid'] = $_SESSION['adminuser']['id']; //缺少数据字段 后续维护
        }
        $total =$type->where($map)->count();
        $page  = new \Think\Page($total,8);
        $pageButton =$page->show();

        $list = $type->where($map)->limit($page->firstRow.','.$page->listRows)->getAll();
        // dump($list);die;
        $this->assign('list',$list);
        $this->assign('button',$pageButton);
        $this->display();
    }

    public function add()
    {
        if (IS_POST) {
            // dump($_POST);die;
            $device_type = D('work');
            $data = I('post.');
            $data['address'] = $data['address'].$data['add_ress'];
            $info = $device_type->create();
            if($info){
                if($data['type'] == 1){
                    $status = ['status'=>2];
                    M('repair')->where('id='.$data['repair_id'])->save($status);
                }
                $res = $device_type->add($data);
                if ($res) {
                    $this->success('工单添加成功啦！！！',U('work/index'));
                } else {
                    $this->error('工单添加失败啦！');
                }
            
            } else {
                // getError是在数据创建验证时调用，提示的是验证失败的错误信息
                $this->error($device_type->getError());
            }

        }else{
            $map['id'] = I('id');
            $repairData = M('Repair')->where($map)->field('device_code,address')->find();
            $where['v_id'] = session('adminuser.id');
            $personnelData = M('personnel')->where($where)->field('id,name,phone')->select();
            // dump($repairData);
            $assign = [
                'repairId' => $map['id'],
                'repairData' => $repairData,
                'personnelData' => $personnelData,
            ];
            $this->assign($assign);
            $this->display();
        }
    }

    public function edit($id,$result)
    {
        $work = M("work");
        $repair = M('repair');
        $data['result'] = $_GET['result'];
        $res = $work->where('id='.$id)->save($data); 
        if ($res) {
            $repair_id = $work->where('id='.$res)->getField('repair_id');
            $status = ['status'=>1];
            $res_repair = $repair->where('id='.$repair_id)->save($status);
            // echo $repair->_sql();
            // dump($res_repair);die;
            if($res_repair){
                $this->redirect('work/index');
            }
            // echo 1111;
        } else {
            $this->error('修改失败啦！');
        }
    }

    /**
     * 删除类型方法（废除）
     * 不做删除，只做隐藏，如果要做删除产品类型，请确保产品类型没有被设备所用 
     *
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function del()
    {

    }

    public function personnel()
    {
        try {
            $map['id'] = I('post.id');
            $phone = M('Personnel')->where($map)->getField('phone');
            echo $phone;
        } catch (\Exception $e) {
            $err = [
                'code' => $e->getCode(),
                'msg' => $e->getMessage(),
            ];
            $this->ajaxReturn($err);
        }
    }

}