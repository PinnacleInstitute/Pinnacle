VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CCoinPrice"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CCoinPrice"
Private Const cEntityID As Long = 166
Private Const cDefaultLanguage As String = "en"
'-----properties
Private mDataRec As CCoinPriceB.tCoinPriceType
Private mSecurityToken As Long
Private mCurrentLanguage As String
'-----enumerators
Public Enum ptsCoinPriceEnumConstants
   ptsCoinPriceEnumCoin = cptsCoinPriceEnumCoin
   ptsCoinPriceEnumSource = cptsCoinPriceEnumSource
   ptsCoinPriceEnumStatus = cptsCoinPriceEnumStatus
End Enum

Public Enum ptsCoinPriceCoinConstants
   ptsCoinPriceCoinCoin1 = cptsCoinPriceCoinCoin1
   ptsCoinPriceCoinCoin2 = cptsCoinPriceCoinCoin2
   ptsCoinPriceCoinCoin3 = cptsCoinPriceCoinCoin3
   ptsCoinPriceCoinCoin4 = cptsCoinPriceCoinCoin4
   ptsCoinPriceCoinCoin5 = cptsCoinPriceCoinCoin5
   ptsCoinPriceCoinCoin6 = cptsCoinPriceCoinCoin6
   ptsCoinPriceCoinCoin7 = cptsCoinPriceCoinCoin7
   ptsCoinPriceCoinCoin8 = cptsCoinPriceCoinCoin8
   ptsCoinPriceCoinCoin9 = cptsCoinPriceCoinCoin9
   ptsCoinPriceCoinCoin10 = cptsCoinPriceCoinCoin10
End Enum

Public Enum ptsCoinPriceSourceConstants
   ptsCoinPriceSourceSource1 = cptsCoinPriceSourceSource1
   ptsCoinPriceSourceSource2 = cptsCoinPriceSourceSource2
   ptsCoinPriceSourceSource3 = cptsCoinPriceSourceSource3
   ptsCoinPriceSourceSource4 = cptsCoinPriceSourceSource4
   ptsCoinPriceSourceSource5 = cptsCoinPriceSourceSource5
   ptsCoinPriceSourceSource6 = cptsCoinPriceSourceSource6
   ptsCoinPriceSourceSource7 = cptsCoinPriceSourceSource7
   ptsCoinPriceSourceSource8 = cptsCoinPriceSourceSource8
   ptsCoinPriceSourceSource9 = cptsCoinPriceSourceSource9
   ptsCoinPriceSourceSource10 = cptsCoinPriceSourceSource10
End Enum

Public Enum ptsCoinPriceStatusConstants
   ptsCoinPriceStatusDefault = cptsCoinPriceStatusDefault
   ptsCoinPriceStatusActive = cptsCoinPriceStatusActive
   ptsCoinPriceStatusInactive = cptsCoinPriceStatusInactive
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
   Add = mDataRec.CoinPriceID

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Function BusnService() As CCoinPriceB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CCoinPriceB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Delete( _ 
   Optional ByVal bvCoinPriceID As Long = 0, _ 
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
   If bvCoinPriceID > 0 Then CoinPriceID = bvCoinPriceID

   BusnService.Delete mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Property Get EnumItems( _ 
   ByVal bvType As ptsCoinPriceEnumConstants) As wtSystem.CEnumItems
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
      Case cptsCoinPriceEnumCoin
         oEnums.Add cptsCoinPriceCoinCoin1, "Coin1"
         oEnums.Add cptsCoinPriceCoinCoin2, "Coin2"
         oEnums.Add cptsCoinPriceCoinCoin3, "Coin3"
         oEnums.Add cptsCoinPriceCoinCoin4, "Coin4"
         oEnums.Add cptsCoinPriceCoinCoin5, "Coin5"
         oEnums.Add cptsCoinPriceCoinCoin6, "Coin6"
         oEnums.Add cptsCoinPriceCoinCoin7, "Coin7"
         oEnums.Add cptsCoinPriceCoinCoin8, "Coin8"
         oEnums.Add cptsCoinPriceCoinCoin9, "Coin9"
         oEnums.Add cptsCoinPriceCoinCoin10, "Coin10"
      Case cptsCoinPriceEnumSource
         oEnums.Add cptsCoinPriceSourceSource1, "Source1"
         oEnums.Add cptsCoinPriceSourceSource2, "Source2"
         oEnums.Add cptsCoinPriceSourceSource3, "Source3"
         oEnums.Add cptsCoinPriceSourceSource4, "Source4"
         oEnums.Add cptsCoinPriceSourceSource5, "Source5"
         oEnums.Add cptsCoinPriceSourceSource6, "Source6"
         oEnums.Add cptsCoinPriceSourceSource7, "Source7"
         oEnums.Add cptsCoinPriceSourceSource8, "Source8"
         oEnums.Add cptsCoinPriceSourceSource9, "Source9"
         oEnums.Add cptsCoinPriceSourceSource10, "Source10"
      Case cptsCoinPriceEnumStatus
         oEnums.Add cptsCoinPriceStatusDefault, "Default"
         oEnums.Add cptsCoinPriceStatusActive, "Active"
         oEnums.Add cptsCoinPriceStatusInactive, "Inactive"
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
   Optional ByVal bvCoinPriceID As Long = 0, _ 
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
   If bvCoinPriceID > 0 Then CoinPriceID = bvCoinPriceID

   BusnService.Fetch mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function GetPrice( _ 
   ByVal bvCoin As Long, _ 
   ByVal bvCurrencyCode As String) As Currency
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetPrice"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   Coin = bvCoin
   If bvCurrencyCode <> "" Then CurrencyCode = bvCurrencyCode

   GetPrice = BusnService.GetPrice(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetPrice( _ 
   ByVal bvSource As Long, _ 
   ByVal bvCoin As Long, _ 
   ByVal bvCurrencyCode As String, _ 
   ByVal bvPrice As Currency) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetPrice"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   Source = bvSource
   Coin = bvCoin
   If bvCurrencyCode <> "" Then CurrencyCode = bvCurrencyCode
   Price = bvPrice

   SetPrice = BusnService.SetPrice(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CalcPrice( _ 
   ByVal bvCoin As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcPrice"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   Coin = bvCoin

   CalcPrice = BusnService.CalcPrice(mDataRec, mSecurityToken)

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
   Optional ByVal bvElementName As String = "CoinPrice") As String
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
      If IsNumeric(Coin) Then
         sChildren = sChildren + EnumItems(16603).XML("ptsCoins", Coin)
      Else
         sChildren = sChildren + EnumItems (16603).XML("ptsCoins")
      End If

      If IsNumeric(Source) Then
         sChildren = sChildren + EnumItems(16604).XML("ptsSources", Source)
      Else
         sChildren = sChildren + EnumItems (16604).XML("ptsSources")
      End If

      If IsNumeric(Status) Then
         sChildren = sChildren + EnumItems(16608).XML("ptsStatuss", Status)
      Else
         sChildren = sChildren + EnumItems (16608).XML("ptsStatuss")
      End If

   End If
   '-----create the XML for the attributes
   sAttributes = ""

   If bAttrib Then
      If (Len(CoinPriceID) > 0) Then sAttributes = sAttributes + XMLAttribute("CoinPriceID", CoinPriceID, False)
      If (Len(Coin) > 0) Then sAttributes = sAttributes + XMLAttribute("Coin", Coin, False)
      If (Len(Source) > 0) Then sAttributes = sAttributes + XMLAttribute("Source", Source, False)
      If (Len(Price) > 0) Then sAttributes = sAttributes + XMLAttribute("Price", Format$(Price, "###,##0.0000"), False)
      If (Len(PriceDate) > 0) And (PriceDate <> "0") Then sAttributes = sAttributes + XMLAttribute("PriceDate", Format$(PriceDate, "m-d-yy h:mm:ss am/pm"), False)
      If (Len(CurrencyCode) > 0) Then sAttributes = sAttributes + XMLAttribute("CurrencyCode", CurrencyCode, False)
      If (Len(Status) > 0) Then sAttributes = sAttributes + XMLAttribute("Status", Status, False)
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

Friend Property Get DataRec() As CCoinPriceB.tCoinPriceType
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
   ByRef brDataRec As CCoinPriceB.tCoinPriceType)
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


Public Property Get CoinPriceID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CoinPriceID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   CoinPriceID = mDataRec.CoinPriceID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CoinPriceID( _ 
   ByVal bvCoinPriceID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CoinPriceID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CoinPriceID = bvCoinPriceID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Coin() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Coin_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Coin = mDataRec.Coin

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Coin( _ 
   ByVal bvCoin As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Coin_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Coin = bvCoin

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Source() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Source_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Source = mDataRec.Source

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Source( _ 
   ByVal bvSource As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Source_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Source = bvSource

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Price() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Price_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Price = mDataRec.Price

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Price( _ 
   ByVal bvPrice As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Price_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Price = bvPrice

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get PriceDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PriceDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.PriceDate) Then PriceDate = mDataRec.PriceDate Else PriceDate = 0
   If mDataRec.PriceDate = "1/1/1900" Then PriceDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let PriceDate( _ 
   ByVal bvPriceDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PriceDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.PriceDate = bvPriceDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get CurrencyCode() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CurrencyCode_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   CurrencyCode = mDataRec.CurrencyCode

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CurrencyCode( _ 
   ByVal bvCurrencyCode As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CurrencyCode_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CurrencyCode = bvCurrencyCode

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

Private Sub Class_Initialize()
   mCurrentLanguage = cDefaultLanguage
End Sub