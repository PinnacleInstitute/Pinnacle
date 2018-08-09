<% Response.Buffer=true

Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
If oHTTP Is Nothing Then
    Response.Write "Error #" & Err.number & " - " + Err.description
    Response.End
End If    

response.Write "<BR>Start: " & Time()

url = "http://www.right180.com"
cntr = 10

With oHTTP
    While cntr > 0
        cntr = cntr - 1
        .open "GET", url
        .send
    Wend
End With

response.Write "<BR>End: " & Time()

Set oHTTP = Nothing

response.write xmlProfile

%>