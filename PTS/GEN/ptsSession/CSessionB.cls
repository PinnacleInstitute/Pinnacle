VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CSessionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSession"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tSessionType
   SessionID As String
   MemberID As String
   CourseID As String
   OrgCourseID As String
   CourseName As String
   CourseLength As String
   PassingGrade As String
   Video As String
   Audio As String
   Quiz As String
   MemberName As String
   QuizLimit As String
   NameLast As String
   NameFirst As String
   StudentName As String
   Status As String
   RegisterDate As String
   StartDate As String
   CompleteDate As String
   Grade As String
   Feedback As String
   Rating1 As String
   Rating2 As String
   Rating3 As String
   Rating4 As String
   TotalRating As String
   URLOption As String
   Time As String
   Times As String
   IsInactive As String
   TrainerScore As String
   CommStatus As String
   Apply As String
   Recommend1 As String
   Recommend2 As String
   Recommend3 As String
   Num1 As String
   Num2 As String
   Num3 As String
   Num4 As String
   OCStatus As String
   OrgID As String
   Quantity As String
   ReportFromDate As String
   ReportToDate As String
   Credit As String
End Type

Public Sub Add( _ 
   ByRef brRec As tSessionType, _ 
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
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamInput, vbNull, CLng(brRec.OrgCourseID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@RegisterDate", adDate, adParamInput, vbNull, CDate(brRec.RegisterDate))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Grade", adInteger, adParamInput, vbNull, CLng(brRec.Grade))
      .Parameters.Append .CreateParameter("@Feedback", adVarWChar, adParamInput, 2000, brRec.Feedback)
      .Parameters.Append .CreateParameter("@Rating1", adInteger, adParamInput, vbNull, CLng(brRec.Rating1))
      .Parameters.Append .CreateParameter("@Rating2", adInteger, adParamInput, vbNull, CLng(brRec.Rating2))
      .Parameters.Append .CreateParameter("@Rating3", adInteger, adParamInput, vbNull, CLng(brRec.Rating3))
      .Parameters.Append .CreateParameter("@Rating4", adInteger, adParamInput, vbNull, CLng(brRec.Rating4))
      .Parameters.Append .CreateParameter("@TotalRating", adInteger, adParamInput, vbNull, CLng(brRec.TotalRating))
      .Parameters.Append .CreateParameter("@URLOption", adInteger, adParamInput, vbNull, CLng(brRec.URLOption))
      .Parameters.Append .CreateParameter("@Time", adInteger, adParamInput, vbNull, CLng(brRec.Time))
      Dim tmpParamTimes As ADODB.Parameter
      Set tmpParamTimes = .CreateParameter("@Times", adNumeric, adParamInput, 10, CDbl(brRec.Times))
      tmpParamTimes.Precision = 10
      tmpParamTimes.NumericScale = 8
      .Parameters.Append tmpParamTimes
      .Parameters.Append .CreateParameter("@IsInactive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsInactive))
      .Parameters.Append .CreateParameter("@TrainerScore", adInteger, adParamInput, vbNull, CLng(brRec.TrainerScore))
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@Apply", adInteger, adParamInput, vbNull, CLng(brRec.Apply))
      .Parameters.Append .CreateParameter("@Recommend1", adInteger, adParamInput, vbNull, CLng(brRec.Recommend1))
      .Parameters.Append .CreateParameter("@Recommend2", adInteger, adParamInput, vbNull, CLng(brRec.Recommend2))
      .Parameters.Append .CreateParameter("@Recommend3", adInteger, adParamInput, vbNull, CLng(brRec.Recommend3))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_Add"

   '-----get return values
   With brRec
      .SessionID = moUtil.FetchLong(oCmd.Parameters.Item("@SessionID").Value)
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

Public Function CheckCourse( _ 
   ByRef brRec As tSessionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_CheckCourse"

   '-----get return values
   CheckCourse = moUtil.FetchLong(oCmd.Parameters.Item("@SessionID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetStatus( _ 
   ByRef brRec As tSessionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@Feedback", adVarWChar, adParamInput, 2000, brRec.Feedback)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_SetStatus"

   '-----get return values
   SetStatus = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Remove( _ 
   ByRef brRec As tSessionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Remove"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_Remove"

   '-----get return values
   Remove = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function MemberAccess( _ 
   ByRef brRec As tSessionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberAccess"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(brRec.ReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(brRec.ReportToDate))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_MemberAccess"

   '-----get return values
   MemberAccess = moUtil.FetchLong(oCmd.Parameters.Item("@Quantity").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Reset( _ 
   ByRef brRec As tSessionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Reset"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_Reset"

   '-----get return values
   Reset = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_Count"

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
   ByRef brRec As tSessionType, _ 
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
      .SessionID = moUtil.EditLong(.SessionID, "SessionID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_Delete"

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

Public Function EnumUserProgram( _ 
   ByVal bvSessionID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecurityToken As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(bvSessionID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_EnumUserProgram")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserProgram = vRecs

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
   ByRef brRec As tSessionType, _ 
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
      .SessionID = moUtil.EditLong(.SessionID, "SessionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@CourseLength", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Video", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Audio", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Quiz", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@StudentName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RegisterDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Grade", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Feedback", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Rating1", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Rating2", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Rating3", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Rating4", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TotalRating", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@URLOption", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Time", adInteger, adParamOutput, vbNull, vbNull)
      Dim tmpParamTimes As ADODB.Parameter
      Set tmpParamTimes = .CreateParameter("@Times", adNumeric, adParamOutput, 10, vbNull)
      tmpParamTimes.Precision = 10
      tmpParamTimes.NumericScale = 8
      .Parameters.Append tmpParamTimes
      .Parameters.Append .CreateParameter("@IsInactive", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrainerScore", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Apply", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Recommend1", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Recommend2", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Recommend3", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .CourseID = moUtil.FetchLong(oCmd.Parameters.Item("@CourseID").Value)
      .OrgCourseID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgCourseID").Value)
      .CourseName = moUtil.FetchString(oCmd.Parameters.Item("@CourseName").Value)
      .CourseLength = moUtil.FetchLong(oCmd.Parameters.Item("@CourseLength").Value)
      .PassingGrade = moUtil.FetchLong(oCmd.Parameters.Item("@PassingGrade").Value)
      .Video = moUtil.FetchLong(oCmd.Parameters.Item("@Video").Value)
      .Audio = moUtil.FetchLong(oCmd.Parameters.Item("@Audio").Value)
      .Quiz = moUtil.FetchLong(oCmd.Parameters.Item("@Quiz").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .QuizLimit = moUtil.FetchLong(oCmd.Parameters.Item("@QuizLimit").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .StudentName = moUtil.FetchString(oCmd.Parameters.Item("@StudentName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .RegisterDate = moUtil.FetchDate(oCmd.Parameters.Item("@RegisterDate").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .CompleteDate = moUtil.FetchDate(oCmd.Parameters.Item("@CompleteDate").Value)
      .Grade = moUtil.FetchLong(oCmd.Parameters.Item("@Grade").Value)
      .Feedback = moUtil.FetchString(oCmd.Parameters.Item("@Feedback").Value)
      .Rating1 = moUtil.FetchLong(oCmd.Parameters.Item("@Rating1").Value)
      .Rating2 = moUtil.FetchLong(oCmd.Parameters.Item("@Rating2").Value)
      .Rating3 = moUtil.FetchLong(oCmd.Parameters.Item("@Rating3").Value)
      .Rating4 = moUtil.FetchLong(oCmd.Parameters.Item("@Rating4").Value)
      .TotalRating = moUtil.FetchLong(oCmd.Parameters.Item("@TotalRating").Value)
      .URLOption = moUtil.FetchLong(oCmd.Parameters.Item("@URLOption").Value)
      .Time = moUtil.FetchLong(oCmd.Parameters.Item("@Time").Value)
      .Times = moUtil.FetchDouble(oCmd.Parameters.Item("@Times").Value)
      .IsInactive = moUtil.FetchInteger(oCmd.Parameters.Item("@IsInactive").Value)
      .TrainerScore = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerScore").Value)
      .CommStatus = moUtil.FetchLong(oCmd.Parameters.Item("@CommStatus").Value)
      .Apply = moUtil.FetchLong(oCmd.Parameters.Item("@Apply").Value)
      .Recommend1 = moUtil.FetchLong(oCmd.Parameters.Item("@Recommend1").Value)
      .Recommend2 = moUtil.FetchLong(oCmd.Parameters.Item("@Recommend2").Value)
      .Recommend3 = moUtil.FetchLong(oCmd.Parameters.Item("@Recommend3").Value)
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

Public Function ListMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
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

Public Function ListMemberStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListMemberStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberStatus = vRecs

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

Public Function ListMemberComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListMemberComplete")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberComplete = vRecs

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

Public Function ListMemberAll( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListMemberAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberAll = vRecs

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

Public Function ListMemberAllStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberAllStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListMemberAllStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberAllStatus = vRecs

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

Public Function ListMemberAllComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberAllComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListMemberAllComplete")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberAllComplete = vRecs

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

Public Function ListOrgMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListOrgMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOrgMember = vRecs

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

Public Function ListOrgMemberStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListOrgMemberStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOrgMemberStatus = vRecs

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

Public Function ListOrgMemberComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListOrgMemberComplete")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOrgMemberComplete = vRecs

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

Public Function ListOrgMemberAll( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListOrgMemberAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOrgMemberAll = vRecs

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

Public Function ListOrgMemberAllStatus( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberAllStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListOrgMemberAllStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOrgMemberAllStatus = vRecs

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

Public Function ListOrgMemberAllComplete( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrgMemberAllComplete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListOrgMemberAllComplete")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.Video = moUtil.FetchLong(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchLong(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.RegisterDate = moUtil.FetchDate(.Fields.Item("RegisterDate").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.IsInactive = moUtil.FetchInteger(.Fields.Item("IsInactive").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOrgMemberAllComplete = vRecs

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

Public Function ProgramSummary( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvMemberID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProgramSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvOrgID = moUtil.EditLong(bvOrgID, "OrgID", True, 0) 
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ProgramSummary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
            vRec.OCStatus = moUtil.FetchLong(.Fields.Item("OCStatus").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ProgramSummary = vRecs

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

Public Function ListCourse( _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(bvCourseID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListCourse")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCourse = vRecs

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

Public Function ListRatings( _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvUserID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListRatings"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(bvCourseID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ListRatings")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Rating1 = moUtil.FetchLong(.Fields.Item("Rating1").Value)
            vRec.Rating2 = moUtil.FetchLong(.Fields.Item("Rating2").Value)
            vRec.Rating3 = moUtil.FetchLong(.Fields.Item("Rating3").Value)
            vRec.Rating4 = moUtil.FetchLong(.Fields.Item("Rating4").Value)
            vRec.TotalRating = moUtil.FetchLong(.Fields.Item("TotalRating").Value)
            vRec.Feedback = moUtil.FetchString(.Fields.Item("Feedback").Value)
            vRec.Apply = moUtil.FetchLong(.Fields.Item("Apply").Value)
            vRec.Recommend1 = moUtil.FetchLong(.Fields.Item("Recommend1").Value)
            vRec.Recommend2 = moUtil.FetchLong(.Fields.Item("Recommend2").Value)
            vRec.Recommend3 = moUtil.FetchLong(.Fields.Item("Recommend3").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListRatings = vRecs

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

Public Function ReportOrg( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ReportOrg")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.OCStatus = moUtil.FetchLong(.Fields.Item("OCStatus").Value)
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
   ReportOrg = vRecs

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

Public Function ReportOrgCourse( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportOrgCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(bvCourseID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ReportOrgCourse")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.StudentName = moUtil.FetchString(.Fields.Item("StudentName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportOrgCourse = vRecs

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

Public Function ReportMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_ReportMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.Feedback = moUtil.FetchString(.Fields.Item("Feedback").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchDouble(.Fields.Item("Times").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportMember = vRecs

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

Public Function CoursesMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CoursesMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(bvStartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(bvCompleteDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_CoursesMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
            vRec.Num1 = moUtil.FetchLong(.Fields.Item("Num1").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CoursesMember = vRecs

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

Public Function CoursesBusiness( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date, _ 
   ByVal bvCourseID As Long) As tSessionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CoursesBusiness"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionType
   Dim vRec As tSessionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(bvStartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(bvCompleteDate))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(bvCourseID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_CoursesBusiness")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionID = moUtil.FetchLong(.Fields.Item("SessionID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Num1 = moUtil.FetchLong(.Fields.Item("Num1").Value)
            vRec.Num2 = moUtil.FetchLong(.Fields.Item("Num2").Value)
            vRec.Num3 = moUtil.FetchLong(.Fields.Item("Num3").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CoursesBusiness = vRecs

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
   ByRef brRec As tSessionType, _ 
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
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamInput, vbNull, CLng(brRec.OrgCourseID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@RegisterDate", adDate, adParamInput, vbNull, CDate(brRec.RegisterDate))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Grade", adInteger, adParamInput, vbNull, CLng(brRec.Grade))
      .Parameters.Append .CreateParameter("@Feedback", adVarWChar, adParamInput, 2000, brRec.Feedback)
      .Parameters.Append .CreateParameter("@Rating1", adInteger, adParamInput, vbNull, CLng(brRec.Rating1))
      .Parameters.Append .CreateParameter("@Rating2", adInteger, adParamInput, vbNull, CLng(brRec.Rating2))
      .Parameters.Append .CreateParameter("@Rating3", adInteger, adParamInput, vbNull, CLng(brRec.Rating3))
      .Parameters.Append .CreateParameter("@Rating4", adInteger, adParamInput, vbNull, CLng(brRec.Rating4))
      .Parameters.Append .CreateParameter("@TotalRating", adInteger, adParamInput, vbNull, CLng(brRec.TotalRating))
      .Parameters.Append .CreateParameter("@URLOption", adInteger, adParamInput, vbNull, CLng(brRec.URLOption))
      .Parameters.Append .CreateParameter("@Time", adInteger, adParamInput, vbNull, CLng(brRec.Time))
      Dim tmpParamTimes As ADODB.Parameter
      Set tmpParamTimes = .CreateParameter("@Times", adNumeric, adParamInput, 10, CDbl(brRec.Times))
      tmpParamTimes.Precision = 10
      tmpParamTimes.NumericScale = 8
      .Parameters.Append tmpParamTimes
      .Parameters.Append .CreateParameter("@IsInactive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsInactive))
      .Parameters.Append .CreateParameter("@TrainerScore", adInteger, adParamInput, vbNull, CLng(brRec.TrainerScore))
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@Apply", adInteger, adParamInput, vbNull, CLng(brRec.Apply))
      .Parameters.Append .CreateParameter("@Recommend1", adInteger, adParamInput, vbNull, CLng(brRec.Recommend1))
      .Parameters.Append .CreateParameter("@Recommend2", adInteger, adParamInput, vbNull, CLng(brRec.Recommend2))
      .Parameters.Append .CreateParameter("@Recommend3", adInteger, adParamInput, vbNull, CLng(brRec.Recommend3))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Session_Update"

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
   ByRef brRec As tSessionType, _ 
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
         .SessionID = moUtil.EditLong(.SessionID, "SessionID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .CourseID = moUtil.EditLong(.CourseID, "CourseID", False) 
      .OrgCourseID = moUtil.EditLong(.OrgCourseID, "OrgCourseID", False) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 30) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .RegisterDate = moUtil.EditDate(.RegisterDate, "RegisterDate", False) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .CompleteDate = moUtil.EditDate(.CompleteDate, "CompleteDate", False) 
      .Grade = moUtil.EditLong(.Grade, "Grade", False) 
      .Feedback = moUtil.EditString(.Feedback, "Feedback", False, , 1, 2000) 
      .Rating1 = moUtil.EditLong(.Rating1, "Rating1", False) 
      .Rating2 = moUtil.EditLong(.Rating2, "Rating2", False) 
      .Rating3 = moUtil.EditLong(.Rating3, "Rating3", False) 
      .Rating4 = moUtil.EditLong(.Rating4, "Rating4", False) 
      .TotalRating = moUtil.EditLong(.TotalRating, "TotalRating", False) 
      .URLOption = moUtil.EditLong(.URLOption, "URLOption", False) 
      .Time = moUtil.EditLong(.Time, "Time", False) 
      .Times = moUtil.EditDouble(.Times, "Times", False) 
      .IsInactive = moUtil.EditInteger(.IsInactive, "IsInactive", False, 0, 0, 1) 
      .TrainerScore = moUtil.EditLong(.TrainerScore, "TrainerScore", False) 
      .CommStatus = moUtil.EditLong(.CommStatus, "CommStatus", False) 
      .Apply = moUtil.EditLong(.Apply, "Apply", False) 
      .Recommend1 = moUtil.EditLong(.Recommend1, "Recommend1", False) 
      .Recommend2 = moUtil.EditLong(.Recommend2, "Recommend2", False) 
      .Recommend3 = moUtil.EditLong(.Recommend3, "Recommend3", False) 
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