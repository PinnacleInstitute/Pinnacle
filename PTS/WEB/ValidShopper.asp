<% Response.Buffer=true
On Error Resume Next

consumer = Request.Item( "c" )
result = 0

If consumer <> "" Then
    Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
    With oConsumer
        retcode = .Logon2( consumer )
        If retcode > 0 Then result = 1
    End With
    Set oConsumer = Nothing
End If

response.write result

%>