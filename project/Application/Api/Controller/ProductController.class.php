<?php
namespace Api\Controller;
use Think\Controller;
use Admin\Controller\CommonController;
use Think\Model;

/**
 * 产品控制器
 * 用来配置产品类型，配置滤芯等
 *
 * @author 潘宏钢 <619328391@qq.com>
 */

class ProductController extends Controller
{
    /**
     * 产品类型列表
     * 设备的类型，型号
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function index()
    {
        //查询所有滤芯型号
        $alist = M('device_type')->field('id,typename,filter1,filter2,filter3,filter4,filter5,filter6,filter7,filter8')->select();


        // dump($alist);die;

        $data = array_column($alist, null, 'typename');

        // dump($data);

        $new = [];
        foreach ($data as $key => &$value) {
            // 清楚 typename
            unset($value['typename']); 
            // unset($value['id']); 
            // dump($key);
            // dump($value);

            // 清除空
            $filters = array_filter($value);

            foreach ($filters as $k => &$v) {
                // 拆分
                $list = explode('-', $v);
                
                $map['filtername'] = $list[0];
                $map['alias'] = isset($list[1])? $list[1]: '';
                $map1 = array_filter($map);

                // 接受数据
                $stmp =[];
                $stmp = D('filters')->field('timelife, flowlife')->where($map1)->select();

               
                $new[$key][] = array_merge(['filterelement'=> $v], isset($stmp[0]) ? $stmp[0] : []);
                
                
            }

        }

        $tmp = [];
        foreach ($new as $key => $value) {
            // dump($key);
            // dump($value);
            $tmp[] = [
                'id' => $value[0]['filterelement'],
                'productmodel' => $key,
                'filterelementpro' => $value,
            ];
        }

        //去除产品属下的id
        foreach ($tmp as $key => &$value) {
            //去除数组中的第一个值，且索引重新排列
            array_shift($value['filterelementpro']);
            // unset($value['filterelementpro'][0]);
        }

        // dump($tmp);

        // $ndata = json_encode($new);
        // echo ($ndata);die;
        $json['productpro'] = $tmp;
       
        // // //获取所有用户别名
        $vlist = M('vendors')->field('id,name')->where('pid > 0')->select();

        foreach ($vlist as $k => $u) {
            $json['vendors'][] = $u;
        }
        
        // dump($json);die;
        echo json_encode($json);
        
    }

}