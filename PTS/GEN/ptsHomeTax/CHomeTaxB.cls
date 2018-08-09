VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CHomeTaxB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CHomeTax"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tHomeTaxType
   HomeTaxID As String
   MemberID As String
   TaxRate As String
   Office As String
   Miles As String
   Home As String
   Meetings As String
   Meals As String
   Supplies As String
   Gifts As String
   Materials As String
   Phones As String
   Internet As String
   Kids As String
   Subscriptions As String
   Entertainment As String
   Activities As String
   Events As String
   Medical As String
   Recreational As String
End Type

Public Sub Add( _ 
   ByRef brRec As tHomeTaxType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Add the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Add"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   Validate brRec, bvUserID, 1

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@HomeTaxID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@TaxRate", adInteger, adParamInput, vbNull, CLng(brRec.TaxRate))
      .Parameters.Append .CreateParameter("@Office", adInteger, adParamInput, vbNull, CLng(brRec.Office))
      .Parameters.Append .CreateParameter("@Miles", adInteger, adParamInput, vbNull, CLng(brRec.Miles))
      .Parameters.Append .CreateParameter("@Home", adCurrency, adParamInput, vbNull, CCur(brRec.Home))
      .Parameters.Append .CreateParameter("@Meetings", adCurrency, adParamInput, vbNull, CCur(brRec.Meetings))
      .Parameters.Append .CreateParameter("@Meals", adCurrency, adParamInput, vbNull, CCur(brRec.Meals))
      .Parameters.Append .CreateParameter("@Supplies", adCurrency, adParamInput, vbNull, CCur(brRec.Supplies))
      .Parameters.Append .CreateParameter("@Gifts", adCurrency, adParamInput, vbNull, CCur(brRec.Gifts))
      .Parameters.Append .CreateParameter("@Materials", adCurrency, adParamInput, vbNull, CCur(brRec.Materials))
      .Parameters.Append .CreateParameter("@Phones", adCurrency, adParamInput, vbNull, CCur(brRec.Phones))
      .Parameters.Append .CreateParameter("@Internet", adCurrency, adParamInput, vbNull, CCur(brRec.Internet))
      .Parameters.Append .CreateParameter("@Kids", adCurrency, adParamInput, vbNull, CCur(brRec.Kids))
      .Parameters.Append .CreateParameter("@Subscriptions", adCurrency, adParamInput, vbNull, CCur(brRec.Subscriptions))
      .Parameters.Append .CreateParameter("@Entertainment", adCurrency, adParamInput, vbNull, CCur(brRec.Entertainment))
      .Parameters.Append .CreateParameter("@Activities", adCurrency, adParamInput, vbNull, CCur(brRec.Activities))
      .Parameters.Append .CreateParameter("@Events", adCurrency, adParamInput, vbNull, CCur(brRec.Events))
      .Parameters.Append .CreateParameter("@Medical", adCurrency, adParamInput, vbNull, CCur(brRec.Medical))
      .Parameters.Append .CreateParameter("@Recreational", adCurrency, adParamInput, vbNull, CCur(brRec.Recreational))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_HomeTax_Add"

   '-----get return values
   With brRec
      .HomeTaxID = moUtil.FetchLong(oCmd.Parameters.Item("@HomeTaxID").Value)
   End With

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Fetch( _ 
   ByRef brRec As tHomeTaxType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Fetch"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .HomeTaxID = moUtil.EditLong(.HomeTaxID, "HomeTaxID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@HomeTaxID", adInteger, adParamInput, vbNull, CLng(brRec.HomeTaxID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TaxRate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Office", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Miles", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Home", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Meetings", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Meals", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Supplies", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Gifts", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Materials", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Phones", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Internet", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Kids", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Subscriptions", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Entertainment", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Activities", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Events", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Medical", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Recreational", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_HomeTax_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .TaxRate = moUtil.FetchLong(oCmd.Parameters.Item("@TaxRate").Value)
      .Office = moUtil.FetchLong(oCmd.Parameters.Item("@Office").Value)
      .Miles = moUtil.FetchLong(oCmd.Parameters.Item("@Miles").Value)
      .Home = moUtil.FetchCurrency(oCmd.Parameters.Item("@Home").Value)
      .Meetings = moUtil.FetchCurrency(oCmd.Parameters.Item("@Meetings").Value)
      .Meals = moUtil.FetchCurrency(oCmd.Parameters.Item("@Meals").Value)
      .Supplies = moUtil.FetchCurrency(oCmd.Parameters.Item("@Supplies").Value)
      .Gifts = moUtil.FetchCurrency(oCmd.Parameters.Item("@Gifts").Value)
      .Materials = moUtil.FetchCurrency(oCmd.Parameters.Item("@Materials").Value)
      .Phones = moUtil.FetchCurrency(oCmd.Parameters.Item("@Phones").Value)
      .Internet = moUtil.FetchCurrency(oCmd.Parameters.Item("@Internet").Value)
      .Kids = moUtil.FetchCurrency(oCmd.Parameters.Item("@Kids").Value)
      .Subscriptions = moUtil.FetchCurrency(oCmd.Parameters.Item("@Subscriptions").Value)
      .Entertainment = moUtil.FetchCurrency(oCmd.Parameters.Item("@Entertainment").Value)
      .Activities = moUtil.FetchCurrency(oCmd.Parameters.Item("@Activities").Value)
      .Events = moUtil.FetchCurrency(oCmd.Parameters.Item("@Events").Value)
      .Medical = moUtil.FetchCurrency(oCmd.Parameters.Item("@Medical").Value)
      .Recreational = moUtil.FetchCurrency(oCmd.Parameters.Item("@Recreational").Value)
   End With

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub FetchMember( _ 
   ByRef brRec As tHomeTaxType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@HomeTaxID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TaxRate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Office", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Miles", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Home", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Meetings", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Meals", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Supplies", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Gifts", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Materials", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Phones", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Internet", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Kids", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Subscriptions", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Entertainment", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Activities", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Events", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Medical", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Recreational", adCurrency, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_HomeTax_FetchMember"

   '-----get return values
   With brRec
      .HomeTaxID = moUtil.FetchLong(oCmd.Parameters.Item("@HomeTaxID").Value)
      .TaxRate = moUtil.FetchLong(oCmd.Parameters.Item("@TaxRate").Value)
      .Office = moUtil.FetchLong(oCmd.Parameters.Item("@Office").Value)
      .Miles = moUtil.FetchLong(oCmd.Parameters.Item("@Miles").Value)
      .Home = moUtil.FetchCurrency(oCmd.Parameters.Item("@Home").Value)
      .Meetings = moUtil.FetchCurrency(oCmd.Parameters.Item("@Meetings").Value)
      .Meals = moUtil.FetchCurrency(oCmd.Parameters.Item("@Meals").Value)
      .Supplies = moUtil.FetchCurrency(oCmd.Parameters.Item("@Supplies").Value)
      .Gifts = moUtil.FetchCurrency(oCmd.Parameters.Item("@Gifts").Value)
      .Materials = moUtil.FetchCurrency(oCmd.Parameters.Item("@Materials").Value)
      .Phones = moUtil.FetchCurrency(oCmd.Parameters.Item("@Phones").Value)
      .Internet = moUtil.FetchCurrency(oCmd.Parameters.Item("@Internet").Value)
      .Kids = moUtil.FetchCurrency(oCmd.Parameters.Item("@Kids").Value)
      .Subscriptions = moUtil.FetchCurrency(oCmd.Parameters.Item("@Subscriptions").Value)
      .Entertainment = moUtil.FetchCurrency(oCmd.Parameters.Item("@Entertainment").Value)
      .Activities = moUtil.FetchCurrency(oCmd.Parameters.Item("@Activities").Value)
      .Events = moUtil.FetchCurrency(oCmd.Parameters.Item("@Events").Value)
      .Medical = moUtil.FetchCurrency(oCmd.Parameters.Item("@Medical").Value)
      .Recreational = moUtil.FetchCurrency(oCmd.Parameters.Item("@Recreational").Value)
   End With

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Update( _ 
   ByRef brRec As tHomeTaxType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Updates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Update"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   Validate brRec, bvUserID

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@HomeTaxID", adInteger, adParamInput, vbNull, CLng(brRec.HomeTaxID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@TaxRate", adInteger, adParamInput, vbNull, CLng(brRec.TaxRate))
      .Parameters.Append .CreateParameter("@Office", adInteger, adParamInput, vbNull, CLng(brRec.Office))
      .Parameters.Append .CreateParameter("@Miles", adInteger, adParamInput, vbNull, CLng(brRec.Miles))
      .Parameters.Append .CreateParameter("@Home", adCurrency, adParamInput, vbNull, CCur(brRec.Home))
      .Parameters.Append .CreateParameter("@Meetings", adCurrency, adParamInput, vbNull, CCur(brRec.Meetings))
      .Parameters.Append .CreateParameter("@Meals", adCurrency, adParamInput, vbNull, CCur(brRec.Meals))
      .Parameters.Append .CreateParameter("@Supplies", adCurrency, adParamInput, vbNull, CCur(brRec.Supplies))
      .Parameters.Append .CreateParameter("@Gifts", adCurrency, adParamInput, vbNull, CCur(brRec.Gifts))
      .Parameters.Append .CreateParameter("@Materials", adCurrency, adParamInput, vbNull, CCur(brRec.Materials))
      .Parameters.Append .CreateParameter("@Phones", adCurrency, adParamInput, vbNull, CCur(brRec.Phones))
      .Parameters.Append .CreateParameter("@Internet", adCurrency, adParamInput, vbNull, CCur(brRec.Internet))
      .Parameters.Append .CreateParameter("@Kids", adCurrency, adParamInput, vbNull, CCur(brRec.Kids))
      .Parameters.Append .CreateParameter("@Subscriptions", adCurrency, adParamInput, vbNull, CCur(brRec.Subscriptions))
      .Parameters.Append .CreateParameter("@Entertainment", adCurrency, adParamInput, vbNull, CCur(brRec.Entertainment))
      .Parameters.Append .CreateParameter("@Activities", adCurrency, adParamInput, vbNull, CCur(brRec.Activities))
      .Parameters.Append .CreateParameter("@Events", adCurrency, adParamInput, vbNull, CCur(brRec.Events))
      .Parameters.Append .CreateParameter("@Medical", adCurrency, adParamInput, vbNull, CCur(brRec.Medical))
      .Parameters.Append .CreateParameter("@Recreational", adCurrency, adParamInput, vbNull, CCur(brRec.Recreational))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_HomeTax_Update"

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Validate( _ 
   ByRef brRec As tHomeTaxType, _ 
   ByVal bvUserID As Long, _ 
   Optional ByVal bvNew As Integer = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Validates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Validate"
   '------------------------------------------------------------------------------------------------------------------------

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      If bvNew = 0 Then
         .HomeTaxID = moUtil.EditLong(.HomeTaxID, "HomeTaxID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .TaxRate = moUtil.EditLong(.TaxRate, "TaxRate", False) 
      .Office = moUtil.EditLong(.Office, "Office", False) 
      .Miles = moUtil.EditLong(.Miles, "Miles", False) 
      .Home = moUtil.EditCurrency(.Home, "Home", False, , 0, 999999.99) 
      .Meetings = moUtil.EditCurrency(.Meetings, "Meetings", False, , 0, 999999.99) 
      .Meals = moUtil.EditCurrency(.Meals, "Meals", False, , 0, 999999.99) 
      .Supplies = moUtil.EditCurrency(.Supplies, "Supplies", False, , 0, 999999.99) 
      .Gifts = moUtil.EditCurrency(.Gifts, "Gifts", False, , 0, 999999.99) 
      .Materials = moUtil.EditCurrency(.Materials, "Materials", False, , 0, 999999.99) 
      .Phones = moUtil.EditCurrency(.Phones, "Phones", False, , 0, 999999.99) 
      .Internet = moUtil.EditCurrency(.Internet, "Internet", False, , 0, 999999.99) 
      .Kids = moUtil.EditCurrency(.Kids, "Kids", False, , 0, 999999.99) 
      .Subscriptions = moUtil.EditCurrency(.Subscriptions, "Subscriptions", False, , 0, 999999.99) 
      .Entertainment = moUtil.EditCurrency(.Entertainment, "Entertainment", False, , 0, 999999.99) 
      .Activities = moUtil.EditCurrency(.Activities, "Activities", False, , 0, 999999.99) 
      .Events = moUtil.EditCurrency(.Events, "Events", False, , 0, 999999.99) 
      .Medical = moUtil.EditCurrency(.Medical, "Medical", False, , 0, 999999.99) 
      .Recreational = moUtil.EditCurrency(.Recreational, "Recreational", False, , 0, 999999.99) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Private Sub Class_Initialize()
   Set moSys = New wtSystem.CSystem
   Set moUtil = New wtSystem.CUtility
End Sub

Private Sub Class_Terminate()
   Set moSys = Nothing
   Set moUtil = Nothing
End Sub