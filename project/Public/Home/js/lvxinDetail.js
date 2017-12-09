window.onload=function ()
{
	var oTab=new TabSwitch('tabs');
};

function TabSwitch(id)
{
	var oDiv=document.getElementById(id);
	this.aBtn=oDiv.getElementsByTagName('input');
	this.aDiv=oDiv.getElementsByTagName('div');
	var i=0;
	
	var _this=this;
	
	for(i=0;i<this.aBtn.length;i++)
	{
		this.aBtn[i].index=i;
		this.aBtn[i].onclick=function ()
		{
			_this.tab(this);

		};
	}
}

TabSwitch.prototype.tab=function (oBtn)
{
	for(i=0;i<this.aBtn.length;i++)
	{
		this.aBtn[i].className='';
		this.aDiv[i].style.display='none';
	}
	oBtn.className='active';
	this.aDiv[oBtn.index].style.display='block';
	this.aDiv[oBtn.index].style.background="red";
};