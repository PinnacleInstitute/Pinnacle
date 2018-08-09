VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CIssues"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CIssues"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsIssuesEnumConstants
   ptsIssueEnumFindType = cptsIssueEnumFindType
End Enum

Public Enum ptsIssueFindTypeConstants
   ptsIssueFindIssueCategoryName = cptsIssueFindIssueCategoryName
   ptsIssueFindIssueName = cptsIssueFindIssueName
   ptsIssueFindIssueID = cptsIssueFindIssueID
   ptsIssueFindSubmittedBy = cptsIssueFindSubmittedBy
   ptsIssueFindAssignedTo = cptsIssueFindAssignedTo
   ptsIssueFindOutsource = cptsIssueFindOutsource
   ptsIssueFindIssueDate = cptsIssueFindIssueDate
   ptsIssueFindDueDate = cptsIssueFindDueDate
   ptsIssueFindDoneDate = cptsIssueFindDoneDate
   ptsIssueFindPriority = cptsIssueFindPriority
End Enum


Private Function BusnService() As CIssueB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CIssueB

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
   ByVal bvType As ptsIssuesEnumConstants, _ 
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
      Case cptsIssueEnumFindType
         oEnums.Add cptsIssueFindIssueCategoryName, "IssueCategoryName"
         oEnums.Add cptsIssueFindIssueName, "IssueName"
         oEnums.Add cptsIssueFindIssueID, "IssueID"
         oEnums.Add cptsIssueFindSubmittedBy, "SubmittedBy"
         oEnums.Add cptsIssueFindAssignedTo, "AssignedTo"
         oEnums.Add cptsIssueFindOutsource, "Outsource"
         oEnums.Add cptsIssueFindIssueDate, "IssueDate"
         oEnums.Add cptsIssueFindDueDate, "DueDate"
         oEnums.Add cptsIssueFindDoneDate, "DoneDate"
         oEnums.Add cptsIssueFindPriority, "Priority"
   End Select

   Set EnumItems = oEnums
   Set oEnums = Nothing
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Find( _ 
   ByVal bvFindType As ptsIssueUser.ptsIssueFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
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
   tRecs = BusnService.Find(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   '-----return the new bookmark
   Find = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindStatus( _ 
   ByVal bvFindType As ptsIssueUser.ptsIssueFindTypeConstants, _ 
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
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
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
   tRecs = BusnService.FindStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   '-----return the new bookmark
   FindStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindAssigned( _ 
   ByVal bvFindType As ptsIssueUser.ptsIssueFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvAssignedTo As String, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
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
   tRecs = BusnService.FindAssigned(bvFindType, sBookMark, bvSearchText, bvDirection, bvAssignedTo, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   '-----return the new bookmark
   FindAssigned = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindAssignedStatus( _ 
   ByVal bvFindType As ptsIssueUser.ptsIssueFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvAssignedTo As String, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssignedStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
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
   tRecs = BusnService.FindAssignedStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvAssignedTo, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   '-----return the new bookmark
   FindAssignedStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSubmit( _ 
   ByVal bvFindType As ptsIssueUser.ptsIssueFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSubmitType As Long, _ 
   ByVal bvSubmitID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSubmit"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
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
   tRecs = BusnService.FindSubmit(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSubmitType, bvSubmitID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   '-----return the new bookmark
   FindSubmit = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSubmitStatus( _ 
   ByVal bvFindType As ptsIssueUser.ptsIssueFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSubmitType As Long, _ 
   ByVal bvSubmitID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSubmitStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
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
   tRecs = BusnService.FindSubmitStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSubmitType, bvSubmitID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   '-----return the new bookmark
   FindSubmitStatus = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsIssueUser.CIssue
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
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
         Set oItem = New ptsIssueUser.CIssue
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

Public Sub ReportStatus( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatus(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportStatusAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatusAssigned(bvCompanyID, bvReportFromDate, bvReportToDate, bvAssignedTo)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportStatusDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvStatus As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatusDetail(bvCompanyID, bvReportFromDate, bvReportToDate, bvStatus)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportStatusAssignedDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String, _ 
   ByVal bvStatus As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusAssignedDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatusAssignedDetail(bvCompanyID, bvReportFromDate, bvReportToDate, bvAssignedTo, bvStatus)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportLate( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportLate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportLate(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportLateAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportLateAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportLateAssigned(bvCompanyID, bvReportFromDate, bvReportToDate, bvAssignedTo)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportRating( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportRating"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportRating(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportRatingAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportRatingAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportRatingAssigned(bvCompanyID, bvReportFromDate, bvReportToDate, bvAssignedTo)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportOutsource( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOutsource"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportOutsource(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportOutsourceAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOutsourceAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportOutsourceAssigned(bvCompanyID, bvReportFromDate, bvReportToDate, bvAssignedTo)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsIssueUser.CIssue
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.IssueID)
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
   Dim oItem As ptsIssueUser.CIssue
   Dim tRecs() As CIssueB.tIssueType
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
   Optional ByVal bvElementName As String = "Issue") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsIssueUser.CIssue
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
      sChildren = sChildren + EnumItems(ptsIssueEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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

Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)
   mCurrentLanguage = bvLanguage
End Property