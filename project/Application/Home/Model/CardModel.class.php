<?php
namespace Home\Model;
use Think\Model;
class CardModel extends Model 
{
    protected $_validate = array(
        array('iccard','require','IC卡编号不能为空'), //默认情况下用正则进行验证 
        array('studentcode','require','学籍号不能为空'), //默认情况下用正则进行验证 
        array('school','require','学校不能为空'), //默认情况下用正则进行验证 

        //学校名中文
        array('school','/^([\xe4-\xe9][\x80-\xbf]{2}){4,20}$/','请输入真实学校名',1,'regex'),
        array('studentcode','/^\d{5,11}$/','请输入真实学籍号',1,'regex')

    );

    public function getIccard()
    {
    	$map['iccard'] = array('eq', $_POST['iccard']);
    	//查询IC号是否存在
    	$res = $this->where($map)->find();
    	if($res){
    		return $res;
    	}else{
    		return false;
    	}
    }

}