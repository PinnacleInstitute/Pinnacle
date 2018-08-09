VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CApptB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAppt"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tApptType
   ApptID As String
   CalendarID As String
   ApptName As String
   Location As String
   Note As String
   StartDate As String
   StartTime As String
   EndDate As String
   EndTime As String
   IsAllDay As String
   Status As String
   ApptType As String
   Importance As String
   Show As String
   Reminder As String
   RemindDate As String
   Recur As String
   RecurDate As String
   IsEdit As String
   IsPlan As String
   FromDate As String
   ToDate As String
   Opt As String
   Email As String
   MemberID As String
   IsMsg As String
End Type

Public Sub Add( _ 
   ByRef brRec As tApptType, _ 
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
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(brRec.CalendarID))
      .Parameters.Append .CreateParameter("@ApptName", adVarWChar, adParamInput, 60, brRec.ApptName)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 80, brRec.Location)
      .Parameters.Append .CreateParameter("@Note", adVarWChar, adParamInput, 500, brRec.Note)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamInput, 8, brRec.StartTime)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@EndTime", adVarWChar, adParamInput, 8, brRec.EndTime)
      .Parameters.Append .CreateParameter("@IsAllDay", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAllDay))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@ApptType", adInteger, adParamInput, vbNull, CLng(brRec.ApptType))
      .Parameters.Append .CreateParameter("@Importance", adInteger, adParamInput, vbNull, CLng(brRec.Importance))
      .Parameters.Append .CreateParameter("@Show", adInteger, adParamInput, vbNull, CLng(brRec.Show))
      .Parameters.Append .CreateParameter("@Reminder", adInteger, adParamInput, vbNull, CLng(brRec.Reminder))
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamInput, vbNull, CDate(brRec.RemindDate))
      .Parameters.Append .CreateParameter("@Recur", adInteger, adParamInput, vbNull, CLng(brRec.Recur))
      .Parameters.Append .CreateParameter("@RecurDate", adDate, adParamInput, vbNull, CDate(brRec.RecurDate))
      .Parameters.Append .CreateParameter("@IsEdit", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEdit))
      .Parameters.Append .CreateParameter("@IsPlan", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPlan))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_Add"

   '-----get return values
   With brRec
      .ApptID = moUtil.FetchLong(oCmd.Parameters.Item("@ApptID").Value)
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

Public Function CalendarEmail( _ 
   ByRef brRec As tApptType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalendarEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(brRec.CalendarID))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_CalendarEmail"

   '-----get return values
   CalendarEmail = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub ClearReminder( _ 
   ByRef brRec As tApptType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ClearReminder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamInput, vbNull, CLng(brRec.ApptID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_ClearReminder"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Delete( _ 
   ByRef brRec As tApptType, _ 
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
      .ApptID = moUtil.EditLong(.ApptID, "ApptID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamInput, vbNull, CLng(brRec.ApptID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_Delete"

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
   ByRef brRec As tApptType, _ 
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
      .ApptID = moUtil.EditLong(.ApptID, "ApptID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamInput, vbNull, CLng(brRec.ApptID))
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ApptName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Note", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamOutput, 8, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndTime", adVarWChar, adParamOutput, 8, vbNull)
      .Parameters.Append .CreateParameter("@IsAllDay", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ApptType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Importance", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Show", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reminder", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Recur", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RecurDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsEdit", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPlan", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_Fetch"

   '-----get return values
   With brRec
      .CalendarID = moUtil.FetchLong(oCmd.Parameters.Item("@CalendarID").Value)
      .ApptName = moUtil.FetchString(oCmd.Parameters.Item("@ApptName").Value)
      .Location = moUtil.FetchString(oCmd.Parameters.Item("@Location").Value)
      .Note = moUtil.FetchString(oCmd.Parameters.Item("@Note").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .StartTime = moUtil.FetchString(oCmd.Parameters.Item("@StartTime").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .EndTime = moUtil.FetchString(oCmd.Parameters.Item("@EndTime").Value)
      .IsAllDay = moUtil.FetchInteger(oCmd.Parameters.Item("@IsAllDay").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .ApptType = moUtil.FetchLong(oCmd.Parameters.Item("@ApptType").Value)
      .Importance = moUtil.FetchLong(oCmd.Parameters.Item("@Importance").Value)
      .Show = moUtil.FetchLong(oCmd.Parameters.Item("@Show").Value)
      .Reminder = moUtil.FetchLong(oCmd.Parameters.Item("@Reminder").Value)
      .RemindDate = moUtil.FetchDate(oCmd.Parameters.Item("@RemindDate").Value)
      .Recur = moUtil.FetchLong(oCmd.Parameters.Item("@Recur").Value)
      .RecurDate = moUtil.FetchDate(oCmd.Parameters.Item("@RecurDate").Value)
      .IsEdit = moUtil.FetchInteger(oCmd.Parameters.Item("@IsEdit").Value)
      .IsPlan = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPlan").Value)
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

Public Function ListCalendar( _ 
   ByVal bvCalendarID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tApptType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCalendar"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tApptType
   Dim vRec As tApptType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCalendarID = moUtil.EditLong(bvCalendarID, "CalendarID", True, 0) 
      bvFromDate = moUtil.EditDate(bvFromDate, "FromDate", True, 0) 
      bvToDate = moUtil.EditDate(bvToDate, "ToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(bvCalendarID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_ListCalendar")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ApptID = moUtil.FetchLong(.Fields.Item("ApptID").Value)
            vRec.ApptName = moUtil.FetchString(.Fields.Item("ApptName").Value)
            vRec.Location = moUtil.FetchString(.Fields.Item("Location").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.IsAllDay = moUtil.FetchInteger(.Fields.Item("IsAllDay").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ApptType = moUtil.FetchLong(.Fields.Item("ApptType").Value)
            vRec.Importance = moUtil.FetchLong(.Fields.Item("Importance").Value)
            vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
            vRec.Recur = moUtil.FetchLong(.Fields.Item("Recur").Value)
            vRec.RecurDate = moUtil.FetchDate(.Fields.Item("RecurDate").Value)
            vRec.IsEdit = moUtil.FetchInteger(.Fields.Item("IsEdit").Value)
            vRec.IsPlan = moUtil.FetchInteger(.Fields.Item("IsPlan").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCalendar = vRecs

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

Public Function ListCalendarAll( _ 
   ByVal bvCalendarID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tApptType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCalendarAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tApptType
   Dim vRec As tApptType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCalendarID = moUtil.EditLong(bvCalendarID, "CalendarID", True, 0) 
      bvFromDate = moUtil.EditDate(bvFromDate, "FromDate", True, 0) 
      bvToDate = moUtil.EditDate(bvToDate, "ToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(bvCalendarID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_ListCalendarAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ApptID = moUtil.FetchLong(.Fields.Item("ApptID").Value)
            vRec.ApptName = moUtil.FetchString(.Fields.Item("ApptName").Value)
            vRec.Location = moUtil.FetchString(.Fields.Item("Location").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.IsAllDay = moUtil.FetchInteger(.Fields.Item("IsAllDay").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ApptType = moUtil.FetchLong(.Fields.Item("ApptType").Value)
            vRec.Importance = moUtil.FetchLong(.Fields.Item("Importance").Value)
            vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
            vRec.Recur = moUtil.FetchLong(.Fields.Item("Recur").Value)
            vRec.RecurDate = moUtil.FetchDate(.Fields.Item("RecurDate").Value)
            vRec.IsEdit = moUtil.FetchInteger(.Fields.Item("IsEdit").Value)
            vRec.IsPlan = moUtil.FetchInteger(.Fields.Item("IsPlan").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCalendarAll = vRecs

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

Public Function ListCalendarOptions( _ 
   ByVal bvCalendarID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvApptName As String) As tApptType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCalendarOptions"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tApptType
   Dim vRec As tApptType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCalendarID = moUtil.EditLong(bvCalendarID, "CalendarID", True, 0) 
      bvFromDate = moUtil.EditDate(bvFromDate, "FromDate", True, 0) 
      bvToDate = moUtil.EditDate(bvToDate, "ToDate", True, 0) 
      bvApptName = moUtil.EditString(bvApptName, "ApptName", True, "", 1, 60) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(bvCalendarID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
      .Parameters.Append .CreateParameter("@ApptName", adVarWChar, adParamInput, 60, bvApptName)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_ListCalendarOptions")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ApptID = moUtil.FetchLong(.Fields.Item("ApptID").Value)
            vRec.ApptName = moUtil.FetchString(.Fields.Item("ApptName").Value)
            vRec.Location = moUtil.FetchString(.Fields.Item("Location").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.IsAllDay = moUtil.FetchInteger(.Fields.Item("IsAllDay").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ApptType = moUtil.FetchLong(.Fields.Item("ApptType").Value)
            vRec.Importance = moUtil.FetchLong(.Fields.Item("Importance").Value)
            vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
            vRec.Recur = moUtil.FetchLong(.Fields.Item("Recur").Value)
            vRec.RecurDate = moUtil.FetchDate(.Fields.Item("RecurDate").Value)
            vRec.IsEdit = moUtil.FetchInteger(.Fields.Item("IsEdit").Value)
            vRec.IsPlan = moUtil.FetchInteger(.Fields.Item("IsPlan").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCalendarOptions = vRecs

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

Public Function ListDayOptions( _ 
   ByVal bvCalendarID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvApptName As String) As tApptType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListDayOptions"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tApptType
   Dim vRec As tApptType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCalendarID = moUtil.EditLong(bvCalendarID, "CalendarID", True, 0) 
      bvFromDate = moUtil.EditDate(bvFromDate, "FromDate", True, 0) 
      bvApptName = moUtil.EditString(bvApptName, "ApptName", True, "", 1, 60) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(bvCalendarID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ApptName", adVarWChar, adParamInput, 60, bvApptName)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_ListDayOptions")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ApptID = moUtil.FetchLong(.Fields.Item("ApptID").Value)
            vRec.ApptName = moUtil.FetchString(.Fields.Item("ApptName").Value)
            vRec.Location = moUtil.FetchString(.Fields.Item("Location").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.IsAllDay = moUtil.FetchInteger(.Fields.Item("IsAllDay").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ApptType = moUtil.FetchLong(.Fields.Item("ApptType").Value)
            vRec.Importance = moUtil.FetchLong(.Fields.Item("Importance").Value)
            vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
            vRec.Recur = moUtil.FetchLong(.Fields.Item("Recur").Value)
            vRec.RecurDate = moUtil.FetchDate(.Fields.Item("RecurDate").Value)
            vRec.IsEdit = moUtil.FetchInteger(.Fields.Item("IsEdit").Value)
            vRec.IsPlan = moUtil.FetchInteger(.Fields.Item("IsPlan").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListDayOptions = vRecs

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

Public Function ListToday( _ 
   ByVal bvCalendarID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvApptName As String) As tApptType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListToday"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tApptType
   Dim vRec As tApptType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCalendarID = moUtil.EditLong(bvCalendarID, "CalendarID", True, 0) 
      bvFromDate = moUtil.EditDate(bvFromDate, "FromDate", True, 0) 
      bvApptName = moUtil.EditString(bvApptName, "ApptName", True, "", 1, 60) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(bvCalendarID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ApptName", adVarWChar, adParamInput, 60, bvApptName)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_ListToday")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ApptID = moUtil.FetchLong(.Fields.Item("ApptID").Value)
            vRec.ApptName = moUtil.FetchString(.Fields.Item("ApptName").Value)
            vRec.Location = moUtil.FetchString(.Fields.Item("Location").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.IsAllDay = moUtil.FetchInteger(.Fields.Item("IsAllDay").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ApptType = moUtil.FetchLong(.Fields.Item("ApptType").Value)
            vRec.Importance = moUtil.FetchLong(.Fields.Item("Importance").Value)
            vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
            vRec.Recur = moUtil.FetchLong(.Fields.Item("Recur").Value)
            vRec.RecurDate = moUtil.FetchDate(.Fields.Item("RecurDate").Value)
            vRec.IsEdit = moUtil.FetchInteger(.Fields.Item("IsEdit").Value)
            vRec.IsPlan = moUtil.FetchInteger(.Fields.Item("IsPlan").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListToday = vRecs

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
   ByVal bvUserID As Long) As tApptType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReminder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tApptType
   Dim vRec As tApptType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_ListReminder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ApptID = moUtil.FetchLong(.Fields.Item("ApptID").Value)
            vRec.ApptName = moUtil.FetchString(.Fields.Item("ApptName").Value)
            vRec.Location = moUtil.FetchString(.Fields.Item("Location").Value)
            vRec.Note = moUtil.FetchString(.Fields.Item("Note").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
            vRec.EndTime = moUtil.FetchString(.Fields.Item("EndTime").Value)
            vRec.IsAllDay = moUtil.FetchInteger(.Fields.Item("IsAllDay").Value)
            vRec.ApptType = moUtil.FetchLong(.Fields.Item("ApptType").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.IsMsg = moUtil.FetchInteger(.Fields.Item("IsMsg").Value)
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

Public Sub Update( _ 
   ByRef brRec As tApptType, _ 
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
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamInput, vbNull, CLng(brRec.ApptID))
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(brRec.CalendarID))
      .Parameters.Append .CreateParameter("@ApptName", adVarWChar, adParamInput, 60, brRec.ApptName)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 80, brRec.Location)
      .Parameters.Append .CreateParameter("@Note", adVarWChar, adParamInput, 500, brRec.Note)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamInput, 8, brRec.StartTime)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@EndTime", adVarWChar, adParamInput, 8, brRec.EndTime)
      .Parameters.Append .CreateParameter("@IsAllDay", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAllDay))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@ApptType", adInteger, adParamInput, vbNull, CLng(brRec.ApptType))
      .Parameters.Append .CreateParameter("@Importance", adInteger, adParamInput, vbNull, CLng(brRec.Importance))
      .Parameters.Append .CreateParameter("@Show", adInteger, adParamInput, vbNull, CLng(brRec.Show))
      .Parameters.Append .CreateParameter("@Reminder", adInteger, adParamInput, vbNull, CLng(brRec.Reminder))
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamInput, vbNull, CDate(brRec.RemindDate))
      .Parameters.Append .CreateParameter("@Recur", adInteger, adParamInput, vbNull, CLng(brRec.Recur))
      .Parameters.Append .CreateParameter("@RecurDate", adDate, adParamInput, vbNull, CDate(brRec.RecurDate))
      .Parameters.Append .CreateParameter("@IsEdit", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEdit))
      .Parameters.Append .CreateParameter("@IsPlan", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPlan))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Appt_Update"

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
   ByRef brRec As tApptType, _ 
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
         .ApptID = moUtil.EditLong(.ApptID, "ApptID", True, , 1) 
      End If
      .CalendarID = moUtil.EditLong(.CalendarID, "CalendarID", False) 
      .ApptName = moUtil.EditString(.ApptName, "ApptName", True, , 1, 60) 
      .Location = moUtil.EditString(.Location, "Location", False, , 1, 80) 
      .Note = moUtil.EditString(.Note, "Note", False, , 1, 500) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .StartTime = moUtil.EditString(.StartTime, "StartTime", False, , 1, 8) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .EndTime = moUtil.EditString(.EndTime, "EndTime", False, , 1, 8) 
      .IsAllDay = moUtil.EditInteger(.IsAllDay, "IsAllDay", False, 0, 0, 1) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .ApptType = moUtil.EditLong(.ApptType, "ApptType", False) 
      .Importance = moUtil.EditLong(.Importance, "Importance", False) 
      .Show = moUtil.EditLong(.Show, "Show", False) 
      .Reminder = moUtil.EditLong(.Reminder, "Reminder", False) 
      .RemindDate = moUtil.EditDate(.RemindDate, "RemindDate", False) 
      .Recur = moUtil.EditLong(.Recur, "Recur", False) 
      .RecurDate = moUtil.EditDate(.RecurDate, "RecurDate", False) 
      .IsEdit = moUtil.EditInteger(.IsEdit, "IsEdit", False, 0, 0, 1) 
      .IsPlan = moUtil.EditInteger(.IsPlan, "IsPlan", False, 0, 0, 1) 
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