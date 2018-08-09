VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CRewardB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CReward"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tRewardType
   RewardID As String
   MerchantID As String
   ConsumerID As String
   Payment2ID As String
   AwardID As String
   NameFirst As String
   NameLast As String
   ConsumerName As String
   MerchantName As String
   AwardName As String
   RewardDate As String
   RewardType As String
   Amount As String
   Points As String
   Status As String
   HoldDate As String
   Reference As String
   Note As String
End Type

Public Sub Add( _ 
   ByRef brRec As tRewardType, _ 
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
      .Parameters.Append .CreateParameter("@RewardID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamInput, vbNull, CLng(brRec.Payment2ID))
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamInput, vbNull, CLng(brRec.AwardID))
      .Parameters.Append .CreateParameter("@RewardDate", adDate, adParamInput, vbNull, CDate(brRec.RewardDate))
      .Parameters.Append .CreateParameter("@RewardType", adInteger, adParamInput, vbNull, CLng(brRec.RewardType))
      .Parameters.Append .CreateParameter("@Amount", adBigInt, adParamInput, vbNull, CStr(brRec.Amount))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@HoldDate", adDate, adParamInput, vbNull, CDate(brRec.HoldDate))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      .Parameters.Append .CreateParameter("@Note", adVarWChar, adParamInput, 100, brRec.Note)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_Add"

   '-----get return values
   With brRec
      .RewardID = moUtil.FetchLong(oCmd.Parameters.Item("@RewardID").Value)
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

Public Function TotalReward( _ 
   ByRef brRec As tRewardType, _ 
   ByVal bvUserID As Long) As Currency
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TotalReward"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", True, 0) 
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@Result", adCurrency, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_TotalReward"

   '-----get return values
   TotalReward = moUtil.FetchCurrency(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function PaymentRewards( _ 
   ByRef brRec As tRewardType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PaymentRewards"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Payment2ID = moUtil.EditLong(.Payment2ID, "Payment2ID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamInput, vbNull, CLng(brRec.Payment2ID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 300, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_PaymentRewards"

   '-----get return values
   PaymentRewards = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tRewardType, _ 
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
      .RewardID = moUtil.EditLong(.RewardID, "RewardID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@RewardID", adInteger, adParamInput, vbNull, CLng(brRec.RewardID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_Delete"

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
   ByRef brRec As tRewardType, _ 
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
      .RewardID = moUtil.EditLong(.RewardID, "RewardID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@RewardID", adInteger, adParamInput, vbNull, CLng(brRec.RewardID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@MerchantName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@AwardName", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@RewardDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RewardType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adBigInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Points", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@HoldDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Note", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_Fetch"

   '-----get return values
   With brRec
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
      .Payment2ID = moUtil.FetchLong(oCmd.Parameters.Item("@Payment2ID").Value)
      .AwardID = moUtil.FetchLong(oCmd.Parameters.Item("@AwardID").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .ConsumerName = moUtil.FetchString(oCmd.Parameters.Item("@ConsumerName").Value)
      .MerchantName = moUtil.FetchString(oCmd.Parameters.Item("@MerchantName").Value)
      .AwardName = moUtil.FetchString(oCmd.Parameters.Item("@AwardName").Value)
      .RewardDate = moUtil.FetchDate(oCmd.Parameters.Item("@RewardDate").Value)
      .RewardType = moUtil.FetchLong(oCmd.Parameters.Item("@RewardType").Value)
      .Amount = moUtil.FetchString(oCmd.Parameters.Item("@Amount").Value)
      .Points = moUtil.FetchCurrency(oCmd.Parameters.Item("@Points").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .HoldDate = moUtil.FetchDate(oCmd.Parameters.Item("@HoldDate").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .Note = moUtil.FetchString(oCmd.Parameters.Item("@Note").Value)
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

Public Function FindMerchant( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvRewardType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tRewardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMerchant"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tRewardType
   Dim vRec As tRewardType
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
   bvMerchantID = moUtil.EditLong(bvMerchantID, "MerchantID", True) 
   bvRewardType = moUtil.EditLong(bvRewardType, "RewardType", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsRewardFindRewardDate
         sProc = "pts_Reward_FindMerchantRewardDate"
         MaxBookMark = 30
      Case cptsRewardFindMerchantID
         sProc = "pts_Reward_FindMerchantMerchantID"
         MaxBookMark = 20
      Case cptsRewardFindConsumerID
         sProc = "pts_Reward_FindMerchantConsumerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@RewardType", adInteger, adParamInput, vbNull, CLng(bvRewardType))
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
               vRec.RewardID = moUtil.FetchLong(.Fields.Item("RewardID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.RewardDate = moUtil.FetchDate(.Fields.Item("RewardDate").Value)
               vRec.RewardType = moUtil.FetchLong(.Fields.Item("RewardType").Value)
               vRec.Amount = moUtil.FetchString(.Fields.Item("Amount").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.HoldDate = moUtil.FetchDate(.Fields.Item("HoldDate").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
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

Public Function FindMerchantRedeem( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   ByVal bvRewardType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tRewardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMerchantRedeem"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tRewardType
   Dim vRec As tRewardType
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
   bvMerchantID = moUtil.EditLong(bvMerchantID, "MerchantID", True) 
   bvRewardType = moUtil.EditLong(bvRewardType, "RewardType", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsRewardFindRewardDate
         sProc = "pts_Reward_FindMerchantRedeemRewardDate"
         MaxBookMark = 30
      Case cptsRewardFindMerchantID
         sProc = "pts_Reward_FindMerchantRedeemMerchantID"
         MaxBookMark = 20
      Case cptsRewardFindConsumerID
         sProc = "pts_Reward_FindMerchantRedeemConsumerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@RewardType", adInteger, adParamInput, vbNull, CLng(bvRewardType))
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
               vRec.RewardID = moUtil.FetchLong(.Fields.Item("RewardID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.RewardDate = moUtil.FetchDate(.Fields.Item("RewardDate").Value)
               vRec.RewardType = moUtil.FetchLong(.Fields.Item("RewardType").Value)
               vRec.Amount = moUtil.FetchString(.Fields.Item("Amount").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.HoldDate = moUtil.FetchDate(.Fields.Item("HoldDate").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
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
   FindMerchantRedeem = vRecs

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
   ByVal bvRewardType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tRewardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tRewardType
   Dim vRec As tRewardType
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
   bvRewardType = moUtil.EditLong(bvRewardType, "RewardType", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsRewardFindRewardDate
         sProc = "pts_Reward_FindConsumerRewardDate"
         MaxBookMark = 30
      Case cptsRewardFindMerchantID
         sProc = "pts_Reward_FindConsumerMerchantID"
         MaxBookMark = 20
      Case cptsRewardFindConsumerID
         sProc = "pts_Reward_FindConsumerConsumerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
      .Parameters.Append .CreateParameter("@RewardType", adInteger, adParamInput, vbNull, CLng(bvRewardType))
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
               vRec.RewardID = moUtil.FetchLong(.Fields.Item("RewardID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.RewardDate = moUtil.FetchDate(.Fields.Item("RewardDate").Value)
               vRec.RewardType = moUtil.FetchLong(.Fields.Item("RewardType").Value)
               vRec.Amount = moUtil.FetchString(.Fields.Item("Amount").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.HoldDate = moUtil.FetchDate(.Fields.Item("HoldDate").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
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

Public Function FindConsumerRedeem( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvRewardType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tRewardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindConsumerRedeem"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tRewardType
   Dim vRec As tRewardType
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
   bvRewardType = moUtil.EditLong(bvRewardType, "RewardType", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsRewardFindRewardDate
         sProc = "pts_Reward_FindConsumerRedeemRewardDate"
         MaxBookMark = 30
      Case cptsRewardFindMerchantID
         sProc = "pts_Reward_FindConsumerRedeemMerchantID"
         MaxBookMark = 20
      Case cptsRewardFindConsumerID
         sProc = "pts_Reward_FindConsumerRedeemConsumerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
      .Parameters.Append .CreateParameter("@RewardType", adInteger, adParamInput, vbNull, CLng(bvRewardType))
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
               vRec.RewardID = moUtil.FetchLong(.Fields.Item("RewardID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.Payment2ID = moUtil.FetchLong(.Fields.Item("Payment2ID").Value)
               vRec.AwardID = moUtil.FetchLong(.Fields.Item("AwardID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.AwardName = moUtil.FetchString(.Fields.Item("AwardName").Value)
               vRec.RewardDate = moUtil.FetchDate(.Fields.Item("RewardDate").Value)
               vRec.RewardType = moUtil.FetchLong(.Fields.Item("RewardType").Value)
               vRec.Amount = moUtil.FetchString(.Fields.Item("Amount").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.HoldDate = moUtil.FetchDate(.Fields.Item("HoldDate").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
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
   FindConsumerRedeem = vRecs

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

Public Function ListCash( _ 
   ByVal bvConsumerID As Long) As tRewardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCash"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tRewardType
   Dim vRec As tRewardType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvConsumerID = moUtil.EditLong(bvConsumerID, "ConsumerID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_ListCash")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.RewardID = moUtil.FetchLong(.Fields.Item("RewardID").Value)
            vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
            vRec.RewardDate = moUtil.FetchDate(.Fields.Item("RewardDate").Value)
            vRec.RewardType = moUtil.FetchLong(.Fields.Item("RewardType").Value)
            vRec.Amount = moUtil.FetchString(.Fields.Item("Amount").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.HoldDate = moUtil.FetchDate(.Fields.Item("HoldDate").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCash = vRecs

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

Public Function ListPointsSummary( _ 
   ByVal bvConsumerID As Long) As tRewardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPointsSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tRewardType
   Dim vRec As tRewardType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvConsumerID = moUtil.EditLong(bvConsumerID, "ConsumerID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_ListPointsSummary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.RewardID = moUtil.FetchLong(.Fields.Item("RewardID").Value)
            vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
            vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
            vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPointsSummary = vRecs

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

Public Function ListPointsDetail( _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvMerchantID As Long) As tRewardType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPointsDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tRewardType
   Dim vRec As tRewardType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvConsumerID = moUtil.EditLong(bvConsumerID, "ConsumerID", True, 0) 
      bvMerchantID = moUtil.EditLong(bvMerchantID, "MerchantID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_ListPointsDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.RewardID = moUtil.FetchLong(.Fields.Item("RewardID").Value)
            vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
            vRec.RewardDate = moUtil.FetchDate(.Fields.Item("RewardDate").Value)
            vRec.RewardType = moUtil.FetchLong(.Fields.Item("RewardType").Value)
            vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.HoldDate = moUtil.FetchDate(.Fields.Item("HoldDate").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPointsDetail = vRecs

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
   ByRef brRec As tRewardType, _ 
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
      .Parameters.Append .CreateParameter("@RewardID", adInteger, adParamInput, vbNull, CLng(brRec.RewardID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@Payment2ID", adInteger, adParamInput, vbNull, CLng(brRec.Payment2ID))
      .Parameters.Append .CreateParameter("@AwardID", adInteger, adParamInput, vbNull, CLng(brRec.AwardID))
      .Parameters.Append .CreateParameter("@RewardDate", adDate, adParamInput, vbNull, CDate(brRec.RewardDate))
      .Parameters.Append .CreateParameter("@RewardType", adInteger, adParamInput, vbNull, CLng(brRec.RewardType))
      .Parameters.Append .CreateParameter("@Amount", adBigInt, adParamInput, vbNull, CStr(brRec.Amount))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@HoldDate", adDate, adParamInput, vbNull, CDate(brRec.HoldDate))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      .Parameters.Append .CreateParameter("@Note", adVarWChar, adParamInput, 100, brRec.Note)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Reward_Update"

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
   ByRef brRec As tRewardType, _ 
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
         .RewardID = moUtil.EditLong(.RewardID, "RewardID", True, , 1) 
      End If
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False) 
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", False) 
      .Payment2ID = moUtil.EditLong(.Payment2ID, "Payment2ID", False) 
      .AwardID = moUtil.EditLong(.AwardID, "AwardID", False) 
      .RewardDate = moUtil.EditDate(.RewardDate, "RewardDate", False) 
      .RewardType = moUtil.EditLong(.RewardType, "RewardType", False) 
      .Amount = moUtil.EditString(.Amount, "Amount", False, 0) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .HoldDate = moUtil.EditDate(.HoldDate, "HoldDate", False) 
      .Reference = moUtil.EditString(.Reference, "Reference", False, , 1, 15) 
      .Note = moUtil.EditString(.Note, "Note", False, , 1, 100) 
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