<%
g_IP_API_KEY  = "be8f9867a7ea1eef4ccff82825b3f823821978cfc0100ae4d6bf8210d472ad41"

'***********************************************************************
Function GetIPCity(ByVal bvIP)
    On Error Resume Next

    myxml="http://api.ipinfodb.com/v3/ip-city/?key=" & g_IP_API_KEY & "&ip=" & bvIP & "&format=xml"
    set xml = server.CreateObject("MSXML2.DOMDocument.6.0")
    xml.async = "false"
    xml.resolveExternals = "false"
    xml.setProperty "ServerHTTPRequest", true
    xml.load(myxml)
    With xml.documentElement
        result = .childNodes(6).text & ", " + .childNodes(5).text & ", " + .childNodes(4).text
    End With

    GetIPCity = result
End Function

Function GetIPAll(ByVal bvIP)
    On Error Resume Next

    myxml="http://api.ipinfodb.com/v3/ip-city/?key=" & g_IP_API_KEY & "&ip=" & bvIP & "&format=xml"
    set xml = server.CreateObject("MSXML2.DOMDocument.6.0")
    xml.async = "false"
    xml.resolveExternals = "false"
    xml.setProperty "ServerHTTPRequest", true
    xml.load(myxml)

    result = ""
    With xml.documentElement
        For i=0 to 10
            result = result + .childNodes(i).nodename & "  :  " + .childNodes(i).text & "<br/>"
        Next
    End With

    GetIPAll = result
End Function


%>