VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CProspects"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CProspects"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsProspectsEnumConstants
   ptsProspectEnumFindType = cptsProspectEnumFindType
End Enum

Public Enum ptsProspectFindTypeConstants
   ptsProspectFindProspectName = cptsProspectFindProspectName
   ptsProspectFindContactName = cptsProspectFindContactName
   ptsProspectFindCreateDate = cptsProspectFindCreateDate
   ptsProspectFindPriority = cptsProspectFindPriority
   ptsProspectFindSource = cptsProspectFindSource
   ptsProspectFindRepresenting = cptsProspectFindRepresenting
   ptsProspectFindProspectID = cptsProspectFindProspectID
   ptsProspectFindEmail = cptsProspectFindEmail
   ptsProspectFindPhone1 = cptsProspectFindPhone1
   ptsProspectFindLeadCampaignID = cptsProspectFindLeadCampaignID
   ptsProspectFindSalesCampaignID = cptsProspectFindSalesCampaignID
   ptsProspectFindDescription = cptsProspectFindDescription
End Enum


Private Function BusnService() As CProspectB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CProspectB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get Count( _ 
   Optional ByVal bvSecurityToken As Long = 0) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the number of items in the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Count_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   If Not (moItems Is Nothing) Then
      '-----if the collection is loaded then return the count from the collection
      Count = moItems.Count
   Else
      '-----return the count from the database
      Count = BusnService.Count(mSecurityToken)
   End If

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get EnumItems( _ 
   ByVal bvType As ptsProspectsEnumConstants, _ 
   Optional ByVal bvSecurityToken As Long = 0) As wtSystem.CEnumItems
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumItems"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems

   On Error GoTo ErrorHandler

   Set oEnums = New wtSystem.CEnumItems

   Select Case bvType
      Case cptsProspectEnumFindType
         oEnums.Add cptsProspectFindProspectName, "ProspectName"
         oEnums.Add cptsProspectFindContactName, "ContactName"
         oEnums.Add cptsProspectFindCreateDate, "CreateDate"
         oEnums.Add cptsProspectFindPriority, "Priority"
         oEnums.Add cptsProspectFindSource, "Source"
         oEnums.Add cptsProspectFindRepresenting, "Representing"
         oEnums.Add cptsProspectFindProspectID, "ProspectID"
         oEnums.Add cptsProspectFindEmail, "Email"
         oEnums.Add cptsProspectFindPhone1, "Phone1"
         oEnums.Add cptsProspectFindLeadCampaignID, "LeadCampaignID"
         oEnums.Add cptsProspectFindSalesCampaignID, "SalesCampaignID"
         oEnums.Add cptsProspectFindDescription, "Description"
   End Select

   Set EnumItems = oEnums
   Set oEnums = Nothing
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindUnassigned( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindUnassigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindUnassigned(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindUnassigned = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindCompany( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindCompany(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindCompany = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindCompanyStatus( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindCompanyStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindCompanyStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindCompanyActive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindCompanyActive(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindCompanyActive = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindCompanyLive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindCompanyLive(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindCompanyLive = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMember( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMember(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMember = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMemberStatus( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMemberStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMemberStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMemberActive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemberActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMemberActive(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMemberActive = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMemberLive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemberLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMemberLive(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMemberLive = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindLead( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLead"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindLead(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindLead = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindLeadStatus( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLeadStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindLeadStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindLeadStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindLeadActive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLeadActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindLeadActive(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindLeadActive = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindLeadLive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLeadLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindLeadLive(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindLeadLive = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindFolder( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFolderID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindFolder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindFolder(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvFolderID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindFolder = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMemCust( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCust"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMemCust(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMemCust = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMemCustCamp( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCustCamp"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMemCustCamp(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSalesCampaignID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMemCustCamp = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMemCustType( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCustType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMemCustType(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvProspectTypeID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMemCustType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMemCustCampType( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCustCampType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindMemCustCampType(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSalesCampaignID, bvProspectTypeID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindMemCustCampType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindComCust( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCust"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindComCust(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindComCust = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindComCustCamp( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCustCamp"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindComCustCamp(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSalesCampaignID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindComCustCamp = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindComCustType( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCustType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindComCustType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvProspectTypeID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindComCustType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindComCustCampType( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCustCampType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.FindComCustCampType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSalesCampaignID, bvProspectTypeID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return the new bookmark
   FindComCustCampType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ExpMember( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpMember(bvFindType, bvSearchText, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return list count
   ExpMember = CStr(UBound(tRecs))

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ExpMemberStatus( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpMemberStatus(bvFindType, bvSearchText, bvMemberID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return list count
   ExpMemberStatus = CStr(UBound(tRecs))

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ExpMemberActive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpMemberActive(bvFindType, bvSearchText, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return list count
   ExpMemberActive = CStr(UBound(tRecs))

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ExpMemberLive( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpMemberLive(bvFindType, bvSearchText, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return list count
   ExpMemberLive = CStr(UBound(tRecs))

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ExpMemberService( _ 
   ByVal bvFindType As ptsProspectUser.ptsProspectFindTypeConstants, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberService"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----set the find type ID
   FindTypeID = bvFindType

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpMemberService(bvFindType, bvSearchText, bvMemberID, bvSalesCampaignID, bvProspectTypeID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   '-----return list count
   ExpMemberService = CStr(UBound(tRecs))

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get FindTypeID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindTypeID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   FindTypeID = mFindTypeID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let FindTypeID( _ 
   ByVal bvFindTypeID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindTypeID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mFindTypeID = bvFindTypeID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Function Item( _ 
   Optional ByVal bvPos As Long = 0, _ 
   Optional ByVal bvKey As String = "", _ 
   Optional ByVal bvSecurityToken As Long = 0) As ptsProspectUser.CProspect
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   If Not (moItems Is Nothing) Then
      '-----if the collection has been loaded then return the item from the collection
      If bvPos > 0 Then
         Set oItem = moItems.Item(bvPos)
      Else
         If bvKey <> "" Then
            Set oItem = moItems.Item(bvKey)
         End If
      End If
   Else
      If bvKey <> "" Then
         '-----if the collection has not been loaded then create a new item and return it
         Set oItem = New ptsProspectUser.CProspect
         With oItem
            .Load bvKey, mSecurityToken
         End With
      End If
   End If

   '-----return the item
   Set Item = oItem

   Exit Function

ErrorHandler:
   Select Case Err.Number
      Case 5, 9, 91:
         Err.Clear
         Set Item = Nothing
         Exit Function
      Case Else:
         CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
         If Err.Number = 0 Then Resume Next
         Err.Raise ErrNo, ErrSrc, ErrDesc
   End Select
End Function

Public Sub ScheduleCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ScheduleCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ScheduleCompany(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ScheduleMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ScheduleMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ScheduleMember(bvMemberID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub BoardCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSalesCampaignID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BoardCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.BoardCompany(bvCompanyID, bvSalesCampaignID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub BoardMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BoardMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.BoardMember(bvMemberID, bvSalesCampaignID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub BoardGroup( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BoardGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.BoardGroup(bvMemberID, bvSalesCampaignID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub FallbackCompany( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FallbackCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.FallbackCompany(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub FallbackMember( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FallbackMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.FallbackMember(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ClosedCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ClosedCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ClosedCompany(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ClosedMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ClosedMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ClosedMember(bvMemberID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub FACompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FACompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.FACompany(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub FAMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FAMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.FAMember(bvMemberID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberDate( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvCreateDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberDate(bvMemberID, bvCreateDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberActive( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberActive(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListEmail( _ 
   ByVal bvEmailID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListEmail(bvEmailID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListNewsLetter( _ 
   ByVal bvNewsLetterID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNewsLetter"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListNewsLetter(bvNewsLetterID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Distribution( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Distribution"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.Distribution(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub DistributionProgram( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvLeadCampaignID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DistributionProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.DistributionProgram(bvMemberID, bvLeadCampaignID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Distributed( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Distributed"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.Distributed(bvMemberID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListCustomers( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCustomers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCustomers(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListReminder( _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReminder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListReminder(mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProspectUser.CProspect
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProspectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Load( _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Load"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim tRecs() As CProspectB.tProspectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   Set moItems = Nothing
   Set moItems = New Collection

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   '------------------------------------------------------------------------------------------------------------------------
   '   Enables For...Next iteration on the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewEnum"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If Not (moItems Is Nothing) Then
      Set NewEnum = moItems.[_NewEnum]
   End If

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XML( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Prospect") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim sChildren As String
   Dim sAttributes As String
   Dim sXML As String
   Dim sOption As String
   Dim bFind As Integer
   Dim lEnum As Long
   Dim lAttr As Long

   On Error GoTo ErrorHandler

   'Handle Common Options for collection classes
   Select Case bvOption
      Case 12: bvOption = 1111   ' attributes with all enums
      Case 13: bvOption = 1001   ' attributes with static enums
      Case 14: bvOption = 11000  ' find enums, attributes with no item enums
      Case 15: bvOption = 11001  ' find enums, attributes with static enums
   End Select
   sOption = Format(bvOption, "00000")
   bFind = (Mid(sOption, 1, 1) = "1")
   lEnum = Val(Mid(sOption, 4, 2))
   lAttr = Val(Mid(sOption, 2, 2) + "00")

   '-----create the XML for the children
   sChildren = ""

   If bFind Then
      sChildren = sChildren + EnumItems(ptsProspectEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
      '-----create the XML for the attributes
      sAttributes = ""

      sAttributes = sAttributes + XMLAttribute("FindTypeID", FindTypeID, False)
   End If

   '-----create the XML for the collection
   '-----don't return XML unless the collection is loaded
   sXML = ""
   If Not (moItems Is Nothing) Then
      If moItems.Count > 0 Then
         If lEnum > 0 Then   ' lookup and/or static Enums Included
            sChildren = sChildren + moItems.Item(1).XML(lEnum, bvElementName)
         End If
         If lAttr > 0 Then   ' attributes and/or filtered enums Included
            For Each oItem In moItems
               sXML = sXML + oItem.XML(lAttr, bvElementName)
            Next oItem
         End If
      End If
   End If

   XML = XMLElement("pts" + bvElementName + "s", sAttributes, , sChildren + sXML)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XMLExport( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Prospect") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLExport"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim sChildren As String
   Dim sAttributes As String
   Dim sXML As String
   Dim sOption As String
   Dim bFind As Integer
   Dim lEnum As Long
   Dim lAttr As Long

   On Error GoTo ErrorHandler

   'Handle Common Options for collection classes
   Select Case bvOption
      Case 12: bvOption = 1111   ' attributes with all enums
      Case 13: bvOption = 1001   ' attributes with static enums
      Case 14: bvOption = 11000  ' find enums, attributes with no item enums
      Case 15: bvOption = 11001  ' find enums, attributes with static enums
   End Select
   sOption = Format(bvOption, "00000")
   bFind = (Mid(sOption, 1, 1) = "1")
   lEnum = Val(Mid(sOption, 4, 2))
   lAttr = Val(Mid(sOption, 2, 2) + "00")

   '-----create the XML for the children
   sChildren = ""

   If bFind Then
      sChildren = sChildren + EnumItems(ptsProspectEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID)
      '-----create the XML for the attributes
      sAttributes = ""

      sAttributes = sAttributes + XMLAttribute("FindTypeID", FindTypeID, False)
   End If
   '-----create the XML for the collection
   sXML = ""
   If Not (moItems Is Nothing) Then
      If moItems.Count > 0 Then
         If lEnum > 0 Then   ' lookup and/or static Enums Included
            sChildren = sChildren + moItems.Item(1).XMLExport(lEnum, bvElementName)
         End If
         If lAttr > 0 Then   ' attributes and/or filtered enums Included
            For Each oItem In moItems
               sXML = sXML + oItem.XMLExport(lAttr, bvElementName)
            Next oItem
         End If
      End If
   End If

   XMLExport = XMLElement("pts" + bvElementName + "s", sAttributes, , sChildren + sXML)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XMLLead( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Prospect") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLLead"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim sChildren As String
   Dim sAttributes As String
   Dim sXML As String
   Dim sOption As String
   Dim bFind As Integer
   Dim lEnum As Long
   Dim lAttr As Long

   On Error GoTo ErrorHandler

   'Handle Common Options for collection classes
   Select Case bvOption
      Case 12: bvOption = 1111   ' attributes with all enums
      Case 13: bvOption = 1001   ' attributes with static enums
      Case 14: bvOption = 11000  ' find enums, attributes with no item enums
      Case 15: bvOption = 11001  ' find enums, attributes with static enums
   End Select
   sOption = Format(bvOption, "00000")
   bFind = (Mid(sOption, 1, 1) = "1")
   lEnum = Val(Mid(sOption, 4, 2))
   lAttr = Val(Mid(sOption, 2, 2) + "00")

   '-----create the XML for the children
   sChildren = ""

   If bFind Then
      sChildren = sChildren + EnumItems(ptsProspectEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID)
      '-----create the XML for the attributes
      sAttributes = ""

      sAttributes = sAttributes + XMLAttribute("FindTypeID", FindTypeID, False)
   End If
   '-----create the XML for the collection
   sXML = ""
   If Not (moItems Is Nothing) Then
      If moItems.Count > 0 Then
         If lEnum > 0 Then   ' lookup and/or static Enums Included
            sChildren = sChildren + moItems.Item(1).XMLLead(lEnum, bvElementName)
         End If
         If lAttr > 0 Then   ' attributes and/or filtered enums Included
            For Each oItem In moItems
               sXML = sXML + oItem.XMLLead(lAttr, bvElementName)
            Next oItem
         End If
      End If
   End If

   XMLLead = XMLElement("pts" + bvElementName + "s", sAttributes, , sChildren + sXML)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XMLCustomer( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Prospect") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLCustomer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProspectUser.CProspect
   Dim sChildren As String
   Dim sAttributes As String
   Dim sXML As String
   Dim sOption As String
   Dim bFind As Integer
   Dim lEnum As Long
   Dim lAttr As Long

   On Error GoTo ErrorHandler

   'Handle Common Options for collection classes
   Select Case bvOption
      Case 12: bvOption = 1111   ' attributes with all enums
      Case 13: bvOption = 1001   ' attributes with static enums
      Case 14: bvOption = 11000  ' find enums, attributes with no item enums
      Case 15: bvOption = 11001  ' find enums, attributes with static enums
   End Select
   sOption = Format(bvOption, "00000")
   bFind = (Mid(sOption, 1, 1) = "1")
   lEnum = Val(Mid(sOption, 4, 2))
   lAttr = Val(Mid(sOption, 2, 2) + "00")

   '-----create the XML for the children
   sChildren = ""

   If bFind Then
      sChildren = sChildren + EnumItems(ptsProspectEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID)
      '-----create the XML for the attributes
      sAttributes = ""

      sAttributes = sAttributes + XMLAttribute("FindTypeID", FindTypeID, False)
   End If
   '-----create the XML for the collection
   sXML = ""
   If Not (moItems Is Nothing) Then
      If moItems.Count > 0 Then
         If lEnum > 0 Then   ' lookup and/or static Enums Included
            sChildren = sChildren + moItems.Item(1).XMLCustomer(lEnum, bvElementName)
         End If
         If lAttr > 0 Then   ' attributes and/or filtered enums Included
            For Each oItem In moItems
               sXML = sXML + oItem.XMLCustomer(lAttr, bvElementName)
            Next oItem
         End If
      End If
   End If

   XMLCustomer = XMLElement("pts" + bvElementName + "s", sAttributes, , sChildren + sXML)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)
   mCurrentLanguage = bvLanguage
End Property