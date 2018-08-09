VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CDebtB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CDebt"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tDebtType
   DebtID As String
   MemberID As String
   DebtType As String
   DebtName As String
   Balance As String
   Payment As String
   MinPayment As String
   IntRate As String
   IntPaid As String
   MonthsPaid As String
   IsActive As String
   IsConsolidate As String
   RegInterest As String
   RegMonths As String
   AccInterest As String
   AccMonths As String
   Margin As String
End Type

Public Sub Add( _ 
   ByRef brRec As tDebtType, _ 
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
      .Parameters.Append .CreateParameter("@DebtID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@DebtType", adInteger, adParamInput, vbNull, CLng(brRec.DebtType))
      .Parameters.Append .CreateParameter("@DebtName", adVarWChar, adParamInput, 30, brRec.DebtName)
      .Parameters.Append .CreateParameter("@Balance", adCurrency, adParamInput, vbNull, CCur(brRec.Balance))
      .Parameters.Append .CreateParameter("@Payment", adCurrency, adParamInput, vbNull, CCur(brRec.Payment))
      .Parameters.Append .CreateParameter("@MinPayment", adCurrency, adParamInput, vbNull, CCur(brRec.MinPayment))
      .Parameters.Append .CreateParameter("@IntRate", adCurrency, adParamInput, vbNull, CCur(brRec.IntRate))
      .Parameters.Append .CreateParameter("@IntPaid", adCurrency, adParamInput, vbNull, CCur(brRec.IntPaid))
      .Parameters.Append .CreateParameter("@MonthsPaid", adInteger, adParamInput, vbNull, CLng(brRec.MonthsPaid))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@IsConsolidate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsConsolidate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Debt_Add"

   '-----get return values
   With brRec
      .DebtID = moUtil.FetchLong(oCmd.Parameters.Item("@DebtID").Value)
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

Public Sub Delete( _ 
   ByRef brRec As tDebtType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Delete the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Delete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   With brRec
      .DebtID = moUtil.EditLong(.DebtID, "DebtID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@DebtID", adInteger, adParamInput, vbNull, CLng(brRec.DebtID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Debt_Delete"

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
   ByRef brRec As tDebtType, _ 
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
      .DebtID = moUtil.EditLong(.DebtID, "DebtID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@DebtID", adInteger, adParamInput, vbNull, CLng(brRec.DebtID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DebtType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DebtName", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Balance", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Payment", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MinPayment", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IntRate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IntPaid", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MonthsPaid", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsConsolidate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Debt_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .DebtType = moUtil.FetchLong(oCmd.Parameters.Item("@DebtType").Value)
      .DebtName = moUtil.FetchString(oCmd.Parameters.Item("@DebtName").Value)
      .Balance = moUtil.FetchCurrency(oCmd.Parameters.Item("@Balance").Value)
      .Payment = moUtil.FetchCurrency(oCmd.Parameters.Item("@Payment").Value)
      .MinPayment = moUtil.FetchCurrency(oCmd.Parameters.Item("@MinPayment").Value)
      .IntRate = moUtil.FetchCurrency(oCmd.Parameters.Item("@IntRate").Value)
      .IntPaid = moUtil.FetchCurrency(oCmd.Parameters.Item("@IntPaid").Value)
      .MonthsPaid = moUtil.FetchLong(oCmd.Parameters.Item("@MonthsPaid").Value)
      .IsActive = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActive").Value)
      .IsConsolidate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsConsolidate").Value)
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

Public Sub FetchConsolidate( _ 
   ByRef brRec As tDebtType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchConsolidate"
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
      .Parameters.Append .CreateParameter("@DebtID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Debt_FetchConsolidate"

   '-----get return values
   With brRec
      .DebtID = moUtil.FetchLong(oCmd.Parameters.Item("@DebtID").Value)
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

Public Function ListMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvDebtType As Long) As tDebtType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tDebtType
   Dim vRec As tDebtType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@DebtType", adInteger, adParamInput, vbNull, CLng(bvDebtType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Debt_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.DebtID = moUtil.FetchLong(.Fields.Item("DebtID").Value)
            vRec.DebtType = moUtil.FetchLong(.Fields.Item("DebtType").Value)
            vRec.DebtName = moUtil.FetchString(.Fields.Item("DebtName").Value)
            vRec.Balance = moUtil.FetchCurrency(.Fields.Item("Balance").Value)
            vRec.Payment = moUtil.FetchCurrency(.Fields.Item("Payment").Value)
            vRec.MinPayment = moUtil.FetchCurrency(.Fields.Item("MinPayment").Value)
            vRec.IntRate = moUtil.FetchCurrency(.Fields.Item("IntRate").Value)
            vRec.IntPaid = moUtil.FetchCurrency(.Fields.Item("IntPaid").Value)
            vRec.MonthsPaid = moUtil.FetchLong(.Fields.Item("MonthsPaid").Value)
            vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
            vRec.IsConsolidate = moUtil.FetchInteger(.Fields.Item("IsConsolidate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMember = vRecs

   '-----clean up
   Set oRecs = Nothing
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oRecs = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Update( _ 
   ByRef brRec As tDebtType, _ 
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
      .Parameters.Append .CreateParameter("@DebtID", adInteger, adParamInput, vbNull, CLng(brRec.DebtID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@DebtType", adInteger, adParamInput, vbNull, CLng(brRec.DebtType))
      .Parameters.Append .CreateParameter("@DebtName", adVarWChar, adParamInput, 30, brRec.DebtName)
      .Parameters.Append .CreateParameter("@Balance", adCurrency, adParamInput, vbNull, CCur(brRec.Balance))
      .Parameters.Append .CreateParameter("@Payment", adCurrency, adParamInput, vbNull, CCur(brRec.Payment))
      .Parameters.Append .CreateParameter("@MinPayment", adCurrency, adParamInput, vbNull, CCur(brRec.MinPayment))
      .Parameters.Append .CreateParameter("@IntRate", adCurrency, adParamInput, vbNull, CCur(brRec.IntRate))
      .Parameters.Append .CreateParameter("@IntPaid", adCurrency, adParamInput, vbNull, CCur(brRec.IntPaid))
      .Parameters.Append .CreateParameter("@MonthsPaid", adInteger, adParamInput, vbNull, CLng(brRec.MonthsPaid))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@IsConsolidate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsConsolidate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Debt_Update"

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
   ByRef brRec As tDebtType, _ 
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
         .DebtID = moUtil.EditLong(.DebtID, "DebtID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .DebtType = moUtil.EditLong(.DebtType, "DebtType", False) 
      .DebtName = moUtil.EditString(.DebtName, "DebtName", False) 
      .Balance = moUtil.EditCurrency(.Balance, "Balance", False, , 0, 999999.99) 
      .Payment = moUtil.EditCurrency(.Payment, "Payment", False, , 0, 999999.99) 
      .MinPayment = moUtil.EditCurrency(.MinPayment, "MinPayment", False, , 0, 999999.99) 
      .IntRate = moUtil.EditCurrency(.IntRate, "IntRate", False, , 0, 99.99) 
      .IntPaid = moUtil.EditCurrency(.IntPaid, "IntPaid", False) 
      .MonthsPaid = moUtil.EditLong(.MonthsPaid, "MonthsPaid", False) 
      .IsActive = moUtil.EditInteger(.IsActive, "IsActive", False, 0, 0, 1) 
      .IsConsolidate = moUtil.EditInteger(.IsConsolidate, "IsConsolidate", False, 0, 0, 1) 
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