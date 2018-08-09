VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CPayment2s"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPayment2s"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsPayment2sEnumConstants
   ptsPayment2EnumFindType = cptsPayment2EnumFindType
End Enum

Public Enum ptsPayment2FindTypeConstants
   ptsPayment2FindPayment2ID = cptsPayment2FindPayment2ID
   ptsPayment2FindPayDate = cptsPayment2FindPayDate
   ptsPayment2FindPayType = cptsPayment2FindPayType
   ptsPayment2FindTotal = cptsPayment2FindTotal
   ptsPayment2FindReference = cptsPayment2FindReference
End Enum


Private Function BusnService() As CPayment2B
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CPayment2B

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get EnumItems( _ 
   ByVal bvType As ptsPayment2sEnumConstants, _ 
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
      Case cptsPayment2EnumFindType
         oEnums.Add cptsPayment2FindPayment2ID, "Payment2ID"
         oEnums.Add cptsPayment2FindPayDate, "PayDate"
         oEnums.Add cptsPayment2FindPayType, "PayType"
         oEnums.Add cptsPayment2FindTotal, "Total"
         oEnums.Add cptsPayment2FindReference, "Reference"
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
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.Find(bvFindType, sBookMark, bvSearchText, bvDirection, bvMerchantID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   Find = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindType( _ 
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.FindType(bvFindType, sBookMark, bvSearchText, bvDirection, bvMerchantID, bvPayType, bvPayType2, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   FindType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindStatus( _ 
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.FindStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvMerchantID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   FindStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindStatusType( _ 
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.FindStatusType(bvFindType, sBookMark, bvSearchText, bvDirection, bvMerchantID, bvStatus, bvPayType, bvPayType2, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   FindStatusType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindConsumer( _ 
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.FindConsumer(bvFindType, sBookMark, bvSearchText, bvDirection, bvConsumerID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   FindConsumer = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindConsumerType( _ 
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumerType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.FindConsumerType(bvFindType, sBookMark, bvSearchText, bvDirection, bvConsumerID, bvPayType, bvPayType2, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   FindConsumerType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindConsumerStatus( _ 
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumerStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.FindConsumerStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvConsumerID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   FindConsumerStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindConsumerStatusType( _ 
   ByVal bvFindType As ptsPayment2User.ptsPayment2FindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumerStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   tRecs = BusnService.FindConsumerStatusType(bvFindType, sBookMark, bvSearchText, bvDirection, bvConsumerID, bvStatus, bvPayType, bvPayType2, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   '-----return the new bookmark
   FindConsumerStatusType = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsPayment2User.CPayment2
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
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
         Set oItem = New ptsPayment2User.CPayment2
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

Public Sub ListApprove( _ 
   ByVal bvMerchantID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListApprove"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListApprove(bvMerchantID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub CustomList( _ 
   ByVal bvStatus As Long, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvAmount As Currency, _ 
   ByVal bvPayDate As Date, _ 
   ByVal bvDescription As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.CustomList(bvStatus, bvMerchantID, bvPayType, bvAmount, bvPayDate, bvDescription)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPayment2User.CPayment2
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.Payment2ID)
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
   Dim oItem As ptsPayment2User.CPayment2
   Dim tRecs() As CPayment2B.tPayment2Type
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
   Optional ByVal bvElementName As String = "Payment2") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPayment2User.CPayment2
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
      sChildren = sChildren + EnumItems(ptsPayment2EnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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