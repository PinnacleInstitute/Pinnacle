VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CSalesStepB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSalesStep"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tSalesStepType
   SalesStepID As String
   SalesCampaignID As String
   EmailID As String
   SalesStepName As String
   Description As String
   Seq As String
   AutoStep As String
   NextStep As String
   Delay As String
   DateNo As String
   IsBoard As String
   BoardRate As String
   Length As String
   Email As String
   Data As String
   Count As String
   Potential As String
   Current As String
End Type

Public Sub Add( _ 
   ByRef brRec As tSalesStepType, _ 
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
      .Parameters.Append .CreateParameter("@SalesStepID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(brRec.EmailID))
      .Parameters.Append .CreateParameter("@SalesStepName", adVarWChar, adParamInput, 40, brRec.SalesStepName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@AutoStep", adInteger, adParamInput, vbNull, CLng(brRec.AutoStep))
      .Parameters.Append .CreateParameter("@NextStep", adInteger, adParamInput, vbNull, CLng(brRec.NextStep))
      .Parameters.Append .CreateParameter("@Delay", adInteger, adParamInput, vbNull, CLng(brRec.Delay))
      .Parameters.Append .CreateParameter("@DateNo", adInteger, adParamInput, vbNull, CLng(brRec.DateNo))
      .Parameters.Append .CreateParameter("@IsBoard", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBoard))
      .Parameters.Append .CreateParameter("@BoardRate", adCurrency, adParamInput, vbNull, CCur(brRec.BoardRate))
      .Parameters.Append .CreateParameter("@Length", adInteger, adParamInput, vbNull, CLng(brRec.Length))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 100, brRec.Email)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesStep_Add"

   '-----get return values
   With brRec
      .SalesStepID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesStepID").Value)
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

Public Function GetNextStep( _ 
   ByRef brRec As tSalesStepType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetNextStep"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .SalesStepID = moUtil.EditLong(.SalesStepID, "SalesStepID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesStepID", adInteger, adParamInput, vbNull, CLng(brRec.SalesStepID))
      .Parameters.Append .CreateParameter("@NextStep", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesStep_GetNextStep"

   '-----get return values
   GetNextStep = moUtil.FetchLong(oCmd.Parameters.Item("@NextStep").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetFirstStep( _ 
   ByRef brRec As tSalesStepType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetFirstStep"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .SalesCampaignID = moUtil.EditLong(.SalesCampaignID, "SalesCampaignID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@FirstStep", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesStep_GetFirstStep"

   '-----get return values
   GetFirstStep = moUtil.FetchLong(oCmd.Parameters.Item("@FirstStep").Value)

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
   ByRef brRec As tSalesStepType, _ 
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
      .SalesStepID = moUtil.EditLong(.SalesStepID, "SalesStepID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesStepID", adInteger, adParamInput, vbNull, CLng(brRec.SalesStepID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesStep_Delete"

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
   ByRef brRec As tSalesStepType, _ 
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
      .SalesStepID = moUtil.EditLong(.SalesStepID, "SalesStepID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesStepID", adInteger, adParamInput, vbNull, CLng(brRec.SalesStepID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesStepName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AutoStep", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextStep", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Delay", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DateNo", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsBoard", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BoardRate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Length", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesStep_Fetch"

   '-----get return values
   With brRec
      .SalesCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesCampaignID").Value)
      .EmailID = moUtil.FetchLong(oCmd.Parameters.Item("@EmailID").Value)
      .SalesStepName = moUtil.FetchString(oCmd.Parameters.Item("@SalesStepName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .AutoStep = moUtil.FetchLong(oCmd.Parameters.Item("@AutoStep").Value)
      .NextStep = moUtil.FetchLong(oCmd.Parameters.Item("@NextStep").Value)
      .Delay = moUtil.FetchLong(oCmd.Parameters.Item("@Delay").Value)
      .DateNo = moUtil.FetchLong(oCmd.Parameters.Item("@DateNo").Value)
      .IsBoard = moUtil.FetchInteger(oCmd.Parameters.Item("@IsBoard").Value)
      .BoardRate = moUtil.FetchCurrency(oCmd.Parameters.Item("@BoardRate").Value)
      .Length = moUtil.FetchLong(oCmd.Parameters.Item("@Length").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
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

Public Function List( _ 
   ByVal bvSalesCampaignID As Long) As tSalesStepType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesStepType
   Dim vRec As tSalesStepType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesStep_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesStepID = moUtil.FetchLong(.Fields.Item("SalesStepID").Value)
            vRec.SalesStepName = moUtil.FetchString(.Fields.Item("SalesStepName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.AutoStep = moUtil.FetchLong(.Fields.Item("AutoStep").Value)
            vRec.NextStep = moUtil.FetchLong(.Fields.Item("NextStep").Value)
            vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
            vRec.DateNo = moUtil.FetchLong(.Fields.Item("DateNo").Value)
            vRec.IsBoard = moUtil.FetchInteger(.Fields.Item("IsBoard").Value)
            vRec.BoardRate = moUtil.FetchCurrency(.Fields.Item("BoardRate").Value)
            vRec.Length = moUtil.FetchLong(.Fields.Item("Length").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   List = vRecs

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
   ByRef brRec As tSalesStepType, _ 
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
      .Parameters.Append .CreateParameter("@SalesStepID", adInteger, adParamInput, vbNull, CLng(brRec.SalesStepID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(brRec.EmailID))
      .Parameters.Append .CreateParameter("@SalesStepName", adVarWChar, adParamInput, 40, brRec.SalesStepName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@AutoStep", adInteger, adParamInput, vbNull, CLng(brRec.AutoStep))
      .Parameters.Append .CreateParameter("@NextStep", adInteger, adParamInput, vbNull, CLng(brRec.NextStep))
      .Parameters.Append .CreateParameter("@Delay", adInteger, adParamInput, vbNull, CLng(brRec.Delay))
      .Parameters.Append .CreateParameter("@DateNo", adInteger, adParamInput, vbNull, CLng(brRec.DateNo))
      .Parameters.Append .CreateParameter("@IsBoard", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBoard))
      .Parameters.Append .CreateParameter("@BoardRate", adCurrency, adParamInput, vbNull, CCur(brRec.BoardRate))
      .Parameters.Append .CreateParameter("@Length", adInteger, adParamInput, vbNull, CLng(brRec.Length))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 100, brRec.Email)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesStep_Update"

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
   ByRef brRec As tSalesStepType, _ 
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
         .SalesStepID = moUtil.EditLong(.SalesStepID, "SalesStepID", True, , 1) 
      End If
      .SalesCampaignID = moUtil.EditLong(.SalesCampaignID, "SalesCampaignID", True) 
      .EmailID = moUtil.EditLong(.EmailID, "EmailID", False) 
      .SalesStepName = moUtil.EditString(.SalesStepName, "SalesStepName", True, , 1, 40) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 100) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False, , 1) 
      .AutoStep = moUtil.EditLong(.AutoStep, "AutoStep", False) 
      .NextStep = moUtil.EditLong(.NextStep, "NextStep", False) 
      .Delay = moUtil.EditLong(.Delay, "Delay", False) 
      .DateNo = moUtil.EditLong(.DateNo, "DateNo", False, , 1, 10) 
      .IsBoard = moUtil.EditInteger(.IsBoard, "IsBoard", False, 0, 0, 1) 
      .BoardRate = moUtil.EditCurrency(.BoardRate, "BoardRate", False) 
      .Length = moUtil.EditLong(.Length, "Length", False) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 100) 
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