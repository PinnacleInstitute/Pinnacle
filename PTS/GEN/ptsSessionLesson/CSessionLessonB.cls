VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CSessionLessonB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSessionLesson"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tSessionLessonType
   SessionLessonID As String
   SessionID As String
   LessonID As String
   LessonName As String
   Description As String
   Content As String
   Quiz As String
   MediaType As String
   MediaURL As String
   LessonLength As String
   PassingGrade As String
   QuizWeight As String
   IsPassQuiz As String
   Status As String
   QuizScore As String
   CreateDate As String
   CompleteDate As String
   Time As String
   Times As String
   Questions As String
   Location As String
   Seq As String
End Type

Public Sub Add( _ 
   ByRef brRec As tSessionLessonType, _ 
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
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@QuizScore", adInteger, adParamInput, vbNull, CLng(brRec.QuizScore))
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Time", adInteger, adParamInput, vbNull, CLng(brRec.Time))
      .Parameters.Append .CreateParameter("@Times", adInteger, adParamInput, vbNull, CLng(brRec.Times))
      .Parameters.Append .CreateParameter("@Questions", adVarWChar, adParamInput, 200, brRec.Questions)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 20, brRec.Location)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_Add"

   '-----get return values
   With brRec
      .SessionLessonID = moUtil.FetchLong(oCmd.Parameters.Item("@SessionLessonID").Value)
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

Public Function GetSessionLesson( _ 
   ByRef brRec As tSessionLessonType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetSessionLesson"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_GetSessionLesson"

   '-----get return values
   GetSessionLesson = moUtil.FetchLong(oCmd.Parameters.Item("@SessionLessonID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function DeleteQuiz( _ 
   ByRef brRec As tSessionLessonType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DeleteQuiz"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_DeleteQuiz"

   '-----get return values
   DeleteQuiz = moUtil.FetchLong(oCmd.Parameters.Item("@SessionLessonID").Value)

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
   ByRef brRec As tSessionLessonType, _ 
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
      .SessionLessonID = moUtil.EditLong(.SessionLessonID, "SessionLessonID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(brRec.SessionLessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_Delete"

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
   ByRef brRec As tSessionLessonType, _ 
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
      .SessionLessonID = moUtil.EditLong(.SessionLessonID, "SessionLessonID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(brRec.SessionLessonID))
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LessonName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Content", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Quiz", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaURL", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@LessonLength", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizWeight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPassQuiz", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizScore", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Time", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Times", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Questions", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_Fetch"

   '-----get return values
   With brRec
      .SessionID = moUtil.FetchLong(oCmd.Parameters.Item("@SessionID").Value)
      .LessonID = moUtil.FetchLong(oCmd.Parameters.Item("@LessonID").Value)
      .LessonName = moUtil.FetchString(oCmd.Parameters.Item("@LessonName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Content = moUtil.FetchInteger(oCmd.Parameters.Item("@Content").Value)
      .Quiz = moUtil.FetchInteger(oCmd.Parameters.Item("@Quiz").Value)
      .MediaType = moUtil.FetchLong(oCmd.Parameters.Item("@MediaType").Value)
      .MediaURL = moUtil.FetchString(oCmd.Parameters.Item("@MediaURL").Value)
      .LessonLength = moUtil.FetchLong(oCmd.Parameters.Item("@LessonLength").Value)
      .PassingGrade = moUtil.FetchLong(oCmd.Parameters.Item("@PassingGrade").Value)
      .QuizWeight = moUtil.FetchLong(oCmd.Parameters.Item("@QuizWeight").Value)
      .IsPassQuiz = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPassQuiz").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .QuizScore = moUtil.FetchLong(oCmd.Parameters.Item("@QuizScore").Value)
      .CreateDate = moUtil.FetchDate(oCmd.Parameters.Item("@CreateDate").Value)
      .CompleteDate = moUtil.FetchDate(oCmd.Parameters.Item("@CompleteDate").Value)
      .Time = moUtil.FetchLong(oCmd.Parameters.Item("@Time").Value)
      .Times = moUtil.FetchLong(oCmd.Parameters.Item("@Times").Value)
      .Questions = moUtil.FetchString(oCmd.Parameters.Item("@Questions").Value)
      .Location = moUtil.FetchString(oCmd.Parameters.Item("@Location").Value)
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

Public Function ListSession( _ 
   ByVal bvLessonID As Long, _ 
   ByVal bvSessionID As Long, _ 
   ByVal bvDescription As String, _ 
   ByVal bvUserID As Long) As tSessionLessonType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSession"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionLessonType
   Dim vRec As tSessionLessonType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(bvLessonID))
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(bvSessionID))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, bvDescription)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_ListSession")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionLessonID = moUtil.FetchLong(.Fields.Item("SessionLessonID").Value)
            vRec.LessonID = moUtil.FetchLong(.Fields.Item("LessonID").Value)
            vRec.LessonName = moUtil.FetchString(.Fields.Item("LessonName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Content = moUtil.FetchInteger(.Fields.Item("Content").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.MediaType = moUtil.FetchLong(.Fields.Item("MediaType").Value)
            vRec.MediaURL = moUtil.FetchString(.Fields.Item("MediaURL").Value)
            vRec.LessonLength = moUtil.FetchLong(.Fields.Item("LessonLength").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.QuizWeight = moUtil.FetchLong(.Fields.Item("QuizWeight").Value)
            vRec.IsPassQuiz = moUtil.FetchInteger(.Fields.Item("IsPassQuiz").Value)
            vRec.QuizScore = moUtil.FetchLong(.Fields.Item("QuizScore").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Time = moUtil.FetchLong(.Fields.Item("Time").Value)
            vRec.Times = moUtil.FetchLong(.Fields.Item("Times").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListSession = vRecs

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

Public Function ListQuiz( _ 
   ByVal bvLessonID As Long, _ 
   ByVal bvSessionID As Long) As tSessionLessonType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListQuiz"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSessionLessonType
   Dim vRec As tSessionLessonType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(bvLessonID))
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(bvSessionID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_ListQuiz")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SessionLessonID = moUtil.FetchLong(.Fields.Item("SessionLessonID").Value)
            vRec.LessonName = moUtil.FetchString(.Fields.Item("LessonName").Value)
            vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
            vRec.QuizWeight = moUtil.FetchLong(.Fields.Item("QuizWeight").Value)
            vRec.QuizScore = moUtil.FetchLong(.Fields.Item("QuizScore").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListQuiz = vRecs

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
   ByRef brRec As tSessionLessonType, _ 
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
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(brRec.SessionLessonID))
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(brRec.SessionID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@QuizScore", adInteger, adParamInput, vbNull, CLng(brRec.QuizScore))
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Time", adInteger, adParamInput, vbNull, CLng(brRec.Time))
      .Parameters.Append .CreateParameter("@Times", adInteger, adParamInput, vbNull, CLng(brRec.Times))
      .Parameters.Append .CreateParameter("@Questions", adVarWChar, adParamInput, 200, brRec.Questions)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 20, brRec.Location)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SessionLesson_Update"

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
   ByRef brRec As tSessionLessonType, _ 
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
         .SessionLessonID = moUtil.EditLong(.SessionLessonID, "SessionLessonID", True, , 1) 
      End If
      .SessionID = moUtil.EditLong(.SessionID, "SessionID", False) 
      .LessonID = moUtil.EditLong(.LessonID, "LessonID", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .QuizScore = moUtil.EditLong(.QuizScore, "QuizScore", False) 
      .CreateDate = moUtil.EditDate(.CreateDate, "CreateDate", False) 
      .CompleteDate = moUtil.EditDate(.CompleteDate, "CompleteDate", False) 
      .Time = moUtil.EditLong(.Time, "Time", False) 
      .Times = moUtil.EditLong(.Times, "Times", False) 
      .Questions = moUtil.EditString(.Questions, "Questions", False) 
      .Location = moUtil.EditString(.Location, "Location", False) 
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