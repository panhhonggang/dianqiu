<?php
namespace Admin\Model;
use Think\Model;


class BindingModel extends Model
{
    public function getInfoByVendors($id)
    {
        $res = $this->where('vid=' . $id)->select();

        return $res;
    }
}