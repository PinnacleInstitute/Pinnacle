VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CBroadcastB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CBroadcast"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tBroadcastType
   BroadcastID As String
   MemberID As String
   FriendGroupID As String
   FriendGroupName As String
   BroadcastDate As String
   Status As String
   Stories As String
   Friends As String
   Title As String
   Image As String
   Summary As String
   NameFirst As String
   NameLast As String
   Email As String
End Type

Public Sub Add( _ 
   ByRef brRec As tBroadcastType, _ 
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
      .Parameters.Append .CreateParameter("@BroadcastID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamInput, vbNull, CLng(brRec.FriendGroupID))
      .Parameters.Append .CreateParameter("@BroadcastDate", adDate, adParamInput, vbNull, CDate(brRec.BroadcastDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Stories", adInteger, adParamInput, vbNull, CLng(brRec.Stories))
      .Parameters.Append .CreateParameter("@Friends", adInteger, adParamInput, vbNull, CLng(brRec.Friends))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_Add"

   '-----get return values
   With brRec
      .BroadcastID = moUtil.FetchLong(oCmd.Parameters.Item("@BroadcastID").Value)
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

Public Function SetFriends( _ 
   ByRef brRec As tBroadcastType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetFriends"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BroadcastID", adInteger, adParamInput, vbNull, CLng(brRec.BroadcastID))
      .Parameters.Append .CreateParameter("@Friends", adInteger, adParamInput, vbNull, CLng(brRec.Friends))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_SetFriends"

   '-----get return values
   SetFriends = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tBroadcastType, _ 
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
      .BroadcastID = moUtil.EditLong(.BroadcastID, "BroadcastID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BroadcastID", adInteger, adParamInput, vbNull, CLng(brRec.BroadcastID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_Delete"

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
   ByRef brRec As tBroadcastType, _ 
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
      .BroadcastID = moUtil.EditLong(.BroadcastID, "BroadcastID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BroadcastID", adInteger, adParamInput, vbNull, CLng(brRec.BroadcastID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FriendGroupName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@BroadcastDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Stories", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Friends", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .FriendGroupID = moUtil.FetchLong(oCmd.Parameters.Item("@FriendGroupID").Value)
      .FriendGroupName = moUtil.FetchString(oCmd.Parameters.Item("@FriendGroupName").Value)
      .BroadcastDate = moUtil.FetchDate(oCmd.Parameters.Item("@BroadcastDate").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Stories = moUtil.FetchLong(oCmd.Parameters.Item("@Stories").Value)
      .Friends = moUtil.FetchLong(oCmd.Parameters.Item("@Friends").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tBroadcastType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBroadcastType
   Dim vRec As tBroadcastType
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
      Case cptsBroadcastFindBroadcastDate
         sProc = "pts_Broadcast_FindBroadcastDate"
         MaxBookMark = 30
      Case cptsBroadcastFindFriendGroupName
         sProc = "pts_Broadcast_FindFriendGroupName"
         MaxBookMark = 50
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
               vRec.BroadcastID = moUtil.FetchLong(.Fields.Item("BroadcastID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.FriendGroupID = moUtil.FetchLong(.Fields.Item("FriendGroupID").Value)
               vRec.FriendGroupName = moUtil.FetchString(.Fields.Item("FriendGroupName").Value)
               vRec.BroadcastDate = moUtil.FetchDate(.Fields.Item("BroadcastDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Stories = moUtil.FetchLong(.Fields.Item("Stories").Value)
               vRec.Friends = moUtil.FetchLong(.Fields.Item("Friends").Value)
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

Public Function FindGroup( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFriendGroupID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tBroadcastType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBroadcastType
   Dim vRec As tBroadcastType
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
      Case cptsBroadcastFindBroadcastDate
         sProc = "pts_Broadcast_FindGroupBroadcastDate"
         MaxBookMark = 30
      Case cptsBroadcastFindFriendGroupName
         sProc = "pts_Broadcast_FindGroupFriendGroupName"
         MaxBookMark = 50
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamInput, vbNull, CLng(bvFriendGroupID))
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
               vRec.BroadcastID = moUtil.FetchLong(.Fields.Item("BroadcastID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.FriendGroupID = moUtil.FetchLong(.Fields.Item("FriendGroupID").Value)
               vRec.FriendGroupName = moUtil.FetchString(.Fields.Item("FriendGroupName").Value)
               vRec.BroadcastDate = moUtil.FetchDate(.Fields.Item("BroadcastDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Stories = moUtil.FetchLong(.Fields.Item("Stories").Value)
               vRec.Friends = moUtil.FetchLong(.Fields.Item("Friends").Value)
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
   FindGroup = vRecs

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
   ByVal bvBroadcastID As Long) As tBroadcastType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNews"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBroadcastType
   Dim vRec As tBroadcastType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BroadcastID", adInteger, adParamInput, vbNull, CLng(bvBroadcastID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_ListNews")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BroadcastID = moUtil.FetchLong(.Fields.Item("BroadcastID").Value)
            vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.Summary = moUtil.FetchString(.Fields.Item("Summary").Value)
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

Public Function ListFriends( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFriendGroupID As Long) As tBroadcastType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFriends"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBroadcastType
   Dim vRec As tBroadcastType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamInput, vbNull, CLng(bvFriendGroupID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_ListFriends")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BroadcastID = moUtil.FetchLong(.Fields.Item("BroadcastID").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListFriends = vRecs

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

Public Function ListEmail( _ 
   ByVal bvBroadcastID As Long) As tBroadcastType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBroadcastType
   Dim vRec As tBroadcastType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BroadcastID", adInteger, adParamInput, vbNull, CLng(bvBroadcastID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_ListEmail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BroadcastID = moUtil.FetchLong(.Fields.Item("BroadcastID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.FriendGroupID = moUtil.FetchLong(.Fields.Item("FriendGroupID").Value)
            vRec.Stories = moUtil.FetchLong(.Fields.Item("Stories").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListEmail = vRecs

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
   ByRef brRec As tBroadcastType, _ 
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
      .Parameters.Append .CreateParameter("@BroadcastID", adInteger, adParamInput, vbNull, CLng(brRec.BroadcastID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamInput, vbNull, CLng(brRec.FriendGroupID))
      .Parameters.Append .CreateParameter("@BroadcastDate", adDate, adParamInput, vbNull, CDate(brRec.BroadcastDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Stories", adInteger, adParamInput, vbNull, CLng(brRec.Stories))
      .Parameters.Append .CreateParameter("@Friends", adInteger, adParamInput, vbNull, CLng(brRec.Friends))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Broadcast_Update"

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
   ByRef brRec As tBroadcastType, _ 
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
         .BroadcastID = moUtil.EditLong(.BroadcastID, "BroadcastID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .FriendGroupID = moUtil.EditLong(.FriendGroupID, "FriendGroupID", False) 
      .BroadcastDate = moUtil.EditDate(.BroadcastDate, "BroadcastDate", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Stories = moUtil.EditLong(.Stories, "Stories", False) 
      .Friends = moUtil.EditLong(.Friends, "Friends", False) 
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