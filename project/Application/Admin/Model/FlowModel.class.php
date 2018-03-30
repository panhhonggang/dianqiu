<?php
namespace Admin\Model;

use Think\Model;
use Org\Util\Date;
/**
 * Class 充值数据处理
 * @package Admin\Model
 * @author 潘宏钢 <619328391@qq.com>
 */
class FlowModel extends Model
{   

    // 处理查询数据
    public function getAll()
    {
       $data = $this->select();
       return $data;
    }

    // 获取当月充值数据
    public function getCurrentMonth()
    {
        $date = new Date();
        $firstDayOfMonth = $date->firstDayOfMonth();
        $firstat = strtotime($firstDayOfMonth);
        $lastDayOfMonth = $date->lastDayOfMonth();
        $lastat = strtotime($lastDayOfMonth) + 24*60*60;

        $map['addtime'] = array(array('gt',$firstat),array('lt',$lastat), 'and');
        $map['_query'] = "status=1";

        if($_SESSION['adminuser']['leavel']>0){
            $map=[
                'f.addtime' => array(array('gt',$firstat),array('lt',$lastat), 'and'),
                'f.status' => "1",
            ];
            $map['b.vid']=$_SESSION['adminuser']['id'];
            $data = $this
                ->where($map)
                ->alias('f')
                ->join('__BINDING__ b on f.did = b.did','LEFT')
                ->select();
        }else{
            $data = $this->where($map)->select();
        }

        return $data;
    }

    // 当月每一天的数据条数
    public function getTotalByEveryDay($data=[])
    {
        if (count($data) == 0) {
            $data = $this->getCurrentMonth();
        }
        $date = new Date();
        $maxDayOfMonth = $date->maxDayOfMonth();
        $firstDayOfMonth = $date->firstDayOfMonth();
        $startat = strtotime($firstDayOfMonth);
        $result = [];

        for ($i=0; $i < $maxDayOfMonth; $i++) { 
          foreach ($data as $key => $value) {
            if ($value['addtime'] >= $startat && $value['addtime'] <= $startat+24*60*60) {
              $result["$i"+1]['count'] += 1;
              $result["$i"+1]['money'] += $value['money'];
              $result["$i"+1]['num']  += $value['num'];
              $result["$i"+1]['flow'] += $value['currentflow'];            
            }else{
              if (!array_key_exists($i+1,$result)) {
                $result["$i"+1] = null;
              }
            }
          }
          $startat = $startat+24*60*60;
        }
        return $result;
    }
}