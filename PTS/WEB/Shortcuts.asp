<!--#include file="Include\System.asp"-->
<% Response.Buffer=true

reqMID = Request.Item("MID")
reqSysUserOptions = GetCache("USEROPTIONS")

Set oMember = server.CreateObject("ptsMemberUser.CMember")
With oMember
	.SysCurrentLanguage = reqSysLanguage
	.Load CLng(reqMID), 1
	tmpAuthUserID = .AuthUserID
	tmpIcons = .Icons
End With 
Set oMember = Nothing
	    
xmlIcons = "<ICONS>"
While tmpIcons <> "" 
    tmpIcon = Left(tmpIcons, 1)
    tmpIcons = Mid(tmpIcons, 2)
    tmpName = ""
    tmpFile = ""
    tmpURL = ""
    Select Case tmpIcon
        Case "E"
        If InStr(reqSysUserOptions,"E") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Sales"" file=""IconE.gif"" url=""8101.asp""/>"
        End If
        Case "F"
        If InStr(reqSysUserOptions,"F") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Projects"" file=""IconF.gif"" url=""7501.asp""/>"
        End If
        Case "G"
        If InStr(reqSysUserOptions,"G") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Mentoring"" file=""IconG.gif"" url=""0410.asp""/>"
        End If
        Case "H"
        If InStr(reqSysUserOptions,"H") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Goals"" file=""IconH.gif"" url=""7001.asp""/>"
        End If
        Case "I"
        If InStr(reqSysUserOptions,"I") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""MyInfo"" file=""IconI.gif"" url=""0403.asp""/>"
        End If
        Case "K"
        If InStr(reqSysUserOptions,"K") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Classes"" file=""IconK.gif"" url=""1311.asp""/>"
        End If
        Case "L"
        If InStr(reqSysUserOptions,"L") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Assessments"" file=""IconL.gif"" url=""3411.asp""/>"
        End If
        Case "2"
        If InStr(reqSysUserOptions,"2") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Calendar"" file=""Icon2.gif"" url=""Calendar.asp""/>"
        End If
        Case "6"
        If InStr(reqSysUserOptions,"6") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Customers"" file=""Icon6.gif"" url=""8151.asp""/>"
        End If
        Case "a"
        If InStr(reqSysUserOptions,"a") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Resources"" file=""Icon_a.gif"" url=""9304.asp""/>"
        End If
        Case "h"
        If InStr(reqSysUserOptions,"h") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Leads"" file=""Icon_h.gif"" url=""2201.asp""/>"
        End If
        Case "o"
        If InStr(reqSysUserOptions,"o") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Genealogy"" file=""Icon_o.gif"" url=""0470.asp""/>"
        End If
        Case "w"
        If InStr(reqSysUserOptions,"w") <> 0 Then
            xmlIcons = xmlIcons + "<ICON name=""Finances"" file=""Icon_w.gif"" url=""0475.asp""/>"
        End If
    End Select
Wend
xmlIcons = xmlIcons + "</ICONS>"

Set oShortcuts = server.CreateObject("ptsShortcutUser.CShortcuts")
With oShortcuts
	.List tmpAuthUserID, 1
	xmlShortcuts = .XMLShortcuts()
End With
Set oShortcuts = Nothing

If err.Number = 0 Then
    Response.Write "<DATA>" + xmlIcons + xmlShortcuts + "</DATA>"
Else
    Response.Write "<ERROR number=""" + CStr(Err.number) + """>" + CleanXML(Err.Description) + "</ERROR>"
End If

Response.End

%>