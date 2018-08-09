<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next
CompanyID = GetCache("CompanyID")
If (Not IsNumeric(CompanyID)) Then CompanyID = CLng(0) Else CompanyID = CLng(CompanyID)

Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Sections\Company\" + CStr(CompanyID) + "\"

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
	Response.Redirect "3850.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description & "&CompanyID=" & CompanyID
Else
	Dim oFileSys, oFile
	Dim Referrals, Rec, Total, Refers, Count, Result
	   
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
	Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
	If oCompany Is Nothing Then
		Response.Write "Unable to Create Object - ptsCompanyUser.CCompany"
		Response.End
	End If

	Total = 0
	Do While oFile.AtEndOfStream <> True
	Rec=""
		Rec = oFile.ReadLine
        Total = Total + 1
		Referrals = Referrals + Rec + ";"
		If Len(Referrals) > 1950 OR oFile.AtEndOfStream = True Then
			Count = oCompany.Referrals(CompanyID, Referrals)
			Refers = Refers + Count
			Referrals = ""
		End If				
	Loop

	oFile.Close
	Set oCompany = Nothing
	Set oFile = Nothing
	Set oFileSys = Nothing

	Result = CStr(Refers) + " of " + CStr(Total) + " Referrals Uploaded!"
	Response.Redirect "3850.asp?CompanyID=" & CompanyID & "&Result=" + Result
End If

%>