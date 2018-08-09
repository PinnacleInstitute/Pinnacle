VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CNoteB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CNote"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tNoteType
   NoteID As String
   OwnerType As String
   OwnerID As String
   AuthUserID As String
   NameLast As String
   NameFirst As String
   UserName As String
   NoteDate As String
   Notes As String
   IsLocked As String
   IsFrozen As String
   IsReminder As String
   FromDate As String
   ToDate As String
   Owner As String
   Num As String
   Data1 As String
   Data2 As String
   Data3 As String
End Type

Public Sub Add( _ 
   ByRef brRec As tNoteType, _ 
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
      .Parameters.Append .CreateParameter("@NoteID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@NoteDate", adDate, adParamInput, vbNull, CDate(brRec.NoteDate))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 1000, brRec.Notes)
      .Parameters.Append .CreateParameter("@IsLocked", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLocked))
      .Parameters.Append .CreateParameter("@IsFrozen", adSmallInt, adParamInput, vbNull, CInt(brRec.IsFrozen))
      .Parameters.Append .CreateParameter("@IsReminder", adSmallInt, adParamInput, vbNull, CInt(brRec.IsReminder))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_Add"

   '-----get return values
   With brRec
      .NoteID = moUtil.FetchLong(oCmd.Parameters.Item("@NoteID").Value)
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_Count"

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
   ByRef brRec As tNoteType, _ 
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
      .NoteID = moUtil.EditLong(.NoteID, "NoteID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NoteID", adInteger, adParamInput, vbNull, CLng(brRec.NoteID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_Delete"

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
   ByRef brRec As tNoteType, _ 
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
      .NoteID = moUtil.EditLong(.NoteID, "NoteID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NoteID", adInteger, adParamInput, vbNull, CLng(brRec.NoteID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@UserName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@NoteDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@IsLocked", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsFrozen", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsReminder", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_Fetch"

   '-----get return values
   With brRec
      .OwnerType = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerType").Value)
      .OwnerID = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .UserName = moUtil.FetchString(oCmd.Parameters.Item("@UserName").Value)
      .NoteDate = moUtil.FetchDate(oCmd.Parameters.Item("@NoteDate").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
      .IsLocked = moUtil.FetchInteger(oCmd.Parameters.Item("@IsLocked").Value)
      .IsFrozen = moUtil.FetchInteger(oCmd.Parameters.Item("@IsFrozen").Value)
      .IsReminder = moUtil.FetchInteger(oCmd.Parameters.Item("@IsReminder").Value)
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

Public Function FindOwner( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
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
      Case cptsNoteFindNoteDate
         sProc = "pts_Note_FindOwnerNoteDate"
         MaxBookMark = 30
      Case cptsNoteFindNotes
         sProc = "pts_Note_FindOwnerNotes"
         MaxBookMark = 1010
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
               vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
               vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
               vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
               vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
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
   FindOwner = vRecs

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

Public Function ListNotes( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNotes"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListNotes")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNotes = vRecs

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

Public Function ListActivity( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvAuthUserID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActivity"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(bvAuthUserID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListActivity")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
            vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListActivity = vRecs

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

Public Function ListReminder( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvAuthUserID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReminder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(bvAuthUserID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListReminder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
            vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListReminder = vRecs

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

Public Function ListActivityOwner( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvAuthUserID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActivityOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(bvAuthUserID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListActivityOwner")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
            vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
            vRec.Owner = moUtil.FetchString(.Fields.Item("Owner").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListActivityOwner = vRecs

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

Public Function ListReminderOwner( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvAuthUserID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReminderOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(bvAuthUserID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListReminderOwner")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
            vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
            vRec.Owner = moUtil.FetchString(.Fields.Item("Owner").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListReminderOwner = vRecs

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

Public Function Summary( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvIsReminder As Integer, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Summary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@IsReminder", adSmallInt, adParamInput, vbNull, CInt(bvIsReminder))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_Summary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.Num = moUtil.FetchLong(.Fields.Item("Num").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Summary = vRecs

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

Public Function ListNotesStarts( _ 
   ByVal bvNotes As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNotesStarts"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 1000, bvNotes)
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListNotesStarts")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
            vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNotesStarts = vRecs

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

Public Function ListNotesContains( _ 
   ByVal bvNotes As String, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNotesContains"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 1000, bvNotes)
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListNotesContains")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
            vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNotesContains = vRecs

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

Public Function ListCustom( _ 
   ByVal bvNum As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvData1 As String, _ 
   ByVal bvData2 As String, _ 
   ByVal bvData3 As String) As tNoteType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tNoteType
   Dim vRec As tNoteType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Num", adInteger, adParamInput, vbNull, CLng(bvNum))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
      .Parameters.Append .CreateParameter("@Data1", adVarWChar, adParamInput, 80, bvData1)
      .Parameters.Append .CreateParameter("@Data2", adVarWChar, adParamInput, 80, bvData2)
      .Parameters.Append .CreateParameter("@Data3", adVarWChar, adParamInput, 80, bvData3)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_ListCustom")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.NoteID = moUtil.FetchLong(.Fields.Item("NoteID").Value)
            vRec.NoteDate = moUtil.FetchDate(.Fields.Item("NoteDate").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
            vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.UserName = moUtil.FetchString(.Fields.Item("UserName").Value)
            vRec.IsLocked = moUtil.FetchInteger(.Fields.Item("IsLocked").Value)
            vRec.IsFrozen = moUtil.FetchInteger(.Fields.Item("IsFrozen").Value)
            vRec.IsReminder = moUtil.FetchInteger(.Fields.Item("IsReminder").Value)
            vRec.Data1 = moUtil.FetchString(.Fields.Item("Data1").Value)
            vRec.Data2 = moUtil.FetchString(.Fields.Item("Data2").Value)
            vRec.Data3 = moUtil.FetchString(.Fields.Item("Data3").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCustom = vRecs

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
   ByRef brRec As tNoteType, _ 
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
      .Parameters.Append .CreateParameter("@NoteID", adInteger, adParamInput, vbNull, CLng(brRec.NoteID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@NoteDate", adDate, adParamInput, vbNull, CDate(brRec.NoteDate))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 1000, brRec.Notes)
      .Parameters.Append .CreateParameter("@IsLocked", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLocked))
      .Parameters.Append .CreateParameter("@IsFrozen", adSmallInt, adParamInput, vbNull, CInt(brRec.IsFrozen))
      .Parameters.Append .CreateParameter("@IsReminder", adSmallInt, adParamInput, vbNull, CInt(brRec.IsReminder))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Note_Update"

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
   ByRef brRec As tNoteType, _ 
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
         .NoteID = moUtil.EditLong(.NoteID, "NoteID", True, , 1) 
      End If
      .OwnerType = moUtil.EditLong(.OwnerType, "OwnerType", False) 
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", False) 
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .NoteDate = moUtil.EditDate(.NoteDate, "NoteDate", False) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 1000) 
      .IsLocked = moUtil.EditInteger(.IsLocked, "IsLocked", False, 0, 0, 1) 
      .IsFrozen = moUtil.EditInteger(.IsFrozen, "IsFrozen", False, 0, 0, 1) 
      .IsReminder = moUtil.EditInteger(.IsReminder, "IsReminder", False, 0, 0, 1) 
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