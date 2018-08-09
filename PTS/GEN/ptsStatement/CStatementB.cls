VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CStatementB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CStatement"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tStatementType
   StatementID As String
   CompanyID As String
   MerchantID As String
   MerchantName As String
   StatementDate As String
   PaidDate As String
   Amount As String
   Status As String
   PayType As String
   Reference As String
   Notes As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tStatementType, _ 
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
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@StatementDate", adDate, adParamInput, vbNull, CDate(brRec.StatementDate))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 30, brRec.Reference)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Statement_Add"

   '-----get return values
   With brRec
      .StatementID = moUtil.FetchLong(oCmd.Parameters.Item("@StatementID").Value)
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

Public Function SetPending( _ 
   ByRef brRec As tStatementType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Statement_SetPending"

   '-----get return values
   SetPending = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ProcessStatement( _ 
   ByRef brRec As tStatementType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProcessStatement"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .StatementID = moUtil.EditLong(.StatementID, "StatementID", True, 0, 1) 
      .Status = moUtil.EditLong(.Status, "Status", False, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamInput, vbNull, CLng(brRec.StatementID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 100, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Statement_ProcessStatement"

   '-----get return values
   ProcessStatement = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Delete( _ 
   ByRef brRec As tStatementType, _ 
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
      .StatementID = moUtil.EditLong(.StatementID, "StatementID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamInput, vbNull, CLng(brRec.StatementID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Statement_Delete"

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
   ByRef brRec As tStatementType, _ 
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
      .StatementID = moUtil.EditLong(.StatementID, "StatementID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamInput, vbNull, CLng(brRec.StatementID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@StatementDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Statement_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
      .MerchantName = moUtil.FetchString(oCmd.Parameters.Item("@MerchantName").Value)
      .StatementDate = moUtil.FetchDate(oCmd.Parameters.Item("@StatementDate").Value)
      .PaidDate = moUtil.FetchDate(oCmd.Parameters.Item("@PaidDate").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .PayType = moUtil.FetchLong(oCmd.Parameters.Item("@PayType").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tStatementType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tStatementType
   Dim vRec As tStatementType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsStatementFindStatementDate
         sProc = "pts_Statement_FindStatementDate"
         MaxBookMark = 30
      Case cptsStatementFindStatementID
         sProc = "pts_Statement_FindStatementID"
         MaxBookMark = 20
      Case cptsStatementFindPaidDate
         sProc = "pts_Statement_FindPaidDate"
         MaxBookMark = 30
      Case cptsStatementFindAmount
         sProc = "pts_Statement_FindAmount"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
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
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.StatementDate = moUtil.FetchDate(.Fields.Item("StatementDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
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

Public Function FindStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tStatementType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tStatementType
   Dim vRec As tStatementType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsStatementFindStatementDate
         sProc = "pts_Statement_FindStatusStatementDate"
         MaxBookMark = 30
      Case cptsStatementFindStatementID
         sProc = "pts_Statement_FindStatusStatementID"
         MaxBookMark = 20
      Case cptsStatementFindPaidDate
         sProc = "pts_Statement_FindStatusPaidDate"
         MaxBookMark = 30
      Case cptsStatementFindAmount
         sProc = "pts_Statement_FindStatusAmount"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
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
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.StatementDate = moUtil.FetchDate(.Fields.Item("StatementDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
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
   FindStatus = vRecs

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

Public Function FindMerchant( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tStatementType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMerchant"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tStatementType
   Dim vRec As tStatementType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsStatementFindStatementDate
         sProc = "pts_Statement_FindMerchantStatementDate"
         MaxBookMark = 30
      Case cptsStatementFindStatementID
         sProc = "pts_Statement_FindMerchantStatementID"
         MaxBookMark = 20
      Case cptsStatementFindPaidDate
         sProc = "pts_Statement_FindMerchantPaidDate"
         MaxBookMark = 30
      Case cptsStatementFindAmount
         sProc = "pts_Statement_FindMerchantAmount"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
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
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.StatementDate = moUtil.FetchDate(.Fields.Item("StatementDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
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
   FindMerchant = vRecs

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

Public Function FindMerchantStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tStatementType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMerchantStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tStatementType
   Dim vRec As tStatementType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsStatementFindStatementDate
         sProc = "pts_Statement_FindMerchantStatusStatementDate"
         MaxBookMark = 30
      Case cptsStatementFindStatementID
         sProc = "pts_Statement_FindMerchantStatusStatementID"
         MaxBookMark = 20
      Case cptsStatementFindPaidDate
         sProc = "pts_Statement_FindMerchantStatusPaidDate"
         MaxBookMark = 30
      Case cptsStatementFindAmount
         sProc = "pts_Statement_FindMerchantStatusAmount"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
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
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.StatementDate = moUtil.FetchDate(.Fields.Item("StatementDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
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
   FindMerchantStatus = vRecs

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

Public Function ListStatement( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long) As tStatementType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListStatement"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tStatementType
   Dim vRec As tStatementType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Statement_ListStatement")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
            vRec.StatementDate = moUtil.FetchDate(.Fields.Item("StatementDate").Value)
            vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListStatement = vRecs

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
   ByRef brRec As tStatementType, _ 
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
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamInput, vbNull, CLng(brRec.StatementID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@StatementDate", adDate, adParamInput, vbNull, CDate(brRec.StatementDate))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 30, brRec.Reference)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Statement_Update"

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
   ByRef brRec As tStatementType, _ 
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
         .StatementID = moUtil.EditLong(.StatementID, "StatementID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False, , 1) 
      .StatementDate = moUtil.EditDate(.StatementDate, "StatementDate", False) 
      .PaidDate = moUtil.EditDate(.PaidDate, "PaidDate", False) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .PayType = moUtil.EditLong(.PayType, "PayType", False) 
      .Reference = moUtil.EditString(.Reference, "Reference", False, , 1, 30) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 500) 
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