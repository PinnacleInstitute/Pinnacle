VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CLeadB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CLead"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tLeadType
   LeadID As String
   MemberID As String
   SalesCampaignID As String
   ProspectTypeID As String
   SalesCampaignName As String
   ProspectTypeName As String
   NameLast As String
   NameFirst As String
   LeadName As String
   LeadDate As String
   Email As String
   Phone1 As String
   Phone2 As String
   Street As String
   Unit As String
   City As String
   State As String
   Zip As String
   Country As String
   Comment As String
   Source As String
   Status As String
   Priority As String
   CallBackDate As String
   CallBackTime As String
   TimeZone As String
   BestTime As String
   DistributorID As String
   DistributeDate As String
   Code As String
End Type

Public Sub Add( _ 
   ByRef brRec As tLeadType, _ 
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
      .Parameters.Append .CreateParameter("@LeadID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectTypeID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@LeadDate", adDate, adParamInput, vbNull, CDate(brRec.LeadDate))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Comment", adVarWChar, adParamInput, 500, brRec.Comment)
      .Parameters.Append .CreateParameter("@Source", adVarWChar, adParamInput, 20, brRec.Source)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Priority", adVarWChar, adParamInput, 4, brRec.Priority)
      .Parameters.Append .CreateParameter("@CallBackDate", adDate, adParamInput, vbNull, CDate(brRec.CallBackDate))
      .Parameters.Append .CreateParameter("@CallBackTime", adVarWChar, adParamInput, 8, brRec.CallBackTime)
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamInput, vbNull, CLng(brRec.TimeZone))
      .Parameters.Append .CreateParameter("@BestTime", adInteger, adParamInput, vbNull, CLng(brRec.BestTime))
      .Parameters.Append .CreateParameter("@DistributorID", adInteger, adParamInput, vbNull, CLng(brRec.DistributorID))
      .Parameters.Append .CreateParameter("@DistributeDate", adDate, adParamInput, vbNull, CDate(brRec.DistributeDate))
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamInput, vbNull, CLng(brRec.Code))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lead_Add"

   '-----get return values
   With brRec
      .LeadID = moUtil.FetchLong(oCmd.Parameters.Item("@LeadID").Value)
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

Public Sub UpdateCode( _ 
   ByRef brRec As tLeadType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateCode"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .LeadID = moUtil.EditLong(.LeadID, "LeadID", True, 0, 1) 
      .Code = moUtil.EditLong(.Code, "Code", False, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadID", adInteger, adParamInput, vbNull, CLng(brRec.LeadID))
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamInput, vbNull, CLng(brRec.Code))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lead_UpdateCode"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lead_Count"

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
   ByRef brRec As tLeadType, _ 
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
      .LeadID = moUtil.EditLong(.LeadID, "LeadID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadID", adInteger, adParamInput, vbNull, CLng(brRec.LeadID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lead_Delete"

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
   ByRef brRec As tLeadType, _ 
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
      .LeadID = moUtil.EditLong(.LeadID, "LeadID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadID", adInteger, adParamInput, vbNull, CLng(brRec.LeadID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesCampaignName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@ProspectTypeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@LeadName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@LeadDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Comment", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Source", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Priority", adVarWChar, adParamOutput, 4, vbNull)
      .Parameters.Append .CreateParameter("@CallBackDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CallBackTime", adVarWChar, adParamOutput, 8, vbNull)
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BestTime", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DistributorID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DistributeDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lead_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .SalesCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesCampaignID").Value)
      .ProspectTypeID = moUtil.FetchLong(oCmd.Parameters.Item("@ProspectTypeID").Value)
      .SalesCampaignName = moUtil.FetchString(oCmd.Parameters.Item("@SalesCampaignName").Value)
      .ProspectTypeName = moUtil.FetchString(oCmd.Parameters.Item("@ProspectTypeName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .LeadName = moUtil.FetchString(oCmd.Parameters.Item("@LeadName").Value)
      .LeadDate = moUtil.FetchDate(oCmd.Parameters.Item("@LeadDate").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Phone1 = moUtil.FetchString(oCmd.Parameters.Item("@Phone1").Value)
      .Phone2 = moUtil.FetchString(oCmd.Parameters.Item("@Phone2").Value)
      .Street = moUtil.FetchString(oCmd.Parameters.Item("@Street").Value)
      .Unit = moUtil.FetchString(oCmd.Parameters.Item("@Unit").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Country = moUtil.FetchString(oCmd.Parameters.Item("@Country").Value)
      .Comment = moUtil.FetchString(oCmd.Parameters.Item("@Comment").Value)
      .Source = moUtil.FetchString(oCmd.Parameters.Item("@Source").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Priority = moUtil.FetchString(oCmd.Parameters.Item("@Priority").Value)
      .CallBackDate = moUtil.FetchDate(oCmd.Parameters.Item("@CallBackDate").Value)
      .CallBackTime = moUtil.FetchString(oCmd.Parameters.Item("@CallBackTime").Value)
      .TimeZone = moUtil.FetchLong(oCmd.Parameters.Item("@TimeZone").Value)
      .BestTime = moUtil.FetchLong(oCmd.Parameters.Item("@BestTime").Value)
      .DistributorID = moUtil.FetchLong(oCmd.Parameters.Item("@DistributorID").Value)
      .DistributeDate = moUtil.FetchDate(oCmd.Parameters.Item("@DistributeDate").Value)
      .Code = moUtil.FetchLong(oCmd.Parameters.Item("@Code").Value)
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
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_FindLeadName"
         MaxBookMark = 72
      Case cptsLeadFindPriority
         sProc = "pts_Lead_FindPriority"
         MaxBookMark = 14
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_FindLeadDate"
         MaxBookMark = 30
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_FindCallBackDate"
         MaxBookMark = 30
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_FindSalesCampaignName"
         MaxBookMark = 50
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_FindProspectTypeName"
         MaxBookMark = 50
      Case cptsLeadFindEmail
         sProc = "pts_Lead_FindEmail"
         MaxBookMark = 90
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_FindPhone1"
         MaxBookMark = 40
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_FindPhone2"
         MaxBookMark = 40
      Case cptsLeadFindSource
         sProc = "pts_Lead_FindSource"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.LeadName = moUtil.FetchString(.Fields.Item("LeadName").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Comment = moUtil.FetchString(.Fields.Item("Comment").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
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
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_FindStatusLeadName"
         MaxBookMark = 72
      Case cptsLeadFindPriority
         sProc = "pts_Lead_FindStatusPriority"
         MaxBookMark = 14
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_FindStatusLeadDate"
         MaxBookMark = 30
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_FindStatusCallBackDate"
         MaxBookMark = 30
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_FindStatusSalesCampaignName"
         MaxBookMark = 50
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_FindStatusProspectTypeName"
         MaxBookMark = 50
      Case cptsLeadFindEmail
         sProc = "pts_Lead_FindStatusEmail"
         MaxBookMark = 90
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_FindStatusPhone1"
         MaxBookMark = 40
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_FindStatusPhone2"
         MaxBookMark = 40
      Case cptsLeadFindSource
         sProc = "pts_Lead_FindStatusSource"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.LeadName = moUtil.FetchString(.Fields.Item("LeadName").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Comment = moUtil.FetchString(.Fields.Item("Comment").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
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

Public Function FindActive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_FindActiveLeadName"
         MaxBookMark = 72
      Case cptsLeadFindPriority
         sProc = "pts_Lead_FindActivePriority"
         MaxBookMark = 14
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_FindActiveLeadDate"
         MaxBookMark = 30
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_FindActiveCallBackDate"
         MaxBookMark = 30
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_FindActiveSalesCampaignName"
         MaxBookMark = 50
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_FindActiveProspectTypeName"
         MaxBookMark = 50
      Case cptsLeadFindEmail
         sProc = "pts_Lead_FindActiveEmail"
         MaxBookMark = 90
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_FindActivePhone1"
         MaxBookMark = 40
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_FindActivePhone2"
         MaxBookMark = 40
      Case cptsLeadFindSource
         sProc = "pts_Lead_FindActiveSource"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.LeadName = moUtil.FetchString(.Fields.Item("LeadName").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Comment = moUtil.FetchString(.Fields.Item("Comment").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
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
   FindActive = vRecs

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

Public Function FindLive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_FindLiveLeadName"
         MaxBookMark = 72
      Case cptsLeadFindPriority
         sProc = "pts_Lead_FindLivePriority"
         MaxBookMark = 14
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_FindLiveLeadDate"
         MaxBookMark = 30
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_FindLiveCallBackDate"
         MaxBookMark = 30
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_FindLiveSalesCampaignName"
         MaxBookMark = 50
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_FindLiveProspectTypeName"
         MaxBookMark = 50
      Case cptsLeadFindEmail
         sProc = "pts_Lead_FindLiveEmail"
         MaxBookMark = 90
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_FindLivePhone1"
         MaxBookMark = 40
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_FindLivePhone2"
         MaxBookMark = 40
      Case cptsLeadFindSource
         sProc = "pts_Lead_FindLiveSource"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.LeadName = moUtil.FetchString(.Fields.Item("LeadName").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Comment = moUtil.FetchString(.Fields.Item("Comment").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
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
   FindLive = vRecs

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

Public Function ExpMember( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_ExpMemberLeadName"
         MaxLen = 62
      Case cptsLeadFindPriority
         sProc = "pts_Lead_ExpMemberPriority"
         MaxLen = 4
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_ExpMemberLeadDate"
         MaxLen = 20
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_ExpMemberCallBackDate"
         MaxLen = 20
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_ExpMemberSalesCampaignName"
         MaxLen = 40
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_ExpMemberProspectTypeName"
         MaxLen = 40
      Case cptsLeadFindEmail
         sProc = "pts_Lead_ExpMemberEmail"
         MaxLen = 80
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_ExpMemberPhone1"
         MaxLen = 30
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_ExpMemberPhone2"
         MaxLen = 30
      Case cptsLeadFindSource
         sProc = "pts_Lead_ExpMemberSource"
         MaxLen = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpMember = vRecs

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

Public Function ExpStatus( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_ExpStatusLeadName"
         MaxLen = 62
      Case cptsLeadFindPriority
         sProc = "pts_Lead_ExpStatusPriority"
         MaxLen = 4
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_ExpStatusLeadDate"
         MaxLen = 20
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_ExpStatusCallBackDate"
         MaxLen = 20
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_ExpStatusSalesCampaignName"
         MaxLen = 40
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_ExpStatusProspectTypeName"
         MaxLen = 40
      Case cptsLeadFindEmail
         sProc = "pts_Lead_ExpStatusEmail"
         MaxLen = 80
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_ExpStatusPhone1"
         MaxLen = 30
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_ExpStatusPhone2"
         MaxLen = 30
      Case cptsLeadFindSource
         sProc = "pts_Lead_ExpStatusSource"
         MaxLen = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpStatus = vRecs

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

Public Function ExpActive( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_ExpActiveLeadName"
         MaxLen = 62
      Case cptsLeadFindPriority
         sProc = "pts_Lead_ExpActivePriority"
         MaxLen = 4
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_ExpActiveLeadDate"
         MaxLen = 20
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_ExpActiveCallBackDate"
         MaxLen = 20
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_ExpActiveSalesCampaignName"
         MaxLen = 40
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_ExpActiveProspectTypeName"
         MaxLen = 40
      Case cptsLeadFindEmail
         sProc = "pts_Lead_ExpActiveEmail"
         MaxLen = 80
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_ExpActivePhone1"
         MaxLen = 30
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_ExpActivePhone2"
         MaxLen = 30
      Case cptsLeadFindSource
         sProc = "pts_Lead_ExpActiveSource"
         MaxLen = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpActive = vRecs

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

Public Function ExpLive( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tLeadType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadType
   Dim vRec As tLeadType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadFindLeadName
         sProc = "pts_Lead_ExpLiveLeadName"
         MaxLen = 62
      Case cptsLeadFindPriority
         sProc = "pts_Lead_ExpLivePriority"
         MaxLen = 4
      Case cptsLeadFindLeadDate
         sProc = "pts_Lead_ExpLiveLeadDate"
         MaxLen = 20
      Case cptsLeadFindCallBackDate
         sProc = "pts_Lead_ExpLiveCallBackDate"
         MaxLen = 20
      Case cptsLeadFindSalesCampaignName
         sProc = "pts_Lead_ExpLiveSalesCampaignName"
         MaxLen = 40
      Case cptsLeadFindProspectTypeName
         sProc = "pts_Lead_ExpLiveProspectTypeName"
         MaxLen = 40
      Case cptsLeadFindEmail
         sProc = "pts_Lead_ExpLiveEmail"
         MaxLen = 80
      Case cptsLeadFindPhone1
         sProc = "pts_Lead_ExpLivePhone1"
         MaxLen = 30
      Case cptsLeadFindPhone2
         sProc = "pts_Lead_ExpLivePhone2"
         MaxLen = 30
      Case cptsLeadFindSource
         sProc = "pts_Lead_ExpLiveSource"
         MaxLen = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.LeadID = moUtil.FetchLong(.Fields.Item("LeadID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.LeadDate = moUtil.FetchDate(.Fields.Item("LeadDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.CallBackDate = moUtil.FetchDate(.Fields.Item("CallBackDate").Value)
               vRec.CallBackTime = moUtil.FetchString(.Fields.Item("CallBackTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpLive = vRecs

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
   ByRef brRec As tLeadType, _ 
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
      .Parameters.Append .CreateParameter("@LeadID", adInteger, adParamInput, vbNull, CLng(brRec.LeadID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectTypeID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@LeadDate", adDate, adParamInput, vbNull, CDate(brRec.LeadDate))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Comment", adVarWChar, adParamInput, 500, brRec.Comment)
      .Parameters.Append .CreateParameter("@Source", adVarWChar, adParamInput, 20, brRec.Source)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Priority", adVarWChar, adParamInput, 4, brRec.Priority)
      .Parameters.Append .CreateParameter("@CallBackDate", adDate, adParamInput, vbNull, CDate(brRec.CallBackDate))
      .Parameters.Append .CreateParameter("@CallBackTime", adVarWChar, adParamInput, 8, brRec.CallBackTime)
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamInput, vbNull, CLng(brRec.TimeZone))
      .Parameters.Append .CreateParameter("@BestTime", adInteger, adParamInput, vbNull, CLng(brRec.BestTime))
      .Parameters.Append .CreateParameter("@DistributorID", adInteger, adParamInput, vbNull, CLng(brRec.DistributorID))
      .Parameters.Append .CreateParameter("@DistributeDate", adDate, adParamInput, vbNull, CDate(brRec.DistributeDate))
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamInput, vbNull, CLng(brRec.Code))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lead_Update"

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
   ByRef brRec As tLeadType, _ 
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
         .LeadID = moUtil.EditLong(.LeadID, "LeadID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, , 1) 
      .SalesCampaignID = moUtil.EditLong(.SalesCampaignID, "SalesCampaignID", False) 
      .ProspectTypeID = moUtil.EditLong(.ProspectTypeID, "ProspectTypeID", False) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 30) 
      .LeadDate = moUtil.EditDate(.LeadDate, "LeadDate", False) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .Phone1 = moUtil.EditString(.Phone1, "Phone1", False, , 1, 30) 
      .Phone2 = moUtil.EditString(.Phone2, "Phone2", False, , 1, 30) 
      .Street = moUtil.EditString(.Street, "Street", False, , 1, 60) 
      .Unit = moUtil.EditString(.Unit, "Unit", False, , 1, 40) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .Country = moUtil.EditString(.Country, "Country", False, , 1, 30) 
      .Comment = moUtil.EditString(.Comment, "Comment", False, , 1, 500) 
      .Source = moUtil.EditString(.Source, "Source", False, , 1, 20) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Priority = moUtil.EditString(.Priority, "Priority", False) 
      .CallBackDate = moUtil.EditDate(.CallBackDate, "CallBackDate", False) 
      .CallBackTime = moUtil.EditString(.CallBackTime, "CallBackTime", False, , 1, 8) 
      .TimeZone = moUtil.EditLong(.TimeZone, "TimeZone", False) 
      .BestTime = moUtil.EditLong(.BestTime, "BestTime", False) 
      .DistributorID = moUtil.EditLong(.DistributorID, "DistributorID", False) 
      .DistributeDate = moUtil.EditDate(.DistributeDate, "DistributeDate", False) 
      .Code = moUtil.EditLong(.Code, "Code", False) 
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