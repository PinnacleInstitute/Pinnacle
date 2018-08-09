<!--#include file="Include\System.asp"-->
<% Response.Buffer=true

On Error Resume Next

reqMID = Request.Item("MID")

Set oMember = server.CreateObject("ptsMemberUser.CMember")
If oMember Is Nothing Then
	Response.Write "<ERROR>Unable to Create Object - ptsMemberUser.CMember</ERROR>"
	Response.End
Else
	With oMember
		.Load reqMID, 1
		tmpMentorID = .MentorID
		str = "<MENTOR"
		If (tmpMentorID <> 0) Then 
			.Load tmpMentorID, 1
			str = str + " id=""" + .MemberID + """ name=""" + CleanXML(.NameFirst + " " + .NameLast) + """"
			If .Image <> "" Then str = str + " image=""" + .Image + """"
		End If
		str = str + ">"
	End With
End If
Set oMember = Nothing

Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
If oMembers Is Nothing Then
	Response.Write "<ERROR>Unable to Create Object - ptsMemberUser.CMembers</ERROR>"
	Response.End
Else
	With oMembers
	.ListMentor reqMID, Date()
	For Each oMember in oMembers
		With oMember
			str = str + "<MENTOREE id=""" + .MemberID + """ name=""" + CleanXML(.NameFirst + " " + .NameLast) + """"
			If .Image <> "" Then str = str + " image=""" + .Image + """"
			str = str + "/>"
		End With
	Next
	End With
End If
Set oMembers = Nothing

str = str + "</MENTOR>"

Response.Write str

Response.End

%>
