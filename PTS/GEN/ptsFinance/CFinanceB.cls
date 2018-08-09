VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CFinanceB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CFinance"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tFinanceType
   FinanceID As String
   MemberID As String
   Payoff As String
   Payment As String
   Savings As String
   StartDate As String
   ROI As String
   SavingsRate As String
   IsMinPayment As String
End Type

Public Sub Add( _ 
   ByRef brRec As tFinanceType, _ 
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
      .Parameters.Append .CreateParameter("@FinanceID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Payoff", adInteger, adParamInput, vbNull, CLng(brRec.Payoff))
      .Parameters.Append .CreateParameter("@Payment", adCurrency, adParamInput, vbNull, CCur(brRec.Payment))
      .Parameters.Append .CreateParameter("@Savings", adInteger, adParamInput, vbNull, CLng(brRec.Savings))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@ROI", adCurrency, adParamInput, vbNull, CCur(brRec.ROI))
      .Parameters.Append .CreateParameter("@SavingsRate", adCurrency, adParamInput, vbNull, CCur(brRec.SavingsRate))
      .Parameters.Append .CreateParameter("@IsMinPayment", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMinPayment))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Finance_Add"

   '-----get return values
   With brRec
      .FinanceID = moUtil.FetchLong(oCmd.Parameters.Item("@FinanceID").Value)
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
   ByRef brRec As tFinanceType, _ 
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
      .FinanceID = moUtil.EditLong(.FinanceID, "FinanceID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FinanceID", adInteger, adParamInput, vbNull, CLng(brRec.FinanceID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Payoff", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Payment", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Savings", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ROI", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SavingsRate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsMinPayment", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Finance_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .Payoff = moUtil.FetchLong(oCmd.Parameters.Item("@Payoff").Value)
      .Payment = moUtil.FetchCurrency(oCmd.Parameters.Item("@Payment").Value)
      .Savings = moUtil.FetchLong(oCmd.Parameters.Item("@Savings").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .ROI = moUtil.FetchCurrency(oCmd.Parameters.Item("@ROI").Value)
      .SavingsRate = moUtil.FetchCurrency(oCmd.Parameters.Item("@SavingsRate").Value)
      .IsMinPayment = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMinPayment").Value)
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

Public Sub FetchMemberID( _ 
   ByRef brRec As tFinanceType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchMemberID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@FinanceID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Finance_FetchMemberID"

   '-----get return values
   With brRec
      .FinanceID = moUtil.FetchLong(oCmd.Parameters.Item("@FinanceID").Value)
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
   ByRef brRec As tFinanceType, _ 
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
      .Parameters.Append .CreateParameter("@FinanceID", adInteger, adParamInput, vbNull, CLng(brRec.FinanceID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Payoff", adInteger, adParamInput, vbNull, CLng(brRec.Payoff))
      .Parameters.Append .CreateParameter("@Payment", adCurrency, adParamInput, vbNull, CCur(brRec.Payment))
      .Parameters.Append .CreateParameter("@Savings", adInteger, adParamInput, vbNull, CLng(brRec.Savings))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@ROI", adCurrency, adParamInput, vbNull, CCur(brRec.ROI))
      .Parameters.Append .CreateParameter("@SavingsRate", adCurrency, adParamInput, vbNull, CCur(brRec.SavingsRate))
      .Parameters.Append .CreateParameter("@IsMinPayment", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMinPayment))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Finance_Update"

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
   ByRef brRec As tFinanceType, _ 
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
         .FinanceID = moUtil.EditLong(.FinanceID, "FinanceID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .Payoff = moUtil.EditLong(.Payoff, "Payoff", False) 
      .Payment = moUtil.EditCurrency(.Payment, "Payment", False, , 0, 999999.99) 
      .Savings = moUtil.EditLong(.Savings, "Savings", False) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .ROI = moUtil.EditCurrency(.ROI, "ROI", False, , 0, 99.99) 
      .SavingsRate = moUtil.EditCurrency(.SavingsRate, "SavingsRate", False, , 0, 99.99) 
      .IsMinPayment = moUtil.EditInteger(.IsMinPayment, "IsMinPayment", False, 0, 0, 1) 
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