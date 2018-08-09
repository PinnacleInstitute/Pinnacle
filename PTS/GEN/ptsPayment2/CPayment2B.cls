VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CPayment2B"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPayment2"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tPayment2Type
   Payment2ID As String
   MerchantID As String
   ConsumerID As String
   StaffID As String
   AwardID As String
   SalesOrderID As String
   StatementID As String
   MerchantName As String
   NameFirst As String
   NameLast As String
   ConsumerName As String
   StaffName As String
   AwardName As String
   PayDate As String
   PayType As String
   Status As String
   Total As String
   Amount As String
   Merchant As String
   Cashback As String
   Fee As String
   PayCoins As String
   PayRate As String
   PaidCoins As String
   Reference As String
   Description As String
   Notes As String
   Ticket As String
   CommStatus As String
   CommDate As String
   CoinStatus As String
   PayType2 As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tPayment2Type, _ 
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
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@StaffID", adInteger, adParamInput, vbNull, CLng(brRec.StaffID))
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamInput, vbNull, CLng(brRec.AwardID))
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamInput, vbNull, CLng(brRec.StatementID))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(brRec.PayDate))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Merchant", adCurrency, adParamInput, vbNull, CCur(brRec.Merchant))
      .Parameters.Append .CreateParameter("@Cashback", adCurrency, adParamInput, vbNull, CCur(brRec.Cashback))
      .Parameters.Append .CreateParameter("@Fee", adCurrency, adParamInput, vbNull, CCur(brRec.Fee))
      .Parameters.Append .CreateParameter("@PayCoins", adBigInt, adParamInput, vbNull, CStr(brRec.PayCoins))
      .Parameters.Append .CreateParameter("@PayRate", adCurrency, adParamInput, vbNull, CCur(brRec.PayRate))
      .Parameters.Append .CreateParameter("@PaidCoins", adBigInt, adParamInput, vbNull, CStr(brRec.PaidCoins))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 40, brRec.Reference)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@Ticket", adInteger, adParamInput, vbNull, CLng(brRec.Ticket))
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@CoinStatus", adInteger, adParamInput, vbNull, CLng(brRec.CoinStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment2_Add"

   '-----get return values
   With brRec
      .Payment2ID = moUtil.FetchLong(oCmd.Parameters.Item("@Payment2ID").Value)
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

Public Function Custom( _ 
   ByRef brRec As tPayment2Type, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Custom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(brRec.PayDate))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment2_Custom"

   '-----get return values
   Custom = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tPayment2Type, _ 
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
      .Payment2ID = moUtil.EditLong(.Payment2ID, "Payment2ID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamInput, vbNull, CLng(brRec.Payment2ID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment2_Delete"

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
   ByRef brRec As tPayment2Type, _ 
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
      .Payment2ID = moUtil.EditLong(.Payment2ID, "Payment2ID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamInput, vbNull, CLng(brRec.Payment2ID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StaffID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@StaffName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@AwardName", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Merchant", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Cashback", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Fee", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayCoins", adBigInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayRate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PaidCoins", adBigInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Ticket", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CoinStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment2_Fetch"

   '-----get return values
   With brRec
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
      .StaffID = moUtil.FetchLong(oCmd.Parameters.Item("@StaffID").Value)
      .AwardID = moUtil.FetchLong(oCmd.Parameters.Item("@AwardID").Value)
      .SalesOrderID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesOrderID").Value)
      .StatementID = moUtil.FetchLong(oCmd.Parameters.Item("@StatementID").Value)
      .MerchantName = moUtil.FetchString(oCmd.Parameters.Item("@MerchantName").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .ConsumerName = moUtil.FetchString(oCmd.Parameters.Item("@ConsumerName").Value)
      .StaffName = moUtil.FetchString(oCmd.Parameters.Item("@StaffName").Value)
      .AwardName = moUtil.FetchString(oCmd.Parameters.Item("@AwardName").Value)
      .PayDate = moUtil.FetchDate(oCmd.Parameters.Item("@PayDate").Value)
      .PayType = moUtil.FetchLong(oCmd.Parameters.Item("@PayType").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Total = moUtil.FetchCurrency(oCmd.Parameters.Item("@Total").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .Merchant = moUtil.FetchCurrency(oCmd.Parameters.Item("@Merchant").Value)
      .Cashback = moUtil.FetchCurrency(oCmd.Parameters.Item("@Cashback").Value)
      .Fee = moUtil.FetchCurrency(oCmd.Parameters.Item("@Fee").Value)
      .PayCoins = moUtil.FetchString(oCmd.Parameters.Item("@PayCoins").Value)
      .PayRate = moUtil.FetchCurrency(oCmd.Parameters.Item("@PayRate").Value)
      .PaidCoins = moUtil.FetchString(oCmd.Parameters.Item("@PaidCoins").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
      .Ticket = moUtil.FetchLong(oCmd.Parameters.Item("@Ticket").Value)
      .CommStatus = moUtil.FetchLong(oCmd.Parameters.Item("@CommStatus").Value)
      .CommDate = moUtil.FetchDate(oCmd.Parameters.Item("@CommDate").Value)
      .CoinStatus = moUtil.FetchLong(oCmd.Parameters.Item("@CoinStatus").Value)
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
   ByVal bvMerchantID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindPayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindPayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindPayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindReference"
         MaxBookMark = 50
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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
   ByVal bvMerchantID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindTypePayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindTypePayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindTypePayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindTypeTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindTypeReference"
         MaxBookMark = 50
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@PayType2", adInteger, adParamInput, vbNull, CLng(bvPayType2))
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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

Public Function FindStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindStatusPayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindStatusPayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindStatusPayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindStatusTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindStatusReference"
         MaxBookMark = 50
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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

Public Function FindStatusType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindStatusTypePayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindStatusTypePayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindStatusTypePayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindStatusTypeTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindStatusTypeReference"
         MaxBookMark = 50
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@PayType2", adInteger, adParamInput, vbNull, CLng(bvPayType2))
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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
   FindStatusType = vRecs

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

Public Function FindConsumer( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
   bvConsumerID = moUtil.EditLong(bvConsumerID, "ConsumerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindConsumerPayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindConsumerPayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindConsumerPayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindConsumerTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindConsumerReference"
         MaxBookMark = 50
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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
   FindConsumer = vRecs

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

Public Function FindConsumerType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumerType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
   bvConsumerID = moUtil.EditLong(bvConsumerID, "ConsumerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindConsumerTypePayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindConsumerTypePayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindConsumerTypePayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindConsumerTypeTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindConsumerTypeReference"
         MaxBookMark = 50
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@PayType2", adInteger, adParamInput, vbNull, CLng(bvPayType2))
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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
   FindConsumerType = vRecs

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

Public Function FindConsumerStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumerStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
   bvConsumerID = moUtil.EditLong(bvConsumerID, "ConsumerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindConsumerStatusPayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindConsumerStatusPayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindConsumerStatusPayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindConsumerStatusTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindConsumerStatusReference"
         MaxBookMark = 50
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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
   FindConsumerStatus = vRecs

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

Public Function FindConsumerStatusType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayType2 As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumerStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
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
   bvConsumerID = moUtil.EditLong(bvConsumerID, "ConsumerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPayment2FindPayment2ID
         sProc = "pts_Payment2_FindConsumerStatusTypePayment2ID"
         MaxBookMark = 20
      Case cptsPayment2FindPayDate
         sProc = "pts_Payment2_FindConsumerStatusTypePayDate"
         MaxBookMark = 30
      Case cptsPayment2FindPayType
         sProc = "pts_Payment2_FindConsumerStatusTypePayType"
         MaxBookMark = 20
      Case cptsPayment2FindTotal
         sProc = "pts_Payment2_FindConsumerStatusTypeTotal"
         MaxBookMark = 30
      Case cptsPayment2FindReference
         sProc = "pts_Payment2_FindConsumerStatusTypeReference"
         MaxBookMark = 50
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@PayType2", adInteger, adParamInput, vbNull, CLng(bvPayType2))
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
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.StaffID = moUtil.FetchLong(.Fields.Item("StaffID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.StatementID = moUtil.FetchLong(.Fields.Item("StatementID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
               vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
               vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
               vRec.PayCoins = moUtil.FetchString(.Fields.Item("PayCoins").Value)
               vRec.PayRate = moUtil.FetchCurrency(.Fields.Item("PayRate").Value)
               vRec.PaidCoins = moUtil.FetchString(.Fields.Item("PaidCoins").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CoinStatus = moUtil.FetchLong(.Fields.Item("CoinStatus").Value)
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
   FindConsumerStatusType = vRecs

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

Public Function ListApprove( _ 
   ByVal bvMerchantID As Long) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListApprove"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment2_ListApprove")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
            vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
            vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
            vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
            vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
            vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
            vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
            vRec.Ticket = moUtil.FetchLong(.Fields.Item("Ticket").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListApprove = vRecs

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

Public Function CustomList( _ 
   ByVal bvStatus As Long, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvAmount As Currency, _ 
   ByVal bvPayDate As Date, _ 
   ByVal bvDescription As String) As tPayment2Type()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPayment2Type
   Dim vRec As tPayment2Type
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(bvAmount))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(bvPayDate))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, bvDescription)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment2_CustomList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
            vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
            vRec.StaffName = moUtil.FetchString(.Fields.Item("StaffName").Value)
            vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
            vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Merchant = moUtil.FetchCurrency(.Fields.Item("Merchant").Value)
            vRec.Cashback = moUtil.FetchCurrency(.Fields.Item("Cashback").Value)
            vRec.Fee = moUtil.FetchCurrency(.Fields.Item("Fee").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CustomList = vRecs

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
   ByRef brRec As tPayment2Type, _ 
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
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamInput, vbNull, CLng(brRec.Payment2ID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@StaffID", adInteger, adParamInput, vbNull, CLng(brRec.StaffID))
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamInput, vbNull, CLng(brRec.AwardID))
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@StatementID", adInteger, adParamInput, vbNull, CLng(brRec.StatementID))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(brRec.PayDate))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Merchant", adCurrency, adParamInput, vbNull, CCur(brRec.Merchant))
      .Parameters.Append .CreateParameter("@Cashback", adCurrency, adParamInput, vbNull, CCur(brRec.Cashback))
      .Parameters.Append .CreateParameter("@Fee", adCurrency, adParamInput, vbNull, CCur(brRec.Fee))
      .Parameters.Append .CreateParameter("@PayCoins", adBigInt, adParamInput, vbNull, CStr(brRec.PayCoins))
      .Parameters.Append .CreateParameter("@PayRate", adCurrency, adParamInput, vbNull, CCur(brRec.PayRate))
      .Parameters.Append .CreateParameter("@PaidCoins", adBigInt, adParamInput, vbNull, CStr(brRec.PaidCoins))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 40, brRec.Reference)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@Ticket", adInteger, adParamInput, vbNull, CLng(brRec.Ticket))
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@CoinStatus", adInteger, adParamInput, vbNull, CLng(brRec.CoinStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment2_Update"

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
   ByRef brRec As tPayment2Type, _ 
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
         .Payment2ID = moUtil.EditLong(.Payment2ID, "Payment2ID", True, , 1) 
      End If
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False) 
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", True) 
      .StaffID = moUtil.EditLong(.StaffID, "StaffID", False) 
      .AwardID = moUtil.EditLong(.AwardID, "AwardID", False) 
      .SalesOrderID = moUtil.EditLong(.SalesOrderID, "SalesOrderID", False) 
      .StatementID = moUtil.EditLong(.StatementID, "StatementID", False) 
      .PayDate = moUtil.EditDate(.PayDate, "PayDate", True) 
      .PayType = moUtil.EditLong(.PayType, "PayType", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Total = moUtil.EditCurrency(.Total, "Total", False, , 0, 99999999.99) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False, , 0, 99999999.99) 
      .Merchant = moUtil.EditCurrency(.Merchant, "Merchant", False, , 0, 99999999.99) 
      .Cashback = moUtil.EditCurrency(.Cashback, "Cashback", False, , 0, 99999999.99) 
      .Fee = moUtil.EditCurrency(.Fee, "Fee", False, , 0, 99999999.99) 
      .PayCoins = moUtil.EditString(.PayCoins, "PayCoins", False, 0) 
      .PayRate = moUtil.EditCurrency(.PayRate, "PayRate", False) 
      .PaidCoins = moUtil.EditString(.PaidCoins, "PaidCoins", False, 0) 
      .Reference = moUtil.EditString(.Reference, "Reference", False, , 1, 40) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 100) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 500) 
      .Ticket = moUtil.EditLong(.Ticket, "Ticket", False) 
      .CommStatus = moUtil.EditLong(.CommStatus, "CommStatus", False) 
      .CommDate = moUtil.EditDate(.CommDate, "CommDate", False) 
      .CoinStatus = moUtil.EditLong(.CoinStatus, "CoinStatus", False) 
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