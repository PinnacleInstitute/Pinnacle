VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CSessions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSessions"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
'-----child classes
Private moItems As Collection

Private Function BusnService() As CSessionB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CSessionB

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

Public Function EnumUserProgram( _ 
   ByVal bvSessionID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecurityToken As Long) As wtSystem.CEnumItems
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems
   Dim vEnums() As CSessionB.tSessionType
   Dim idxEnum As Integer

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   Set oEnums = New wtSystem.CEnumItems

   vEnums = BusnService.EnumUserProgram(bvSessionID, bvMemberID, mSecurityToken)

   For idxEnum = 1 To UBound(vEnums)
      With vEnums(idxEnum)
         oEnums.Add .SessionID, .CourseName
      End With
   Next idxEnum

   Set EnumUserProgram = oEnums
   Set oEnums = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function EnumProgram( _ 
   ByVal bvSessionID As Long, _ 
   ByVal bvMemberID As Long, _
   Optional ByVal bvItemID As Long = 0, _
   Optional ByVal bvElementName As String = "Session", _
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an XML enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumProgram"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   EnumProgram = EnumUserProgram(bvSessionID, bvMemberID, mSecurityToken).XML("pts" + bvElementName + "s", bvItemID, True)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Item( _ 
   Optional ByVal bvPos As Long = 0, _ 
   Optional ByVal bvKey As String = "", _ 
   Optional ByVal bvSecurityToken As Long = 0) As ptsSessionUser.CSession
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
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
         Set oItem = New ptsSessionUser.CSession
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

Public Sub ListMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMember(bvMemberID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberStatus(bvMemberID, bvStatus, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberComplete(bvMemberID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberAll( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberAll(bvMemberID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberAllStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberAllStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberAllStatus(bvMemberID, bvStatus, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberAllComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberAllComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberAllComplete(bvMemberID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOrgMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrgMember(bvMemberID, bvOrgID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOrgMemberStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrgMemberStatus(bvMemberID, bvOrgID, bvStatus, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOrgMemberComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrgMemberComplete(bvMemberID, bvOrgID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOrgMemberAll( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrgMemberAll(bvMemberID, bvOrgID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOrgMemberAllStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberAllStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrgMemberAllStatus(bvMemberID, bvOrgID, bvStatus, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOrgMemberAllComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberAllComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrgMemberAllComplete(bvMemberID, bvOrgID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ProgramSummary( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProgramSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ProgramSummary(bvOrgID, bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListCourse( _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCourse(bvCourseID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListRatings( _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListRatings"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListRatings(bvCourseID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportOrg( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportOrg(bvOrgID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportOrgCourse( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOrgCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportOrgCourse(bvOrgID, bvCourseID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportMember(bvMemberID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub CoursesMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CoursesMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.CoursesMember(bvMemberID, bvStartDate, bvCompleteDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub CoursesBusiness( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date, _ 
   ByVal bvCourseID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CoursesBusiness"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.CoursesBusiness(bvMemberID, bvStartDate, bvCompleteDate, bvCourseID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsSessionUser.CSession
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.SessionID)
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
   Dim oItem As ptsSessionUser.CSession
   Dim tRecs() As CSessionB.tSessionType
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
   Optional ByVal bvElementName As String = "Session") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsSessionUser.CSession
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
      '-----create the XML for the attributes
      sAttributes = ""

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