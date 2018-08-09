VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CCourses"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CCourses"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsCoursesEnumConstants
   ptsCourseEnumFindType = cptsCourseEnumFindType
End Enum

Public Enum ptsCourseFindTypeConstants
   ptsCourseFindCourseName = cptsCourseFindCourseName
   ptsCourseFindCourseID = cptsCourseFindCourseID
   ptsCourseFindStatus = cptsCourseFindStatus
   ptsCourseFindCourseDate = cptsCourseFindCourseDate
End Enum


Private Function BusnService() As CCourseB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CCourseB

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
   ByVal bvType As ptsCoursesEnumConstants, _ 
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
      Case cptsCourseEnumFindType
         oEnums.Add cptsCourseFindCourseName, "CourseName"
         oEnums.Add cptsCourseFindCourseID, "CourseID"
         oEnums.Add cptsCourseFindStatus, "Status"
         oEnums.Add cptsCourseFindCourseDate, "CourseDate"
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
   ByVal bvFindType As ptsCourseUser.ptsCourseFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
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
   tRecs = BusnService.Find(bvFindType, sBookMark, bvSearchText, bvDirection, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   Find = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindCompany( _ 
   ByVal bvFindType As ptsCourseUser.ptsCourseFindTypeConstants, _ 
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
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
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
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   FindCompany = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindOrg( _ 
   ByVal bvFindType As ptsCourseUser.ptsCourseFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOrgID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
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
   tRecs = BusnService.FindOrg(bvFindType, sBookMark, bvSearchText, bvDirection, bvOrgID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   FindOrg = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindTrainer( _ 
   ByVal bvFindType As ptsCourseUser.ptsCourseFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvTrainerID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindTrainer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
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
   tRecs = BusnService.FindTrainer(bvFindType, sBookMark, bvSearchText, bvDirection, bvTrainerID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   FindTrainer = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Search( _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Search"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.Search(sBookMark, bvSearchText, bvDirection, bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   Search = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TBCompanyDate( _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTrainerID As Long, _ 
   ByVal bvCourseDate As Date) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBCompanyDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.TBCompanyDate(sBookMark, bvSearchText, bvDirection, bvCompanyID, bvTrainerID, bvCourseDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   TBCompanyDate = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TBPublicDate( _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCourseDate As Date) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBPublicDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.TBPublicDate(sBookMark, bvSearchText, bvDirection, bvCourseDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   TBPublicDate = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TBUnRegistered( _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTrainerID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBUnRegistered"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.TBUnRegistered(sBookMark, bvSearchText, bvDirection, bvCompanyID, bvTrainerID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   TBUnRegistered = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TBFavoritePublic( _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvTrainerID As Long, _ 
   ByVal bvCourseDate As Date) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBFavoritePublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.TBFavoritePublic(sBookMark, bvSearchText, bvDirection, bvTrainerID, bvCourseDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   TBFavoritePublic = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TBFavoriteCompany( _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvTrainerID As Long, _ 
   ByVal bvCourseDate As Date) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBFavoriteCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long
   Dim sBookMark As String

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   sBookMark = bvBookMark
   tRecs = BusnService.TBFavoriteCompany(sBookMark, bvSearchText, bvDirection, bvTrainerID, bvCourseDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   '-----return the new bookmark
   TBFavoriteCompany = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsCourseUser.CCourse
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
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
         Set oItem = New ptsCourseUser.CCourse
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

Public Sub ListCourse( _ 
   ByVal bvCourseCategoryID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCourse(bvCourseCategoryID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListPrivate( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListPrivate(bvCompanyID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListSingleCourse( _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSingleCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListSingleCourse(bvCourseID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListTextCourses( _ 
   ByVal bvDescription As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTextCourses"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListTextCourses(bvDescription)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOrg( _ 
   ByVal bvOrgID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrg(bvOrgID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListFavorite( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFavorite"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListFavorite(bvOrgID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListProgram( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListProgram(bvOrgID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListCourseCategory( _ 
   ByVal bvCourseCategoryID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCourseCategory"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCourseCategory(bvCourseCategoryID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListGrp( _ 
   ByVal bvGrp As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGrp"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListGrp(bvGrp)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportStatus()
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatus()

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportReview()
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportReview"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportReview()

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCourseUser.CCourse
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CourseID)
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
   Dim oItem As ptsCourseUser.CCourse
   Dim tRecs() As CCourseB.tCourseType
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
   Optional ByVal bvElementName As String = "Course") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCourseUser.CCourse
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
      sChildren = sChildren + EnumItems(ptsCourseEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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