VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CMetrics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMetrics"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsMetricsEnumConstants
   ptsMetricEnumFindType = cptsMetricEnumFindType
End Enum

Public Enum ptsMetricFindTypeConstants
   ptsMetricFindPoints = cptsMetricFindPoints
End Enum


Private Function BusnService() As CMetricB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CMetricB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get EnumItems( _ 
   ByVal bvType As ptsMetricsEnumConstants, _ 
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
      Case cptsMetricEnumFindType
         oEnums.Add cptsMetricFindPoints, "Points"
   End Select

   Set EnumItems = oEnums
   Set oEnums = Nothing
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderCompany( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderCompany(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvFromDate, bvToDate, bvRpt, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderCompany = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderGroup( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderGroup(bvFindType, sBookMark, bvSearchText, bvDirection, bvGroupID, bvFromDate, bvToDate, bvRpt, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderGroup = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderMentor( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderMentor"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderMentor(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvFromDate, bvToDate, bvRpt, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderMentor = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderPrivate( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvContestID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderPrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderPrivate(bvFindType, sBookMark, bvSearchText, bvDirection, bvContestID, bvFromDate, bvToDate, bvRpt, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderPrivate = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderCompanyCustom( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderCompanyCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderCompanyCustom(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderCompanyCustom = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderGroupCustom( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderGroupCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderGroupCustom(bvFindType, sBookMark, bvSearchText, bvDirection, bvGroupID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderGroupCustom = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderMentorCustom( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderMentorCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderMentorCustom(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderMentorCustom = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LeaderPrivateCustom( _ 
   ByVal bvFindType As ptsMetricUser.ptsMetricFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvContestID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderPrivateCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   tRecs = BusnService.LeaderPrivateCustom(bvFindType, sBookMark, bvSearchText, bvDirection, bvContestID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   '-----return the new bookmark
   LeaderPrivateCustom = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsMetricUser.CMetric
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
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
         Set oItem = New ptsMetricUser.CMetric
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

Public Sub ExpLeaderCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderCompany(bvCompanyID, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ExpLeaderGroup( _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderGroup(bvGroupID, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ExpLeaderMentor( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderMentor"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderMentor(bvMemberID, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ExpLeaderPrivate( _ 
   ByVal bvContestID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderPrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderPrivate(bvContestID, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ExpLeaderCompanyCustom( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderCompanyCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderCompanyCustom(bvCompanyID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ExpLeaderGroupCustom( _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderGroupCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderGroupCustom(bvGroupID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ExpLeaderMentorCustom( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderMentorCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderMentorCustom(bvMemberID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ExpLeaderPrivateCustom( _ 
   ByVal bvContestID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLeaderPrivateCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ExpLeaderPrivateCustom(bvContestID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMember(bvMemberID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListGoal( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGoal"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListGoal(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberSummary( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberSummary(bvMemberID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberDetail( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvMetricTypeID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberDetail(bvMemberID, bvMetricTypeID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub LeaderSummary( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.LeaderSummary(bvMemberID, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub LeaderSummaryCustom( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeaderSummaryCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.LeaderSummaryCustom(bvMemberID, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Report( _ 
   ByVal bvRpt As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvUnit As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Report"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.Report(bvRpt, bvMemberID, bvFromDate, bvToDate, bvUnit)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberCompany(bvCompanyID, bvMemberName, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberGroup( _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberGroup(bvGroupID, bvMemberName, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberMentor( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberMentor"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberMentor(bvMemberID, bvMemberName, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberPrivate( _ 
   ByVal bvContestID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvRpt As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberPrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberPrivate(bvContestID, bvMemberName, bvFromDate, bvToDate, bvRpt)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberCompanyCustom( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberCompanyCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberCompanyCustom(bvCompanyID, bvMemberName, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberGroupCustom( _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberGroupCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberGroupCustom(bvGroupID, bvMemberName, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberMentorCustom( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberMentorCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberMentorCustom(bvMemberID, bvMemberName, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub MemberPrivateCustom( _ 
   ByVal bvContestID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvCustom1 As Long, _ 
   ByVal bvCustom2 As Long, _ 
   ByVal bvCustom3 As Long, _ 
   ByVal bvCustom4 As Long, _ 
   ByVal bvCustom5 As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberPrivateCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.MemberPrivateCustom(bvContestID, bvMemberName, bvFromDate, bvToDate, bvCustom1, bvCustom2, bvCustom3, bvCustom4, bvCustom5)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMetricUser.CMetric
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MetricID)
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
   Dim oItem As ptsMetricUser.CMetric
   Dim tRecs() As CMetricB.tMetricType
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
   Optional ByVal bvElementName As String = "Metric") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMetricUser.CMetric
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
      sChildren = sChildren + EnumItems(ptsMetricEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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