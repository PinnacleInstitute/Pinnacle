VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CPromoB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPromo"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tPromoType
   PromoID As String
   MerchantID As String
   CountryID As String
   PromoName As String
   FromEmail As String
   Subject As String
   Message As String
   Status As String
   TargetArea As String
   TargetType As String
   TargetDays As String
   Target As String
   StartDate As String
   EndDate As String
   SendDate As String
   Msgs As String
   TestEmail As String
End Type

Public Sub Add( _ 
   ByRef brRec As tPromoType, _ 
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
      .Parameters.Append .CreateParameter("@PromoID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@PromoName", adVarWChar, adParamInput, 60, brRec.PromoName)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamInput, 60, brRec.FromEmail)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamInput, 200, brRec.Message)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@TargetArea", adInteger, adParamInput, vbNull, CLng(brRec.TargetArea))
      .Parameters.Append .CreateParameter("@TargetType", adInteger, adParamInput, vbNull, CLng(brRec.TargetType))
      .Parameters.Append .CreateParameter("@TargetDays", adInteger, adParamInput, vbNull, CLng(brRec.TargetDays))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, brRec.Target)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamInput, vbNull, CDate(brRec.SendDate))
      .Parameters.Append .CreateParameter("@Msgs", adInteger, adParamInput, vbNull, CLng(brRec.Msgs))
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamInput, 80, brRec.TestEmail)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promo_Add"

   '-----get return values
   With brRec
      .PromoID = moUtil.FetchLong(oCmd.Parameters.Item("@PromoID").Value)
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
   ByRef brRec As tPromoType, _ 
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
      .PromoID = moUtil.EditLong(.PromoID, "PromoID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PromoID", adInteger, adParamInput, vbNull, CLng(brRec.PromoID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promo_Delete"

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
   ByRef brRec As tPromoType, _ 
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
      .PromoID = moUtil.EditLong(.PromoID, "PromoID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PromoID", adInteger, adParamInput, vbNull, CLng(brRec.PromoID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PromoName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TargetArea", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TargetType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TargetDays", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Msgs", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promo_Fetch"

   '-----get return values
   With brRec
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .PromoName = moUtil.FetchString(oCmd.Parameters.Item("@PromoName").Value)
      .FromEmail = moUtil.FetchString(oCmd.Parameters.Item("@FromEmail").Value)
      .Subject = moUtil.FetchString(oCmd.Parameters.Item("@Subject").Value)
      .Message = moUtil.FetchString(oCmd.Parameters.Item("@Message").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .TargetArea = moUtil.FetchLong(oCmd.Parameters.Item("@TargetArea").Value)
      .TargetType = moUtil.FetchLong(oCmd.Parameters.Item("@TargetType").Value)
      .TargetDays = moUtil.FetchLong(oCmd.Parameters.Item("@TargetDays").Value)
      .Target = moUtil.FetchString(oCmd.Parameters.Item("@Target").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .SendDate = moUtil.FetchDate(oCmd.Parameters.Item("@SendDate").Value)
      .Msgs = moUtil.FetchLong(oCmd.Parameters.Item("@Msgs").Value)
      .TestEmail = moUtil.FetchString(oCmd.Parameters.Item("@TestEmail").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tPromoType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPromoType
   Dim vRec As tPromoType
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
      Case cptsPromoFindPromoName
         sProc = "pts_Promo_FindPromoName"
         MaxBookMark = 70
      Case cptsPromoFindSendDate
         sProc = "pts_Promo_FindSendDate"
         MaxBookMark = 30
      Case cptsPromoFindStatus
         sProc = "pts_Promo_FindStatus"
         MaxBookMark = 20
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
               vRec.PromoID = moUtil.FetchLong(.Fields.Item("PromoID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.PromoName = moUtil.FetchString(.Fields.Item("PromoName").Value)
               vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Message = moUtil.FetchString(.Fields.Item("Message").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.TargetArea = moUtil.FetchLong(.Fields.Item("TargetArea").Value)
               vRec.TargetType = moUtil.FetchLong(.Fields.Item("TargetType").Value)
               vRec.TargetDays = moUtil.FetchLong(.Fields.Item("TargetDays").Value)
               vRec.Target = moUtil.FetchString(.Fields.Item("Target").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
               vRec.Msgs = moUtil.FetchLong(.Fields.Item("Msgs").Value)
               vRec.TestEmail = moUtil.FetchString(.Fields.Item("TestEmail").Value)
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

Public Sub Update( _ 
   ByRef brRec As tPromoType, _ 
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
      .Parameters.Append .CreateParameter("@PromoID", adInteger, adParamInput, vbNull, CLng(brRec.PromoID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@PromoName", adVarWChar, adParamInput, 60, brRec.PromoName)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamInput, 60, brRec.FromEmail)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamInput, 200, brRec.Message)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@TargetArea", adInteger, adParamInput, vbNull, CLng(brRec.TargetArea))
      .Parameters.Append .CreateParameter("@TargetType", adInteger, adParamInput, vbNull, CLng(brRec.TargetType))
      .Parameters.Append .CreateParameter("@TargetDays", adInteger, adParamInput, vbNull, CLng(brRec.TargetDays))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, brRec.Target)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamInput, vbNull, CDate(brRec.SendDate))
      .Parameters.Append .CreateParameter("@Msgs", adInteger, adParamInput, vbNull, CLng(brRec.Msgs))
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamInput, 80, brRec.TestEmail)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promo_Update"

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
   ByRef brRec As tPromoType, _ 
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
         .PromoID = moUtil.EditLong(.PromoID, "PromoID", True, , 1) 
      End If
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False, , 1) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", True) 
      .PromoName = moUtil.EditString(.PromoName, "PromoName", True, , 1, 60) 
      .FromEmail = moUtil.EditString(.FromEmail, "FromEmail", True, , 1, 60) 
      .Subject = moUtil.EditString(.Subject, "Subject", True, , 1, 80) 
      .Message = moUtil.EditString(.Message, "Message", False, , 1, 200) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .TargetArea = moUtil.EditLong(.TargetArea, "TargetArea", False) 
      .TargetType = moUtil.EditLong(.TargetType, "TargetType", False) 
      .TargetDays = moUtil.EditLong(.TargetDays, "TargetDays", False) 
      .Target = moUtil.EditString(.Target, "Target", False, , 1, 200) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .SendDate = moUtil.EditDate(.SendDate, "SendDate", False) 
      .Msgs = moUtil.EditLong(.Msgs, "Msgs", False) 
      .TestEmail = moUtil.EditString(.TestEmail, "TestEmail", False) 
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