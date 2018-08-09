<!--#include file="Include\System.asp"-->
<% Response.Buffer=true

On Error Resume Next

reqMID = Numeric(Request.Item("MID"))

Set oMember = server.CreateObject("ptsMemberUser.CMember")
If oMember Is Nothing Then
	Response.Write "<ERROR>Unable to Create Object - ptsMemberUser.CMember</ERROR>"
	Response.End
Else
    With oMember
	    .Load reqMID, 1
		str = str + "<MEMBER id=""" + .MemberID + """ name=""" + CleanXML(.NameFirst + " " + .NameLast) + """"
		If .Image <> "" Then str = str + " image=""" + .Image + """"
		str = str + "/>"
		Response.Write str
		Response.End
    End With
End If
Set oMember = Nothing

%>
