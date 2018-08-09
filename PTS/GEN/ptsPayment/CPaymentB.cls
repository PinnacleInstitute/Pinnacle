VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CPaymentB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPayment"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tPaymentType
   PaymentID As String
   CompanyID As String
   OwnerType As String
   OwnerID As String
   BillingID As String
   ProductID As String
   PaidID As String
   PayDate As String
   PaidDate As String
   PayType As String
   Amount As String
   Total As String
   Credit As String
   Retail As String
   Commission As String
   Description As String
   Purpose As String
   Status As String
   Reference As String
   Notes As String
   CommStatus As String
   CommDate As String
   TokenType As String
   TokenOwner As String
   Token As String
   ReportFromDate As String
   ReportToDate As String
   Count As String
   FromDate As String
   ToDate As String
   MemberID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tPaymentType, _ 
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
      .Parameters.Append .CreateParameter("@PaymentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@PaidID", adInteger, adParamInput, vbNull, CLng(brRec.PaidID))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(brRec.PayDate))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Credit", adCurrency, adParamInput, vbNull, CCur(brRec.Credit))
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamInput, vbNull, CCur(brRec.Retail))
      .Parameters.Append .CreateParameter("@Commission", adCurrency, adParamInput, vbNull, CCur(brRec.Commission))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 200, brRec.Description)
      .Parameters.Append .CreateParameter("@Purpose", adVarWChar, adParamInput, 100, brRec.Purpose)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 40, brRec.Reference)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@TokenType", adInteger, adParamInput, vbNull, CLng(brRec.TokenType))
      .Parameters.Append .CreateParameter("@TokenOwner", adInteger, adParamInput, vbNull, CLng(brRec.TokenOwner))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(brRec.Token))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_Add"

   '-----get return values
   With brRec
      .PaymentID = moUtil.FetchLong(oCmd.Parameters.Item("@PaymentID").Value)
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

Public Function LastBillingID( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LastBillingID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_LastBillingID"

   '-----get return values
   LastBillingID = moUtil.FetchLong(oCmd.Parameters.Item("@BillingID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetPendingCCCK( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetPendingCCCK"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_SetPendingCCCK"

   '-----get return values
   SetPendingCCCK = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetCompanyPendingCCCK( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetCompanyPendingCCCK"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_SetCompanyPendingCCCK"

   '-----get return values
   SetCompanyPendingCCCK = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetCompany( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_GetCompany"

   '-----get return values
   GetCompany = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetOwnerEmail( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetOwnerEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 100, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_GetOwnerEmail"

   '-----get return values
   GetOwnerEmail = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CompanyPayments( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CompanyPayments"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(brRec.PayDate))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_CompanyPayments"

   '-----get return values
   CompanyPayments = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CompanyDebits( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CompanyDebits"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(brRec.PayDate))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_CompanyDebits"

   '-----get return values
   CompanyDebits = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Custom( _ 
   ByRef brRec As tPaymentType, _ 
   ByVal bvUserID As Long) As Long
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
      .Parameters.Append .CreateParameter("@PaymentID", adInteger, adParamInput, vbNull, CLng(brRec.PaymentID))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 40, brRec.Reference)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_Custom"

   '-----get return values
   Custom = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Count( _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the number of records.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Count"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("Return", adInteger, adParamReturnValue, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With
   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_Count"

   '-----get return values
   Count = moUtil.FetchLong(oCmd.Parameters.Item("Return").Value)

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
   ByRef brRec As tPaymentType, _ 
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
      .PaymentID = moUtil.EditLong(.PaymentID, "PaymentID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PaymentID", adInteger, adParamInput, vbNull, CLng(brRec.PaymentID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_Delete"

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
   ByRef brRec As tPaymentType, _ 
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
      .PaymentID = moUtil.EditLong(.PaymentID, "PaymentID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PaymentID", adInteger, adParamInput, vbNull, CLng(brRec.PaymentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PaidID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Credit", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Commission", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Purpose", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TokenType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TokenOwner", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .OwnerType = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerType").Value)
      .OwnerID = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerID").Value)
      .BillingID = moUtil.FetchLong(oCmd.Parameters.Item("@BillingID").Value)
      .ProductID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductID").Value)
      .PaidID = moUtil.FetchLong(oCmd.Parameters.Item("@PaidID").Value)
      .PayDate = moUtil.FetchDate(oCmd.Parameters.Item("@PayDate").Value)
      .PaidDate = moUtil.FetchDate(oCmd.Parameters.Item("@PaidDate").Value)
      .PayType = moUtil.FetchLong(oCmd.Parameters.Item("@PayType").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .Total = moUtil.FetchCurrency(oCmd.Parameters.Item("@Total").Value)
      .Credit = moUtil.FetchCurrency(oCmd.Parameters.Item("@Credit").Value)
      .Retail = moUtil.FetchCurrency(oCmd.Parameters.Item("@Retail").Value)
      .Commission = moUtil.FetchCurrency(oCmd.Parameters.Item("@Commission").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Purpose = moUtil.FetchString(oCmd.Parameters.Item("@Purpose").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
      .CommStatus = moUtil.FetchLong(oCmd.Parameters.Item("@CommStatus").Value)
      .CommDate = moUtil.FetchDate(oCmd.Parameters.Item("@CommDate").Value)
      .TokenType = moUtil.FetchLong(oCmd.Parameters.Item("@TokenType").Value)
      .TokenOwner = moUtil.FetchLong(oCmd.Parameters.Item("@TokenOwner").Value)
      .Token = moUtil.FetchLong(oCmd.Parameters.Item("@Token").Value)
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
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindPaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindPayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindPayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   ByVal bvCompanyID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindTypePaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindTypeReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindTypePayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindTypePayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindTypeAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindTypeDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(bvToken))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindStatusPaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindStatusReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindStatusPayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindStatusPayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindStatusAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindStatusDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindStatusTypePaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindStatusTypeReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindStatusTypePayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindStatusTypePayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindStatusTypeAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindStatusTypeDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(bvToken))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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

Public Function FindMember( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindMemberPaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindMemberReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindMemberPayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindMemberPayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindMemberAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindMemberDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   FindMember = vRecs

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

Public Function FindOwner( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
   bvOwnerType = moUtil.EditLong(bvOwnerType, "OwnerType", True) 
   bvOwnerID = moUtil.EditLong(bvOwnerID, "OwnerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindOwnerPaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindOwnerReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindOwnerPayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindOwnerPayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindOwnerAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindOwnerDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   FindOwner = vRecs

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

Public Function FindOwnerType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwnerType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
   bvOwnerType = moUtil.EditLong(bvOwnerType, "OwnerType", True) 
   bvOwnerID = moUtil.EditLong(bvOwnerID, "OwnerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindOwnerTypePaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindOwnerTypeReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindOwnerTypePayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindOwnerTypePayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindOwnerTypeAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindOwnerTypeDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(bvToken))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   FindOwnerType = vRecs

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

Public Function FindOwnerStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwnerStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
   bvOwnerType = moUtil.EditLong(bvOwnerType, "OwnerType", True) 
   bvOwnerID = moUtil.EditLong(bvOwnerID, "OwnerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindOwnerStatusPaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindOwnerStatusReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindOwnerStatusPayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindOwnerStatusPayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindOwnerStatusAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindOwnerStatusDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   FindOwnerStatus = vRecs

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

Public Function FindOwnerStatusType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvToken As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwnerStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
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
   bvOwnerType = moUtil.EditLong(bvOwnerType, "OwnerType", True) 
   bvOwnerID = moUtil.EditLong(bvOwnerID, "OwnerID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPaymentFindPaymentID
         sProc = "pts_Payment_FindOwnerStatusTypePaymentID"
         MaxBookMark = 20
      Case cptsPaymentFindReference
         sProc = "pts_Payment_FindOwnerStatusTypeReference"
         MaxBookMark = 50
      Case cptsPaymentFindPayDate
         sProc = "pts_Payment_FindOwnerStatusTypePayDate"
         MaxBookMark = 30
      Case cptsPaymentFindPayType
         sProc = "pts_Payment_FindOwnerStatusTypePayType"
         MaxBookMark = 20
      Case cptsPaymentFindAmount
         sProc = "pts_Payment_FindOwnerStatusTypeAmount"
         MaxBookMark = 30
      Case cptsPaymentFindDescription
         sProc = "pts_Payment_FindOwnerStatusTypeDescription"
         MaxBookMark = 210
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(bvToken))
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
               vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PaidID = moUtil.FetchLong(.Fields.Item("PaidID").Value)
               vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
               vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.CommStatus = moUtil.FetchLong(.Fields.Item("CommStatus").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
               vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
               vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
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
   FindOwnerStatusType = vRecs

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

Public Function ListOwner( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ListOwner")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOwner = vRecs

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

Public Function ListOwnerStatus( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOwnerStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ListOwnerStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOwnerStatus = vRecs

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

Public Function ListSubmittedCCCK( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvPayDate As Date) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSubmittedCCCK"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(bvPayDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ListSubmittedCCCK")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
            vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
            vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
            vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListSubmittedCCCK = vRecs

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

Public Function ReportStatusAmount( _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvOwnerType As Long) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusAmount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ReportStatusAmount")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportStatusAmount = vRecs

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

Public Function ReportStatusCount( _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ReportStatusCount")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Count = moUtil.FetchLong(.Fields.Item("Count").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportStatusCount = vRecs

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

Public Function ReportPayTypeAmount( _ 
   ByVal bvStatus As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportPayTypeAmount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ReportPayTypeAmount")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportPayTypeAmount = vRecs

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

Public Function ReportPayTypeCount( _ 
   ByVal bvStatus As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportPayTypeCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ReportPayTypeCount")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Count = moUtil.FetchLong(.Fields.Item("Count").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportPayTypeCount = vRecs

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

Public Function ListMemberPayments( _ 
   ByVal bvOwnerID As Long) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberPayments"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvOwnerID = moUtil.EditLong(bvOwnerID, "OwnerID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ListMemberPayments")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberPayments = vRecs

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

Public Function ListCustom( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvPayType As Long, _ 
   ByVal bvPayDate As Date, _ 
   ByVal bvNotes As String) As tPaymentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPaymentType
   Dim vRec As tPaymentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(bvPayType))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(bvPayDate))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, bvNotes)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_ListCustom")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PaymentID = moUtil.FetchLong(.Fields.Item("PaymentID").Value)
            vRec.PayDate = moUtil.FetchDate(.Fields.Item("PayDate").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
            vRec.Retail = moUtil.FetchCurrency(.Fields.Item("Retail").Value)
            vRec.Commission = moUtil.FetchCurrency(.Fields.Item("Commission").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.Purpose = moUtil.FetchString(.Fields.Item("Purpose").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCustom = vRecs

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
   ByRef brRec As tPaymentType, _ 
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
      .Parameters.Append .CreateParameter("@PaymentID", adInteger, adParamInput, vbNull, CLng(brRec.PaymentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@PaidID", adInteger, adParamInput, vbNull, CLng(brRec.PaidID))
      .Parameters.Append .CreateParameter("@PayDate", adDate, adParamInput, vbNull, CDate(brRec.PayDate))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Credit", adCurrency, adParamInput, vbNull, CCur(brRec.Credit))
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamInput, vbNull, CCur(brRec.Retail))
      .Parameters.Append .CreateParameter("@Commission", adCurrency, adParamInput, vbNull, CCur(brRec.Commission))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 200, brRec.Description)
      .Parameters.Append .CreateParameter("@Purpose", adVarWChar, adParamInput, 100, brRec.Purpose)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 40, brRec.Reference)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@TokenType", adInteger, adParamInput, vbNull, CLng(brRec.TokenType))
      .Parameters.Append .CreateParameter("@TokenOwner", adInteger, adParamInput, vbNull, CLng(brRec.TokenOwner))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(brRec.Token))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Payment_Update"

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
   ByRef brRec As tPaymentType, _ 
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
         .PaymentID = moUtil.EditLong(.PaymentID, "PaymentID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .OwnerType = moUtil.EditLong(.OwnerType, "OwnerType", True) 
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", True) 
      .BillingID = moUtil.EditLong(.BillingID, "BillingID", False) 
      .ProductID = moUtil.EditLong(.ProductID, "ProductID", False) 
      .PaidID = moUtil.EditLong(.PaidID, "PaidID", False) 
      .PayDate = moUtil.EditDate(.PayDate, "PayDate", True) 
      .PaidDate = moUtil.EditDate(.PaidDate, "PaidDate", False) 
      .PayType = moUtil.EditLong(.PayType, "PayType", False) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False, , 0, 99999999.99) 
      .Total = moUtil.EditCurrency(.Total, "Total", False, , 0, 99999999.99) 
      .Credit = moUtil.EditCurrency(.Credit, "Credit", False, , 0, 99999999.99) 
      .Retail = moUtil.EditCurrency(.Retail, "Retail", False, , 0, 99999999.99) 
      .Commission = moUtil.EditCurrency(.Commission, "Commission", False, , 0, 99999999.99) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 200) 
      .Purpose = moUtil.EditString(.Purpose, "Purpose", False, , 1, 100) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Reference = moUtil.EditString(.Reference, "Reference", False, , 1, 40) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 500) 
      .CommStatus = moUtil.EditLong(.CommStatus, "CommStatus", False) 
      .CommDate = moUtil.EditDate(.CommDate, "CommDate", False) 
      .TokenType = moUtil.EditLong(.TokenType, "TokenType", False) 
      .TokenOwner = moUtil.EditLong(.TokenOwner, "TokenOwner", False) 
      .Token = moUtil.EditLong(.Token, "Token", False) 
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