VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMarketB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMarket"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMarketType
   MarketID As String
   CompanyID As String
   CountryID As String
   MarketName As String
   FromEmail As String
   Subject As String
   Status As String
   Target As String
   CreateDate As String
   SendDate As String
   SendDays As String
   Consumers As String
   Merchants As String
   Orgs As String
   TestEmail As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMarketType, _ 
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
      .Parameters.Append .CreateParameter("@MarketID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@MarketName", adVarWChar, adParamInput, 80, brRec.MarketName)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamInput, 60, brRec.FromEmail)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, brRec.Target)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamInput, vbNull, CDate(brRec.SendDate))
      .Parameters.Append .CreateParameter("@SendDays", adInteger, adParamInput, vbNull, CLng(brRec.SendDays))
      .Parameters.Append .CreateParameter("@Consumers", adInteger, adParamInput, vbNull, CLng(brRec.Consumers))
      .Parameters.Append .CreateParameter("@Merchants", adInteger, adParamInput, vbNull, CLng(brRec.Merchants))
      .Parameters.Append .CreateParameter("@Orgs", adInteger, adParamInput, vbNull, CLng(brRec.Orgs))
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamInput, 80, brRec.TestEmail)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Market_Add"

   '-----get return values
   With brRec
      .MarketID = moUtil.FetchLong(oCmd.Parameters.Item("@MarketID").Value)
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
   ByRef brRec As tMarketType, _ 
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
      .MarketID = moUtil.EditLong(.MarketID, "MarketID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MarketID", adInteger, adParamInput, vbNull, CLng(brRec.MarketID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Market_Delete"

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
   ByRef brRec As tMarketType, _ 
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
      .MarketID = moUtil.EditLong(.MarketID, "MarketID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MarketID", adInteger, adParamInput, vbNull, CLng(brRec.MarketID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MarketName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SendDays", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Consumers", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Merchants", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Orgs", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Market_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .MarketName = moUtil.FetchString(oCmd.Parameters.Item("@MarketName").Value)
      .FromEmail = moUtil.FetchString(oCmd.Parameters.Item("@FromEmail").Value)
      .Subject = moUtil.FetchString(oCmd.Parameters.Item("@Subject").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Target = moUtil.FetchString(oCmd.Parameters.Item("@Target").Value)
      .CreateDate = moUtil.FetchDate(oCmd.Parameters.Item("@CreateDate").Value)
      .SendDate = moUtil.FetchDate(oCmd.Parameters.Item("@SendDate").Value)
      .SendDays = moUtil.FetchLong(oCmd.Parameters.Item("@SendDays").Value)
      .Consumers = moUtil.FetchLong(oCmd.Parameters.Item("@Consumers").Value)
      .Merchants = moUtil.FetchLong(oCmd.Parameters.Item("@Merchants").Value)
      .Orgs = moUtil.FetchLong(oCmd.Parameters.Item("@Orgs").Value)
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
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMarketType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMarketType
   Dim vRec As tMarketType
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
      Case cptsMarketFindMarketName
         sProc = "pts_Market_FindMarketName"
         MaxBookMark = 90
      Case cptsMarketFindSendDate
         sProc = "pts_Market_FindSendDate"
         MaxBookMark = 30
      Case cptsMarketFindStatus
         sProc = "pts_Market_FindStatus"
         MaxBookMark = 20
      Case cptsMarketFindTarget
         sProc = "pts_Market_FindTarget"
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
               vRec.MarketID = moUtil.FetchLong(.Fields.Item("MarketID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.MarketName = moUtil.FetchString(.Fields.Item("MarketName").Value)
               vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Target = moUtil.FetchString(.Fields.Item("Target").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
               vRec.SendDays = moUtil.FetchLong(.Fields.Item("SendDays").Value)
               vRec.Consumers = moUtil.FetchLong(.Fields.Item("Consumers").Value)
               vRec.Merchants = moUtil.FetchLong(.Fields.Item("Merchants").Value)
               vRec.Orgs = moUtil.FetchLong(.Fields.Item("Orgs").Value)
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

Public Function ListMarket( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSendDate As Date) As tMarketType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMarket"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMarketType
   Dim vRec As tMarketType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0, 1) 
      bvSendDate = moUtil.EditDate(bvSendDate, "SendDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamInput, vbNull, CDate(bvSendDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Market_ListMarket")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MarketID = moUtil.FetchLong(.Fields.Item("MarketID").Value)
            vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
            vRec.MarketName = moUtil.FetchString(.Fields.Item("MarketName").Value)
            vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Target = moUtil.FetchString(.Fields.Item("Target").Value)
            vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
            vRec.SendDays = moUtil.FetchLong(.Fields.Item("SendDays").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMarket = vRecs

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
   ByRef brRec As tMarketType, _ 
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
      .Parameters.Append .CreateParameter("@MarketID", adInteger, adParamInput, vbNull, CLng(brRec.MarketID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@MarketName", adVarWChar, adParamInput, 80, brRec.MarketName)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamInput, 60, brRec.FromEmail)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, brRec.Target)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamInput, vbNull, CDate(brRec.SendDate))
      .Parameters.Append .CreateParameter("@SendDays", adInteger, adParamInput, vbNull, CLng(brRec.SendDays))
      .Parameters.Append .CreateParameter("@Consumers", adInteger, adParamInput, vbNull, CLng(brRec.Consumers))
      .Parameters.Append .CreateParameter("@Merchants", adInteger, adParamInput, vbNull, CLng(brRec.Merchants))
      .Parameters.Append .CreateParameter("@Orgs", adInteger, adParamInput, vbNull, CLng(brRec.Orgs))
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamInput, 80, brRec.TestEmail)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Market_Update"

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
   ByRef brRec As tMarketType, _ 
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
         .MarketID = moUtil.EditLong(.MarketID, "MarketID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", True) 
      .MarketName = moUtil.EditString(.MarketName, "MarketName", True, , 1, 80) 
      .FromEmail = moUtil.EditString(.FromEmail, "FromEmail", True, , 1, 60) 
      .Subject = moUtil.EditString(.Subject, "Subject", True, , 1, 80) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Target = moUtil.EditString(.Target, "Target", False, , 1, 200) 
      .CreateDate = moUtil.EditDate(.CreateDate, "CreateDate", False) 
      .SendDate = moUtil.EditDate(.SendDate, "SendDate", False) 
      .SendDays = moUtil.EditLong(.SendDays, "SendDays", False) 
      .Consumers = moUtil.EditLong(.Consumers, "Consumers", False) 
      .Merchants = moUtil.EditLong(.Merchants, "Merchants", False) 
      .Orgs = moUtil.EditLong(.Orgs, "Orgs", False) 
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