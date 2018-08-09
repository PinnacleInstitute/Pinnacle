<!--#include file="Include\Cookies.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\CSV.asp"-->
<%
On Error Resume Next
CompanyID = GetCache("CompanyID")
If (Not IsNumeric(CompanyID)) Then CompanyID = CLng(0) Else CompanyID = CLng(CompanyID)

Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Orders\" + CSTR(CompanyID) + "\"
'Set this page to not timeout for 4 hours
Server.ScriptTimeout = 14400

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.UpLoadPath = Path
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "5225.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&CompanyID=" & CompanyID
Else
   Dim oFileSys, oFile
   Dim	NameFirst, NameLast, Email
   Dim data, x, rec, pos
   
   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
   End If
   Set oFile = oFileSys.OpenTextFile(Path + NewFileName)
   If oFile Is Nothing Then
		Response.Write "Couldn't open file: " + Path + NewFileName
		Response.End
   End If
   Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
   If oSalesOrder Is Nothing Then
		Response.Write "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
		Response.End
   End If
   
   cnt = 0
   Do While oFile.AtEndOfStream <> True
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
        a = CSVArray( rec )
        If UBOUND(a) = 2 Then
		    Order = a(0)
		    Desc = a(1)
		    Track = a(2)
             If IsNumeric(Order) Then
                With oSalesOrder
                    .Load Order, 1
                    If .CompanyID = CSTR(CompanyID) Then
                        .Track = Track
                        .Save(1)
                        cnt = cnt + 1
                    End If
                End With
	         End If
	     End If
      End If
   Loop

   oFile.Close
   Set oSalesOrder = Nothing
   Set oFile = Nothing
   Set oFileSys = Nothing

	If cnt = 0 Then cnt = -1
	Response.Redirect "5225.asp?CompanyID=" & CompanyID & "&Orders=" & cnt
End If

%>