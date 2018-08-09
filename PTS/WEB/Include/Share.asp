<%
' Requires Resources.asp
'*** Find the Group with shared activities **************************************************
Function GetSharedActivities( byVal bvGroupID, byRef brTracks, byRef brTheme)
	On Error Resume Next

   If (bvGroupID <> 0) Then
      Set oMoption = server.CreateObject("ptsMoptionUser.CMoption")
      If oMoption Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMoptionUser.CMoption"
      Else
         With oMoption
            .FetchMember bvGroupID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .MoptionID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.IsActivity <> 0) Then
                brTracks = .ActivityTracks
                brTheme = .TrackTheme
            End If    
            If (.IsActivity = 0) Then
               bvGroupID = 0
               GetResource 1, tmpGroupID1, tmpGroupID2, tmpGroupID3
               If (tmpGroupID1 <> 0) Then
                  .FetchMember tmpGroupID1
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .Load .MoptionID, 1
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  If (.IsActivity <> 0) Then
                     bvGroupID = tmpGroupID1
                     brTracks = .ActivityTracks
                     brTheme = .TrackTheme
                  End If
               End If
            End If
         End With
      End If
      Set oMoption = Nothing
   End If
   GetSharedActivities = bvGroupID
End Function

%>

