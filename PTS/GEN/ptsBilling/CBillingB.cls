VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CBillingB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CBilling"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tBillingType
   BillingID As String
   CountryID As String
   CountryName As String
   CountryCode As String
   TokenType As String
   TokenOwner As String
   Token As String
   Verified As String
   BillingName As String
   Street1 As String
   Street2 As String
   City As String
   State As String
   Zip As String
   PayType As String
   CommType As String
   CardType As String
   CardNumber As String
   CardMo As String
   CardYr As String
   CardName As String
   CardCode As String
   CheckBank As String
   CheckRoute As String
   CheckAccount As String
   CheckAcctType As String
   CheckNumber As String
   CheckName As String
   UpdatedDate As String
   CompanyID As String
   CommDate As String
   Amount As String
   Memo As String
End Type

Public Sub Add( _ 
   ByRef brRec As tBillingType, _ 
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
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@TokenType", adInteger, adParamInput, vbNull, CLng(brRec.TokenType))
      .Parameters.Append .CreateParameter("@TokenOwner", adInteger, adParamInput, vbNull, CLng(brRec.TokenOwner))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(brRec.Token))
      .Parameters.Append .CreateParameter("@Verified", adInteger, adParamInput, vbNull, CLng(brRec.Verified))
      .Parameters.Append .CreateParameter("@BillingName", adVarWChar, adParamInput, 60, brRec.BillingName)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(brRec.CommType))
      .Parameters.Append .CreateParameter("@CardType", adInteger, adParamInput, vbNull, CLng(brRec.CardType))
      .Parameters.Append .CreateParameter("@CardNumber", adVarWChar, adParamInput, 30, brRec.CardNumber)
      .Parameters.Append .CreateParameter("@CardMo", adInteger, adParamInput, vbNull, CLng(brRec.CardMo))
      .Parameters.Append .CreateParameter("@CardYr", adInteger, adParamInput, vbNull, CLng(brRec.CardYr))
      .Parameters.Append .CreateParameter("@CardName", adVarWChar, adParamInput, 50, brRec.CardName)
      .Parameters.Append .CreateParameter("@CardCode", adVarWChar, adParamInput, 10, brRec.CardCode)
      .Parameters.Append .CreateParameter("@CheckBank", adVarWChar, adParamInput, 50, brRec.CheckBank)
      .Parameters.Append .CreateParameter("@CheckRoute", adVarWChar, adParamInput, 9, brRec.CheckRoute)
      .Parameters.Append .CreateParameter("@CheckAccount", adVarWChar, adParamInput, 20, brRec.CheckAccount)
      .Parameters.Append .CreateParameter("@CheckAcctType", adInteger, adParamInput, vbNull, CLng(brRec.CheckAcctType))
      .Parameters.Append .CreateParameter("@CheckNumber", adVarWChar, adParamInput, 6, brRec.CheckNumber)
      .Parameters.Append .CreateParameter("@CheckName", adVarWChar, adParamInput, 50, brRec.CheckName)
      .Parameters.Append .CreateParameter("@UpdatedDate", adDate, adParamInput, vbNull, CDate(brRec.UpdatedDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_Add"

   '-----get return values
   With brRec
      .BillingID = moUtil.FetchLong(oCmd.Parameters.Item("@BillingID").Value)
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
   ByRef brRec As tBillingType, _ 
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
      .BillingID = moUtil.EditLong(.BillingID, "BillingID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_Delete"

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
   ByRef brRec As tBillingType, _ 
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
      .BillingID = moUtil.EditLong(.BillingID, "BillingID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@CountryCode", adVarWChar, adParamOutput, 2, vbNull)
      .Parameters.Append .CreateParameter("@TokenType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TokenOwner", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Verified", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BillingName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CardType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CardNumber", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@CardMo", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CardYr", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CardName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@CardCode", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@CheckBank", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@CheckRoute", adVarWChar, adParamOutput, 9, vbNull)
      .Parameters.Append .CreateParameter("@CheckAccount", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@CheckAcctType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CheckNumber", adVarWChar, adParamOutput, 6, vbNull)
      .Parameters.Append .CreateParameter("@CheckName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@UpdatedDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_Fetch"

   '-----get return values
   With brRec
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .CountryCode = moUtil.FetchString(oCmd.Parameters.Item("@CountryCode").Value)
      .TokenType = moUtil.FetchLong(oCmd.Parameters.Item("@TokenType").Value)
      .TokenOwner = moUtil.FetchLong(oCmd.Parameters.Item("@TokenOwner").Value)
      .Token = moUtil.FetchLong(oCmd.Parameters.Item("@Token").Value)
      .Verified = moUtil.FetchLong(oCmd.Parameters.Item("@Verified").Value)
      .BillingName = moUtil.FetchString(oCmd.Parameters.Item("@BillingName").Value)
      .Street1 = moUtil.FetchString(oCmd.Parameters.Item("@Street1").Value)
      .Street2 = moUtil.FetchString(oCmd.Parameters.Item("@Street2").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .PayType = moUtil.FetchLong(oCmd.Parameters.Item("@PayType").Value)
      .CommType = moUtil.FetchLong(oCmd.Parameters.Item("@CommType").Value)
      .CardType = moUtil.FetchLong(oCmd.Parameters.Item("@CardType").Value)
      .CardNumber = moUtil.FetchString(oCmd.Parameters.Item("@CardNumber").Value)
      .CardMo = moUtil.FetchLong(oCmd.Parameters.Item("@CardMo").Value)
      .CardYr = moUtil.FetchLong(oCmd.Parameters.Item("@CardYr").Value)
      .CardName = moUtil.FetchString(oCmd.Parameters.Item("@CardName").Value)
      .CardCode = moUtil.FetchString(oCmd.Parameters.Item("@CardCode").Value)
      .CheckBank = moUtil.FetchString(oCmd.Parameters.Item("@CheckBank").Value)
      .CheckRoute = moUtil.FetchString(oCmd.Parameters.Item("@CheckRoute").Value)
      .CheckAccount = moUtil.FetchString(oCmd.Parameters.Item("@CheckAccount").Value)
      .CheckAcctType = moUtil.FetchLong(oCmd.Parameters.Item("@CheckAcctType").Value)
      .CheckNumber = moUtil.FetchString(oCmd.Parameters.Item("@CheckNumber").Value)
      .CheckName = moUtil.FetchString(oCmd.Parameters.Item("@CheckName").Value)
      .UpdatedDate = moUtil.FetchDate(oCmd.Parameters.Item("@UpdatedDate").Value)
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

Public Function CommeCheck( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvCommDate As Date, _ 
   ByVal bvAmount As Currency) As tBillingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommeCheck"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBillingType
   Dim vRec As tBillingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(bvCommDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(bvAmount))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_CommeCheck")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
            vRec.BillingName = moUtil.FetchString(.Fields.Item("BillingName").Value)
            vRec.CheckBank = moUtil.FetchString(.Fields.Item("CheckBank").Value)
            vRec.CheckRoute = moUtil.FetchString(.Fields.Item("CheckRoute").Value)
            vRec.CheckAccount = moUtil.FetchString(.Fields.Item("CheckAccount").Value)
            vRec.CheckAcctType = moUtil.FetchLong(.Fields.Item("CheckAcctType").Value)
            vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Memo = moUtil.FetchString(.Fields.Item("Memo").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CommeCheck = vRecs

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

Public Function CommpCheck( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvCommDate As Date, _ 
   ByVal bvAmount As Currency) As tBillingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommpCheck"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBillingType
   Dim vRec As tBillingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(bvCommDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(bvAmount))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_CommpCheck")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
            vRec.BillingName = moUtil.FetchString(.Fields.Item("BillingName").Value)
            vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
            vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
            vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Memo = moUtil.FetchString(.Fields.Item("Memo").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CommpCheck = vRecs

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

Public Function CommWallet( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvCommDate As Date, _ 
   ByVal bvAmount As Currency) As tBillingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommWallet"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBillingType
   Dim vRec As tBillingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(bvCommDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(bvAmount))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_CommWallet")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
            vRec.BillingName = moUtil.FetchString(.Fields.Item("BillingName").Value)
            vRec.CardType = moUtil.FetchLong(.Fields.Item("CardType").Value)
            vRec.CardName = moUtil.FetchString(.Fields.Item("CardName").Value)
            vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CommWallet = vRecs

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

Public Function CommCC( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvCommDate As Date, _ 
   ByVal bvAmount As Currency) As tBillingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CommCC"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBillingType
   Dim vRec As tBillingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(bvCommDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(bvAmount))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_CommCC")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
            vRec.CardType = moUtil.FetchLong(.Fields.Item("CardType").Value)
            vRec.CardNumber = moUtil.FetchString(.Fields.Item("CardNumber").Value)
            vRec.CardMo = moUtil.FetchLong(.Fields.Item("CardMo").Value)
            vRec.CardYr = moUtil.FetchLong(.Fields.Item("CardYr").Value)
            vRec.CardName = moUtil.FetchString(.Fields.Item("CardName").Value)
            vRec.CardCode = moUtil.FetchString(.Fields.Item("CardCode").Value)
            vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Memo = moUtil.FetchString(.Fields.Item("Memo").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CommCC = vRecs

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

Public Function Custom( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvToken As Long) As tBillingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Custom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBillingType
   Dim vRec As tBillingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(bvToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_Custom")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
            vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
            vRec.TokenType = moUtil.FetchLong(.Fields.Item("TokenType").Value)
            vRec.TokenOwner = moUtil.FetchLong(.Fields.Item("TokenOwner").Value)
            vRec.Token = moUtil.FetchLong(.Fields.Item("Token").Value)
            vRec.Verified = moUtil.FetchLong(.Fields.Item("Verified").Value)
            vRec.BillingName = moUtil.FetchString(.Fields.Item("BillingName").Value)
            vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
            vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.PayType = moUtil.FetchLong(.Fields.Item("PayType").Value)
            vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
            vRec.CardType = moUtil.FetchLong(.Fields.Item("CardType").Value)
            vRec.CardNumber = moUtil.FetchString(.Fields.Item("CardNumber").Value)
            vRec.CardMo = moUtil.FetchLong(.Fields.Item("CardMo").Value)
            vRec.CardYr = moUtil.FetchLong(.Fields.Item("CardYr").Value)
            vRec.CardName = moUtil.FetchString(.Fields.Item("CardName").Value)
            vRec.CardCode = moUtil.FetchString(.Fields.Item("CardCode").Value)
            vRec.CheckBank = moUtil.FetchString(.Fields.Item("CheckBank").Value)
            vRec.CheckRoute = moUtil.FetchString(.Fields.Item("CheckRoute").Value)
            vRec.CheckAccount = moUtil.FetchString(.Fields.Item("CheckAccount").Value)
            vRec.CheckAcctType = moUtil.FetchLong(.Fields.Item("CheckAcctType").Value)
            vRec.CheckNumber = moUtil.FetchString(.Fields.Item("CheckNumber").Value)
            vRec.CheckName = moUtil.FetchString(.Fields.Item("CheckName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Custom = vRecs

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
   ByRef brRec As tBillingType, _ 
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
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@TokenType", adInteger, adParamInput, vbNull, CLng(brRec.TokenType))
      .Parameters.Append .CreateParameter("@TokenOwner", adInteger, adParamInput, vbNull, CLng(brRec.TokenOwner))
      .Parameters.Append .CreateParameter("@Token", adInteger, adParamInput, vbNull, CLng(brRec.Token))
      .Parameters.Append .CreateParameter("@Verified", adInteger, adParamInput, vbNull, CLng(brRec.Verified))
      .Parameters.Append .CreateParameter("@BillingName", adVarWChar, adParamInput, 60, brRec.BillingName)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@PayType", adInteger, adParamInput, vbNull, CLng(brRec.PayType))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(brRec.CommType))
      .Parameters.Append .CreateParameter("@CardType", adInteger, adParamInput, vbNull, CLng(brRec.CardType))
      .Parameters.Append .CreateParameter("@CardNumber", adVarWChar, adParamInput, 30, brRec.CardNumber)
      .Parameters.Append .CreateParameter("@CardMo", adInteger, adParamInput, vbNull, CLng(brRec.CardMo))
      .Parameters.Append .CreateParameter("@CardYr", adInteger, adParamInput, vbNull, CLng(brRec.CardYr))
      .Parameters.Append .CreateParameter("@CardName", adVarWChar, adParamInput, 50, brRec.CardName)
      .Parameters.Append .CreateParameter("@CardCode", adVarWChar, adParamInput, 10, brRec.CardCode)
      .Parameters.Append .CreateParameter("@CheckBank", adVarWChar, adParamInput, 50, brRec.CheckBank)
      .Parameters.Append .CreateParameter("@CheckRoute", adVarWChar, adParamInput, 9, brRec.CheckRoute)
      .Parameters.Append .CreateParameter("@CheckAccount", adVarWChar, adParamInput, 20, brRec.CheckAccount)
      .Parameters.Append .CreateParameter("@CheckAcctType", adInteger, adParamInput, vbNull, CLng(brRec.CheckAcctType))
      .Parameters.Append .CreateParameter("@CheckNumber", adVarWChar, adParamInput, 6, brRec.CheckNumber)
      .Parameters.Append .CreateParameter("@CheckName", adVarWChar, adParamInput, 50, brRec.CheckName)
      .Parameters.Append .CreateParameter("@UpdatedDate", adDate, adParamInput, vbNull, CDate(brRec.UpdatedDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Billing_Update"

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
   ByRef brRec As tBillingType, _ 
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
         .BillingID = moUtil.EditLong(.BillingID, "BillingID", True, , 1) 
      End If
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", False) 
      .TokenType = moUtil.EditLong(.TokenType, "TokenType", False) 
      .TokenOwner = moUtil.EditLong(.TokenOwner, "TokenOwner", False) 
      .Token = moUtil.EditLong(.Token, "Token", False) 
      .Verified = moUtil.EditLong(.Verified, "Verified", False) 
      .BillingName = moUtil.EditString(.BillingName, "BillingName", False, , 1, 60) 
      .Street1 = moUtil.EditString(.Street1, "Street1", False, , 1, 60) 
      .Street2 = moUtil.EditString(.Street2, "Street2", False, , 1, 60) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .PayType = moUtil.EditLong(.PayType, "PayType", False) 
      .CommType = moUtil.EditLong(.CommType, "CommType", False) 
      .CardType = moUtil.EditLong(.CardType, "CardType", False) 
      If (.PayType = 1) Then
      .CardNumber = moUtil.EditString(.CardNumber, "CardNumber", True, , 1, 30) 
      End If
      If (.PayType = 1) Then
      .CardMo = moUtil.EditLong(.CardMo, "CardMo", True, , 1, 12) 
      End If
      If (.PayType = 1) Then
      .CardYr = moUtil.EditLong(.CardYr, "CardYr", True, , 2, 99) 
      End If
      .CardName = moUtil.EditString(.CardName, "CardName", False, , 1, 50) 
      .CardCode = moUtil.EditString(.CardCode, "CardCode", False, , 1, 10) 
      If (.PayType = 2) Or (.CommType = 1) Then
      .CheckBank = moUtil.EditString(.CheckBank, "CheckBank", True, , 1, 50) 
      End If
      If (.PayType = 2) Or (.CommType = 1) Then
      .CheckRoute = moUtil.EditString(.CheckRoute, "CheckRoute", True, , 9, 9) 
      End If
      If (.PayType = 2) Or (.CommType = 1) Then
      .CheckAccount = moUtil.EditString(.CheckAccount, "CheckAccount", True, , 1, 20) 
      End If
      .CheckAcctType = moUtil.EditLong(.CheckAcctType, "CheckAcctType", False) 
      .CheckNumber = moUtil.EditString(.CheckNumber, "CheckNumber", False, , 1, 6) 
      .CheckName = moUtil.EditString(.CheckName, "CheckName", False, , 1, 50) 
      .UpdatedDate = moUtil.EditDate(.UpdatedDate, "UpdatedDate", False) 
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