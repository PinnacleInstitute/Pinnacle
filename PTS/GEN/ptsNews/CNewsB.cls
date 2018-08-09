VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CNewsB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CNews"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tNewsType
   NewsID As String
   CompanyID As String
   AuthUserID As String
   NewsTopicID As String
   NameLast As String
   NameFirst As String
   UserName As String
   NewsTopicName As String
   Title As String
   Description As String
   CreateDate As String
   ActiveDate As String
   Image As String
   Tags As String
   Status As String
   Seq As String
   LeadMain As String
   LeadTopic As String
   IsBreaking As String
   IsBreaking2 As String
   IsStrategic As String
   IsShare As String
   IsEditorial As String
   UserRole As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tNewsType, _ 
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
      .Parameters.Append .CreateParameter("@NewsID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@NewsTopicID", adInteger, adParamInput, vbNull, CLng(brRec.NewsTopicID))
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 150, brRec.Title)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamInput, vbNull, CDate(brRec.ActiveDate))
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 80, brRec.Image)
      .Parameters.Append .CreateParameter("@Tags", adVarWChar, adParamInput, 80, brRec.Tags)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@LeadMain", adInteger, adParamInput, vbNull, CLng(brRec.LeadMain))
      .Parameters.Append .CreateParameter("@LeadTopic", adInteger, adParamInput, vbNull, CLng(brRec.LeadTopic))
      .Parameters.Append .CreateParameter("@IsBreaking", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBreaking))
      .Parameters.Append .CreateParameter("@IsBreaking2", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBreaking2))
      .Parameters.Append .CreateParameter("@IsStrategic", adSmallInt, adParamInput, vbNull, CInt(brRec.IsStrategic))
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShare))
      .Parameters.Append .CreateParameter("@IsEditorial", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEditorial))
      .Parameters.Append .CreateParameter("@UserRole", adInteger, adParamInput, vbNull, CLng(brRec.UserRole))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_Add"

   '-----get return values
   With brRec
      .NewsID = moUtil.FetchLong(oCmd.Parameters.Item("@NewsID").Value)
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

Public Function Avatar( _ 
   ByRef brRec As tNewsType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Avatar"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 80, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_Avatar"

   '-----get return values
   Avatar = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_Count"

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
   ByRef brRec As tNewsType, _ 
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
      .NewsID = moUtil.EditLong(.NewsID, "NewsID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NewsID", adInteger, adParamInput, vbNull, CLng(brRec.NewsID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_Delete"

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
   ByRef brRec As tNewsType, _ 
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
      .NewsID = moUtil.EditLong(.NewsID, "NewsID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NewsID", adInteger, adParamInput, vbNull, CLng(brRec.NewsID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewsTopicID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@UserName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@NewsTopicName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamOutput, 150, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Tags", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadMain", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadTopic", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsBreaking", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsBreaking2", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsStrategic", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsEditorial", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserRole", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .NewsTopicID = moUtil.FetchLong(oCmd.Parameters.Item("@NewsTopicID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .UserName = moUtil.FetchString(oCmd.Parameters.Item("@UserName").Value)
      .NewsTopicName = moUtil.FetchString(oCmd.Parameters.Item("@NewsTopicName").Value)
      .Title = moUtil.FetchString(oCmd.Parameters.Item("@Title").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .CreateDate = moUtil.FetchDate(oCmd.Parameters.Item("@CreateDate").Value)
      .ActiveDate = moUtil.FetchDate(oCmd.Parameters.Item("@ActiveDate").Value)
      .Image = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)
      .Tags = moUtil.FetchString(oCmd.Parameters.Item("@Tags").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .LeadMain = moUtil.FetchLong(oCmd.Parameters.Item("@LeadMain").Value)
      .LeadTopic = moUtil.FetchLong(oCmd.Parameters.Item("@LeadTopic").Value)
      .IsBreaking = moUtil.FetchInteger(oCmd.Parameters.Item("@IsBreaking").Value)
      .IsBreaking2 = moUtil.FetchInteger(oCmd.Parameters.Item("@IsBreaking2").Value)
      .IsStrategic = moUtil.FetchInteger(oCmd.Parameters.Item("@IsStrategic").Value)
      .IsShare = moUtil.FetchInteger(oCmd.Parameters.Item("@IsShare").Value)
      .IsEditorial = moUtil.FetchInteger(oCmd.Parameters.Item("@IsEditorial").Value)
      .UserRole = moUtil.FetchLong(oCmd.Parameters.Item("@UserRole").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tNewsType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNewsType
   Dim vRec As tNewsType
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
      Case cptsNewsFindActiveDate
         sProc = "pts_News_FindActiveDate"
         MaxBookMark = 30
      Case cptsNewsFindTitle
         sProc = "pts_News_FindTitle"
         MaxBookMark = 160
      Case cptsNewsFindDescription
         sProc = "pts_News_FindDescription"
         MaxBookMark = 1010
      Case cptsNewsFindTags
         sProc = "pts_News_FindTags"
         MaxBookMark = 90
      Case cptsNewsFindStatus
         sProc = "pts_News_FindStatus"
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
               vRec.NewsID = moUtil.FetchLong(.Fields.Item("NewsID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.NewsTopicID = moUtil.FetchLong(.Fields.Item("NewsTopicID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
               vRec.NewsTopicName = moUtil.FetchString(.Fields.Item("NewsTopicName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Tags = moUtil.FetchString(.Fields.Item("Tags").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.LeadMain = moUtil.FetchLong(.Fields.Item("LeadMain").Value)
               vRec.LeadTopic = moUtil.FetchLong(.Fields.Item("LeadTopic").Value)
               vRec.IsBreaking = moUtil.FetchInteger(.Fields.Item("IsBreaking").Value)
               vRec.IsBreaking2 = moUtil.FetchInteger(.Fields.Item("IsBreaking2").Value)
               vRec.IsStrategic = moUtil.FetchInteger(.Fields.Item("IsStrategic").Value)
               vRec.IsShare = moUtil.FetchInteger(.Fields.Item("IsShare").Value)
               vRec.IsEditorial = moUtil.FetchInteger(.Fields.Item("IsEditorial").Value)
               vRec.UserRole = moUtil.FetchLong(.Fields.Item("UserRole").Value)
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

Public Function FindTopic( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvNewsTopicID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tNewsType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindTopic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNewsType
   Dim vRec As tNewsType
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
      Case cptsNewsFindActiveDate
         sProc = "pts_News_FindTopicActiveDate"
         MaxBookMark = 30
      Case cptsNewsFindTitle
         sProc = "pts_News_FindTopicTitle"
         MaxBookMark = 160
      Case cptsNewsFindDescription
         sProc = "pts_News_FindTopicDescription"
         MaxBookMark = 1010
      Case cptsNewsFindTags
         sProc = "pts_News_FindTopicTags"
         MaxBookMark = 90
      Case cptsNewsFindStatus
         sProc = "pts_News_FindTopicStatus"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@NewsTopicID", adInteger, adParamInput, vbNull, CLng(bvNewsTopicID))
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
               vRec.NewsID = moUtil.FetchLong(.Fields.Item("NewsID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.NewsTopicID = moUtil.FetchLong(.Fields.Item("NewsTopicID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
               vRec.NewsTopicName = moUtil.FetchString(.Fields.Item("NewsTopicName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Tags = moUtil.FetchString(.Fields.Item("Tags").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.LeadMain = moUtil.FetchLong(.Fields.Item("LeadMain").Value)
               vRec.LeadTopic = moUtil.FetchLong(.Fields.Item("LeadTopic").Value)
               vRec.IsBreaking = moUtil.FetchInteger(.Fields.Item("IsBreaking").Value)
               vRec.IsBreaking2 = moUtil.FetchInteger(.Fields.Item("IsBreaking2").Value)
               vRec.IsStrategic = moUtil.FetchInteger(.Fields.Item("IsStrategic").Value)
               vRec.IsShare = moUtil.FetchInteger(.Fields.Item("IsShare").Value)
               vRec.IsEditorial = moUtil.FetchInteger(.Fields.Item("IsEditorial").Value)
               vRec.UserRole = moUtil.FetchLong(.Fields.Item("UserRole").Value)
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
   FindTopic = vRecs

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

Public Function Search( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNewsType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Search"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNewsType
   Dim vRec As tNewsType
   Dim idxRec As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, 200, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 14, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_Search")

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
               vRec.NewsID = moUtil.FetchLong(.Fields.Item("NewsID").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Tags = moUtil.FetchString(.Fields.Item("Tags").Value)
               vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.LeadMain = moUtil.FetchLong(.Fields.Item("LeadMain").Value)
               vRec.LeadTopic = moUtil.FetchLong(.Fields.Item("LeadTopic").Value)
               vRec.IsBreaking = moUtil.FetchInteger(.Fields.Item("IsBreaking").Value)
               vRec.IsBreaking2 = moUtil.FetchInteger(.Fields.Item("IsBreaking2").Value)
               vRec.IsStrategic = moUtil.FetchInteger(.Fields.Item("IsStrategic").Value)
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
   Set oBookMark = Nothing

   '-----return the results
   Search = vRecs

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

Public Function ListNews( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvNewsTopicID As Long) As tNewsType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNews"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNewsType
   Dim vRec As tNewsType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@NewsTopicID", adInteger, adParamInput, vbNull, CLng(bvNewsTopicID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_ListNews")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NewsID = moUtil.FetchLong(.Fields.Item("NewsID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.NewsTopicName = moUtil.FetchString(.Fields.Item("NewsTopicName").Value)
            vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
            vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.Tags = moUtil.FetchString(.Fields.Item("Tags").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.LeadMain = moUtil.FetchLong(.Fields.Item("LeadMain").Value)
            vRec.LeadTopic = moUtil.FetchLong(.Fields.Item("LeadTopic").Value)
            vRec.IsBreaking = moUtil.FetchInteger(.Fields.Item("IsBreaking").Value)
            vRec.IsBreaking2 = moUtil.FetchInteger(.Fields.Item("IsBreaking2").Value)
            vRec.IsStrategic = moUtil.FetchInteger(.Fields.Item("IsStrategic").Value)
            vRec.UserRole = moUtil.FetchLong(.Fields.Item("UserRole").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNews = vRecs

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

Public Function ListShare( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNewsType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListShare"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNewsType
   Dim vRec As tNewsType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_ListShare")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NewsID = moUtil.FetchLong(.Fields.Item("NewsID").Value)
            vRec.NewsTopicName = moUtil.FetchString(.Fields.Item("NewsTopicName").Value)
            vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListShare = vRecs

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
   ByRef brRec As tNewsType, _ 
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
      .Parameters.Append .CreateParameter("@NewsID", adInteger, adParamInput, vbNull, CLng(brRec.NewsID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@NewsTopicID", adInteger, adParamInput, vbNull, CLng(brRec.NewsTopicID))
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 150, brRec.Title)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamInput, vbNull, CDate(brRec.ActiveDate))
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 80, brRec.Image)
      .Parameters.Append .CreateParameter("@Tags", adVarWChar, adParamInput, 80, brRec.Tags)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@LeadMain", adInteger, adParamInput, vbNull, CLng(brRec.LeadMain))
      .Parameters.Append .CreateParameter("@LeadTopic", adInteger, adParamInput, vbNull, CLng(brRec.LeadTopic))
      .Parameters.Append .CreateParameter("@IsBreaking", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBreaking))
      .Parameters.Append .CreateParameter("@IsBreaking2", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBreaking2))
      .Parameters.Append .CreateParameter("@IsStrategic", adSmallInt, adParamInput, vbNull, CInt(brRec.IsStrategic))
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShare))
      .Parameters.Append .CreateParameter("@IsEditorial", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEditorial))
      .Parameters.Append .CreateParameter("@UserRole", adInteger, adParamInput, vbNull, CLng(brRec.UserRole))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_News_Update"

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
   ByRef brRec As tNewsType, _ 
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
         .NewsID = moUtil.EditLong(.NewsID, "NewsID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .NewsTopicID = moUtil.EditLong(.NewsTopicID, "NewsTopicID", False) 
      .Title = moUtil.EditString(.Title, "Title", True, , 1, 150) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 1000) 
      .CreateDate = moUtil.EditDate(.CreateDate, "CreateDate", False) 
      .ActiveDate = moUtil.EditDate(.ActiveDate, "ActiveDate", False) 
      .Image = moUtil.EditString(.Image, "Image", False, , 1, 80) 
      .Tags = moUtil.EditString(.Tags, "Tags", False, , 1, 80) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False, , 1) 
      .LeadMain = moUtil.EditLong(.LeadMain, "LeadMain", False) 
      .LeadTopic = moUtil.EditLong(.LeadTopic, "LeadTopic", False) 
      .IsBreaking = moUtil.EditInteger(.IsBreaking, "IsBreaking", False, 0, 0, 1) 
      .IsBreaking2 = moUtil.EditInteger(.IsBreaking2, "IsBreaking2", False, 0, 0, 1) 
      .IsStrategic = moUtil.EditInteger(.IsStrategic, "IsStrategic", False, 0, 0, 1) 
      .IsShare = moUtil.EditInteger(.IsShare, "IsShare", False, 0, 0, 1) 
      .IsEditorial = moUtil.EditInteger(.IsEditorial, "IsEditorial", False, 0, 0, 1) 
      .UserRole = moUtil.EditLong(.UserRole, "UserRole", False) 
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