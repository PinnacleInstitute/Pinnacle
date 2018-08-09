<!--#include file="Include\System.asp"-->
<% Response.Buffer=true

reqAID = Request.Item("AID")
reqURL = Request.Item("URL")
      
File = "LiveDesktop\Users\" + CStr(reqAID) + ".xml"
Set oSystem = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oSystem.load server.MapPath(File)
If oSystem.parseError <> 0 Then
   Response.Write "Load System file failed with error code " + CStr(oSystem.parseError)
   Response.End
End If
SET oNode = oSystem.selectSingleNode("SYSTEM")
With oNode
   SetCache "HEADERIMAGE", .getAttribute("headerimage")
   SetCache "FOOTERIMAGE", .getAttribute("footerimage")
   SetCache "RETURNIMAGE", .getAttribute("returnimage")
   SetCache "NAVBARIMAGE", .getAttribute("navbarimage")
   SetCache "HEADERURL", .getAttribute("headerurl")
   SetCache "LANGUAGE", .getAttribute("language")
   SetCache "LANGDIALECT", .getAttribute("langdialect")
   SetCache "LANGCOUNTRY", .getAttribute("langcountry")
   SetCache "LANGDEFAULT", .getAttribute("langdefault")
   SetCache "USERID", .getAttribute("userid")
   SetCache "USERGROUP", .getAttribute("usergroup")
   SetCache "USERSTATUS", .getAttribute("userstatus")
   SetCache "USERNAME", .getAttribute("username")
   SetCache "MENUBARSTATE", .getAttribute("menubarstate")
   SetCache "COMPANYID", .getAttribute("companyid")
   SetCache "MEMBERID", .getAttribute("memberid")
   SetCache "USERMODE", .getAttribute("usermode")
   SetCache "USEROPTIONS", .getAttribute("useroptions")
   SetCache "GAA", .getAttribute("gaa")
   SetCache "CGAA", .getAttribute("cgaa")
   SetCache "SECURITYLEVEL", .getAttribute("securitylevel")
   SetCache "VISITDATE", .getAttribute("visitdate")
   SetCache "IDENTIFY", .getAttribute("identify")
   SetCache "MEMBEROPTIONS", .getAttribute("memberoptions")
End With

Response.Redirect Replace(reqURL, "%26", "&")
Response.End

%>