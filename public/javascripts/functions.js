// Operates on tabs with class "form_tab" - hides all but "tabname"
function switch_tab(tabname)
{
	tabs = $$('.form_tab');	
	for ( var i in tabs )
	{
		tab = tabs[i];
		(tabname == tab.id) ? tab.show() : tab.hide();
	}
	scroll(0,0);
}