<%@ Language=VBScript %>
<% Option Explicit %>
<html><head><title>Browse For Pictures</title></head>
<body bgcolor="white">
<!--#include file="dirwalk.asp" -->
<%
'Released under the (Modified) BSD license
'Copyright (c) 2002-2003, S Babu, vsbabu@vsbabu.org, http://vsbabu.org/
'All rights reserved.

'Modifications, security addon and adaptation to htmlArea released
'under the (Modified) BSD license
'Copyright (c) 2002-2003, P Engvall, pengvall@engvall.nu, http://www.engvall.nu/
'All rights reserved.
dim reqSysServerPath, pos
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(reqSysServerPath, "/Include")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

'''Prints a link for copying the path to some form field
Sub PrintCopyLink(strPath, strName)
  'URLs are different from DOS directory seps
  strPath = reqSysServerPath & "/" & Replace(CutRootFolder(strPath), "\", "/") 
  Response.Write "<a href=""javascript:"" onClick=""top.document.forms[0].elements['txtAlt'].value='"  & strName &"';top.document.forms[0].elements['ImgUrl'].value='" & strPath  & "';top.document.PREVIEWPIC.src='" & strPath  &"';"">" & strName & "</a>"
  'In ASP if you know how to get an image's height and width properties,
  'you can pass those as well
End Sub

' We want to see only graphic files, so restrict it here
arrValidFileTypes =  Array("jpg","gif")
MainProcess
%>
</body>
</html>
