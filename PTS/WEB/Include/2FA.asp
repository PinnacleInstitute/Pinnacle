<%
'**************************************************************************************
Function Is2FAConsumer( tmpConsumerID )
    Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
    With oConsumer
        .Load tmpConsumerID, 1
        If .UserKey <> "" Then
            Is2FAConsumer = 1
        Else
            Is2FAConsumer = 0
        End If
    End With
    Set oConsumer = Nothing
End Function

'**************************************************************************************
Function Is2FAMerchant( tmpMerchantID )
    Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
    With oMerchant
        .Load tmpMerchantID, 1
        Is2FAMerchant = 0
        MerchantAccount = GetCache("MERCHACCT")
        If MerchantAccount = 1 And .UserKey <> "" Then Is2FAMerchant = 1
        If MerchantAccount = 3 And .UserKey3 <> "" Then Is2FAMerchant = 1
        If MerchantAccount = 4 And .UserKey4 <> "" Then Is2FAMerchant = 1
    End With
    Set oMerchant = Nothing
End Function

'**************************************************************************************
Function Check2FAMerchant( MerchantID )
    If (reqSysUserGroup > 23) And (reqSysUserGroup <> 51) And (reqSysUserGroup <> 52) Then
        Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
        With oMerchant
            .Load MerchantID, 1
            If .IsOrg = 0 And .UserKey = "" And .Status = 3 Then AbortUser()
            Set oMerchant = Nothing
        End With
        tmpMerchantID = Numeric(GetCache("MERCHANT"))
        If ( CLng(MerchantID) <> CLng(tmpMerchantID) ) Then
            SetCache "MERCHANT", ""
            Response.Redirect "15005.asp"
        End If
    End If    
End Function

'**************************************************************************************
Function Check2FAConsumer( ConsumerID )
    If (reqSysUserGroup > 23) And (reqSysUserGroup <> 51) And (reqSysUserGroup <> 52) Then
        Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
        With oConsumer
            .Load ConsumerID, 1
            If .UserKey = "" Then  AbortUser()
            Set oConsumer = Nothing
        End With
        tmpConsumerID = Numeric(GetCache("CONSUMER"))
        If ( CLng(ConsumerID) <> CLng(tmpConsumerID) ) Then
            SetCache "CONSUMER", ""
            Response.Redirect "15005.asp"
        End If
    End If    
End Function

%>

