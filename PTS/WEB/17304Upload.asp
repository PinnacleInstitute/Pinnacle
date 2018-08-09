<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

tmpBarterImageID = GetCache("BARTERIMAGEID")
tmpPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Barter\Upload"

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.MaxFileBytes = 4 * 1024 * 1024
	.RejectExeExtension = true
	.RejectEmptyExtension = true
	.FileExtensionList "jpg", "gif", "png"
	.UpLoadPath = tmpPath
	.NewFileName = tmpBarterImageID
	.Upload
    tmpTitle = .UploadedFileName
    pos = InStrRev(tmpTitle,".")
    tmpExt = mid(tmpTitle,pos+1)
End With
Set Obj = Nothing

If Err.number = 0 Then
    Set oBarterImage = server.CreateObject("ptsBarterImageUser.CBarterImage")
    If oBarterImage Is Nothing Then
        Response.write "Unable to Create Object - ptsBarterImageUser.CBarterImage"
        Response.end
    Else
        With oBarterImage
            .Load CLng(tmpBarterImageID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Title = tmpTitle
            .Ext = tmpExt
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
        End With
    End If
    Set oBarterImage = Nothing

'    tmpPath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Barter\"
'    Set oFileSys = server.CreateObject("Scripting.FileSystemObject")
'    With oFileSys
'        .CopyFile tmpPath + "l." + tmpExt, tmpPath + CSTR(tmpBarterImageID) + "l." + tmpExt
'        .CopyFile tmpPath + "m." + tmpExt, tmpPath + CSTR(tmpBarterImageID) + "m." + tmpExt
'        .CopyFile tmpPath + "s." + tmpExt, tmpPath + CSTR(tmpBarterImageID) + "s." + tmpExt
'    End With
'    Set oFileSys = Nothing

    Response.Redirect "17303.asp?BarterImageID=" & tmpBarterImageID
Else
    Response.Redirect "17304.asp?BarterImageID=" & tmpBarterImageID & "&UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
End If

%>