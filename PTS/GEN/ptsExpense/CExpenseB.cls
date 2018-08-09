VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CExpenseB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CExpense"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tExpenseType
   ExpenseID As String
   MemberID As String
   ExpenseTypeID As String
   ExpenseTypeName As String
   TaxType As String
   IsRequired As String
   ExpType As String
   ExpDate As String
   Total As String
   Amount As String
   MilesStart As String
   MilesEnd As String
   TotalMiles As String
   Note1 As String
   Note2 As String
   Purpose As String
   Method As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tExpenseType, _ 
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
      .Parameters.Append .CreateParameter("@ExpenseID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ExpenseTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ExpenseTypeID))
      .Parameters.Append .CreateParameter("@ExpType", adInteger, adParamInput, vbNull, CLng(brRec.ExpType))
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamInput, vbNull, CDate(brRec.ExpDate))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@MilesStart", adInteger, adParamInput, vbNull, CLng(brRec.MilesStart))
      .Parameters.Append .CreateParameter("@MilesEnd", adInteger, adParamInput, vbNull, CLng(brRec.MilesEnd))
      .Parameters.Append .CreateParameter("@TotalMiles", adInteger, adParamInput, vbNull, CLng(brRec.TotalMiles))
      .Parameters.Append .CreateParameter("@Note1", adVarWChar, adParamInput, 50, brRec.Note1)
      .Parameters.Append .CreateParameter("@Note2", adVarWChar, adParamInput, 100, brRec.Note2)
      .Parameters.Append .CreateParameter("@Purpose", adVarWChar, adParamInput, 200, brRec.Purpose)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_Add"

   '-----get return values
   With brRec
      .ExpenseID = moUtil.FetchLong(oCmd.Parameters.Item("@ExpenseID").Value)
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

Public Function GetVehicleMethod( _ 
   ByRef brRec As tExpenseType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetVehicleMethod"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamInput, vbNull, CDate(brRec.ExpDate))
      .Parameters.Append .CreateParameter("@Method", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_GetVehicleMethod"

   '-----get return values
   GetVehicleMethod = moUtil.FetchLong(oCmd.Parameters.Item("@Method").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub CalcTotal( _ 
   ByRef brRec As tExpenseType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcTotal"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ExpenseID", adInteger, adParamInput, vbNull, CLng(brRec.ExpenseID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_CalcTotal"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Delete( _ 
   ByRef brRec As tExpenseType, _ 
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
      .ExpenseID = moUtil.EditLong(.ExpenseID, "ExpenseID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ExpenseID", adInteger, adParamInput, vbNull, CLng(brRec.ExpenseID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_Delete"

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
   ByRef brRec As tExpenseType, _ 
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
      .ExpenseID = moUtil.EditLong(.ExpenseID, "ExpenseID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ExpenseID", adInteger, adParamInput, vbNull, CLng(brRec.ExpenseID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExpenseTypeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExpenseTypeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@TaxType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsRequired", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExpType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MilesStart", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MilesEnd", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TotalMiles", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Note1", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Note2", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Purpose", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .ExpenseTypeID = moUtil.FetchLong(oCmd.Parameters.Item("@ExpenseTypeID").Value)
      .ExpenseTypeName = moUtil.FetchString(oCmd.Parameters.Item("@ExpenseTypeName").Value)
      .TaxType = moUtil.FetchLong(oCmd.Parameters.Item("@TaxType").Value)
      .IsRequired = moUtil.FetchInteger(oCmd.Parameters.Item("@IsRequired").Value)
      .ExpType = moUtil.FetchLong(oCmd.Parameters.Item("@ExpType").Value)
      .ExpDate = moUtil.FetchDate(oCmd.Parameters.Item("@ExpDate").Value)
      .Total = moUtil.FetchCurrency(oCmd.Parameters.Item("@Total").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .MilesStart = moUtil.FetchLong(oCmd.Parameters.Item("@MilesStart").Value)
      .MilesEnd = moUtil.FetchLong(oCmd.Parameters.Item("@MilesEnd").Value)
      .TotalMiles = moUtil.FetchLong(oCmd.Parameters.Item("@TotalMiles").Value)
      .Note1 = moUtil.FetchString(oCmd.Parameters.Item("@Note1").Value)
      .Note2 = moUtil.FetchString(oCmd.Parameters.Item("@Note2").Value)
      .Purpose = moUtil.FetchString(oCmd.Parameters.Item("@Purpose").Value)
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

Public Function Find( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tExpenseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tExpenseType
   Dim vRec As tExpenseType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxBookMark As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
      .SearchType = bvFindType
   End With

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsExpenseFindExpDate
         sProc = "pts_Expense_FindExpDate"
         MaxBookMark = 30
      Case cptsExpenseFindAmount
         sProc = "pts_Expense_FindAmount"
         MaxBookMark = 30
      Case cptsExpenseFindPurpose
         sProc = "pts_Expense_FindPurpose"
         MaxBookMark = 210
      Case cptsExpenseFindNote1
         sProc = "pts_Expense_FindNote1"
         MaxBookMark = 60
      Case cptsExpenseFindNote2
         sProc = "pts_Expense_FindNote2"
         MaxBookMark = 110
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.ExpenseID = moUtil.FetchLong(.Fields.Item("ExpenseID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ExpenseTypeID = moUtil.FetchLong(.Fields.Item("ExpenseTypeID").Value)
               vRec.ExpenseTypeName = moUtil.FetchString(.Fields.Item("ExpenseTypeName").Value)
               vRec.TaxType = moUtil.FetchLong(.Fields.Item("TaxType").Value)
               vRec.IsRequired = moUtil.FetchInteger(.Fields.Item("IsRequired").Value)
               vRec.ExpType = moUtil.FetchLong(.Fields.Item("ExpType").Value)
               vRec.ExpDate = moUtil.FetchDate(.Fields.Item("ExpDate").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.MilesStart = moUtil.FetchLong(.Fields.Item("MilesStart").Value)
               vRec.MilesEnd = moUtil.FetchLong(.Fields.Item("MilesEnd").Value)
               vRec.TotalMiles = moUtil.FetchLong(.Fields.Item("TotalMiles").Value)
               vRec.Note1 = moUtil.FetchString(.Fields.Item("Note1").Value)
               vRec.Note2 = moUtil.FetchString(.Fields.Item("Note2").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With

   '-----return the results
   Find = vRecs

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

Public Function FindType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvExpType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tExpenseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tExpenseType
   Dim vRec As tExpenseType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxBookMark As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
      .SearchType = bvFindType
   End With

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvExpType = moUtil.EditLong(bvExpType, "ExpType", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsExpenseFindExpDate
         sProc = "pts_Expense_FindTypeExpDate"
         MaxBookMark = 30
      Case cptsExpenseFindAmount
         sProc = "pts_Expense_FindTypeAmount"
         MaxBookMark = 30
      Case cptsExpenseFindPurpose
         sProc = "pts_Expense_FindTypePurpose"
         MaxBookMark = 210
      Case cptsExpenseFindNote1
         sProc = "pts_Expense_FindTypeNote1"
         MaxBookMark = 60
      Case cptsExpenseFindNote2
         sProc = "pts_Expense_FindTypeNote2"
         MaxBookMark = 110
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ExpType", adInteger, adParamInput, vbNull, CLng(bvExpType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.ExpenseID = moUtil.FetchLong(.Fields.Item("ExpenseID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ExpenseTypeID = moUtil.FetchLong(.Fields.Item("ExpenseTypeID").Value)
               vRec.ExpenseTypeName = moUtil.FetchString(.Fields.Item("ExpenseTypeName").Value)
               vRec.TaxType = moUtil.FetchLong(.Fields.Item("TaxType").Value)
               vRec.IsRequired = moUtil.FetchInteger(.Fields.Item("IsRequired").Value)
               vRec.ExpType = moUtil.FetchLong(.Fields.Item("ExpType").Value)
               vRec.ExpDate = moUtil.FetchDate(.Fields.Item("ExpDate").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.MilesStart = moUtil.FetchLong(.Fields.Item("MilesStart").Value)
               vRec.MilesEnd = moUtil.FetchLong(.Fields.Item("MilesEnd").Value)
               vRec.TotalMiles = moUtil.FetchLong(.Fields.Item("TotalMiles").Value)
               vRec.Note1 = moUtil.FetchString(.Fields.Item("Note1").Value)
               vRec.Note2 = moUtil.FetchString(.Fields.Item("Note2").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With

   '-----return the results
   FindType = vRecs

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

Public Function ReportSummary( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tExpenseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tExpenseType
   Dim vRec As tExpenseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 
      bvFromDate = moUtil.EditDate(bvFromDate, "FromDate", True, 0) 
      bvToDate = moUtil.EditDate(bvToDate, "ToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_ReportSummary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ExpenseID = moUtil.FetchLong(.Fields.Item("ExpenseID").Value)
            vRec.ExpType = moUtil.FetchLong(.Fields.Item("ExpType").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportSummary = vRecs

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

Public Function ReportDetail( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvExpType As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tExpenseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tExpenseType
   Dim vRec As tExpenseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 
      bvExpType = moUtil.EditLong(bvExpType, "ExpType", True, 0) 
      bvFromDate = moUtil.EditDate(bvFromDate, "FromDate", True, 0) 
      bvToDate = moUtil.EditDate(bvToDate, "ToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ExpType", adInteger, adParamInput, vbNull, CLng(bvExpType))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_ReportDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ExpenseID = moUtil.FetchLong(.Fields.Item("ExpenseID").Value)
            vRec.ExpDate = moUtil.FetchDate(.Fields.Item("ExpDate").Value)
            vRec.ExpenseTypeName = moUtil.FetchString(.Fields.Item("ExpenseTypeName").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.MilesStart = moUtil.FetchLong(.Fields.Item("MilesStart").Value)
            vRec.MilesEnd = moUtil.FetchLong(.Fields.Item("MilesEnd").Value)
            vRec.TotalMiles = moUtil.FetchLong(.Fields.Item("TotalMiles").Value)
            vRec.Note1 = moUtil.FetchString(.Fields.Item("Note1").Value)
            vRec.Note2 = moUtil.FetchString(.Fields.Item("Note2").Value)
            vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportDetail = vRecs

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
   ByRef brRec As tExpenseType, _ 
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
      .Parameters.Append .CreateParameter("@ExpenseID", adInteger, adParamInput, vbNull, CLng(brRec.ExpenseID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ExpenseTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ExpenseTypeID))
      .Parameters.Append .CreateParameter("@ExpType", adInteger, adParamInput, vbNull, CLng(brRec.ExpType))
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamInput, vbNull, CDate(brRec.ExpDate))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@MilesStart", adInteger, adParamInput, vbNull, CLng(brRec.MilesStart))
      .Parameters.Append .CreateParameter("@MilesEnd", adInteger, adParamInput, vbNull, CLng(brRec.MilesEnd))
      .Parameters.Append .CreateParameter("@TotalMiles", adInteger, adParamInput, vbNull, CLng(brRec.TotalMiles))
      .Parameters.Append .CreateParameter("@Note1", adVarWChar, adParamInput, 50, brRec.Note1)
      .Parameters.Append .CreateParameter("@Note2", adVarWChar, adParamInput, 100, brRec.Note2)
      .Parameters.Append .CreateParameter("@Purpose", adVarWChar, adParamInput, 200, brRec.Purpose)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Expense_Update"

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
   ByRef brRec As tExpenseType, _ 
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
         .ExpenseID = moUtil.EditLong(.ExpenseID, "ExpenseID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .ExpenseTypeID = moUtil.EditLong(.ExpenseTypeID, "ExpenseTypeID", True) 
      .ExpType = moUtil.EditLong(.ExpType, "ExpType", True) 
      .ExpDate = moUtil.EditDate(.ExpDate, "ExpDate", False) 
      .Total = moUtil.EditCurrency(.Total, "Total", False) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False) 
      .MilesStart = moUtil.EditLong(.MilesStart, "MilesStart", False) 
      .MilesEnd = moUtil.EditLong(.MilesEnd, "MilesEnd", False) 
      .TotalMiles = moUtil.EditLong(.TotalMiles, "TotalMiles", False) 
      .Note1 = moUtil.EditString(.Note1, "Note1", False, , 1, 50) 
      .Note2 = moUtil.EditString(.Note2, "Note2", False, , 1, 100) 
      .Purpose = moUtil.EditString(.Purpose, "Purpose", False, , 1, 200) 
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