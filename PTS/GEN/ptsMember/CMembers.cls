VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CMembers"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMembers"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsMembersEnumConstants
   ptsMemberEnumFindType = cptsMemberEnumFindType
End Enum

Public Enum ptsMemberFindTypeConstants
   ptsMemberFindMemberName = cptsMemberFindMemberName
   ptsMemberFindCompanyName = cptsMemberFindCompanyName
   ptsMemberFindEnrollDate = cptsMemberFindEnrollDate
   ptsMemberFindMemberID = cptsMemberFindMemberID
   ptsMemberFindReference = cptsMemberFindReference
   ptsMemberFindPhone1 = cptsMemberFindPhone1
   ptsMemberFindStatus = cptsMemberFindStatus
   ptsMemberFindEmail = cptsMemberFindEmail
   ptsMemberFindMasterID = cptsMemberFindMasterID
   ptsMemberFindGroupID = cptsMemberFindGroupID
   ptsMemberFindRole = cptsMemberFindRole
End Enum


Private Function BusnService() As CMemberB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CMemberB

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
   ByVal bvType As ptsMembersEnumConstants, _ 
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
      Case cptsMemberEnumFindType
         oEnums.Add cptsMemberFindMemberName, "MemberName"
         oEnums.Add cptsMemberFindCompanyName, "CompanyName"
         oEnums.Add cptsMemberFindEnrollDate, "EnrollDate"
         oEnums.Add cptsMemberFindMemberID, "MemberID"
         oEnums.Add cptsMemberFindReference, "Reference"
         oEnums.Add cptsMemberFindPhone1, "Phone1"
         oEnums.Add cptsMemberFindStatus, "Status"
         oEnums.Add cptsMemberFindEmail, "Email"
         oEnums.Add cptsMemberFindMasterID, "MasterID"
         oEnums.Add cptsMemberFindGroupID, "GroupID"
         oEnums.Add cptsMemberFindRole, "Role"
   End Select

   Set EnumItems = oEnums
   Set oEnums = Nothing
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSponsor( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvSponsorID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSponsor"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindSponsor(bvFindType, sBookMark, bvSearchText, bvDirection, bvSponsorID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindSponsor = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSponsor2( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvSponsor2ID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSponsor2"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindSponsor2(bvFindType, sBookMark, bvSearchText, bvDirection, bvSponsor2ID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindSponsor2 = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindSponsor3( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvSponsor3ID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSponsor3"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindSponsor3(bvFindType, sBookMark, bvSearchText, bvDirection, bvSponsor3ID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindSponsor3 = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Find( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
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
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   Find = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindOwner( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindOwner(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindOwner = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindOrg( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindOrg(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindOrg = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMaster( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMasterID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMaster"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindMaster(bvFindType, sBookMark, bvSearchText, bvDirection, bvMasterID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindMaster = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindGroup( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvGroupID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindGroup(bvFindType, sBookMark, bvSearchText, bvDirection, bvGroupID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindGroup = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindCustomer( _ 
   ByVal bvFindType As ptsMemberUser.ptsMemberFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCustomer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   tRecs = BusnService.FindCustomer(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   '-----return the new bookmark
   FindCustomer = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsMemberUser.CMember
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
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
         Set oItem = New ptsMemberUser.CMember
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

Public Sub ListOrg( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOrg(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListReferral( _ 
   ByVal bvReferralID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReferral"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListReferral(bvReferralID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
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
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCustomers(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMentor( _ 
   ByVal bvMentorID As Long, _ 
   ByVal bvVisitDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMentor"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMentor(bvMentorID, bvVisitDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportMembership( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMembership"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportMembership(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportNewEnrollment( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvUnit As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportNewEnrollment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportNewEnrollment(bvCompanyID, bvReportFromDate, bvReportToDate, bvUnit)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportTotalEnrollment( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvUnit As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportTotalEnrollment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportTotalEnrollment(bvCompanyID, bvReportFromDate, bvReportToDate, bvUnit)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportBilling( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportBilling"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportBilling(bvCompanyID, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportVisit( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisit"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportVisit(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportVisitStatus( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisitStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportVisitStatus(bvCompanyID, bvStatus)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportAuthLog( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportAuthLog"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportAuthLog(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportMembershipDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvStatus As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMembershipDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportMembershipDetail(bvCompanyID, bvReportFromDate, bvReportToDate, bvStatus)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportBillingDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvBilling As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportBillingDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportBillingDetail(bvCompanyID, bvReportFromDate, bvReportToDate, bvBilling)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportVisitDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvQuantity As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisitDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportVisitDetail(bvCompanyID, bvQuantity)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportVisitDetailStatus( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvQuantity As Long, _ 
   ByVal bvStatus As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisitDetailStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportVisitDetailStatus(bvCompanyID, bvQuantity, bvStatus)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListNewsLetter( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNewsLetter"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListNewsLetter(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Genealogy( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvLevel As Long, _ 
   ByVal bvTitle As Long, _ 
   ByVal bvQV As Currency)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Genealogy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.Genealogy(bvMemberID, bvStatus, bvLevel, bvTitle, bvQV)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListEmail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvEmail As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListEmail(bvCompanyID, bvEmail)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub NewMembers( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewMembers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.NewMembers(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub FundRaisingSummary( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FundRaisingSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.FundRaisingSummary(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub FundRaisingDetail( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FundRaisingDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.FundRaisingDetail(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub CustomList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvLevel As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.CustomList(bvCompanyID, bvStatus, bvLevel)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsMemberUser.CMember
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.MemberID)
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
   Dim oItem As ptsMemberUser.CMember
   Dim tRecs() As CMemberB.tMemberType
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
   Optional ByVal bvElementName As String = "Member") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
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
      sChildren = sChildren + EnumItems(ptsMemberEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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

Public Function XMLFind( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Member") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLFind"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
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
      sChildren = sChildren + EnumItems(ptsMemberEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID)
      '-----create the XML for the attributes
      sAttributes = ""

      sAttributes = sAttributes + XMLAttribute("FindTypeID", FindTypeID, False)
   End If
   '-----create the XML for the collection
   sXML = ""
   If Not (moItems Is Nothing) Then
      If moItems.Count > 0 Then
         If lEnum > 0 Then   ' lookup and/or static Enums Included
            sChildren = sChildren + moItems.Item(1).XMLFind(lEnum, bvElementName)
         End If
         If lAttr > 0 Then   ' attributes and/or filtered enums Included
            For Each oItem In moItems
               sXML = sXML + oItem.XMLFind(lAttr, bvElementName)
            Next oItem
         End If
      End If
   End If

   XMLFind = XMLElement("pts" + bvElementName + "s", sAttributes, , sChildren + sXML)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XMLGenealogy( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Member") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLGenealogy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsMemberUser.CMember
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
      sChildren = sChildren + EnumItems(ptsMemberEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID)
      '-----create the XML for the attributes
      sAttributes = ""

      sAttributes = sAttributes + XMLAttribute("FindTypeID", FindTypeID, False)
   End If
   '-----create the XML for the collection
   sXML = ""
   If Not (moItems Is Nothing) Then
      If moItems.Count > 0 Then
         If lEnum > 0 Then   ' lookup and/or static Enums Included
            sChildren = sChildren + moItems.Item(1).XMLGenealogy(lEnum, bvElementName)
         End If
         If lAttr > 0 Then   ' attributes and/or filtered enums Included
            For Each oItem In moItems
               sXML = sXML + oItem.XMLGenealogy(lAttr, bvElementName)
            Next oItem
         End If
      End If
   End If

   XMLGenealogy = XMLElement("pts" + bvElementName + "s", sAttributes, , sChildren + sXML)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)
   mCurrentLanguage = bvLanguage
End Property