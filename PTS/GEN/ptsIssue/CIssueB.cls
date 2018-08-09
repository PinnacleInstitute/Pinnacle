VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CIssueB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CIssue"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tIssueType
   IssueID As String
   CompanyID As String
   IssueCategoryID As String
   SubmitID As String
   IssueCategoryName As String
   InputOptions As String
   IssueDate As String
   IssueName As String
   SubmittedBy As String
   SubmitType As String
   Priority As String
   Description As String
   AssignedTo As String
   Status As String
   Notes As String
   ChangeDate As String
   DueDate As String
   DoneDate As String
   Variance As String
   InputValues As String
   Rating As String
   Outsource As String
   Quantity As String
   ReportFromDate As String
   ReportToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tIssueType, _ 
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
      .Parameters.Append .CreateParameter("@IssueID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@IssueCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.IssueCategoryID))
      .Parameters.Append .CreateParameter("@SubmitID", adInteger, adParamInput, vbNull, CLng(brRec.SubmitID))
      .Parameters.Append .CreateParameter("@IssueDate", adDate, adParamInput, vbNull, CDate(brRec.IssueDate))
      .Parameters.Append .CreateParameter("@IssueName", adVarWChar, adParamInput, 60, brRec.IssueName)
      .Parameters.Append .CreateParameter("@SubmittedBy", adVarWChar, adParamInput, 40, brRec.SubmittedBy)
      .Parameters.Append .CreateParameter("@SubmitType", adInteger, adParamInput, vbNull, CLng(brRec.SubmitType))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(brRec.Priority))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, brRec.AssignedTo)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 2000, brRec.Notes)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@DueDate", adDate, adParamInput, vbNull, CDate(brRec.DueDate))
      .Parameters.Append .CreateParameter("@DoneDate", adDate, adParamInput, vbNull, CDate(brRec.DoneDate))
      .Parameters.Append .CreateParameter("@Variance", adInteger, adParamInput, vbNull, CLng(brRec.Variance))
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 500, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@Outsource", adVarWChar, adParamInput, 20, brRec.Outsource)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_Add"

   '-----get return values
   With brRec
      .IssueID = moUtil.FetchLong(oCmd.Parameters.Item("@IssueID").Value)
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_Count"

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
   ByRef brRec As tIssueType, _ 
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
      .IssueID = moUtil.EditLong(.IssueID, "IssueID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@IssueID", adInteger, adParamInput, vbNull, CLng(brRec.IssueID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_Delete"

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
   ByRef brRec As tIssueType, _ 
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
      .IssueID = moUtil.EditLong(.IssueID, "IssueID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@IssueID", adInteger, adParamInput, vbNull, CLng(brRec.IssueID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IssueCategoryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SubmitID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IssueCategoryName", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@IssueDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IssueName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@SubmittedBy", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@SubmitType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DueDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DoneDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Variance", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Outsource", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .IssueCategoryID = moUtil.FetchLong(oCmd.Parameters.Item("@IssueCategoryID").Value)
      .SubmitID = moUtil.FetchLong(oCmd.Parameters.Item("@SubmitID").Value)
      .IssueCategoryName = moUtil.FetchString(oCmd.Parameters.Item("@IssueCategoryName").Value)
      .InputOptions = moUtil.FetchString(oCmd.Parameters.Item("@InputOptions").Value)
      .IssueDate = moUtil.FetchDate(oCmd.Parameters.Item("@IssueDate").Value)
      .IssueName = moUtil.FetchString(oCmd.Parameters.Item("@IssueName").Value)
      .SubmittedBy = moUtil.FetchString(oCmd.Parameters.Item("@SubmittedBy").Value)
      .SubmitType = moUtil.FetchLong(oCmd.Parameters.Item("@SubmitType").Value)
      .Priority = moUtil.FetchLong(oCmd.Parameters.Item("@Priority").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .AssignedTo = moUtil.FetchString(oCmd.Parameters.Item("@AssignedTo").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
      .ChangeDate = moUtil.FetchDate(oCmd.Parameters.Item("@ChangeDate").Value)
      .DueDate = moUtil.FetchDate(oCmd.Parameters.Item("@DueDate").Value)
      .DoneDate = moUtil.FetchDate(oCmd.Parameters.Item("@DoneDate").Value)
      .Variance = moUtil.FetchLong(oCmd.Parameters.Item("@Variance").Value)
      .InputValues = moUtil.FetchString(oCmd.Parameters.Item("@InputValues").Value)
      .Rating = moUtil.FetchLong(oCmd.Parameters.Item("@Rating").Value)
      .Outsource = moUtil.FetchString(oCmd.Parameters.Item("@Outsource").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
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
      Case cptsIssueFindIssueCategoryName
         sProc = "pts_Issue_FindIssueCategoryName"
         MaxBookMark = 30
      Case cptsIssueFindIssueName
         sProc = "pts_Issue_FindIssueName"
         MaxBookMark = 70
      Case cptsIssueFindIssueID
         sProc = "pts_Issue_FindIssueID"
         MaxBookMark = 20
      Case cptsIssueFindSubmittedBy
         sProc = "pts_Issue_FindSubmittedBy"
         MaxBookMark = 50
      Case cptsIssueFindAssignedTo
         sProc = "pts_Issue_FindAssignedTo"
         MaxBookMark = 25
      Case cptsIssueFindOutsource
         sProc = "pts_Issue_FindOutsource"
         MaxBookMark = 30
      Case cptsIssueFindIssueDate
         sProc = "pts_Issue_FindIssueDate"
         MaxBookMark = 30
      Case cptsIssueFindDueDate
         sProc = "pts_Issue_FindDueDate"
         MaxBookMark = 30
      Case cptsIssueFindDoneDate
         sProc = "pts_Issue_FindDoneDate"
         MaxBookMark = 30
      Case cptsIssueFindPriority
         sProc = "pts_Issue_FindPriority"
         MaxBookMark = 20
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
               vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("IssueCategoryID").Value)
               vRec.SubmitID = moUtil.FetchLong(.Fields.Item("SubmitID").Value)
               vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
               vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
               vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
               vRec.SubmitType = moUtil.FetchLong(.Fields.Item("SubmitType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
               vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
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
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
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
      Case cptsIssueFindIssueCategoryName
         sProc = "pts_Issue_FindStatusIssueCategoryName"
         MaxBookMark = 30
      Case cptsIssueFindIssueName
         sProc = "pts_Issue_FindStatusIssueName"
         MaxBookMark = 70
      Case cptsIssueFindIssueID
         sProc = "pts_Issue_FindStatusIssueID"
         MaxBookMark = 20
      Case cptsIssueFindSubmittedBy
         sProc = "pts_Issue_FindStatusSubmittedBy"
         MaxBookMark = 50
      Case cptsIssueFindAssignedTo
         sProc = "pts_Issue_FindStatusAssignedTo"
         MaxBookMark = 25
      Case cptsIssueFindOutsource
         sProc = "pts_Issue_FindStatusOutsource"
         MaxBookMark = 30
      Case cptsIssueFindIssueDate
         sProc = "pts_Issue_FindStatusIssueDate"
         MaxBookMark = 30
      Case cptsIssueFindDueDate
         sProc = "pts_Issue_FindStatusDueDate"
         MaxBookMark = 30
      Case cptsIssueFindDoneDate
         sProc = "pts_Issue_FindStatusDoneDate"
         MaxBookMark = 30
      Case cptsIssueFindPriority
         sProc = "pts_Issue_FindStatusPriority"
         MaxBookMark = 20
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
               vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("IssueCategoryID").Value)
               vRec.SubmitID = moUtil.FetchLong(.Fields.Item("SubmitID").Value)
               vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
               vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
               vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
               vRec.SubmitType = moUtil.FetchLong(.Fields.Item("SubmitType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
               vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
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

Public Function FindAssigned( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvAssignedTo As String, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
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
      Case cptsIssueFindIssueCategoryName
         sProc = "pts_Issue_FindAssignedIssueCategoryName"
         MaxBookMark = 30
      Case cptsIssueFindIssueName
         sProc = "pts_Issue_FindAssignedIssueName"
         MaxBookMark = 70
      Case cptsIssueFindIssueID
         sProc = "pts_Issue_FindAssignedIssueID"
         MaxBookMark = 20
      Case cptsIssueFindSubmittedBy
         sProc = "pts_Issue_FindAssignedSubmittedBy"
         MaxBookMark = 50
      Case cptsIssueFindAssignedTo
         sProc = "pts_Issue_FindAssignedAssignedTo"
         MaxBookMark = 25
      Case cptsIssueFindOutsource
         sProc = "pts_Issue_FindAssignedOutsource"
         MaxBookMark = 30
      Case cptsIssueFindIssueDate
         sProc = "pts_Issue_FindAssignedIssueDate"
         MaxBookMark = 30
      Case cptsIssueFindDueDate
         sProc = "pts_Issue_FindAssignedDueDate"
         MaxBookMark = 30
      Case cptsIssueFindDoneDate
         sProc = "pts_Issue_FindAssignedDoneDate"
         MaxBookMark = 30
      Case cptsIssueFindPriority
         sProc = "pts_Issue_FindAssignedPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, bvAssignedTo)
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
               vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("IssueCategoryID").Value)
               vRec.SubmitID = moUtil.FetchLong(.Fields.Item("SubmitID").Value)
               vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
               vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
               vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
               vRec.SubmitType = moUtil.FetchLong(.Fields.Item("SubmitType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
               vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
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
   FindAssigned = vRecs

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

Public Function FindAssignedStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvAssignedTo As String, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssignedStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
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
      Case cptsIssueFindIssueCategoryName
         sProc = "pts_Issue_FindAssignedStatusIssueCategoryName"
         MaxBookMark = 30
      Case cptsIssueFindIssueName
         sProc = "pts_Issue_FindAssignedStatusIssueName"
         MaxBookMark = 70
      Case cptsIssueFindIssueID
         sProc = "pts_Issue_FindAssignedStatusIssueID"
         MaxBookMark = 20
      Case cptsIssueFindSubmittedBy
         sProc = "pts_Issue_FindAssignedStatusSubmittedBy"
         MaxBookMark = 50
      Case cptsIssueFindAssignedTo
         sProc = "pts_Issue_FindAssignedStatusAssignedTo"
         MaxBookMark = 25
      Case cptsIssueFindOutsource
         sProc = "pts_Issue_FindAssignedStatusOutsource"
         MaxBookMark = 30
      Case cptsIssueFindIssueDate
         sProc = "pts_Issue_FindAssignedStatusIssueDate"
         MaxBookMark = 30
      Case cptsIssueFindDueDate
         sProc = "pts_Issue_FindAssignedStatusDueDate"
         MaxBookMark = 30
      Case cptsIssueFindDoneDate
         sProc = "pts_Issue_FindAssignedStatusDoneDate"
         MaxBookMark = 30
      Case cptsIssueFindPriority
         sProc = "pts_Issue_FindAssignedStatusPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, bvAssignedTo)
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
               vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("IssueCategoryID").Value)
               vRec.SubmitID = moUtil.FetchLong(.Fields.Item("SubmitID").Value)
               vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
               vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
               vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
               vRec.SubmitType = moUtil.FetchLong(.Fields.Item("SubmitType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
               vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
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
   FindAssignedStatus = vRecs

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

Public Function FindSubmit( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSubmitType As Long, _ 
   ByVal bvSubmitID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSubmit"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
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
      Case cptsIssueFindIssueCategoryName
         sProc = "pts_Issue_FindSubmitIssueCategoryName"
         MaxBookMark = 30
      Case cptsIssueFindIssueName
         sProc = "pts_Issue_FindSubmitIssueName"
         MaxBookMark = 70
      Case cptsIssueFindIssueID
         sProc = "pts_Issue_FindSubmitIssueID"
         MaxBookMark = 20
      Case cptsIssueFindSubmittedBy
         sProc = "pts_Issue_FindSubmitSubmittedBy"
         MaxBookMark = 50
      Case cptsIssueFindAssignedTo
         sProc = "pts_Issue_FindSubmitAssignedTo"
         MaxBookMark = 25
      Case cptsIssueFindOutsource
         sProc = "pts_Issue_FindSubmitOutsource"
         MaxBookMark = 30
      Case cptsIssueFindIssueDate
         sProc = "pts_Issue_FindSubmitIssueDate"
         MaxBookMark = 30
      Case cptsIssueFindDueDate
         sProc = "pts_Issue_FindSubmitDueDate"
         MaxBookMark = 30
      Case cptsIssueFindDoneDate
         sProc = "pts_Issue_FindSubmitDoneDate"
         MaxBookMark = 30
      Case cptsIssueFindPriority
         sProc = "pts_Issue_FindSubmitPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@SubmitType", adInteger, adParamInput, vbNull, CLng(bvSubmitType))
      .Parameters.Append .CreateParameter("@SubmitID", adInteger, adParamInput, vbNull, CLng(bvSubmitID))
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
               vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("IssueCategoryID").Value)
               vRec.SubmitID = moUtil.FetchLong(.Fields.Item("SubmitID").Value)
               vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
               vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
               vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
               vRec.SubmitType = moUtil.FetchLong(.Fields.Item("SubmitType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
               vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
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
   FindSubmit = vRecs

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

Public Function FindSubmitStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSubmitType As Long, _ 
   ByVal bvSubmitID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSubmitStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
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
      Case cptsIssueFindIssueCategoryName
         sProc = "pts_Issue_FindSubmitStatusIssueCategoryName"
         MaxBookMark = 30
      Case cptsIssueFindIssueName
         sProc = "pts_Issue_FindSubmitStatusIssueName"
         MaxBookMark = 70
      Case cptsIssueFindIssueID
         sProc = "pts_Issue_FindSubmitStatusIssueID"
         MaxBookMark = 20
      Case cptsIssueFindSubmittedBy
         sProc = "pts_Issue_FindSubmitStatusSubmittedBy"
         MaxBookMark = 50
      Case cptsIssueFindAssignedTo
         sProc = "pts_Issue_FindSubmitStatusAssignedTo"
         MaxBookMark = 25
      Case cptsIssueFindOutsource
         sProc = "pts_Issue_FindSubmitStatusOutsource"
         MaxBookMark = 30
      Case cptsIssueFindIssueDate
         sProc = "pts_Issue_FindSubmitStatusIssueDate"
         MaxBookMark = 30
      Case cptsIssueFindDueDate
         sProc = "pts_Issue_FindSubmitStatusDueDate"
         MaxBookMark = 30
      Case cptsIssueFindDoneDate
         sProc = "pts_Issue_FindSubmitStatusDoneDate"
         MaxBookMark = 30
      Case cptsIssueFindPriority
         sProc = "pts_Issue_FindSubmitStatusPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@SubmitType", adInteger, adParamInput, vbNull, CLng(bvSubmitType))
      .Parameters.Append .CreateParameter("@SubmitID", adInteger, adParamInput, vbNull, CLng(bvSubmitID))
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
               vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("IssueCategoryID").Value)
               vRec.SubmitID = moUtil.FetchLong(.Fields.Item("SubmitID").Value)
               vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
               vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
               vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
               vRec.SubmitType = moUtil.FetchLong(.Fields.Item("SubmitType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
               vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
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
   FindSubmitStatus = vRecs

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

Public Function ReportStatus( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportStatus = vRecs

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

Public Function ReportStatusAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, bvAssignedTo)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportStatusAssigned")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportStatusAssigned = vRecs

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

Public Function ReportStatusDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvStatus As Long) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportStatusDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportStatusDetail = vRecs

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

Public Function ReportStatusAssignedDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String, _ 
   ByVal bvStatus As Long) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatusAssignedDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, bvAssignedTo)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportStatusAssignedDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportStatusAssignedDetail = vRecs

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

Public Function ReportLate( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportLate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportLate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportLate = vRecs

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

Public Function ReportLateAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportLateAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, bvAssignedTo)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportLateAssigned")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportLateAssigned = vRecs

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

Public Function ReportRating( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportRating"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportRating")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportRating = vRecs

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

Public Function ReportRatingAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportRatingAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, bvAssignedTo)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportRatingAssigned")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportRatingAssigned = vRecs

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

Public Function ReportOutsource( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOutsource"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportOutsource")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportOutsource = vRecs

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

Public Function ReportOutsourceAssigned( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvAssignedTo As String) As tIssueType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOutsourceAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueType
   Dim vRec As tIssueType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, bvAssignedTo)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_ReportOutsourceAssigned")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueID = moUtil.FetchLong(.Fields.Item("IssueID").Value)
            vRec.IssueName = moUtil.FetchString(.Fields.Item("IssueName").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.SubmittedBy = moUtil.FetchString(.Fields.Item("SubmittedBy").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Outsource = moUtil.FetchString(.Fields.Item("Outsource").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.DueDate = moUtil.FetchDate(.Fields.Item("DueDate").Value)
            vRec.DoneDate = moUtil.FetchDate(.Fields.Item("DoneDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportOutsourceAssigned = vRecs

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
   ByRef brRec As tIssueType, _ 
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
      .Parameters.Append .CreateParameter("@IssueID", adInteger, adParamInput, vbNull, CLng(brRec.IssueID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@IssueCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.IssueCategoryID))
      .Parameters.Append .CreateParameter("@SubmitID", adInteger, adParamInput, vbNull, CLng(brRec.SubmitID))
      .Parameters.Append .CreateParameter("@IssueDate", adDate, adParamInput, vbNull, CDate(brRec.IssueDate))
      .Parameters.Append .CreateParameter("@IssueName", adVarWChar, adParamInput, 60, brRec.IssueName)
      .Parameters.Append .CreateParameter("@SubmittedBy", adVarWChar, adParamInput, 40, brRec.SubmittedBy)
      .Parameters.Append .CreateParameter("@SubmitType", adInteger, adParamInput, vbNull, CLng(brRec.SubmitType))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(brRec.Priority))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, brRec.AssignedTo)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 2000, brRec.Notes)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@DueDate", adDate, adParamInput, vbNull, CDate(brRec.DueDate))
      .Parameters.Append .CreateParameter("@DoneDate", adDate, adParamInput, vbNull, CDate(brRec.DoneDate))
      .Parameters.Append .CreateParameter("@Variance", adInteger, adParamInput, vbNull, CLng(brRec.Variance))
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 500, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@Outsource", adVarWChar, adParamInput, 20, brRec.Outsource)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Issue_Update"

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
   ByRef brRec As tIssueType, _ 
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
         .IssueID = moUtil.EditLong(.IssueID, "IssueID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .IssueCategoryID = moUtil.EditLong(.IssueCategoryID, "IssueCategoryID", False, , 1) 
      .SubmitID = moUtil.EditLong(.SubmitID, "SubmitID", False) 
      .IssueDate = moUtil.EditDate(.IssueDate, "IssueDate", False) 
      .IssueName = moUtil.EditString(.IssueName, "IssueName", True, , 1, 60) 
      .SubmittedBy = moUtil.EditString(.SubmittedBy, "SubmittedBy", False, , 1, 40) 
      .SubmitType = moUtil.EditLong(.SubmitType, "SubmitType", False) 
      .Priority = moUtil.EditLong(.Priority, "Priority", False) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 1000) 
      .AssignedTo = moUtil.EditString(.AssignedTo, "AssignedTo", False, , 1, 15) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 2000) 
      .ChangeDate = moUtil.EditDate(.ChangeDate, "ChangeDate", False) 
      .DueDate = moUtil.EditDate(.DueDate, "DueDate", False) 
      .DoneDate = moUtil.EditDate(.DoneDate, "DoneDate", False) 
      .Variance = moUtil.EditLong(.Variance, "Variance", False) 
      .InputValues = moUtil.EditString(.InputValues, "InputValues", False, , 1, 500) 
      .Rating = moUtil.EditLong(.Rating, "Rating", False) 
      .Outsource = moUtil.EditString(.Outsource, "Outsource", False, , 1, 20) 
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