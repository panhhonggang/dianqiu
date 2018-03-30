<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 工单数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class WorkModel extends Model
{   

    // 自动验证
    protected $_validate = array(
        array('number','require','工单号不能为空'),
        array('number','/^[\w-]{1,30}$/u','工单号格式不正确',0,'regex'),
        array('name','require','处理人不能为空'),
        array('phone','/^1[34578]\d{9}$/','电话号码格式不对',0,'regex'),
        array('content','require','工作内容不能为空'),
        // array('address','require','地址不能为空'),
        array('name','/^([\xe4-\xe9][\x80-\xbf]{2}){2,4}$/','请输入真实姓名',0,'regex')
        
        // array('cname','','该机组名称已存在，请换一个试试，如清华大学清华园1号机',0,'unique',1)
        
    );


    // 自动完成
    // protected $_auto = array ( 
    //     array('addtime','time',3,'function'), // 对addtime字段在新增和编辑的时候写入当前时间戳 
    // );

    // 处理查询数据
    public function getAll()
    {
        $list = $this->select();

        $type = array('安装','维修','维护');
        $result = array('未处理','正在处理','已处理');
        foreach ($list as $key => $val) {
            $list[$key]['type'] = $type[$val['type']];
            $list[$key]['result'] = $result[$val['result']];
        }
        return $list;
    }


}