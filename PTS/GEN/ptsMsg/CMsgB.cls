VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMsgB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMsg"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMsgType
   MsgID As String
   OwnerType As String
   OwnerID As String
   AuthUserID As String
   NameLast As String
   NameFirst As String
   UserName As String
   MsgDate As String
   Subject As String
   Message As String
   Status As String
   Num As String
   MemberID As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMsgType, _ 
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
      .Parameters.Append .CreateParameter("@MsgID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@MsgDate", adDate, adParamInput, vbNull, CDate(brRec.MsgDate))
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamInput, 2000, brRec.Message)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_Add"

   '-----get return values
   With brRec
      .MsgID = moUtil.FetchLong(oCmd.Parameters.Item("@MsgID").Value)
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

Public Function GetMemberMsgs( _ 
   ByRef brRec As tMsgType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetMemberMsgs"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_GetMemberMsgs"

   '-----get return values
   GetMemberMsgs = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub SetMemberMsgs( _ 
   ByRef brRec As tMsgType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetMemberMsgs"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", True, 0) 
      .Num = moUtil.EditLong(.Num, "Num", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@Num", adInteger, adParamInput, vbNull, CLng(brRec.Num))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_SetMemberMsgs"

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_Count"

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
   ByRef brRec As tMsgType, _ 
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
      .MsgID = moUtil.EditLong(.MsgID, "MsgID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MsgID", adInteger, adParamInput, vbNull, CLng(brRec.MsgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_Delete"

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
   ByRef brRec As tMsgType, _ 
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
      .MsgID = moUtil.EditLong(.MsgID, "MsgID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MsgID", adInteger, adParamInput, vbNull, CLng(brRec.MsgID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@UserName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@MsgDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_Fetch"

   '-----get return values
   With brRec
      .OwnerType = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerType").Value)
      .OwnerID = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .UserName = moUtil.FetchString(oCmd.Parameters.Item("@UserName").Value)
      .MsgDate = moUtil.FetchDate(oCmd.Parameters.Item("@MsgDate").Value)
      .Subject = moUtil.FetchString(oCmd.Parameters.Item("@Subject").Value)
      .Message = moUtil.FetchString(oCmd.Parameters.Item("@Message").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
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
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMsgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMsgType
   Dim vRec As tMsgType
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
      Case cptsMsgFindMsgID
         sProc = "pts_Msg_FindMsgID"
         MaxBookMark = 20
      Case cptsMsgFindSubject
         sProc = "pts_Msg_FindSubject"
         MaxBookMark = 90
      Case cptsMsgFindMessage
         sProc = "pts_Msg_FindMessage"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
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
               vRec.MsgID = moUtil.FetchLong(.Fields.Item("MsgID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
               vRec.MsgDate = moUtil.FetchDate(.Fields.Item("MsgDate").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Message = moUtil.FetchString(.Fields.Item("Message").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
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

Public Function ListMsgs( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long) As tMsgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMsgs"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMsgType
   Dim vRec As tMsgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_ListMsgs")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MsgID = moUtil.FetchLong(.Fields.Item("MsgID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.MsgDate = moUtil.FetchDate(.Fields.Item("MsgDate").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Message = moUtil.FetchString(.Fields.Item("Message").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMsgs = vRecs

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

Public Function MemberMsgs( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvMsgDate As Date, _ 
   ByVal bvNum As Long) As tMsgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberMsgs"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMsgType
   Dim vRec As tMsgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@MsgDate", adDate, adParamInput, vbNull, CDate(bvMsgDate))
      .Parameters.Append .CreateParameter("@Num", adInteger, adParamInput, vbNull, CLng(bvNum))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_MemberMsgs")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MsgID = moUtil.FetchLong(.Fields.Item("MsgID").Value)
            vRec.MsgDate = moUtil.FetchDate(.Fields.Item("MsgDate").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Message = moUtil.FetchString(.Fields.Item("Message").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   MemberMsgs = vRecs

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
   ByRef brRec As tMsgType, _ 
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
      .Parameters.Append .CreateParameter("@MsgID", adInteger, adParamInput, vbNull, CLng(brRec.MsgID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@MsgDate", adDate, adParamInput, vbNull, CDate(brRec.MsgDate))
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamInput, 2000, brRec.Message)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Msg_Update"

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
   ByRef brRec As tMsgType, _ 
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
         .MsgID = moUtil.EditLong(.MsgID, "MsgID", True, , 1) 
      End If
      .OwnerType = moUtil.EditLong(.OwnerType, "OwnerType", False) 
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", False) 
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .MsgDate = moUtil.EditDate(.MsgDate, "MsgDate", False) 
      .Subject = moUtil.EditString(.Subject, "Subject", True, , 1, 80) 
      .Message = moUtil.EditString(.Message, "Message", False, , 1, 2000) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
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