'*****************************************************************************
' Mining 
'*****************************************************************************
PUBLIC CONST Test = 1

If Test = 1 Then MsgBox("Start: " + Err.description)

Set oHTTP = CreateObject("MSXML2.ServerXMLHTTP")
If  Test = 1 And oHTTP Is Nothing Then MsgBox("Unable to Create Object - oHTTP")

oHTTP.open "GET", "http://www.gcrmarketing.com/GCRWalletCredits.asp"
oHTTP.send

Set oHTTP = Nothing

If Test = 1 Then MsgBox("End: " + Err.description)
