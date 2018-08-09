VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CCompanys"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CCompanys"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsCompanysEnumConstants
   ptsCompanyEnumFindType = cptsCompanyEnumFindType
End Enum

Public Enum ptsCompanyFindTypeConstants
   ptsCompanyFindCompanyName = cptsCompanyFindCompanyName
   ptsCompanyFindCompanyID = cptsCompanyFindCompanyID
   ptsCompanyFindContactName = cptsCompanyFindContactName
   ptsCompanyFindEmail = cptsCompanyFindEmail
   ptsCompanyFindEnrollDate = cptsCompanyFindEnrollDate
   ptsCompanyFindStatus = cptsCompanyFindStatus
   ptsCompanyFindCompanyType = cptsCompanyFindCompanyType
End Enum


Private Function BusnService() As CCompanyB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CCompanyB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get EnumItems( _ 
   ByVal bvType As ptsCompanysEnumConstants, _ 
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
      Case cptsCompanyEnumFindType
         oEnums.Add cptsCompanyFindCompanyName, "CompanyName"
         oEnums.Add cptsCompanyFindCompanyID, "CompanyID"
         oEnums.Add cptsCompanyFindContactName, "ContactName"
         oEnums.Add cptsCompanyFindEmail, "Email"
         oEnums.Add cptsCompanyFindEnrollDate, "EnrollDate"
         oEnums.Add cptsCompanyFindStatus, "Status"
         oEnums.Add cptsCompanyFindCompanyType, "CompanyType"
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
   ByVal bvFindType As ptsCompanyUser.ptsCompanyFindTypeConstants, _ 
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
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
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
      Set oItem = New ptsCompanyUser.CCompany
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CompanyID)
   Next idxRec

   '-----return the new bookmark
   Find = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsCompanyUser.CCompany
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCompanyUser.CCompany
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
         Set oItem = New ptsCompanyUser.CCompany
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
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvUserID <> 0 Then mSecurityToken = bvUserID

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMember(bvMemberID, mSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCompanyUser.CCompany
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CompanyID)
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
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatus()

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCompanyUser.CCompany
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CompanyID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportType()

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCompanyUser.CCompany
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CompanyID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportTypeMember()
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportTypeMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportTypeMember()

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCompanyUser.CCompany
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CompanyID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportStats()
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStats"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStats()

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCompanyUser.CCompany
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CompanyID)
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
   ByVal bvEnrollDate As Date, _ 
   ByVal bvQuantity As Long, _ 
   ByVal bvAmount As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.CustomList(bvCompanyID, bvStatus, bvEnrollDate, bvQuantity, bvAmount)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsCompanyUser.CCompany
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.CompanyID)
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
   Dim oItem As ptsCompanyUser.CCompany
   Dim tRecs() As CCompanyB.tCompanyType
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
   Optional ByVal bvElementName As String = "Company") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCompanyUser.CCompany
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
      sChildren = sChildren + EnumItems(ptsCompanyEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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
   Optional ByVal bvElementName As String = "Company") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLFind"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsCompanyUser.CCompany
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
      sChildren = sChildren + EnumItems(ptsCompanyEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID)
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

Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)
   mCurrentLanguage = bvLanguage
End Property