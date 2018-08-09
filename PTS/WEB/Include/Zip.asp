<!--#include virtual="include\aspJSON1.17.asp" -->
<% 
' Bob Wood 9/13/16
' Get Zip Code Information
' *******************************************
Public Function GetZip(ByVal bvZip, byRef brCity, byRef brState )
    On Error Resume Next
    sURL = "http://maps.googleapis.com/maps/api/geocode/json?address=" & bvZip
    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open "GET", sURL
        .send 
        sResponse = .responseText
    End With
    Set oHTTP = Nothing

    Set oJSON = New aspJSON
    oJSON.loadJSON( sResponse )
    status = oJSON.data("status")
    If status = "OK" Then
        ' "formatted_address" : "Plano, TX 75025, USA",
        address = oJSON.data("results")(0)("formatted_address")
        arr = Split(address, ",")
        If UBOUND(arr) >= 0 Then
            brCity = arr(0)
            aParts = Split( TRIM(arr(1)), " ") 
            If UBOUND(aParts) >= 0 Then brState = aParts(0)
        End If
        GetZip = "OK"
    Else
        GetZip = status
    End If
    Set oJSON = Nothing
End Function

%>
