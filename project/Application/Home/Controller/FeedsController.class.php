<?php
namespace Home\Controller;
use Think\Controller;

/**
 * 客户建议控制器
 * 
 * @author 潘宏钢 <619328391@qq.com>
 */

class FeedsController extends CommonController 
{
	/**
     * 建议页面
     * @author 潘宏钢 <619328391@qq.com>
     */
    public function proposal()
    {	
        if (IS_POST) {
            // 接收用户输入数据
            $arr = array(
                'content' => I('content'),
                'uid' => $_SESSION['homeuser']['id'],
                'addtime' => time(),
                'did' => $_SESSION['homeuser']['did'],
            );

            // 实例化
            $feeds = M('feeds');
            if ($feeds->add($arr)) {
                $this->success('感谢您的建议，我们会仔细阅读并做出相应调整，谢谢！',U('Index/index'));
            }else{
                $this->error('一不小心服务器偷懒了~');
            }

        }else{
            $this->display();
        }
    
    }

}