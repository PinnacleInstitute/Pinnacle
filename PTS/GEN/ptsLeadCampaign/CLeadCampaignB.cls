VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CLeadCampaignB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CLeadCampaign"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tLeadCampaignType
   LeadCampaignID As String
   CompanyID As String
   SalesCampaignID As String
   ProspectTypeID As String
   CycleID As String
   NewsLetterID As String
   GroupID As String
   FolderID As String
   LeadCampaignName As String
   Status As String
   PageType As String
   Objective As String
   Title As String
   Description As String
   Keywords As String
   IsMember As String
   IsAffiliate As String
   Cycle As String
   CSS As String
   NoEdit As String
   Page As String
   Image As String
   Entity As String
   Seq As String
   GroupID1 As String
   GroupID2 As String
   GroupID3 As String
End Type

Public Sub Add( _ 
   ByRef brRec As tLeadCampaignType, _ 
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
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectTypeID))
      .Parameters.Append .CreateParameter("@CycleID", adInteger, adParamInput, vbNull, CLng(brRec.CycleID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(brRec.GroupID))
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@LeadCampaignName", adVarWChar, adParamInput, 60, brRec.LeadCampaignName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(brRec.PageType))
      .Parameters.Append .CreateParameter("@Objective", adVarWChar, adParamInput, 500, brRec.Objective)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 100, brRec.Title)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Keywords", adVarWChar, adParamInput, 500, brRec.Keywords)
      .Parameters.Append .CreateParameter("@IsMember", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMember))
      .Parameters.Append .CreateParameter("@IsAffiliate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAffiliate))
      .Parameters.Append .CreateParameter("@Cycle", adVarWChar, adParamInput, 1000, brRec.Cycle)
      .Parameters.Append .CreateParameter("@CSS", adVarWChar, adParamInput, 100, brRec.CSS)
      .Parameters.Append .CreateParameter("@NoEdit", adSmallInt, adParamInput, vbNull, CInt(brRec.NoEdit))
      .Parameters.Append .CreateParameter("@Page", adVarWChar, adParamInput, 25, brRec.Page)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 25, brRec.Image)
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(brRec.Entity))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_Add"

   '-----get return values
   With brRec
      .LeadCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@LeadCampaignID").Value)
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
   ByRef brRec As tLeadCampaignType, _ 
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
      .LeadCampaignID = moUtil.EditLong(.LeadCampaignID, "LeadCampaignID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_Delete"

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

Public Function EnumMemberList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvCycleID As Long, _ 
   ByVal bvSecurityToken As Long) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumMemberList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@CycleID", adInteger, adParamInput, vbNull, CLng(bvCycleID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_EnumMemberList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumMemberList = vRecs

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

Public Function EnumPresentList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvCycleID As Long, _ 
   ByVal bvSecurityToken As Long) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumPresentList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@CycleID", adInteger, adParamInput, vbNull, CLng(bvCycleID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_EnumPresentList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumPresentList = vRecs

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
   ByRef brRec As tLeadCampaignType, _ 
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
      .LeadCampaignID = moUtil.EditLong(.LeadCampaignID, "LeadCampaignID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CycleID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadCampaignName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Objective", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Keywords", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@IsMember", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsAffiliate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Cycle", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@CSS", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@NoEdit", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Page", adVarWChar, adParamOutput, 25, vbNull)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 25, vbNull)
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .SalesCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesCampaignID").Value)
      .ProspectTypeID = moUtil.FetchLong(oCmd.Parameters.Item("@ProspectTypeID").Value)
      .CycleID = moUtil.FetchLong(oCmd.Parameters.Item("@CycleID").Value)
      .NewsLetterID = moUtil.FetchLong(oCmd.Parameters.Item("@NewsLetterID").Value)
      .GroupID = moUtil.FetchLong(oCmd.Parameters.Item("@GroupID").Value)
      .FolderID = moUtil.FetchLong(oCmd.Parameters.Item("@FolderID").Value)
      .LeadCampaignName = moUtil.FetchString(oCmd.Parameters.Item("@LeadCampaignName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .PageType = moUtil.FetchLong(oCmd.Parameters.Item("@PageType").Value)
      .Objective = moUtil.FetchString(oCmd.Parameters.Item("@Objective").Value)
      .Title = moUtil.FetchString(oCmd.Parameters.Item("@Title").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Keywords = moUtil.FetchString(oCmd.Parameters.Item("@Keywords").Value)
      .IsMember = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMember").Value)
      .IsAffiliate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsAffiliate").Value)
      .Cycle = moUtil.FetchString(oCmd.Parameters.Item("@Cycle").Value)
      .CSS = moUtil.FetchString(oCmd.Parameters.Item("@CSS").Value)
      .NoEdit = moUtil.FetchInteger(oCmd.Parameters.Item("@NoEdit").Value)
      .Page = moUtil.FetchString(oCmd.Parameters.Item("@Page").Value)
      .Image = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)
      .Entity = moUtil.FetchLong(oCmd.Parameters.Item("@Entity").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsLeadCampaignFindSeq
         sProc = "pts_LeadCampaign_FindSeq"
         MaxBookMark = 20
      Case cptsLeadCampaignFindLeadCampaignName
         sProc = "pts_LeadCampaign_FindLeadCampaignName"
         MaxBookMark = 70
      Case cptsLeadCampaignFindLeadCampaignID
         sProc = "pts_LeadCampaign_FindLeadCampaignID"
         MaxBookMark = 20
      Case cptsLeadCampaignFindObjective
         sProc = "pts_LeadCampaign_FindObjective"
         MaxBookMark = 510
      Case cptsLeadCampaignFindStatus
         sProc = "pts_LeadCampaign_FindStatus"
         MaxBookMark = 20
      Case cptsLeadCampaignFindGroupID
         sProc = "pts_LeadCampaign_FindGroupID"
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
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.CycleID = moUtil.FetchLong(.Fields.Item("CycleID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.GroupID = moUtil.FetchLong(.Fields.Item("GroupID").Value)
               vRec.FolderID = moUtil.FetchLong(.Fields.Item("FolderID").Value)
               vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("LeadCampaignName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
               vRec.Objective = moUtil.FetchString(.Fields.Item("Objective").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Keywords = moUtil.FetchString(.Fields.Item("Keywords").Value)
               vRec.IsMember = moUtil.FetchInteger(.Fields.Item("IsMember").Value)
               vRec.IsAffiliate = moUtil.FetchInteger(.Fields.Item("IsAffiliate").Value)
               vRec.Cycle = moUtil.FetchString(.Fields.Item("Cycle").Value)
               vRec.CSS = moUtil.FetchString(.Fields.Item("CSS").Value)
               vRec.NoEdit = moUtil.FetchInteger(.Fields.Item("NoEdit").Value)
               vRec.Page = moUtil.FetchString(.Fields.Item("Page").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Entity = moUtil.FetchLong(.Fields.Item("Entity").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
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

Public Function ListMember( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvCycleID As Long) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@CycleID", adInteger, adParamInput, vbNull, CLng(bvCycleID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
            vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("LeadCampaignName").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
            vRec.Objective = moUtil.FetchString(.Fields.Item("Objective").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMember = vRecs

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

Public Function ListAffiliate( _ 
   ByVal bvCompanyID As Long) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAffiliate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_ListAffiliate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
            vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("LeadCampaignName").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
            vRec.Objective = moUtil.FetchString(.Fields.Item("Objective").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAffiliate = vRecs

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

Public Function ListAffiliateText( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvDescription As String) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAffiliateText"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvDescription = moUtil.EditString(bvDescription, "Description", True, "") 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, bvDescription)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_ListAffiliateText")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
            vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("LeadCampaignName").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
            vRec.Objective = moUtil.FetchString(.Fields.Item("Objective").Value)
            vRec.CycleID = moUtil.FetchLong(.Fields.Item("CycleID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAffiliateText = vRecs

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

Public Function ListPresent( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvCycleID As Long) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPresent"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@CycleID", adInteger, adParamInput, vbNull, CLng(bvCycleID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_ListPresent")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
            vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("LeadCampaignName").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
            vRec.Objective = moUtil.FetchString(.Fields.Item("Objective").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPresent = vRecs

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

Public Function ListGroup( _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvPageType As Long) As tLeadCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadCampaignType
   Dim vRec As tLeadCampaignType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_ListGroup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
            vRec.LeadCampaignName = moUtil.FetchString(.Fields.Item("LeadCampaignName").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
            vRec.Objective = moUtil.FetchString(.Fields.Item("Objective").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListGroup = vRecs

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
   ByRef brRec As tLeadCampaignType, _ 
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
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectTypeID))
      .Parameters.Append .CreateParameter("@CycleID", adInteger, adParamInput, vbNull, CLng(brRec.CycleID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(brRec.GroupID))
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@LeadCampaignName", adVarWChar, adParamInput, 60, brRec.LeadCampaignName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(brRec.PageType))
      .Parameters.Append .CreateParameter("@Objective", adVarWChar, adParamInput, 500, brRec.Objective)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 100, brRec.Title)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Keywords", adVarWChar, adParamInput, 500, brRec.Keywords)
      .Parameters.Append .CreateParameter("@IsMember", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMember))
      .Parameters.Append .CreateParameter("@IsAffiliate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAffiliate))
      .Parameters.Append .CreateParameter("@Cycle", adVarWChar, adParamInput, 1000, brRec.Cycle)
      .Parameters.Append .CreateParameter("@CSS", adVarWChar, adParamInput, 100, brRec.CSS)
      .Parameters.Append .CreateParameter("@NoEdit", adSmallInt, adParamInput, vbNull, CInt(brRec.NoEdit))
      .Parameters.Append .CreateParameter("@Page", adVarWChar, adParamInput, 25, brRec.Page)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 25, brRec.Image)
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(brRec.Entity))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadCampaign_Update"

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
   ByRef brRec As tLeadCampaignType, _ 
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
         .LeadCampaignID = moUtil.EditLong(.LeadCampaignID, "LeadCampaignID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True) 
      .SalesCampaignID = moUtil.EditLong(.SalesCampaignID, "SalesCampaignID", False) 
      .ProspectTypeID = moUtil.EditLong(.ProspectTypeID, "ProspectTypeID", False) 
      .CycleID = moUtil.EditLong(.CycleID, "CycleID", False) 
      .NewsLetterID = moUtil.EditLong(.NewsLetterID, "NewsLetterID", False) 
      .GroupID = moUtil.EditLong(.GroupID, "GroupID", False) 
      .FolderID = moUtil.EditLong(.FolderID, "FolderID", False) 
      .LeadCampaignName = moUtil.EditString(.LeadCampaignName, "LeadCampaignName", True, , 1, 60) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .PageType = moUtil.EditLong(.PageType, "PageType", False) 
      .Objective = moUtil.EditString(.Objective, "Objective", False) 
      .Title = moUtil.EditString(.Title, "Title", False) 
      .Description = moUtil.EditString(.Description, "Description", False) 
      .Keywords = moUtil.EditString(.Keywords, "Keywords", False) 
      .IsMember = moUtil.EditInteger(.IsMember, "IsMember", False, 0, 0, 1) 
      .IsAffiliate = moUtil.EditInteger(.IsAffiliate, "IsAffiliate", False, 0, 0, 1) 
      .Cycle = moUtil.EditString(.Cycle, "Cycle", False) 
      .CSS = moUtil.EditString(.CSS, "CSS", False) 
      .NoEdit = moUtil.EditInteger(.NoEdit, "NoEdit", False, 0, 0, 1) 
      .Page = moUtil.EditString(.Page, "Page", False, , 1, 25) 
      .Image = moUtil.EditString(.Image, "Image", False, , 1, 25) 
      .Entity = moUtil.EditLong(.Entity, "Entity", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
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