<!--#include file="Include\System.asp"-->
<!--#include file="Include\IP.asp"-->

<% Response.Buffer=true
On Error Resume Next

CompanyID = 17
MemberID = 0

Email = Request.Item("E")
IP = Request.Item("I")

If Email <> "" Then
    Set oMember = server.CreateObject("ptsMemberUser.CMember")
    If oMember Is Nothing Then
        response.Write "Unable to Create Object - ptsMemberUser.CMember"
    Else
        With oMember
             MemberID = CLng(.ExistEmail(CompanyID, Email))
             If (MemberID = 0) Then
                Response.Write "ERROR: Member Not Found!"
                Responce.End
             End If
            .Load MemberID, 1
            Response.Write "<BR>Member #" & MemberID
            Response.Write "<BR>Name: " & .NameFirst + " " + .NameLast
            Response.Write "<BR>Email: " & .Email
            Response.Write "<BR>Phone: " & .Phone1
            Response.Write "<BR>"
        End With
    End If
    Set oMember = Nothing

      Set oAddresss = server.CreateObject("ptsAddressUser.CAddresss")
      If oAddresss Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddresss"
      Else
         With oAddresss
            .ListOwner 4, MemberID
         End With
        For Each oItem in oAddresss
            With oItem
                Response.Write "<BR>" + .City + ", " + .State + ", " + .CountryName 
            End With
        Next
      End If
      Set oAddresss = Nothing
End If

If IP <> "" Then
	result = GetIPCity( IP )
	response.write "<p><strong>" + IP + "</strong>: " + result
	response.write "</p>" 
End If

%>