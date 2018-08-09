VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CPayments"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPayments"
Private Const cDefaultLanguage As String = "en"
'-----variables
Private mSecurityToken As Long
Private mCurrentLanguage As String
Private mFindTypeID As Long
'-----child classes
Private moItems As Collection
'-----enumerators
Public Enum ptsPaymentsEnumConstants
   ptsPaymentEnumFindType = cptsPaymentEnumFindType
End Enum

Public Enum ptsPaymentFindTypeConstants
   ptsPaymentFindPaymentID = cptsPaymentFindPaymentID
   ptsPaymentFindReference = cptsPaymentFindReference
   ptsPaymentFindPayDate = cptsPaymentFindPayDate
   ptsPaymentFindPayType = cptsPaymentFindPayType
   ptsPaymentFindAmount = cptsPaymentFindAmount
   ptsPaymentFindDescription = cptsPaymentFindDescription
End Enum


Private Function BusnService() As CPaymentB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CPaymentB

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
   ByVal bvType As ptsPaymentsEnumConstants, _ 
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
      Case cptsPaymentEnumFindType
         oEnums.Add cptsPaymentFindPaymentID, "PaymentID"
         oEnums.Add cptsPaymentFindReference, "Reference"
         oEnums.Add cptsPaymentFindPayDate, "PayDate"
         oEnums.Add cptsPaymentFindPayType, "PayType"
         oEnums.Add cptsPaymentFindAmount, "Amount"
         oEnums.Add cptsPaymentFindDescription, "Description"
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
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
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
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
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
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
   tRecs = BusnService.FindType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvPayType, bvToken, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
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
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
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
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
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
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
   tRecs = BusnService.FindStatusType(bvFindType, sBookMark, bvSearchText, bvDirection, bvCompanyID, bvStatus, bvPayType, bvToken, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   '-----return the new bookmark
   FindStatusType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindMember( _ 
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
   tRecs = BusnService.FindMember(bvFindType, sBookMark, bvSearchText, bvDirection, bvMemberID, bvFromDate, bvToDate, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   '-----return the new bookmark
   FindMember = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindOwner( _ 
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
   tRecs = BusnService.FindOwner(bvFindType, sBookMark, bvSearchText, bvDirection, bvOwnerType, bvOwnerID, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   '-----return the new bookmark
   FindOwner = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindOwnerType( _ 
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwnerType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
   tRecs = BusnService.FindOwnerType(bvFindType, sBookMark, bvSearchText, bvDirection, bvOwnerType, bvOwnerID, bvPayType, bvToken, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   '-----return the new bookmark
   FindOwnerType = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindOwnerStatus( _ 
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwnerStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
   tRecs = BusnService.FindOwnerStatus(bvFindType, sBookMark, bvSearchText, bvDirection, bvOwnerType, bvOwnerID, bvStatus, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   '-----return the new bookmark
   FindOwnerStatus = sBookMark

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function FindOwnerStatusType( _ 
   ByVal bvFindType As ptsPaymentUser.ptsPaymentFindTypeConstants, _ 
   ByVal bvBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwnerStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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
   tRecs = BusnService.FindOwnerStatusType(bvFindType, sBookMark, bvSearchText, bvDirection, bvOwnerType, bvOwnerID, bvStatus, bvPayType, bvToken, bvSecurityToken)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   '-----return the new bookmark
   FindOwnerStatusType = sBookMark

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
   Optional ByVal bvSecurityToken As Long = 0) As ptsPaymentUser.CPayment
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves an item from the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Item"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
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
         Set oItem = New ptsPaymentUser.CPayment
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

Public Sub ListOwner( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOwner(bvOwnerType, bvOwnerID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListOwnerStatus( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOwnerStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListOwnerStatus(bvOwnerType, bvOwnerID, bvStatus)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListSubmittedCCCK( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvPayDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSubmittedCCCK"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListSubmittedCCCK(bvCompanyID, bvOwnerType, bvPayDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportStatusAmount( _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvOwnerType As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusAmount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatusAmount(bvReportFromDate, bvReportToDate, bvOwnerType)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportStatusCount( _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportStatusCount(bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportPayTypeAmount( _ 
   ByVal bvStatus As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportPayTypeAmount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportPayTypeAmount(bvStatus, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ReportPayTypeCount( _ 
   ByVal bvStatus As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportPayTypeCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ReportPayTypeCount(bvStatus, bvReportFromDate, bvReportToDate)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListMemberPayments( _ 
   ByVal bvOwnerID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberPayments"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListMemberPayments(bvOwnerID)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
   Next idxRec

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ListCustom( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayDate As Date, _ 
   ByVal bvNotes As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Initializes the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
   Dim idxRec As Long

   On Error GoTo ErrorHandler

   Set moItems = Nothing
   Set moItems = New Collection

   tRecs = BusnService.ListCustom(bvCompanyID, bvOwnerType, bvOwnerID, bvStatus, bvPayType, bvPayDate, bvNotes)

   For idxRec = 1 To UBound(tRecs)
      Set oItem = New ptsPaymentUser.CPayment
      oItem.DataRec = tRecs(idxRec)
      moItems.Add oItem, CStr(oItem.PaymentID)
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
   Dim oItem As ptsPaymentUser.CPayment
   Dim tRecs() As CPaymentB.tPaymentType
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

Public Function Sum( _ 
   ByVal bvAttr As String, _
   Optional ByVal bvFormat As Boolean = True) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the Sum of the specified Attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Sum"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
   Dim AttrID As Long
   Dim lSum As Long
   Dim dSum As Double
   Dim cSum As Currency

   On Error GoTo ErrorHandler

   Select Case bvAttr
      Case "Amount": AttrID = 1011
      Case "Total": AttrID = 1012
      Case "Credit": AttrID = 1013
      Case "Retail": AttrID = 1014
      Case "Commission": AttrID = 1015
   End Select

   If Not (moItems Is Nothing) Then
      If moItems.Count > 0 Then
         For Each oItem In moItems
            Select Case AttrID
               Case 1011: If oItem.Amount<>"" Then cSum = cSum + CCur(oItem.Amount)
               Case 1012: If oItem.Total<>"" Then cSum = cSum + CCur(oItem.Total)
               Case 1013: If oItem.Credit<>"" Then cSum = cSum + CCur(oItem.Credit)
               Case 1014: If oItem.Retail<>"" Then cSum = cSum + CCur(oItem.Retail)
               Case 1015: If oItem.Commission<>"" Then cSum = cSum + CCur(oItem.Commission)
            End Select
         Next oItem
      End If
   End If

   Select Case AttrID
      Case 1011: If bvFormat Then Sum = Format$(cSum, "currency") Else Sum = CStr(cSum)
      Case 1012: If bvFormat Then Sum = Format$(cSum, "currency") Else Sum = CStr(cSum)
      Case 1013: If bvFormat Then Sum = Format$(cSum, "currency") Else Sum = CStr(cSum)
      Case 1014: If bvFormat Then Sum = Format$(cSum, "currency") Else Sum = CStr(cSum)
      Case 1015: If bvFormat Then Sum = Format$(cSum, "currency") Else Sum = CStr(cSum)
   End Select
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XML( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Payment") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the collection.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oItem As ptsPaymentUser.CPayment
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
      sChildren = sChildren + EnumItems(ptsPaymentEnumFindType, mSecurityToken).XML("ptsFindTypeIDs", FindTypeID, False)
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