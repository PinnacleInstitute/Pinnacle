<%
Function GetCompanyMember(byref brCompanyID, byref brMemberID)
   On Error Resume Next
	If brCompanyID > 0 OR brMemberID > 0 Then 
		SetCache "CURCOMPANYID", brCompanyID
		SetCache "CURMEMBERID", brMemberID
	Else	
		brCompanyID = GetCache("CURCOMPANYID")
		brMemberID = GetCache("CURMEMBERID")
		If brCompanyID = 0 AND brMemberID = 0 Then 
			brCompanyID = GetCache("COMPANYID")
			brMemberID = GetCache("MEMBERID")
			SetCache "CURCOMPANYID", brCompanyID
			SetCache "CURMEMBERID", brMemberID
		End If
	End If
End Function
%>

