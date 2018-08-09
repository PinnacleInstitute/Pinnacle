Attribute VB_Name = "wtiUserDefinedEmailListMod"
Option Explicit
Private Const cModName As String = "wtiUserDefinedEmailListMod"

Public Function UserDefinedEmailListSQL(ByVal bvQuery As String, _
   ByVal bvFields As String, ByVal bvFrom As String) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate SQL Statement for User Defined Email List
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UserDefinedEmailListSQL"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim XML As New MSXML2.DOMDocument
   Dim XSL As New MSXML2.DOMDocument
   Dim OUT As New MSXML2.DOMDocument
   Dim sXML As String
   
   On Error GoTo ErrorHandler
      
   '-----build data----------
   sXML = "<DATA>"
   sXML = sXML + bvFields + bvQuery
   If InStr(bvFrom, "WHERE") > 0 Then
      sXML = sXML + "<WTFROM where='true'>" + bvFrom + "</WTFROM>"
   Else
      sXML = sXML + "<WTFROM>" + bvFrom + "</WTFROM>"
   End If
   sXML = sXML + "<SYSTEM date=" & Chr$(34) & Date & Chr$(34) & "/>"
   sXML = sXML + "</DATA>"
      
   XML.loadXML sXML
   
   If Len(XML.XML) = 0 Then
      UserDefinedEmailListSQL = ""
   Else
      '-----build SQL----------
      XSL.Load App.Path + "\UserDefinedEmailList.xsl"
      XML.transformNodeToObject XSL, OUT
      UserDefinedEmailListSQL = OUT.Text
   End If
   
   Set XML = Nothing
   Set XSL = Nothing
   Set OUT = Nothing
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set XML = Nothing
   Set XSL = Nothing
   Set OUT = Nothing
   ShowError Err.Number, Err.Source, Err.Description
   Exit Function
End Function

