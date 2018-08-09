<%
'*****************************************************************************************************
Function GetPortal( byVal bvCompanyID, byVal bvGroupID, byRef brHeaderPosition, byRef brHeaderAlign, byRef brMenuAlign, byRef brMenuBackground )
	On Error Resume Next
    'HeaderPosition: Above=0 (default), Below=1, None=-1
    'HeaderAlign: Left=0, Center=1(default), Right=2
    'MenuAlign: Left=0(default), Center=1, Right=2

    Portal = ""
    
    If bvGroupID > 0 Then
        Set oMoption = server.CreateObject("ptsMoptionUser.CMoption")
        If oMoption Is Nothing Then
          DoError Err.Number, Err.Source, "Unable to Create Object - ptsMoptionUser.CMoption"
        Else
          With oMoption
             .FetchMember CLng(bvGroupID)
             Portal = .Portal
          End With
        End If
        Set oMoption = Nothing
    End If
    If bvCompanyID > 0 And Portal = "" Then
        Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
        If oCoption Is Nothing Then
          DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
        Else
          With oCoption
             .FetchCompany CLng(bvCompanyID)
             .Load CLng(.CoptionID), 1
             Portal = .Portal
          End With
        End If
        Set oCoption = Nothing
    End If 

    brHeaderPosition = 0
    brHeaderAlign = 1
    brMenuAlign = 0
    brMenubackground = 0

    If InStr( Portal, "HB") > 0 Then brHeaderPosition = 1
    If InStr( Portal, "HN") > 0 Then brHeaderPosition = -1
    If InStr( Portal, "HL") > 0 Then brHeaderAlign = 0
    If InStr( Portal, "HR") > 0 Then brHeaderAlign = 2
    If InStr( Portal, "MC") > 0 Then brMenuAlign = 1
    If InStr( Portal, "MR") > 0 Then brMenuAlign = 2
    If InStr( Portal, "MB") > 0 Then brMenubackground = 1

End Function
%>

