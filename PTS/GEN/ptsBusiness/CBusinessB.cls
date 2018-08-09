VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CBusinessB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CBusiness"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tBusinessType
   BusinessID As String
   Install As String
   BusinessName As String
   SystemEmail As String
   CustomerEmail As String
   TrainerEmail As String
   FinanceEmail As String
   Street As String
   Unit As String
   City As String
   State As String
   Zip As String
   Country As String
   Phone As String
   Fax As String
   WebSite As String
   TaxRate As String
   CardProcessor As String
   CheckProcessor As String
   CardAcct As String
   CheckAcct As String
   PayPalAcct As String
   IsNotifyUser As String
   PaymentOptions As String
   MiscPay1 As String
   MiscPay2 As String
   MiscPay3 As String
   Languages As String
   Options1 As String
   Options2 As String
   Options3 As String
   Options4 As String
   Tutorial As String
   Timezone As String
   Rpt As String
   R1 As String
   R2 As String
   R3 As String
   R4 As String
   R5 As String
   R6 As String
   R7 As String
   R8 As String
   R9 As String
   R10 As String
End Type

Public Sub Fetch( _ 
   ByRef brRec As tBusinessType, _ 
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
      .BusinessID = moUtil.EditLong(.BusinessID, "BusinessID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BusinessID", adInteger, adParamInput, vbNull, CLng(brRec.BusinessID))
      .Parameters.Append .CreateParameter("@Install", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusinessName", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@SystemEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@CustomerEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@TrainerEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@FinanceEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@WebSite", adVarWChar, adParamOutput, 255, vbNull)
      .Parameters.Append .CreateParameter("@TaxRate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CardProcessor", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CheckProcessor", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CardAcct", adVarWChar, adParamOutput, 255, vbNull)
      .Parameters.Append .CreateParameter("@CheckAcct", adVarWChar, adParamOutput, 255, vbNull)
      .Parameters.Append .CreateParameter("@PayPalAcct", adVarWChar, adParamOutput, 255, vbNull)
      .Parameters.Append .CreateParameter("@IsNotifyUser", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PaymentOptions", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@MiscPay1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MiscPay2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MiscPay3", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Languages", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Options1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Options4", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Tutorial", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Business_Fetch"

   '-----get return values
   With brRec
      .Install = moUtil.FetchLong(oCmd.Parameters.Item("@Install").Value)
      .BusinessName = moUtil.FetchString(oCmd.Parameters.Item("@BusinessName").Value)
      .SystemEmail = moUtil.FetchString(oCmd.Parameters.Item("@SystemEmail").Value)
      .CustomerEmail = moUtil.FetchString(oCmd.Parameters.Item("@CustomerEmail").Value)
      .TrainerEmail = moUtil.FetchString(oCmd.Parameters.Item("@TrainerEmail").Value)
      .FinanceEmail = moUtil.FetchString(oCmd.Parameters.Item("@FinanceEmail").Value)
      .Street = moUtil.FetchString(oCmd.Parameters.Item("@Street").Value)
      .Unit = moUtil.FetchString(oCmd.Parameters.Item("@Unit").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Country = moUtil.FetchString(oCmd.Parameters.Item("@Country").Value)
      .Phone = moUtil.FetchString(oCmd.Parameters.Item("@Phone").Value)
      .Fax = moUtil.FetchString(oCmd.Parameters.Item("@Fax").Value)
      .WebSite = moUtil.FetchString(oCmd.Parameters.Item("@WebSite").Value)
      .TaxRate = moUtil.FetchCurrency(oCmd.Parameters.Item("@TaxRate").Value)
      .CardProcessor = moUtil.FetchLong(oCmd.Parameters.Item("@CardProcessor").Value)
      .CheckProcessor = moUtil.FetchLong(oCmd.Parameters.Item("@CheckProcessor").Value)
      .CardAcct = moUtil.FetchString(oCmd.Parameters.Item("@CardAcct").Value)
      .CheckAcct = moUtil.FetchString(oCmd.Parameters.Item("@CheckAcct").Value)
      .PayPalAcct = moUtil.FetchString(oCmd.Parameters.Item("@PayPalAcct").Value)
      .IsNotifyUser = moUtil.FetchInteger(oCmd.Parameters.Item("@IsNotifyUser").Value)
      .PaymentOptions = moUtil.FetchString(oCmd.Parameters.Item("@PaymentOptions").Value)
      .MiscPay1 = moUtil.FetchString(oCmd.Parameters.Item("@MiscPay1").Value)
      .MiscPay2 = moUtil.FetchString(oCmd.Parameters.Item("@MiscPay2").Value)
      .MiscPay3 = moUtil.FetchString(oCmd.Parameters.Item("@MiscPay3").Value)
      .Languages = moUtil.FetchString(oCmd.Parameters.Item("@Languages").Value)
      .Options1 = moUtil.FetchString(oCmd.Parameters.Item("@Options1").Value)
      .Options2 = moUtil.FetchString(oCmd.Parameters.Item("@Options2").Value)
      .Options3 = moUtil.FetchString(oCmd.Parameters.Item("@Options3").Value)
      .Options4 = moUtil.FetchString(oCmd.Parameters.Item("@Options4").Value)
      .Tutorial = moUtil.FetchLong(oCmd.Parameters.Item("@Tutorial").Value)
      .Timezone = moUtil.FetchLong(oCmd.Parameters.Item("@Timezone").Value)
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

Public Function Reports( _ 
   ByVal bvRpt As Long, _ 
   ByVal bvR1 As String, _ 
   ByVal bvR2 As String, _ 
   ByVal bvR3 As String, _ 
   ByVal bvR4 As String, _ 
   ByVal bvR5 As String) As tBusinessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Reports"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBusinessType
   Dim vRec As tBusinessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Rpt", adInteger, adParamInput, vbNull, CLng(bvRpt))
      .Parameters.Append .CreateParameter("@R1", adVarWChar, adParamInput, 50, bvR1)
      .Parameters.Append .CreateParameter("@R2", adVarWChar, adParamInput, 50, bvR2)
      .Parameters.Append .CreateParameter("@R3", adVarWChar, adParamInput, 50, bvR3)
      .Parameters.Append .CreateParameter("@R4", adVarWChar, adParamInput, 50, bvR4)
      .Parameters.Append .CreateParameter("@R5", adVarWChar, adParamInput, 50, bvR5)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Business_Reports")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BusinessID = moUtil.FetchLong(.Fields.Item("BusinessID").Value)
            vRec.R1 = moUtil.FetchString(.Fields.Item("R1").Value)
            vRec.R2 = moUtil.FetchString(.Fields.Item("R2").Value)
            vRec.R3 = moUtil.FetchString(.Fields.Item("R3").Value)
            vRec.R4 = moUtil.FetchString(.Fields.Item("R4").Value)
            vRec.R5 = moUtil.FetchString(.Fields.Item("R5").Value)
            vRec.R6 = moUtil.FetchString(.Fields.Item("R6").Value)
            vRec.R7 = moUtil.FetchString(.Fields.Item("R7").Value)
            vRec.R8 = moUtil.FetchString(.Fields.Item("R8").Value)
            vRec.R9 = moUtil.FetchString(.Fields.Item("R9").Value)
            vRec.R10 = moUtil.FetchString(.Fields.Item("R10").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Reports = vRecs

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
   ByRef brRec As tBusinessType, _ 
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
      .Parameters.Append .CreateParameter("@BusinessID", adInteger, adParamInput, vbNull, CLng(brRec.BusinessID))
      .Parameters.Append .CreateParameter("@Install", adInteger, adParamInput, vbNull, CLng(brRec.Install))
      .Parameters.Append .CreateParameter("@BusinessName", adVarWChar, adParamInput, 30, brRec.BusinessName)
      .Parameters.Append .CreateParameter("@SystemEmail", adVarWChar, adParamInput, 80, brRec.SystemEmail)
      .Parameters.Append .CreateParameter("@CustomerEmail", adVarWChar, adParamInput, 80, brRec.CustomerEmail)
      .Parameters.Append .CreateParameter("@TrainerEmail", adVarWChar, adParamInput, 80, brRec.TrainerEmail)
      .Parameters.Append .CreateParameter("@FinanceEmail", adVarWChar, adParamInput, 80, brRec.FinanceEmail)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@WebSite", adVarWChar, adParamInput, 255, brRec.WebSite)
      .Parameters.Append .CreateParameter("@TaxRate", adCurrency, adParamInput, vbNull, CCur(brRec.TaxRate))
      .Parameters.Append .CreateParameter("@CardProcessor", adInteger, adParamInput, vbNull, CLng(brRec.CardProcessor))
      .Parameters.Append .CreateParameter("@CheckProcessor", adInteger, adParamInput, vbNull, CLng(brRec.CheckProcessor))
      .Parameters.Append .CreateParameter("@CardAcct", adVarWChar, adParamInput, 255, brRec.CardAcct)
      .Parameters.Append .CreateParameter("@CheckAcct", adVarWChar, adParamInput, 255, brRec.CheckAcct)
      .Parameters.Append .CreateParameter("@PayPalAcct", adVarWChar, adParamInput, 255, brRec.PayPalAcct)
      .Parameters.Append .CreateParameter("@IsNotifyUser", adSmallInt, adParamInput, vbNull, CInt(brRec.IsNotifyUser))
      .Parameters.Append .CreateParameter("@PaymentOptions", adVarWChar, adParamInput, 15, brRec.PaymentOptions)
      .Parameters.Append .CreateParameter("@MiscPay1", adVarWChar, adParamInput, 30, brRec.MiscPay1)
      .Parameters.Append .CreateParameter("@MiscPay2", adVarWChar, adParamInput, 30, brRec.MiscPay2)
      .Parameters.Append .CreateParameter("@MiscPay3", adVarWChar, adParamInput, 30, brRec.MiscPay3)
      .Parameters.Append .CreateParameter("@Languages", adVarWChar, adParamInput, 1000, brRec.Languages)
      .Parameters.Append .CreateParameter("@Options1", adVarWChar, adParamInput, 60, brRec.Options1)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamInput, 60, brRec.Options2)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamInput, 60, brRec.Options3)
      .Parameters.Append .CreateParameter("@Options4", adVarWChar, adParamInput, 60, brRec.Options4)
      .Parameters.Append .CreateParameter("@Tutorial", adInteger, adParamInput, vbNull, CLng(brRec.Tutorial))
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamInput, vbNull, CLng(brRec.Timezone))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Business_Update"

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
   ByRef brRec As tBusinessType, _ 
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
         .BusinessID = moUtil.EditLong(.BusinessID, "BusinessID", True, , 1) 
      End If
      .Install = moUtil.EditLong(.Install, "Install", False) 
      .BusinessName = moUtil.EditString(.BusinessName, "BusinessName", True, , 1, 30) 
      .SystemEmail = moUtil.EditString(.SystemEmail, "SystemEmail", True, , 1, 80) 
      .CustomerEmail = moUtil.EditString(.CustomerEmail, "CustomerEmail", True, , 1, 80) 
      .TrainerEmail = moUtil.EditString(.TrainerEmail, "TrainerEmail", True, , 1, 80) 
      .FinanceEmail = moUtil.EditString(.FinanceEmail, "FinanceEmail", True, , 1, 80) 
      .Street = moUtil.EditString(.Street, "Street", True, , 1, 60) 
      .Unit = moUtil.EditString(.Unit, "Unit", False, , 1, 40) 
      .City = moUtil.EditString(.City, "City", True, , 1, 30) 
      .State = moUtil.EditString(.State, "State", True, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", True, , 1, 20) 
      .Country = moUtil.EditString(.Country, "Country", True, , 1, 30) 
      .Phone = moUtil.EditString(.Phone, "Phone", True, , 1, 30) 
      .Fax = moUtil.EditString(.Fax, "Fax", True, , 1, 30) 
      .WebSite = moUtil.EditString(.WebSite, "WebSite", False, , 1, 255) 
      .TaxRate = moUtil.EditCurrency(.TaxRate, "TaxRate", False, , 0, 999999.9999) 
      .CardProcessor = moUtil.EditLong(.CardProcessor, "CardProcessor", False) 
      .CheckProcessor = moUtil.EditLong(.CheckProcessor, "CheckProcessor", False) 
      .CardAcct = moUtil.EditString(.CardAcct, "CardAcct", False, , 1, 255) 
      .CheckAcct = moUtil.EditString(.CheckAcct, "CheckAcct", False, , 1, 255) 
      .PayPalAcct = moUtil.EditString(.PayPalAcct, "PayPalAcct", False, , 1, 255) 
      .IsNotifyUser = moUtil.EditInteger(.IsNotifyUser, "IsNotifyUser", False, 0, 0, 1) 
      .PaymentOptions = moUtil.EditString(.PaymentOptions, "PaymentOptions", False) 
      .MiscPay1 = moUtil.EditString(.MiscPay1, "MiscPay1", False, , 1, 30) 
      .MiscPay2 = moUtil.EditString(.MiscPay2, "MiscPay2", False, , 1, 30) 
      .MiscPay3 = moUtil.EditString(.MiscPay3, "MiscPay3", False, , 1, 30) 
      .Languages = moUtil.EditString(.Languages, "Languages", False, , 1, 1000) 
      .Options1 = moUtil.EditString(.Options1, "Options1", False) 
      .Options2 = moUtil.EditString(.Options2, "Options2", False) 
      .Options3 = moUtil.EditString(.Options3, "Options3", False) 
      .Options4 = moUtil.EditString(.Options4, "Options4", False) 
      .Tutorial = moUtil.EditLong(.Tutorial, "Tutorial", False) 
      .Timezone = moUtil.EditLong(.Timezone, "Timezone", False) 
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