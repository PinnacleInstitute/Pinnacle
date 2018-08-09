<%
g_CompanyID = 21
'****************************************************************************************
Function GetNexxusAcct( byVal bvKey )
    On Error Resume Next
   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
        .FetchCompany g_CompanyID
        .Load CLng(.CoptionID), 1
        tmpWalletAcct = .WalletAcct
      End With
   End If
   Set oCoption = Nothing

    GetNexxusAcct = GetKeyToken( Key, tmpWalletAcct )

End Function

%>
