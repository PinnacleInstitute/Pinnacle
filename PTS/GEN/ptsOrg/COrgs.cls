VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "COrgs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "COrgs"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
'-----child classes
Private moItems As Collection

Private Function BusnService() As COrgB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New COrgB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function EnumCompanyDocList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvSecurityToken As Long) As wtSystem.CEnumItems
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumCompanyDocList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems
   Dim vEnums() As COrgB.tOrgType
   Dim idxEnum As Integer

   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   Set oEnums = New wtSystem.CEnumItems

   vEnums = BusnService.EnumCompanyDocList(bvCompanyID, bvSecure, mSecurityToken)

   For idxEnum = 1 To UBound(vEnums)
      With vEnums(idxEnum)
         oEnums.Add .OrgID, .OrgName
      End With
   Next idxEnum

   Set EnumCompanyDocList = oEnums
   Set oEnums = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function EnumCompanyDoc( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecure As Long, _
   Optional ByVal bvItemID As Long = 0, _
   Optional ByVal bvElementName As String = "Org", _
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an XML enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumCompanyDoc"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   EnumCompanyDoc = EnumCompanyDocList(bvCompanyID, bvSecure, mSecurityToken).XML("pts" + bvElementName + "s", bvItemID, True)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Item( _ 
   Optional ByVal bvPos As Long = 0, _ 
   Optional ByVal bvKey As String = "", _ 
   Optional ByVal bvSecurityToken As Long = 0) As ptsOrgUser.COrg
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
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
         Set oItem = New ptsOrgUser.COrg
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

Public Sub ListTree( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTree"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListTree(bvCompanyID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListBranch( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListBranch"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListBranch(bvOrgID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMember( _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMember(bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberHierarchy( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberHierarchy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberHierarchy(bvCompanyID, bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListProgram( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListProgram(bvCompanyID, bvMemberID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListFavoritePrivate( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFavoritePrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListFavoritePrivate(bvCompanyID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListFavorite( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvCourseDate As Date, _ 
   ByVal bvStatus As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFavorite"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListFavorite(bvMemberID, bvCourseDate, bvStatus)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListActiveUsers( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActiveUsers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListActiveUsers(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListUsers( _ 
   ByVal bvCompanyID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListUsers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListUsers(bvCompanyID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsOrgUser.COrg
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.OrgID)
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
   Dim oItem As ptsOrgUser.COrg
   Dim tRecs() As COrgB.tOrgType
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
   Optional ByVal bvElementName As String = "Org") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsOrgUser.COrg
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