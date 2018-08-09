VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAttendeeB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAttendee"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAttendeeType
   AttendeeID As String
   SeminarID As String
   MeetingID As String
   VenueName As String
   MeetingDate As String
   StartTime As String
   NameFirst As String
   NameLast As String
   Email As String
   Phone As String
   Street1 As String
   Street2 As String
   City As String
   State As String
   Zip As String
   Status As String
   Guests As String
   IP As String
   RegisterDate As String
   Attended As String
   Refer As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAttendeeType, _ 
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
      .Parameters.Append .CreateParameter("@AttendeeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SeminarID", adInteger, adParamInput, vbNull, CLng(brRec.SeminarID))
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(brRec.MeetingID))
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Guests", adInteger, adParamInput, vbNull, CLng(brRec.Guests))
      .Parameters.Append .CreateParameter("@IP", adVarWChar, adParamInput, 15, brRec.IP)
      .Parameters.Append .CreateParameter("@RegisterDate", adDate, adParamInput, vbNull, CDate(brRec.RegisterDate))
      .Parameters.Append .CreateParameter("@Attended", adInteger, adParamInput, vbNull, CLng(brRec.Attended))
      .Parameters.Append .CreateParameter("@Refer", adVarWChar, adParamInput, 20, brRec.Refer)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attendee_Add"

   '-----get return values
   With brRec
      .AttendeeID = moUtil.FetchLong(oCmd.Parameters.Item("@AttendeeID").Value)
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

Public Function Report( _ 
   ByRef brRec As tAttendeeType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Report"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SeminarID", adInteger, adParamInput, vbNull, CLng(brRec.SeminarID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(brRec.FromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(brRec.ToDate))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attendee_Report"

   '-----get return values
   Report = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tAttendeeType, _ 
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
      .AttendeeID = moUtil.EditLong(.AttendeeID, "AttendeeID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AttendeeID", adInteger, adParamInput, vbNull, CLng(brRec.AttendeeID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attendee_Delete"

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
   ByRef brRec As tAttendeeType, _ 
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
      .AttendeeID = moUtil.EditLong(.AttendeeID, "AttendeeID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AttendeeID", adInteger, adParamInput, vbNull, CLng(brRec.AttendeeID))
      .Parameters.Append .CreateParameter("@SeminarID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VenueName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@MeetingDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Guests", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IP", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@RegisterDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Attended", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Refer", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attendee_Fetch"

   '-----get return values
   With brRec
      .SeminarID = moUtil.FetchLong(oCmd.Parameters.Item("@SeminarID").Value)
      .MeetingID = moUtil.FetchLong(oCmd.Parameters.Item("@MeetingID").Value)
      .VenueName = moUtil.FetchString(oCmd.Parameters.Item("@VenueName").Value)
      .MeetingDate = moUtil.FetchDate(oCmd.Parameters.Item("@MeetingDate").Value)
      .StartTime = moUtil.FetchString(oCmd.Parameters.Item("@StartTime").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Phone = moUtil.FetchString(oCmd.Parameters.Item("@Phone").Value)
      .Street1 = moUtil.FetchString(oCmd.Parameters.Item("@Street1").Value)
      .Street2 = moUtil.FetchString(oCmd.Parameters.Item("@Street2").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Guests = moUtil.FetchLong(oCmd.Parameters.Item("@Guests").Value)
      .IP = moUtil.FetchString(oCmd.Parameters.Item("@IP").Value)
      .RegisterDate = moUtil.FetchDate(oCmd.Parameters.Item("@RegisterDate").Value)
      .Attended = moUtil.FetchLong(oCmd.Parameters.Item("@Attended").Value)
      .Refer = moUtil.FetchString(oCmd.Parameters.Item("@Refer").Value)
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
   ByVal bvSeminarID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tAttendeeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttendeeType
   Dim vRec As tAttendeeType
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
      Case cptsAttendeeFindNameLast
         sProc = "pts_Attendee_FindNameLast"
         MaxBookMark = 40
      Case cptsAttendeeFindNameFirst
         sProc = "pts_Attendee_FindNameFirst"
         MaxBookMark = 40
      Case cptsAttendeeFindEmail
         sProc = "pts_Attendee_FindEmail"
         MaxBookMark = 90
      Case cptsAttendeeFindPhone
         sProc = "pts_Attendee_FindPhone"
         MaxBookMark = 40
      Case cptsAttendeeFindMeetingID
         sProc = "pts_Attendee_FindMeetingID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SeminarID", adInteger, adParamInput, vbNull, CLng(bvSeminarID))
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
               vRec.AttendeeID = moUtil.FetchLong(.Fields.Item("AttendeeID").Value)
               vRec.SeminarID = moUtil.FetchLong(.Fields.Item("SeminarID").Value)
               vRec.MeetingID = moUtil.FetchLong(.Fields.Item("MeetingID").Value)
               vRec.VenueName = moUtil.FetchString(.Fields.Item("VenueName").Value)
               vRec.MeetingDate = moUtil.FetchDate(.Fields.Item("MeetingDate").Value)
               vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Guests = moUtil.FetchLong(.Fields.Item("Guests").Value)
               vRec.IP = moUtil.FetchString(.Fields.Item("IP").Value)
               vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
               vRec.Attended = moUtil.FetchLong(.Fields.Item("Attended").Value)
               vRec.Refer = moUtil.FetchString(.Fields.Item("Refer").Value)
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

Public Function List( _ 
   ByVal bvMeetingID As Long) As tAttendeeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttendeeType
   Dim vRec As tAttendeeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMeetingID = moUtil.EditLong(bvMeetingID, "MeetingID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(bvMeetingID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attendee_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AttendeeID = moUtil.FetchLong(.Fields.Item("AttendeeID").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
            vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
            vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Guests = moUtil.FetchLong(.Fields.Item("Guests").Value)
            vRec.IP = moUtil.FetchString(.Fields.Item("IP").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.Attended = moUtil.FetchLong(.Fields.Item("Attended").Value)
            vRec.Refer = moUtil.FetchString(.Fields.Item("Refer").Value)
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

Public Function ListActive( _ 
   ByVal bvMeetingID As Long) As tAttendeeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttendeeType
   Dim vRec As tAttendeeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMeetingID = moUtil.EditLong(bvMeetingID, "MeetingID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(bvMeetingID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attendee_ListActive")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AttendeeID = moUtil.FetchLong(.Fields.Item("AttendeeID").Value)
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
   ByRef brRec As tAttendeeType, _ 
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
      .Parameters.Append .CreateParameter("@AttendeeID", adInteger, adParamInput, vbNull, CLng(brRec.AttendeeID))
      .Parameters.Append .CreateParameter("@SeminarID", adInteger, adParamInput, vbNull, CLng(brRec.SeminarID))
      .Parameters.Append .CreateParameter("@MeetingID", adInteger, adParamInput, vbNull, CLng(brRec.MeetingID))
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Guests", adInteger, adParamInput, vbNull, CLng(brRec.Guests))
      .Parameters.Append .CreateParameter("@IP", adVarWChar, adParamInput, 15, brRec.IP)
      .Parameters.Append .CreateParameter("@RegisterDate", adDate, adParamInput, vbNull, CDate(brRec.RegisterDate))
      .Parameters.Append .CreateParameter("@Attended", adInteger, adParamInput, vbNull, CLng(brRec.Attended))
      .Parameters.Append .CreateParameter("@Refer", adVarWChar, adParamInput, 20, brRec.Refer)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attendee_Update"

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
   ByRef brRec As tAttendeeType, _ 
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
         .AttendeeID = moUtil.EditLong(.AttendeeID, "AttendeeID", True, , 1) 
      End If
      .SeminarID = moUtil.EditLong(.SeminarID, "SeminarID", False) 
      .MeetingID = moUtil.EditLong(.MeetingID, "MeetingID", False) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", True, , 1, 30) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", True, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80) 
      .Phone = moUtil.EditString(.Phone, "Phone", False, , 1, 30) 
      .Street1 = moUtil.EditString(.Street1, "Street1", False, , 1, 60) 
      .Street2 = moUtil.EditString(.Street2, "Street2", False, , 1, 60) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Guests = moUtil.EditLong(.Guests, "Guests", False) 
      .IP = moUtil.EditString(.IP, "IP", False) 
      .RegisterDate = moUtil.EditDate(.RegisterDate, "RegisterDate", False) 
      .Attended = moUtil.EditLong(.Attended, "Attended", False) 
      .Refer = moUtil.EditString(.Refer, "Refer", False, , 0, 20) 
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