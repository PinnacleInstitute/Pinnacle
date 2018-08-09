VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CPayment"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPayment"
Private Const cEntityID As Long = 10
Private Const cDefaultLanguage As String = "en"
'-----properties
Private mDataRec As CPaymentB.tPaymentType
Private mSecurityToken As Long
Private mCurrentLanguage As String
'-----enumerators
Public Enum ptsPaymentEnumConstants
   ptsPaymentEnumPayType = cptsPaymentEnumPayType
   ptsPaymentEnumStatus = cptsPaymentEnumStatus
   ptsPaymentEnumCommStatus = cptsPaymentEnumCommStatus
End Enum

Public Enum ptsPaymentPayTypeConstants
   ptsPaymentPayTypeVisa = cptsPaymentPayTypeVisa
   ptsPaymentPayTypeMasterCard = cptsPaymentPayTypeMasterCard
   ptsPaymentPayTypeDiscover = cptsPaymentPayTypeDiscover
   ptsPaymentPayTypeAmex = cptsPaymentPayTypeAmex
   ptsPaymentPayTypeCheck = cptsPaymentPayTypeCheck
   ptsPaymentPayTypePayPal = cptsPaymentPayTypePayPal
   ptsPaymentPayTypeCash = cptsPaymentPayTypeCash
   ptsPaymentPayTypePO = cptsPaymentPayTypePO
   ptsPaymentPayTypeWallet = cptsPaymentPayTypeWallet
   ptsPaymentPayTypeiPayout = cptsPaymentPayTypeiPayout
   ptsPaymentPayTypePayQuicker = cptsPaymentPayTypePayQuicker
   ptsPaymentPayTypeSolidTrust = cptsPaymentPayTypeSolidTrust
   ptsPaymentPayTypeBitCoin = cptsPaymentPayTypeBitCoin
   ptsPaymentPayTypeBitCoinCash = cptsPaymentPayTypeBitCoinCash
   ptsPaymentPayTypeGCR = cptsPaymentPayTypeGCR
   ptsPaymentPayTypeNTX = cptsPaymentPayTypeNTX
   ptsPaymentPayTypeCoin1 = cptsPaymentPayTypeCoin1
   ptsPaymentPayTypeCoin2 = cptsPaymentPayTypeCoin2
   ptsPaymentPayTypeCoin3 = cptsPaymentPayTypeCoin3
   ptsPaymentPayTypeCoin4 = cptsPaymentPayTypeCoin4
   ptsPaymentPayTypeCoin5 = cptsPaymentPayTypeCoin5
   ptsPaymentPayTypeCoin6 = cptsPaymentPayTypeCoin6
   ptsPaymentPayTypeCoin7 = cptsPaymentPayTypeCoin7
   ptsPaymentPayTypeCoin8 = cptsPaymentPayTypeCoin8
   ptsPaymentPayTypeCoin9 = cptsPaymentPayTypeCoin9
   ptsPaymentPayTypeCoin10 = cptsPaymentPayTypeCoin10
   ptsPaymentPayTypeCommission = cptsPaymentPayTypeCommission
   ptsPaymentPayTypeCredit = cptsPaymentPayTypeCredit
   ptsPaymentPayTypeMiscPay1 = cptsPaymentPayTypeMiscPay1
   ptsPaymentPayTypeMiscPay2 = cptsPaymentPayTypeMiscPay2
   ptsPaymentPayTypeMiscPay3 = cptsPaymentPayTypeMiscPay3
End Enum

Public Enum ptsPaymentStatusConstants
   ptsPaymentStatusSubmitted = cptsPaymentStatusSubmitted
   ptsPaymentStatusPending = cptsPaymentStatusPending
   ptsPaymentStatusApproved = cptsPaymentStatusApproved
   ptsPaymentStatusDeclined = cptsPaymentStatusDeclined
   ptsPaymentStatusReturned = cptsPaymentStatusReturned
   ptsPaymentStatusCancelled = cptsPaymentStatusCancelled
   ptsPaymentStatusPartial = cptsPaymentStatusPartial
End Enum

Public Enum ptsPaymentCommStatusConstants
   ptsPaymentCommStatusNo = cptsPaymentCommStatusNo
   ptsPaymentCommStatusYes = cptsPaymentCommStatusYes
   ptsPaymentCommStatusNone = cptsPaymentCommStatusNone
   ptsPaymentCommStatusReclaimed = cptsPaymentCommStatusReclaimed
End Enum

Public Function Add( _ 
   Optional ByVal bvSecurityToken As Long = 0) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Adds a new record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Add"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Add mDataRec, mSecurityToken

   '-----return the new item
   Add = mDataRec.PaymentID

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

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

Public Sub Delete( _ 
   Optional ByVal bvPaymentID As Long = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Deletes the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Delete"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----initialize the ID if provided
   If bvPaymentID > 0 Then PaymentID = bvPaymentID

   BusnService.Delete mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Property Get EnumItems( _ 
   ByVal bvType As ptsPaymentEnumConstants) As wtSystem.CEnumItems
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
      Case cptsPaymentEnumPayType
         oEnums.Add cptsPaymentPayTypeVisa, "Visa"
         oEnums.Add cptsPaymentPayTypeMasterCard, "MasterCard"
         oEnums.Add cptsPaymentPayTypeDiscover, "Discover"
         oEnums.Add cptsPaymentPayTypeAmex, "Amex"
         oEnums.Add cptsPaymentPayTypeCheck, "Check"
         oEnums.Add cptsPaymentPayTypePayPal, "PayPal"
         oEnums.Add cptsPaymentPayTypeCash, "Cash"
         oEnums.Add cptsPaymentPayTypePO, "PO"
         oEnums.Add cptsPaymentPayTypeWallet, "Wallet"
         oEnums.Add cptsPaymentPayTypeiPayout, "iPayout"
         oEnums.Add cptsPaymentPayTypePayQuicker, "PayQuicker"
         oEnums.Add cptsPaymentPayTypeSolidTrust, "SolidTrust"
         oEnums.Add cptsPaymentPayTypeBitCoin, "BitCoin"
         oEnums.Add cptsPaymentPayTypeBitCoinCash, "BitCoinCash"
         oEnums.Add cptsPaymentPayTypeGCR, "GCR"
         oEnums.Add cptsPaymentPayTypeNTX, "NTX"
         oEnums.Add cptsPaymentPayTypeCoin1, "Coin1"
         oEnums.Add cptsPaymentPayTypeCoin2, "Coin2"
         oEnums.Add cptsPaymentPayTypeCoin3, "Coin3"
         oEnums.Add cptsPaymentPayTypeCoin4, "Coin4"
         oEnums.Add cptsPaymentPayTypeCoin5, "Coin5"
         oEnums.Add cptsPaymentPayTypeCoin6, "Coin6"
         oEnums.Add cptsPaymentPayTypeCoin7, "Coin7"
         oEnums.Add cptsPaymentPayTypeCoin8, "Coin8"
         oEnums.Add cptsPaymentPayTypeCoin9, "Coin9"
         oEnums.Add cptsPaymentPayTypeCoin10, "Coin10"
         oEnums.Add cptsPaymentPayTypeCommission, "Commission"
         oEnums.Add cptsPaymentPayTypeCredit, "Credit"
         oEnums.Add cptsPaymentPayTypeMiscPay1, "MiscPay1"
         oEnums.Add cptsPaymentPayTypeMiscPay2, "MiscPay2"
         oEnums.Add cptsPaymentPayTypeMiscPay3, "MiscPay3"
      Case cptsPaymentEnumStatus
         oEnums.Add cptsPaymentStatusSubmitted, "Submitted"
         oEnums.Add cptsPaymentStatusPending, "Pending"
         oEnums.Add cptsPaymentStatusApproved, "Approved"
         oEnums.Add cptsPaymentStatusDeclined, "Declined"
         oEnums.Add cptsPaymentStatusReturned, "Returned"
         oEnums.Add cptsPaymentStatusCancelled, "Cancelled"
         oEnums.Add cptsPaymentStatusPartial, "Partial"
      Case cptsPaymentEnumCommStatus
         oEnums.Add cptsPaymentCommStatusNo, "No"
         oEnums.Add cptsPaymentCommStatusYes, "Yes"
         oEnums.Add cptsPaymentCommStatusNone, "None"
         oEnums.Add cptsPaymentCommStatusReclaimed, "Reclaimed"
   End Select

   Set EnumItems = oEnums
   Set oEnums = Nothing

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Sub Load( _ 
   Optional ByVal bvPaymentID As Long = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Load"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----initialize the ID if provided
   If bvPaymentID > 0 Then PaymentID = bvPaymentID

   BusnService.Fetch mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function LastBillingID( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LastBillingID"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvOwnerType <> 0 Then OwnerType = bvOwnerType
   If bvOwnerID <> 0 Then OwnerID = bvOwnerID

   LastBillingID = BusnService.LastBillingID(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetPendingCCCK() As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetPendingCCCK"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   SetPendingCCCK = BusnService.SetPendingCCCK(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetCompanyPendingCCCK( _ 
   ByVal bvCompanyID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetCompanyPendingCCCK"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvCompanyID <> 0 Then CompanyID = bvCompanyID

   SetCompanyPendingCCCK = BusnService.SetCompanyPendingCCCK(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetCompany( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetCompany"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvOwnerType <> 0 Then OwnerType = bvOwnerType
   If bvOwnerID <> 0 Then OwnerID = bvOwnerID

   GetCompany = BusnService.GetCompany(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetOwnerEmail( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetOwnerEmail"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvOwnerType <> 0 Then OwnerType = bvOwnerType
   If bvOwnerID <> 0 Then OwnerID = bvOwnerID

   GetOwnerEmail = BusnService.GetOwnerEmail(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CompanyPayments( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvPayDate As Date) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CompanyPayments"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   CompanyID = bvCompanyID
   PayDate = bvPayDate

   CompanyPayments = BusnService.CompanyPayments(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CompanyDebits( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvPayDate As Date) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CompanyDebits"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   CompanyID = bvCompanyID
   PayDate = bvPayDate

   CompanyDebits = BusnService.CompanyDebits(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Custom( _ 
   ByVal bvPaymentID As Long, _ 
   ByVal bvReference As String, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvNotes As String) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Custom"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   PaymentID = bvPaymentID
   If bvReference <> "" Then Reference = bvReference
   Status = bvStatus
   If bvNotes <> "" Then Notes = bvNotes

   Custom = BusnService.Custom(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Save( _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Adds or updates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Save"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Update mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Validate( _ 
   Optional ByVal bvNew As Integer = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Validates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Validate"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Validate mDataRec, mSecurityToken, bvNew

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function XML( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Payment") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the item.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim sChildren As String
   Dim sAttributes As String
   Dim sValue As String
   Dim sOption As String
   Dim bLookup As Integer
   Dim bFilter As Integer
   Dim bStatic As Integer
   Dim bAttrib As Integer

   On Error GoTo ErrorHandler

   'Handle Common Options for item classes
   Select Case bvOption
      Case 2: bvOption = 1111    ' attributes with all enums
      Case 3: bvOption = 1001    ' attributes with static enums only
   End Select
   sOption = Format(bvOption, "0000")
   bAttrib = (Mid(sOption, 1, 1) = "1")
   bFilter = (Mid(sOption, 2, 1) = "1")
   bLookup = (Mid(sOption, 3, 1) = "1")
   bStatic = (Mid(sOption, 4, 1) = "1")

   '-----create the XML for the children
   sChildren = ""
   If bStatic Then
      If IsNumeric(PayType) Then
         sChildren = sChildren + EnumItems(1010).XML("ptsPayTypes", PayType)
      Else
         sChildren = sChildren + EnumItems (1010).XML("ptsPayTypes")
      End If

      If IsNumeric(Status) Then
         sChildren = sChildren + EnumItems(1018).XML("ptsStatuss", Status)
      Else
         sChildren = sChildren + EnumItems (1018).XML("ptsStatuss")
      End If

      If IsNumeric(CommStatus) Then
         sChildren = sChildren + EnumItems(1021).XML("ptsCommStatuss", CommStatus)
      Else
         sChildren = sChildren + EnumItems (1021).XML("ptsCommStatuss")
      End If

   End If
   '-----create the XML for the attributes
   sAttributes = ""

   If bAttrib Then
      If (Len(PaymentID) > 0) Then sAttributes = sAttributes + XMLAttribute("PaymentID", PaymentID, False)
      If (Len(CompanyID) > 0) Then sAttributes = sAttributes + XMLAttribute("CompanyID", CompanyID, False)
      If (Len(OwnerType) > 0) Then sAttributes = sAttributes + XMLAttribute("OwnerType", OwnerType, False)
      If (Len(OwnerID) > 0) Then sAttributes = sAttributes + XMLAttribute("OwnerID", OwnerID, False)
      If (Len(BillingID) > 0) Then sAttributes = sAttributes + XMLAttribute("BillingID", BillingID, False)
      If (Len(ProductID) > 0) Then sAttributes = sAttributes + XMLAttribute("ProductID", ProductID, False)
      If (Len(PaidID) > 0) Then sAttributes = sAttributes + XMLAttribute("PaidID", PaidID, False)
      If (Len(PayDate) > 0) And (PayDate <> "0") Then sAttributes = sAttributes + XMLAttribute("PayDate", Format$(PayDate, "m/d/yyyy"), False)
      If (Len(PaidDate) > 0) And (PaidDate <> "0") Then sAttributes = sAttributes + XMLAttribute("PaidDate", Format$(PaidDate, "m/d/yyyy"), False)
      If (Len(PayType) > 0) Then sAttributes = sAttributes + XMLAttribute("PayType", PayType, False)
      If (Len(Amount) > 0) Then sAttributes = sAttributes + XMLAttribute("Amount", Format$(Amount, "currency"), False)
      If (Len(Total) > 0) Then sAttributes = sAttributes + XMLAttribute("Total", Format$(Total, "currency"), False)
      If (Len(Credit) > 0) Then sAttributes = sAttributes + XMLAttribute("Credit", Format$(Credit, "currency"), False)
      If (Len(Retail) > 0) Then sAttributes = sAttributes + XMLAttribute("Retail", Format$(Retail, "currency"), False)
      If (Len(Commission) > 0) Then sAttributes = sAttributes + XMLAttribute("Commission", Format$(Commission, "currency"), False)
      If (Len(Description) > 0) Then sAttributes = sAttributes + XMLAttribute("Description", Description, False)
      If (Len(Purpose) > 0) Then sAttributes = sAttributes + XMLAttribute("Purpose", Purpose, False)
      If (Len(Status) > 0) Then sAttributes = sAttributes + XMLAttribute("Status", Status, False)
      If (Len(Reference) > 0) Then sAttributes = sAttributes + XMLAttribute("Reference", Reference, False)
      If (Len(Notes) > 0) Then sAttributes = sAttributes + XMLAttribute("Notes", Notes, False)
      If (Len(CommStatus) > 0) Then sAttributes = sAttributes + XMLAttribute("CommStatus", CommStatus, False)
      If (Len(CommDate) > 0) And (CommDate <> "0") Then sAttributes = sAttributes + XMLAttribute("CommDate", Format$(CommDate, "m/d/yyyy"), False)
      If (Len(TokenType) > 0) Then sAttributes = sAttributes + XMLAttribute("TokenType", TokenType, False)
      If (Len(TokenOwner) > 0) Then sAttributes = sAttributes + XMLAttribute("TokenOwner", TokenOwner, False)
      If (Len(Token) > 0) Then sAttributes = sAttributes + XMLAttribute("Token", Token, False)
   End If
   '-----create the XML for the value
   sValue = ""

   '-----create the XML for the object
   If bAttrib Then
      XML = XMLElement("pts" + bvElementName, sAttributes, sValue, sChildren)
   Else
      XML = sChildren
   End If

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Friend Property Get DataRec() As CPaymentB.tPaymentType
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   DataRec = mDataRec

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Friend Property Let DataRec( _ 
   ByRef brDataRec As CPaymentB.tPaymentType)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec = brDataRec

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)
   mCurrentLanguage = bvLanguage
End Property


Public Property Get PaymentID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PaymentID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   PaymentID = mDataRec.PaymentID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let PaymentID( _ 
   ByVal bvPaymentID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PaymentID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.PaymentID = bvPaymentID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get CompanyID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CompanyID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   CompanyID = mDataRec.CompanyID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CompanyID( _ 
   ByVal bvCompanyID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CompanyID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CompanyID = bvCompanyID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get OwnerType() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "OwnerType_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   OwnerType = mDataRec.OwnerType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let OwnerType( _ 
   ByVal bvOwnerType As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "OwnerType_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.OwnerType = bvOwnerType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get OwnerID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "OwnerID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   OwnerID = mDataRec.OwnerID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let OwnerID( _ 
   ByVal bvOwnerID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "OwnerID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.OwnerID = bvOwnerID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get BillingID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BillingID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   BillingID = mDataRec.BillingID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let BillingID( _ 
   ByVal bvBillingID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BillingID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.BillingID = bvBillingID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ProductID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProductID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ProductID = mDataRec.ProductID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ProductID( _ 
   ByVal bvProductID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProductID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ProductID = bvProductID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get PaidID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PaidID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   PaidID = mDataRec.PaidID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let PaidID( _ 
   ByVal bvPaidID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PaidID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.PaidID = bvPaidID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get PayDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PayDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.PayDate) Then PayDate = mDataRec.PayDate Else PayDate = 0
   If mDataRec.PayDate = "1/1/1900" Then PayDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let PayDate( _ 
   ByVal bvPayDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PayDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.PayDate = bvPayDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get PaidDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PaidDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.PaidDate) Then PaidDate = mDataRec.PaidDate Else PaidDate = 0
   If mDataRec.PaidDate = "1/1/1900" Then PaidDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let PaidDate( _ 
   ByVal bvPaidDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PaidDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.PaidDate = bvPaidDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get PayType() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PayType_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   PayType = mDataRec.PayType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let PayType( _ 
   ByVal bvPayType As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PayType_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.PayType = bvPayType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Amount() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Amount_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Amount = mDataRec.Amount

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Amount( _ 
   ByVal bvAmount As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Amount_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Amount = bvAmount

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Total() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Total_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Total = mDataRec.Total

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Total( _ 
   ByVal bvTotal As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Total_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Total = bvTotal

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Credit() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Credit_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Credit = mDataRec.Credit

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Credit( _ 
   ByVal bvCredit As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Credit_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Credit = bvCredit

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Retail() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Retail_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Retail = mDataRec.Retail

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Retail( _ 
   ByVal bvRetail As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Retail_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Retail = bvRetail

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Commission() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Commission_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Commission = mDataRec.Commission

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Commission( _ 
   ByVal bvCommission As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Commission_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Commission = bvCommission

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Description() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Description_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Description = mDataRec.Description

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Description( _ 
   ByVal bvDescription As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Description_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Description = bvDescription

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Purpose() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Purpose_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Purpose = mDataRec.Purpose

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Purpose( _ 
   ByVal bvPurpose As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Purpose_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Purpose = bvPurpose

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Status() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Status_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Status = mDataRec.Status

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Status( _ 
   ByVal bvStatus As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Status_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Status = bvStatus

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Reference() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Reference_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Reference = mDataRec.Reference

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Reference( _ 
   ByVal bvReference As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Reference_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Reference = bvReference

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Notes() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Notes_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Notes = mDataRec.Notes

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Notes( _ 
   ByVal bvNotes As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Notes_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Notes = bvNotes

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get CommStatus() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommStatus_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   CommStatus = mDataRec.CommStatus

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CommStatus( _ 
   ByVal bvCommStatus As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommStatus_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CommStatus = bvCommStatus

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get CommDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.CommDate) Then CommDate = mDataRec.CommDate Else CommDate = 0
   If mDataRec.CommDate = "1/1/1900" Then CommDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CommDate( _ 
   ByVal bvCommDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CommDate = bvCommDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get TokenType() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TokenType_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   TokenType = mDataRec.TokenType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let TokenType( _ 
   ByVal bvTokenType As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TokenType_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.TokenType = bvTokenType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get TokenOwner() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TokenOwner_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   TokenOwner = mDataRec.TokenOwner

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let TokenOwner( _ 
   ByVal bvTokenOwner As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TokenOwner_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.TokenOwner = bvTokenOwner

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Token() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Token_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Token = mDataRec.Token

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Token( _ 
   ByVal bvToken As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Token_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Token = bvToken

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ReportFromDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportFromDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.ReportFromDate) Then ReportFromDate = mDataRec.ReportFromDate Else ReportFromDate = 0
   If mDataRec.ReportFromDate = "1/1/1900" Then ReportFromDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ReportFromDate( _ 
   ByVal bvReportFromDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportFromDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ReportFromDate = bvReportFromDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ReportToDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportToDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.ReportToDate) Then ReportToDate = mDataRec.ReportToDate Else ReportToDate = 0
   If mDataRec.ReportToDate = "1/1/1900" Then ReportToDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ReportToDate( _ 
   ByVal bvReportToDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportToDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ReportToDate = bvReportToDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Count() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Count_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Count = mDataRec.Count

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Count( _ 
   ByVal bvCount As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Count_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Count = bvCount

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get FromDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FromDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.FromDate) Then FromDate = mDataRec.FromDate Else FromDate = 0
   If mDataRec.FromDate = "1/1/1900" Then FromDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let FromDate( _ 
   ByVal bvFromDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FromDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.FromDate = bvFromDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ToDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ToDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.ToDate) Then ToDate = mDataRec.ToDate Else ToDate = 0
   If mDataRec.ToDate = "1/1/1900" Then ToDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ToDate( _ 
   ByVal bvToDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ToDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ToDate = bvToDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get MemberID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   MemberID = mDataRec.MemberID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let MemberID( _ 
   ByVal bvMemberID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.MemberID = bvMemberID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Private Sub Class_Initialize()
   mCurrentLanguage = cDefaultLanguage
End Sub