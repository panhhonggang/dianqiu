<?php
namespace Org\Util;
/**
* 
*/
class MYExcel
{
    /**
     * 下载文件的名称
     * @var string
     */
	private $filename;
    /**
     * 文件内容标题
     * @var string
     */
	private $title;
    /**
     * Excel文件字段
     * @var array
     */
	private $cellName;
    /**
     * 数据 
     * @var array
     */
	private $data;
    /**
     * 对应Excel的列标
     * @var array
     */
	private $cellKey = array(
                'A','B','C','D','E','F','G','H','I','J','K','L','M',
                'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                'AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ','AK','AL','AM',
                'AN','AO','AP','AQ','AR','AS','AT','AU','AV','AW','AX','AY','AZ'
        );
    /**
     * PHPExcel资源对象
     * @var [type]
     */
	private $objPHPExcel; 
    /**
     * 数据内容显示隔离顶部行数
     * @var integer
     */
	public $topNumber = 2;

	/**
	 * 初始化方法
	 * @param string $filename 导出的Excel文件名称
     * @param string $title 模型名（如Member），用于导出生成文件名的前缀
     * @param array $cellName 表头及字段名
     * @param array $data 导出的表数据
     *
     * 特殊处理：合并单元格需要先对数据进行处理
	 */
	function __construct($filename,$title,$cellName,$data)
	{
		// 引入数据
		$this->filename = $filename?:'default';
		$this->title = $title?:'default';
		$this->cellName = $cellName?:[];
		$this->data = $data?:[];
		// 引入PHPExcel
		require_once VENDOR_PATH.'PHPExcel.php';
		$this->objPHPExcel = new \PHPExcel();
		// 设置默认样式
        $this->setDefualtStyle();
	}

    /**
     * 导入Excel处理方法
     * @return [type] [description]
     */
	public function output()
    {        
        //处理表头标题
        $this->objPHPExcel->getActiveSheet()->mergeCells('A1:'.$this->cellKey[count($this->cellName)-1].'1');//合并单元格（如果要拆分单元格是需要先合并再拆分的，否则程序会报错）
        $this->objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1',$this->title);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(18);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);
        for ($i=0; $i < count($this->cellName); $i++) { 
            $this->objPHPExcel->setActiveSheetIndex(0)->setCellValue($this->cellKey[$i].$this->topNumber, $this->cellName[$i]);
            $this->objPHPExcel->getActiveSheet()->freezePane($this->cellKey[0].($this->topNumber+1));//冻结窗口
            $this->objPHPExcel->getActiveSheet()->getStyle($this->cellKey[$i].$this->topNumber)->getFont()->setBold(true);//设置是否加粗
            $this->objPHPExcel->getActiveSheet()->getStyle($this->cellKey[$i].$this->topNumber)->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);//垂直居中
            $this->objPHPExcel->getActiveSheet()->getStyle($this->cellKey[$i].$this->topNumber)->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        }
        foreach ($this->data as $key => $value) {
            $j = 0;
            foreach ($value as $k => $v) {
                $this->objPHPExcel->setActiveSheetIndex(0)->setCellValue($this->cellKey[$j].($key+$this->topNumber+1), $v.' ');
                $this->objPHPExcel->getActiveSheet()->getStyle($this->cellKey[$j].($key+$this->topNumber+1))->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);               
                
                $j++;
            }           
        }
        
        ob_end_clean();//清除缓冲区,避免乱码 
        // 输出Excel表格到浏览器下载
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$this->filename.'.xls"');
        header('Cache-Control: max-age=0');
        // If you're serving to IE 9, then the following may be needed
        header('Cache-Control: max-age=1');
        // If you're serving to IE over SSL, then the following may be needed
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT'); // always modified
        header('Cache-Control: cache, must-revalidate'); // HTTP/1.1
        header('Pragma: public'); // HTTP/1.0
        $objWriter = new \PHPExcel_Writer_Excel5($this->objPHPExcel);
        $objWriter->save('php://output');
    }

    /**
     * 设置默认样式
     */
    public  function  setDefualtStyle()
    {
       // 写在处理的前面（了解表格基本知识，已测试）
         $this->objPHPExcel->getActiveSheet()->getDefaultRowDimension()->setRowHeight(20);//所有单元格（行）默认高度
         $this->objPHPExcel->getActiveSheet()->getDefaultColumnDimension()->setWidth(20);//所有单元格（列）默认宽度
         $this->objPHPExcel->getActiveSheet()->getRowDimension('1')->setRowHeight(30);//设置行高度
         $this->objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(30);//设置列宽度
         $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(18);//设置文字大小
         $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);//设置是否加粗
         $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->getColor()->setARGB(\PHPExcel_Style_Color::COLOR_WHITE);// 设置文字颜色
         $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);//设置文字居左（HORIZONTAL_LEFT，默认值）中（HORIZONTAL_CENTER）右（HORIZONTAL_RIGHT）
         $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);//垂直居中
         $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFill()->setFillType(\PHPExcel_Style_Fill::FILL_SOLID);//设置填充颜色
         $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFill()->getStartColor()->setARGB('FF7F24');//设置填充颜色
    }

}