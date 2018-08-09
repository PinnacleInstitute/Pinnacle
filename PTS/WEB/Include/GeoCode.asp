<!--#include virtual="include\aspJSON1.17.asp" -->
<%
'***** Google Maps API ******************************************
g_GM_KEY  = "AIzaSyB_HxuNA8k_fZRG2tcUxMHhw4RfNK1hjbY"
g_GM_URL = "https://maps.googleapis.com/maps/api/geocode/json"
g_GM_Test = False

'***********************************************************************
Function GM_GeoCode( ByVal bvAddress ) 
    Dim sURL, sResponse
    On Error Resume Next
    sURL = g_GM_URL + "?address=" + bvAddress
'    sURL = sURL + "&key=" + g_GM_KEY

    sResponse = GM_SendURL( sURL ) 
    If sResponse = "" Then	
        GM_GeoCode = ""
    Else
        GM_GeoCode = GM_GetResponse( sResponse, 1, "", "" ) 
    End If
End Function

'***********************************************************************
Public Function GM_GetZip(ByVal bvZip, byRef brCity, byRef brState )
    On Error Resume Next
    sURL = g_GM_URL + "?address=" + bvZip

    sResponse = GM_SendURL( sURL ) 
    If sResponse = "" Then	
        GM_GetZip = ""
    Else
        GM_GetZip = GM_GetResponse( sResponse, 2, brCity, brState ) 
    End If
End Function

'***********************************************************************
Function GM_SendURL( ByVal bvURL ) 
    On Error Resume Next
    If g_GM_Test Then response.write "<BR>URL: " + bvURL
    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open "GET", bvURL
        .send 
        GM_SendURL = .responseText
    End With
    Set oHTTP = Nothing
End Function

'***********************************************************************
Function GM_GetResponse( ByVal bvResponse, ByVal bvType, ByRef brCity, ByRef brState ) 

    On Error Resume Next
    Dim status, address, arr 

    If g_GM_Test Then response.write "<BR>Response: " + bvResponse
    Set oJSON = New aspJSON
    oJSON.loadJSON( bvResponse )
    status = oJSON.data("status")
    Select Case bvType
    Case 1 'GeoCode
        If status = "OK" Then
            GM_GetResponse = CSTR(oJSON.data("results")(0)("geometry")("location")("lat")) + "," + CSTR(oJSON.data("results")(0)("geometry")("location")("lng"))
        Else
            GM_GetResponse = Left("Err:" + status, 30)
        End If
    Case 2 'Zip
        If status = "OK" Then
            ' "formatted_address" : "Plano, TX 75025, USA",
            address = oJSON.data("results")(0)("formatted_address")
            arr = Split(address, ",")
            If UBOUND(arr) >= 0 Then
                brCity = arr(0)
                aParts = Split( TRIM(arr(1)), " ") 
                If UBOUND(aParts) >= 0 Then brState = aParts(0)
            End If
            GM_GetResponse = "OK"
        Else
            GM_GetResponse = Left("Err:" + status, 30)
        End If
    End Select
    Set oJSON = Nothing
End Function

%>

