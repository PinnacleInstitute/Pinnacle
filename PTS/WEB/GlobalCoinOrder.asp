<!--#include file="Include\Globalcoin.asp"-->
<%
On Error Resume Next

API_Secret = "5a643ea8dc6150a780c78338c1c55fc8"

MemberID = Request.Item("MemberID")
Username = Request.Item("User")
Password = Request.Item("Pswd")
Product = Request.Item("Product")

If MemberID <> "0" Then
    Set oMember = server.CreateObject("ptsMemberUser.CMember")
    If oMember Is Nothing Then
        response.Write "Unable to Create Object - ptsMemberUser.CMember"
    Else
        With oMember
            .Load MemberID, 1
            SetGCSecret API_Secret
            result = SendGCOrder( MemberID, Product, Username, Password ) 
            If Left(result,5) <> "ERROR" Then
                If Len(result) > 0 Then
                    'Wallet Creation - Save Wallet Token
                    If Len(Username) > 0 Then
                        .Reference = Left(result,15)
                        .Referral = Mid(result,16)
                        .Save 1
                    End If
                    'New Order - Set Member next bill date
                    If Len(Username) = 0 Then
                        .PaidDate = DateAdd("m", 1, Date())
                        .Save 1
                    End If
                End If
            End If
            Response.Write result
        End With
    End If
    Set oMember = Nothing
End If

%>