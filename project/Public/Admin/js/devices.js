$('.add_device').click(function(){
    var fileName = $('.filename').val();
    if( fileName == '' ){
        alert('请选择导入的文件')
        return false
    }
})