VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CProjects"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CProjects"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsProjectsEnumConstants
   ptsProjectEnumFindType = cptsProjectEnumFindType
End Enum

Public Enum ptsProjectFindTypeConstants
   ptsProjectFindProjectName = cptsProjectFindProjectName
   ptsProjectFindDescription = cptsProjectFindDescription
   ptsProjectFindProjectID = cptsProjectFindProjectID
End Enum


Private Function BusnService() As CProjectB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CProjectB

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

Public Function EnumUserMember( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecurityToken As Long) As wtSystem.CEnumItems
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems
   Dim vEnums() As CProjectB.tProjectType
   Dim idxEnum As Integer

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   Set oEnums = New wtSystem.CEnumItems

   vEnums = BusnService.EnumUserMember(bvProjectID, bvMemberID, mSecurityToken)

   For idxEnum = 1 To UBound(vEnums)
      With vEnums(idxEnum)
         oEnums.Add .ProjectID, .ProjectName
      End With
   Next idxEnum

   Set EnumUserMember = oEnums
   Set oEnums = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function EnumMember( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvMemberID As Long, _
   Optional ByVal bvItemID As Long = 0, _
   Optional ByVal bvElementName As String = "Project", _
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an XML enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumMember"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   EnumMember = EnumUserMember(bvProjectID, bvMemberID, mSecurityToken).XML("pts" + bvElementName + "s", bvItemID, True)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get EnumItems( _ 
   ByVal bvType As ptsProjectsEnumConstants, _ 
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
      Case cptsProjectEnumFindType
         oEnums.Add cptsProjectFindProjectName, "ProjectName"
         oEnums.Add cptsProjectFindDescription, "Description"
         oEnums.Add cptsProjectFindProjectID, "ProjectID"
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
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
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
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   Find = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSecure( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecure"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindSecure(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvMemberID, bvSecure, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindSecure = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindAssigned( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindAssigned(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindAssigned = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindStatus( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
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
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSecureStatus( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecureStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindSecureStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvMemberID, bvSecure, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindSecureStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindAssignedStatus( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
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
   Const cProcName As String = "FindAssignedStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindAssignedStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindAssignedStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindType( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvProjectTypeID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSecureType( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecureType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindSecureType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvProjectTypeID, bvMemberID, bvSecure, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindSecureType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindAssignedType( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssignedType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindAssignedType(bvFindType, sBookMark, bvSearchText, bvDirection, bvProjectTypeID, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindAssignedType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindStatusType( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindStatusType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvProjectTypeID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindStatusType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSecureStatusType( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecureStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindSecureStatusType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvProjectTypeID, bvMemberID, bvSecure, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindSecureStatusType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindAssignedStatusType( _ 
   ByVal bvFindType As ptsProjectUser.ptsProjectFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssignedStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   tRecs = BusnService.FindAssignedStatusType(bvFindType, sBookMark, bvSearchText, bvDirection, bvProjectTypeID, bvMemberID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   '-----return the new bookmark
   FindAssignedStatusType = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsProjectUser.CProject
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
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
         Set oItem = New ptsProjectUser.CProject
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

Public Sub ListParent( _ 
   ByVal bvParentID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListParent"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListParent(bvParentID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Projects( _ 
   ByVal bvProjectID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Projects"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.Projects(bvProjectID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListCompanyPending( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCompanyPending(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListCompanyStarted( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyStarted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCompanyStarted(bvCompanyID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListCompanyCompleted( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyCompleted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCompanyCompleted(bvCompanyID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberPending( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberPending(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberStarted( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberStarted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberStarted(bvMemberID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberCompleted( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberCompleted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberCompleted(bvMemberID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub WhatsNewOwn( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewOwn"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.WhatsNewOwn(bvMemberID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub WhatsNewBelong( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewBelong"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.WhatsNewBelong(bvMemberID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub WhatsNewAccess( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewAccess"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.WhatsNewAccess(bvCompanyID, bvSecure, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub WhatsNew( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNew"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.WhatsNew(bvProjectID, bvFromDate, bvToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsProjectUser.CProject
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.ProjectID)
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
   Dim oItem As ptsProjectUser.CProject
   Dim tRecs() As CProjectB.tProjectType
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
   Optional ByVal bvElementName As String = "Project") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsProjectUser.CProject
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
      sChildren = sChildren + EnumItems(ptsProjectEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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