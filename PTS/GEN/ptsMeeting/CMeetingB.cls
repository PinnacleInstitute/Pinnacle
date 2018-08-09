VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMeetingB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMeeting"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMeetingType
   MeetingID As String
   VenueID As String
   MeetingDate As String
   StartTime As String
   EndTime As String
   Status As String
   Limit As String
   Guests As String
   Attended As String
   Notes As String
   SeminarID As String
   VenueName As String
   Description As String
   Day As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMeetingType, _ 
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
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VenueID", adInteger, adParamInput, vbNull, CLng(brRec.VenueID))
      .Parameters.Append .CreateParameter("@MeetingDate", adDate, adParamInput, vbNull, CDate(brRec.MeetingDate))
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamInput, 10, brRec.StartTime)
      .Parameters.Append .CreateParameter("@EndTime", adVarWChar, adParamInput, 10, brRec.EndTime)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Limit", adInteger, adParamInput, vbNull, CLng(brRec.Limit))
      .Parameters.Append .CreateParameter("@Guests", adInteger, adParamInput, vbNull, CLng(brRec.Guests))
      .Parameters.Append .CreateParameter("@Attended", adInteger, adParamInput, vbNull, CLng(brRec.Attended))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_Add"

   '-----get return values
   With brRec
      .MeetingID = moUtil.FetchLong(oCmd.Parameters.Item("@MeetingID").Value)
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

Public Function CountGuests( _ 
   ByRef brRec As tMeetingType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CountGuests"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(brRec.MeetingID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 100, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_CountGuests"

   '-----get return values
   CountGuests = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tMeetingType, _ 
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
      .MeetingID = moUtil.EditLong(.MeetingID, "MeetingID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(brRec.MeetingID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_Delete"

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
   ByRef brRec As tMeetingType, _ 
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
      .MeetingID = moUtil.EditLong(.MeetingID, "MeetingID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(brRec.MeetingID))
      .Parameters.Append .CreateParameter("@VenueID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MeetingDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@EndTime", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Limit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Guests", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Attended", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_Fetch"

   '-----get return values
   With brRec
      .VenueID = moUtil.FetchLong(oCmd.Parameters.Item("@VenueID").Value)
      .MeetingDate = moUtil.FetchDate(oCmd.Parameters.Item("@MeetingDate").Value)
      .StartTime = moUtil.FetchString(oCmd.Parameters.Item("@StartTime").Value)
      .EndTime = moUtil.FetchString(oCmd.Parameters.Item("@EndTime").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Limit = moUtil.FetchLong(oCmd.Parameters.Item("@Limit").Value)
      .Guests = moUtil.FetchLong(oCmd.Parameters.Item("@Guests").Value)
      .Attended = moUtil.FetchLong(oCmd.Parameters.Item("@Attended").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
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

Public Function List( _ 
   ByVal bvVenueID As Long) As tMeetingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMeetingType
   Dim vRec As tMeetingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvVenueID = moUtil.EditLong(bvVenueID, "VenueID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@VenueID", adInteger, adParamInput, vbNull, CLng(bvVenueID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MeetingID = moUtil.FetchLong(.Fields.Item("MeetingID").Value)
            vRec.MeetingDate = moUtil.FetchDate(.Fields.Item("MeetingDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Limit = moUtil.FetchLong(.Fields.Item("Limit").Value)
            vRec.Guests = moUtil.FetchLong(.Fields.Item("Guests").Value)
            vRec.Attended = moUtil.FetchLong(.Fields.Item("Attended").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   List = vRecs

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

Public Function ListSeminar( _ 
   ByVal bvSeminarID As Long, _ 
   ByVal bvStatus As Long) As tMeetingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSeminar"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMeetingType
   Dim vRec As tMeetingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SeminarID", adInteger, adParamInput, vbNull, CLng(bvSeminarID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_ListSeminar")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MeetingID = moUtil.FetchLong(.Fields.Item("MeetingID").Value)
            vRec.MeetingDate = moUtil.FetchDate(.Fields.Item("MeetingDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Limit = moUtil.FetchLong(.Fields.Item("Limit").Value)
            vRec.Guests = moUtil.FetchLong(.Fields.Item("Guests").Value)
            vRec.Attended = moUtil.FetchLong(.Fields.Item("Attended").Value)
            vRec.VenueName = moUtil.FetchString(.Fields.Item("VenueName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListSeminar = vRecs

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

Public Function ListActive( _ 
   ByVal bvSeminarID As Long) As tMeetingType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMeetingType
   Dim vRec As tMeetingType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SeminarID", adInteger, adParamInput, vbNull, CLng(bvSeminarID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_ListActive")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MeetingID = moUtil.FetchLong(.Fields.Item("MeetingID").Value)
            vRec.MeetingDate = moUtil.FetchDate(.Fields.Item("MeetingDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Limit = moUtil.FetchLong(.Fields.Item("Limit").Value)
            vRec.Guests = moUtil.FetchLong(.Fields.Item("Guests").Value)
            vRec.VenueName = moUtil.FetchString(.Fields.Item("VenueName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.SeminarID = moUtil.FetchLong(.Fields.Item("SeminarID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListActive = vRecs

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
   ByRef brRec As tMeetingType, _ 
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
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(brRec.MeetingID))
      .Parameters.Append .CreateParameter("@VenueID", adInteger, adParamInput, vbNull, CLng(brRec.VenueID))
      .Parameters.Append .CreateParameter("@MeetingDate", adDate, adParamInput, vbNull, CDate(brRec.MeetingDate))
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamInput, 10, brRec.StartTime)
      .Parameters.Append .CreateParameter("@EndTime", adVarWChar, adParamInput, 10, brRec.EndTime)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Limit", adInteger, adParamInput, vbNull, CLng(brRec.Limit))
      .Parameters.Append .CreateParameter("@Guests", adInteger, adParamInput, vbNull, CLng(brRec.Guests))
      .Parameters.Append .CreateParameter("@Attended", adInteger, adParamInput, vbNull, CLng(brRec.Attended))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Meeting_Update"

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
   ByRef brRec As tMeetingType, _ 
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
         .MeetingID = moUtil.EditLong(.MeetingID, "MeetingID", True, , 1) 
      End If
      .VenueID = moUtil.EditLong(.VenueID, "VenueID", False) 
      .MeetingDate = moUtil.EditDate(.MeetingDate, "MeetingDate", False) 
      .StartTime = moUtil.EditString(.StartTime, "StartTime", False, , 1) 
      .EndTime = moUtil.EditString(.EndTime, "EndTime", False, , 1) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Limit = moUtil.EditLong(.Limit, "Limit", False) 
      .Guests = moUtil.EditLong(.Guests, "Guests", False) 
      .Attended = moUtil.EditLong(.Attended, "Attended", False) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1) 
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