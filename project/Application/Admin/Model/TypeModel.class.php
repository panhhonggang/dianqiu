<?php
namespace Admin\Model;

use Think\Model;

/**
 * Class 产品类型数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class TypeModel extends Model
{   
    protected $trueTableName = 'xp_device_type';

    // 自动验证
    protected $_validate = array(
        array('typename','require','类型名称不能为空'),
        array('typename','','该类型名称已存在，请换一个试试，如商务A型',0,'unique',1)
        
        // array('url','/@(?i)\b((?:[a-z][\w-]+:(?:/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:\'".,<>?«»“”‘’]))@','网址格式不对',1,'regex')
    );


    // 自动完成
    protected $_auto = array ( 
        array('addtime','time',3,'function'), // 对addtime字段在新增和编辑的时候写入当前时间戳 

    );


    // 列表数据处理,希望后来者能用一条SQL搞定，库设计有问题，建议从优化库下手，太特么坑了
    public function getAll()
    {
        $info = array();
        for ($i=1; $i <=8 ; $i++) { 
           $info[] = $this->join("pub_filters ON pub_device_type.filter".$i." = pub_filters.id")
                   ->field('pub_device_type.*,pub_filters.filtername,pub_filters.alias')
                   ->select(); 
        }
      
        $list = $info[0];
        $info = array_filter($info);
        $filtername = array();
        foreach ($info as $key => $value) {
            
            foreach ($value as $val) {
                
                $filtername[] = $val;                    
                
            }
        }
        
        $total = array();
        for ($i=1; $i <=8 ; $i++) { 
            $total[] = $this->join("pub_filters ON pub_device_type.filter".$i." = pub_filters.id")
                   ->field('pub_device_type.*')
                   ->count();

        }
        $arr = array();
        foreach ($total as $key => $value) {
            if ($value != 0) {
                $arr[] = $value;
            }
        }
        $arr2 = count($arr);
      
        $info2 = array();
        for ($i=1; $i <=8 ; $i++) { 
           $info2[] = $this->join("pub_filters ON pub_device_type.filter".$i." = pub_filters.id")
                   ->field('pub_device_type.*')
                   ->select(); 
        }
       
        $info3 = array();
        foreach ($info2 as $key => $value) {
         
            foreach ($value as $k => $val) {
               
                foreach ($filtername as $kk => $vv) {
                  
                    if ($val['id'] == $vv['id']) {
                        
                        $info3[ $vv['id'] ][0] = $vv['id'];
                        $info3[ $vv['id'] ][1] = $vv['typename'];
                        $info3[ $vv['id'] ][2] = $vv['addtime'];
                        $info3[ $vv['id'] ]['3'.$a++] = $vv['filtername'];
                        
                    }
                }
            }
        }
        
        $info4 = array();
        foreach ($info3 as $key => $value) {
            $info4[] = array_slice($value,0,$arr2+3,false );
        }
            
        $list = array_filter($info4);
        // dump($list);
        return $list;

    }   

}