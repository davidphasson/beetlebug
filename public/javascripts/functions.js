// Operates on tabs with class "form_tab" - hides all but "tabname"
function switch_tab(tabname)
{
	tabs = $$('.form_tab');	
	for ( var i in tabs )
	{
		tab = tabs[i];
		if(tabname == tab.id)
		{
			tab.show()
			$("tab_" + tab.id).className = "tab currtab"
		}
		else
		{
			tab.hide();
			$("tab_" + tab.id).className = "tab"
		}
	}
	scroll(0,0);
}