<%@EnableSessionState=False%>
<HTML>
<HEAD>
<TITLE>Uploading...</TITLE>
<!--METADATA
TYPE="TypeLib"
NAME="Microsoft ActiveX Data Objects 2.6 Library"
UUID="{00000206-0000-0010-8000-00AA006D2EA4}"
VERSION="2.6"
-->
<%
On Error Resume Next 'GoTo ErrorHandler
Dim strUploadID, dblProgress, lngFileSizeKB, lngKBDone, strStatus
Dim strFileName, lngFileSize, lngStatus
dim Obj

strUploadID = CStr(Request.QueryString("UID"))
If (Not IsNumeric(strUploadID)) Then strUploadID = CLng(0) Else strUploadID = CLng(strUploadID)

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
With Obj
	.LogID = strUploadID
	.FetchLog
	strFileName = .FullFileName
	lngFileSize = .FileSize
	lngKBDone = .PhysicalFileSize
	lngStatus = .Status
End With
Set Obj = Nothing 

lngFileSizeKB = lngFileSize / 1024

If (lngFileSize > 0) And (lngKBDone > 0) Then
    If lngStatus = 1 Then
        dblProgress = 1 'prevent rounding errors
    Else
        dblProgress = (lngKBDone / lngFileSize)
    End If
Else
    dblProgress = 0
End If	

lngKBDone = Round(dblProgress * lngFileSizeKB, 1)
strStatus = FormatNumber(lngKBDone, 0, -1, 0, -1) & " of " & FormatNumber(lngFileSizeKB, 0, -1, 0, -1) & " KB (" & Round(dblProgress*100, 1) & "%)"

If lngStatus = 0 And dblProgress < 1 Then
	%>
	<meta http-equiv="expires" content="Tue, 01 Jan 1981 01:00:00 GMT">
	<meta http-equiv=refresh content="2,UploadControl.asp?ID=<%=strUploadID%>">
	<%
End If
%>
</HEAD>
<BODY style="BACKGROUND-COLOR: #EEEEEE;" <%If dblProgress = 0 OR lngStatus <> 0 Then %>onload="focus();"<% End If%>>
<STYLE>
TABLE.ProgressBox{
	BORDER: inset 2px;
	SPACING: none;
	PADDING: none;
	BACKGROUND-COLOR: gray;
	WIDTH: 100%;
}
TD.ProgressBar{
	BACKGROUND-COLOR: blue;
}
TD.Status{
	font-weight: 700; 
	color: #333333; 
	font-family: arial
	font-size: 12pt;
}
TD.Title{
	font-weight: 700; 
	color: #333333; 
	font-size: 14pt;
	font-family: arial
}
TD.Error{
	font-weight: 700; 
	color: #FF0000; 
	font-size: 14pt;
	font-family: arial
}
</STYLE>
<TABLE border="0" width="100%">

<TR>
	<%Select Case lngStatus%>
	<%Case 0:%> <TD class=Title>Upload Progress:</TD>
	<%Case 1:%> <TD class=Title>Upload Complete!</TD>
	<%Case 2:%> <TD align="center" class=Error>Oops, File Length Too Long!</TD>
	<%Case 3:%> <TD align="center" class=Error>Oops, Invalid File Extension!</TD>
	<%Case 4:%> <TD align="center" class=Error>Oops, Invalid Input Name!</TD>
	<%Case Else:%> <TD align="center" class=Error>Oops, System Error! (<%=lngStatus%>)</TD>
	<%End Select%>
</TR>
<%If lngStatus = 0 OR lngStatus = 1 Then %>
<TR>
	<TD><TABLE class="ProgressBox">
		<TR>
			<TD <%If (dblProgress > 0) Then %>class="ProgressBar"<% End If%> width="<%=CStr(Round(dblProgress*100, 1))%>%">&nbsp;</TD>
			<TD>&nbsp;</TD>
		</TR>
	</TABLE></TD>
</TR>
<TR align="right">
	<TD class=Status><%=strStatus%></FONT></TD>
</TR>
<% End If%>
<TR>
	<TD height="10px"></TD>
</TR>
<TR align="center">
	<TD><INPUT type="button" value="close" <%If lngStatus = 0 Then Response.Write "DISABLED"%> onclick="javascript:window.close();"></TD>
</TR>
</TABLE>
</BODY>
</HTML>
