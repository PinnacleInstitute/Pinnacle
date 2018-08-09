<%
'*** Cache Shared Resources ***********************************************************************
Function GetResources( byVal bvMemberID)
    On Error Resume Next

    Set oResources = server.CreateObject("ptsResourceUser.CResources")
    If oResources Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsResourceUser.CResources"
    Else
        oResources.ListUsing CLng(bvMemberID)

        tmpResources = ""
        tmpType = -1
        For Each oItem in oResources
            With oItem
                'Dont process excluded items
                If .IsExclude = 0 Then
                    'If we got a new resource type, start with the resource type
                    If tmpType <> .ResourceType Then
                    If tmpResources <> "" Then tmpResources = tmpResources + ";"
                        tmpResources = tmpResources + .ResourceType + ":"
                    Else
                        tmpResources = tmpResources + ","
                    End If    
                    tmpResources = tmpResources + .ShareID
                End If    
            End With
        Next
        SetCache "RESOURCES", tmpResources
    End If
    Set oResources = Nothing
    GetResources = tmpResources
End Function

'*** Get up to 3 Shared Resources from Cache ******************************************************
Function GetResource( byVal bvType, byRef brShare1, byRef brShare2, byRef brShare3 )
	On Error Resume Next
	tmpResources = GetCache("RESOURCES")
	brShare1 = 0
	brShare2 = 0
	brShare3 = 0
    'First check for all resources (bvType=0)       
    GetRes tmpResources, 0, brShare1, brShare2, brShare3
    'Next check for specific resources type (if type<>0 and we haven't already found 3 shares)       
    If bvType <> 0 AND brShare3 = 0 Then GetRes tmpResources, bvType, brShare1, brShare2, brShare3
End Function

'*** Utility **************************************************************************************
Function GetRes( byVal tmpResources, byVal bvType, byRef brShare1, byRef brShare2, byRef brShare3 )
	On Error Resume Next
    
    pos = InStr( tmpResources, bvType & ":" ) 
    If pos > 0 Then
        tmpResource = Mid(tmpResources, pos+2, Len(tmpResources) )
        pos2 = InStr( tmpResource, ";" ) 
        If pos2 > 0 Then tmpResource = Left( tmpResource, pos2-1) 
        aResource = Split( tmpResource, ",")
        total = UBOUND(aResource)
        If total >= 0 AND brShare1 = 0 Then brShare1 = aResource(0)
        If total >= 1 AND brShare2 = 0 Then brShare1 = aResource(1)
        If total >= 2 AND brShare3 = 0 Then brShare1 = aResource(2)
    End If   
    
End Function

%>

