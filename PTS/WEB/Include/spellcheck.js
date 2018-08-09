function SpellCheck(obj)
{
	oWord = new ActiveXObject("Word.Application");

	if ( typeof oWord == 'undefined' )
		alert('Unable to start MS Word for spell checking.\n Active X is not enabled for this site or MS Word is not available.'); 
	else {
		obj.focus();
		obj.select();
		range = obj.createTextRange()
		range.execCommand("Copy")
		
		oShell= new ActiveXObject("WScript.Shell");
//		oShell.SendKeys( "^c" ); // copy
		oWord.Documents.Add();
		oWord.Selection.Paste();
		oWord.ActiveDocument.CheckSpelling();
		oWord.Selection.WholeStory();
		oWord.Selection.Copy();
		oWord.ActiveDocument.Close(0);
		oWord.Quit();
		var nRet= oShell.Popup( "HTMLArea finished checking your document.\nApply changes? Click OK to replace the corrected words.",0,"Spell Check Complete",33 );
		if ( nRet == 1 ) {oShell.SendKeys( "^v" );}// paste
		oShell.SendKeys( "^{HOME}" );
	}
}
