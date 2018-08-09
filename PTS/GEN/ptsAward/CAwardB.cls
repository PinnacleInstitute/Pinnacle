VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAwardB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAward"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAwardType
   AwardID As String
   MerchantID As String
   AwardType As String
   Seq As String
   Amount As String
   Status As String
   Description As String
   Cap As String
   Award As String
   StartDate As String
   EndDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAwardType, _ 
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
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@AwardType", adInteger, adParamInput, vbNull, CLng(brRec.AwardType))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Cap", adCurrency, adParamInput, vbNull, CCur(brRec.Cap))
      .Parameters.Append .CreateParameter("@Award", adCurrency, adParamInput, vbNull, CCur(brRec.Award))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Award_Add"

   '-----get return values
   With brRec
      .AwardID = moUtil.FetchLong(oCmd.Parameters.Item("@AwardID").Value)
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
   ByRef brRec As tAwardType, _ 
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
      .AwardID = moUtil.EditLong(.AwardID, "AwardID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamInput, vbNull, CLng(brRec.AwardID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Award_Delete"

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

Public Function EnumUserMerchant( _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvAwardType As Long, _ 
   ByVal bvSecurityToken As Long) As tAwardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserMerchant"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAwardType
   Dim vRec As tAwardType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@AwardType", adInteger, adParamInput, vbNull, CLng(bvAwardType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Award_EnumUserMerchant")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AwardID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserMerchant = vRecs

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

Public Sub Fetch( _ 
   ByRef brRec As tAwardType, _ 
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
      .AwardID = moUtil.EditLong(.AwardID, "AwardID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamInput, vbNull, CLng(brRec.AwardID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AwardType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Cap", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Award", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Award_Fetch"

   '-----get return values
   With brRec
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
      .AwardType = moUtil.FetchLong(oCmd.Parameters.Item("@AwardType").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Cap = moUtil.FetchCurrency(oCmd.Parameters.Item("@Cap").Value)
      .Award = moUtil.FetchCurrency(oCmd.Parameters.Item("@Award").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
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

Public Function ListAllAwards( _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvAwardType As Long) As tAwardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAllAwards"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAwardType
   Dim vRec As tAwardType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMerchantID = moUtil.EditLong(bvMerchantID, "MerchantID", True, 0, 1) 
      bvAwardType = moUtil.EditLong(bvAwardType, "AwardType", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@AwardType", adInteger, adParamInput, vbNull, CLng(bvAwardType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Award_ListAllAwards")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
            vRec.AwardType = moUtil.FetchLong(.Fields.Item("AwardType").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Cap = moUtil.FetchCurrency(.Fields.Item("Cap").Value)
            vRec.Award = moUtil.FetchCurrency(.Fields.Item("Award").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAllAwards = vRecs

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

Public Function ListAwards( _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvAwardType As Long) As tAwardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAwards"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAwardType
   Dim vRec As tAwardType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMerchantID = moUtil.EditLong(bvMerchantID, "MerchantID", True, 0, 1) 
      bvAwardType = moUtil.EditLong(bvAwardType, "AwardType", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@AwardType", adInteger, adParamInput, vbNull, CLng(bvAwardType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Award_ListAwards")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
            vRec.AwardType = moUtil.FetchLong(.Fields.Item("AwardType").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Cap = moUtil.FetchCurrency(.Fields.Item("Cap").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAwards = vRecs

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
   ByRef brRec As tAwardType, _ 
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
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamInput, vbNull, CLng(brRec.AwardID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@AwardType", adInteger, adParamInput, vbNull, CLng(brRec.AwardType))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Cap", adCurrency, adParamInput, vbNull, CCur(brRec.Cap))
      .Parameters.Append .CreateParameter("@Award", adCurrency, adParamInput, vbNull, CCur(brRec.Award))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Award_Update"

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
   ByRef brRec As tAwardType, _ 
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
         .AwardID = moUtil.EditLong(.AwardID, "AwardID", True, , 1) 
      End If
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False, , 1) 
      .AwardType = moUtil.EditLong(.AwardType, "AwardType", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 100) 
      .Cap = moUtil.EditCurrency(.Cap, "Cap", False) 
      .Award = moUtil.EditCurrency(.Award, "Award", False) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
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