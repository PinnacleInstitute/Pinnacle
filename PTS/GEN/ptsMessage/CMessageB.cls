VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMessageB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMessage"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMessageType
   MessageID As String
   ForumID As String
   ParentID As String
   ThreadID As String
   BoardUserID As String
   ModifyID As String
   ForumName As String
   BoardUserName As String
   Signature As String
   ModifyName As String
   MessageTitle As String
   Status As String
   IsSticky As String
   Body As String
   CreateDate As String
   ChangeDate As String
   ThreadOrder As String
   Replies As String
   PageSize As String
   Page As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMessageType, _ 
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
      .Parameters.Append .CreateParameter("@MessageID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(brRec.ForumID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@ThreadID", adInteger, adParamInput, vbNull, CLng(brRec.ThreadID))
      .Parameters.Append .CreateParameter("@BoardUserID", adInteger, adParamInput, vbNull, CLng(brRec.BoardUserID))
      .Parameters.Append .CreateParameter("@ModifyID", adInteger, adParamInput, vbNull, CLng(brRec.ModifyID))
      .Parameters.Append .CreateParameter("@MessageTitle", adVarWChar, adParamInput, 60, brRec.MessageTitle)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@IsSticky", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSticky))
      .Parameters.Append .CreateParameter("@Body", adVarWChar, adParamInput, 2000, brRec.Body)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@ThreadOrder", adInteger, adParamInput, vbNull, CLng(brRec.ThreadOrder))
      .Parameters.Append .CreateParameter("@Replies", adInteger, adParamInput, vbNull, CLng(brRec.Replies))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_Add"

   '-----get return values
   With brRec
      .MessageID = moUtil.FetchLong(oCmd.Parameters.Item("@MessageID").Value)
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

Public Function GetThreadPages( _ 
   ByRef brRec As tMessageType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetThreadPages"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ThreadID", adInteger, adParamInput, vbNull, CLng(brRec.ThreadID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@PageSize", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_GetThreadPages"

   '-----get return values
   GetThreadPages = moUtil.FetchLong(oCmd.Parameters.Item("@PageSize").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetLastPost( _ 
   ByRef brRec As tMessageType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetLastPost"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ThreadID", adInteger, adParamInput, vbNull, CLng(brRec.ThreadID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@MessageID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_GetLastPost"

   '-----get return values
   GetLastPost = moUtil.FetchLong(oCmd.Parameters.Item("@MessageID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetForumPages( _ 
   ByRef brRec As tMessageType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetForumPages"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(brRec.ForumID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@PageSize", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_GetForumPages"

   '-----get return values
   GetForumPages = moUtil.FetchLong(oCmd.Parameters.Item("@PageSize").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CanUserDelete( _ 
   ByRef brRec As tMessageType, _ 
   ByVal bvUserID As Long) As Integer
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CanUserDelete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MessageID", adInteger, adParamInput, vbNull, CLng(brRec.MessageID))
      .Parameters.Append .CreateParameter("@BoardUserID", adInteger, adParamInput, vbNull, CLng(brRec.BoardUserID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@CanDelete", adSmallInt, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_CanUserDelete"

   '-----get return values
   CanUserDelete = moUtil.FetchInteger(oCmd.Parameters.Item("@CanDelete").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub DeleteBranch( _ 
   ByRef brRec As tMessageType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DeleteBranch"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MessageID", adInteger, adParamInput, vbNull, CLng(brRec.MessageID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_DeleteBranch"

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_Count"

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

Public Sub Fetch( _ 
   ByRef brRec As tMessageType, _ 
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
      .MessageID = moUtil.EditLong(.MessageID, "MessageID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MessageID", adInteger, adParamInput, vbNull, CLng(brRec.MessageID))
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ThreadID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BoardUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ModifyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ForumName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@BoardUserName", adVarWChar, adParamOutput, 32, vbNull)
      .Parameters.Append .CreateParameter("@Signature", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@ModifyName", adVarWChar, adParamOutput, 32, vbNull)
      .Parameters.Append .CreateParameter("@MessageTitle", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsSticky", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Body", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ThreadOrder", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Replies", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_Fetch"

   '-----get return values
   With brRec
      .ForumID = moUtil.FetchLong(oCmd.Parameters.Item("@ForumID").Value)
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .ThreadID = moUtil.FetchLong(oCmd.Parameters.Item("@ThreadID").Value)
      .BoardUserID = moUtil.FetchLong(oCmd.Parameters.Item("@BoardUserID").Value)
      .ModifyID = moUtil.FetchLong(oCmd.Parameters.Item("@ModifyID").Value)
      .ForumName = moUtil.FetchString(oCmd.Parameters.Item("@ForumName").Value)
      .BoardUserName = moUtil.FetchString(oCmd.Parameters.Item("@BoardUserName").Value)
      .Signature = moUtil.FetchString(oCmd.Parameters.Item("@Signature").Value)
      .ModifyName = moUtil.FetchString(oCmd.Parameters.Item("@ModifyName").Value)
      .MessageTitle = moUtil.FetchString(oCmd.Parameters.Item("@MessageTitle").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .IsSticky = moUtil.FetchInteger(oCmd.Parameters.Item("@IsSticky").Value)
      .Body = moUtil.FetchString(oCmd.Parameters.Item("@Body").Value)
      .CreateDate = moUtil.FetchDate(oCmd.Parameters.Item("@CreateDate").Value)
      .ChangeDate = moUtil.FetchDate(oCmd.Parameters.Item("@ChangeDate").Value)
      .ThreadOrder = moUtil.FetchLong(oCmd.Parameters.Item("@ThreadOrder").Value)
      .Replies = moUtil.FetchLong(oCmd.Parameters.Item("@Replies").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tMessageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMessageType
   Dim vRec As tMessageType
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
      Case cptsMessageFindMessageTitle
         sProc = "pts_Message_FindMessageTitle"
         MaxBookMark = 70
      Case cptsMessageFindBody
         sProc = "pts_Message_FindBody"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
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
               vRec.MessageID = moUtil.FetchLong(.Fields.Item("MessageID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ThreadID = moUtil.FetchLong(.Fields.Item("ThreadID").Value)
               vRec.BoardUserID = moUtil.FetchLong(.Fields.Item("BoardUserID").Value)
               vRec.ModifyID = moUtil.FetchLong(.Fields.Item("ModifyID").Value)
               vRec.ForumName = moUtil.FetchString(.Fields.Item("ForumName").Value)
               vRec.BoardUserName = moUtil.FetchString(.Fields.Item("BoardUserName").Value)
               vRec.Signature = moUtil.FetchString(.Fields.Item("Signature").Value)
               vRec.ModifyName = moUtil.FetchString(.Fields.Item("ModifyName").Value)
               vRec.MessageTitle = moUtil.FetchString(.Fields.Item("MessageTitle").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.IsSticky = moUtil.FetchInteger(.Fields.Item("IsSticky").Value)
               vRec.Body = moUtil.FetchString(.Fields.Item("Body").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ThreadOrder = moUtil.FetchLong(.Fields.Item("ThreadOrder").Value)
               vRec.Replies = moUtil.FetchLong(.Fields.Item("Replies").Value)
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

Public Function ListThread( _ 
   ByVal bvThreadID As Long, _ 
   ByVal bvPage As Long, _ 
   ByVal bvPageSize As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long) As tMessageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListThread"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMessageType
   Dim vRec As tMessageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvThreadID = moUtil.EditLong(bvThreadID, "ThreadID", True, 0) 
      bvPageSize = moUtil.EditLong(bvPageSize, "PageSize", True, 0) 
      bvStatus = moUtil.EditLong(bvStatus, "Status", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ThreadID", adInteger, adParamInput, vbNull, CLng(bvThreadID))
      .Parameters.Append .CreateParameter("@Page", adInteger, adParamInput, vbNull, CLng(bvPage))
      .Parameters.Append .CreateParameter("@PageSize", adInteger, adParamInput, vbNull, CLng(bvPageSize))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_ListThread")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MessageID = moUtil.FetchLong(.Fields.Item("MessageID").Value)
            vRec.BoardUserID = moUtil.FetchLong(.Fields.Item("BoardUserID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.ThreadOrder = moUtil.FetchLong(.Fields.Item("ThreadOrder").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.IsSticky = moUtil.FetchInteger(.Fields.Item("IsSticky").Value)
            vRec.BoardUserName = moUtil.FetchString(.Fields.Item("BoardUserName").Value)
            vRec.ModifyID = moUtil.FetchLong(.Fields.Item("ModifyID").Value)
            vRec.ModifyName = moUtil.FetchString(.Fields.Item("ModifyName").Value)
            vRec.MessageTitle = moUtil.FetchString(.Fields.Item("MessageTitle").Value)
            vRec.Body = moUtil.FetchString(.Fields.Item("Body").Value)
            vRec.Signature = moUtil.FetchString(.Fields.Item("Signature").Value)
            vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListThread = vRecs

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

Public Function ListThreadTree( _ 
   ByVal bvThreadID As Long, _ 
   ByVal bvUserID As Long) As tMessageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListThreadTree"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMessageType
   Dim vRec As tMessageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvThreadID = moUtil.EditLong(bvThreadID, "ThreadID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ThreadID", adInteger, adParamInput, vbNull, CLng(bvThreadID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_ListThreadTree")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MessageID = moUtil.FetchLong(.Fields.Item("MessageID").Value)
            vRec.BoardUserID = moUtil.FetchLong(.Fields.Item("BoardUserID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.BoardUserName = moUtil.FetchString(.Fields.Item("BoardUserName").Value)
            vRec.ModifyID = moUtil.FetchLong(.Fields.Item("ModifyID").Value)
            vRec.ModifyName = moUtil.FetchString(.Fields.Item("ModifyName").Value)
            vRec.MessageTitle = moUtil.FetchString(.Fields.Item("MessageTitle").Value)
            vRec.Body = moUtil.FetchString(.Fields.Item("Body").Value)
            vRec.Signature = moUtil.FetchString(.Fields.Item("Signature").Value)
            vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListThreadTree = vRecs

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

Public Function ListForum( _ 
   ByVal bvForumID As Long, _ 
   ByVal bvPage As Long, _ 
   ByVal bvChangeDate As Date, _ 
   ByVal bvUserID As Long) As tMessageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListForum"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMessageType
   Dim vRec As tMessageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(bvForumID))
      .Parameters.Append .CreateParameter("@Page", adInteger, adParamInput, vbNull, CLng(bvPage))
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(bvChangeDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_ListForum")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MessageID = moUtil.FetchLong(.Fields.Item("MessageID").Value)
            vRec.BoardUserID = moUtil.FetchLong(.Fields.Item("BoardUserID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.IsSticky = moUtil.FetchInteger(.Fields.Item("IsSticky").Value)
            vRec.BoardUserName = moUtil.FetchString(.Fields.Item("BoardUserName").Value)
            vRec.ModifyID = moUtil.FetchLong(.Fields.Item("ModifyID").Value)
            vRec.ModifyName = moUtil.FetchString(.Fields.Item("ModifyName").Value)
            vRec.MessageTitle = moUtil.FetchString(.Fields.Item("MessageTitle").Value)
            vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.Replies = moUtil.FetchLong(.Fields.Item("Replies").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListForum = vRecs

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

Public Function ListMessageBoardUser( _ 
   ByVal bvBoardUserID As Long, _ 
   ByVal bvUserID As Long) As tMessageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMessageBoardUser"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMessageType
   Dim vRec As tMessageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvBoardUserID = moUtil.EditLong(bvBoardUserID, "BoardUserID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BoardUserID", adInteger, adParamInput, vbNull, CLng(bvBoardUserID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_ListMessageBoardUser")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MessageID = moUtil.FetchLong(.Fields.Item("MessageID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
            vRec.MessageTitle = moUtil.FetchString(.Fields.Item("MessageTitle").Value)
            vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMessageBoardUser = vRecs

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
   ByRef brRec As tMessageType, _ 
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
      .Parameters.Append .CreateParameter("@MessageID", adInteger, adParamInput, vbNull, CLng(brRec.MessageID))
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(brRec.ForumID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@ThreadID", adInteger, adParamInput, vbNull, CLng(brRec.ThreadID))
      .Parameters.Append .CreateParameter("@BoardUserID", adInteger, adParamInput, vbNull, CLng(brRec.BoardUserID))
      .Parameters.Append .CreateParameter("@ModifyID", adInteger, adParamInput, vbNull, CLng(brRec.ModifyID))
      .Parameters.Append .CreateParameter("@MessageTitle", adVarWChar, adParamInput, 60, brRec.MessageTitle)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@IsSticky", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSticky))
      .Parameters.Append .CreateParameter("@Body", adVarWChar, adParamInput, 2000, brRec.Body)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@ThreadOrder", adInteger, adParamInput, vbNull, CLng(brRec.ThreadOrder))
      .Parameters.Append .CreateParameter("@Replies", adInteger, adParamInput, vbNull, CLng(brRec.Replies))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Message_Update"

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
   ByRef brRec As tMessageType, _ 
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
         .MessageID = moUtil.EditLong(.MessageID, "MessageID", True, , 1) 
      End If
      .ForumID = moUtil.EditLong(.ForumID, "ForumID", False) 
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False) 
      .ThreadID = moUtil.EditLong(.ThreadID, "ThreadID", False) 
      .BoardUserID = moUtil.EditLong(.BoardUserID, "BoardUserID", False) 
      .ModifyID = moUtil.EditLong(.ModifyID, "ModifyID", False) 
      .MessageTitle = moUtil.EditString(.MessageTitle, "MessageTitle", True, , 1, 60) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .IsSticky = moUtil.EditInteger(.IsSticky, "IsSticky", False, 0, 0, 1) 
      .Body = moUtil.EditString(.Body, "Body", False, , 1, 2000) 
      .CreateDate = moUtil.EditDate(.CreateDate, "CreateDate", False) 
      .ChangeDate = moUtil.EditDate(.ChangeDate, "ChangeDate", False) 
      .ThreadOrder = moUtil.EditLong(.ThreadOrder, "ThreadOrder", False) 
      .Replies = moUtil.EditLong(.Replies, "Replies", False) 
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