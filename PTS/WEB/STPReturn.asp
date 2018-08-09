<% 
On Error Resume Next

Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
If oHTMLFile Is Nothing Then
 DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
Else
 With oHTMLFile
    .Filename = "STPReturn.htm"
    reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
    .Path = reqSysWebDirectory + "Sections"
    .Language = "en"
    .Project = "PTS"
    .Load 

    response.Write .Data

 End With
End If
Set oHTMLFile = Nothing


%>