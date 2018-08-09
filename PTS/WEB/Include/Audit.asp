<%
Function DoAudit( ByVal bvPage, ByVal bvOptions )

tmpAudit = 0

' check for comma delimiter at beginning and end of options string
If Left(bvOptions,1) <> "," Then bvOptions = "," + bvOptions
If Right(bvOptions,1) <> "," Then bvOptions = bvOptions + ","

' Check for any action for any user group card Audit options
If InStr(bvOptions, "?/?") > 0 Then	tmpAudit = 1 
' Check for the current action for any user group card Audit options
If tmpAudit = 0 AND InStr(bvOptions, "?/" + CStr(reqActionCode) + "," ) > 0 Then tmpAudit = 2 
' Check for any action for the current user group card Audit options
If  tmpAudit = 0 AND InStr(bvOptions, "," + CStr(reqSysUserGroup) + "/?" ) > 0 Then tmpAudit = 3 
' Check for the current action for the current user group card Audit options
If  tmpAudit = 0 AND InStr(bvOptions, "," + CStr(reqSysUserGroup) + "/" + CStr(reqActionCode) + "," ) > 0 Then tmpAudit = 4

If tmpAudit > 0 Then
   ' Clean up Page URL
   tmpPage = Replace(reqPageURL, "%26", "&")
   tmpIP = Request.ServerVariables("REMOTE_ADDR")
   pos = InStr(tmpPage, bvPage)
   If pos > 0 Then tmpPage = Mid(tmpPage, pos)
   pos = InStr(tmpPage, "ReturnURL")
   If pos > 0 Then tmpPage = Left(tmpPage, pos-1)
   ' Add Audit Record
   Set oAudit = server.CreateObject("ptsAuditUser.CAudit")
   If oAudit Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuditUser.CAudit"
   Else
      With oAudit
         .AuthUserID = reqSysUserID
         .AuditDate = Now
         .Action = reqActionCode
         .Page = tmpPage
         .IP = tmpIP
         .Add 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAudit = Nothing
End If

End Function

%>

