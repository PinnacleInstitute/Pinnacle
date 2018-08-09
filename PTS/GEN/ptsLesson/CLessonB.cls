VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CLessonB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CLesson"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tLessonType
   LessonID As String
   CourseID As String
   CourseName As String
   LessonName As String
   Description As String
   Status As String
   LessonLength As String
   Seq As String
   MediaURL As String
   MediaType As String
   MediaLength As String
   MediaWidth As String
   MediaHeight As String
   Content As String
   Quiz As String
   QuizLimit As String
   QuizLength As String
   PassingGrade As String
   QuizWeight As String
   IsPassQuiz As String
End Type

Public Sub Add( _ 
   ByRef brRec As tLessonType, _ 
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
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@LessonName", adVarWChar, adParamInput, 80, brRec.LessonName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@LessonLength", adInteger, adParamInput, vbNull, CLng(brRec.LessonLength))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@MediaURL", adVarWChar, adParamInput, 250, brRec.MediaURL)
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamInput, vbNull, CLng(brRec.MediaType))
      .Parameters.Append .CreateParameter("@MediaLength", adInteger, adParamInput, vbNull, CLng(brRec.MediaLength))
      .Parameters.Append .CreateParameter("@MediaWidth", adInteger, adParamInput, vbNull, CLng(brRec.MediaWidth))
      .Parameters.Append .CreateParameter("@MediaHeight", adInteger, adParamInput, vbNull, CLng(brRec.MediaHeight))
      .Parameters.Append .CreateParameter("@Content", adInteger, adParamInput, vbNull, CLng(brRec.Content))
      .Parameters.Append .CreateParameter("@Quiz", adInteger, adParamInput, vbNull, CLng(brRec.Quiz))
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@QuizLength", adInteger, adParamInput, vbNull, CLng(brRec.QuizLength))
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamInput, vbNull, CLng(brRec.PassingGrade))
      .Parameters.Append .CreateParameter("@QuizWeight", adInteger, adParamInput, vbNull, CLng(brRec.QuizWeight))
      .Parameters.Append .CreateParameter("@IsPassQuiz", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPassQuiz))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lesson_Add"

   '-----get return values
   With brRec
      .LessonID = moUtil.FetchLong(oCmd.Parameters.Item("@LessonID").Value)
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lesson_Count"

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
   ByRef brRec As tLessonType, _ 
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
      .LessonID = moUtil.EditLong(.LessonID, "LessonID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lesson_Delete"

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
   ByRef brRec As tLessonType, _ 
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
      .LessonID = moUtil.EditLong(.LessonID, "LessonID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@LessonName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LessonLength", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaURL", adVarWChar, adParamOutput, 250, vbNull)
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaLength", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaWidth", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaHeight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Content", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Quiz", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizLength", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizWeight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPassQuiz", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lesson_Fetch"

   '-----get return values
   With brRec
      .CourseID = moUtil.FetchLong(oCmd.Parameters.Item("@CourseID").Value)
      .CourseName = moUtil.FetchString(oCmd.Parameters.Item("@CourseName").Value)
      .LessonName = moUtil.FetchString(oCmd.Parameters.Item("@LessonName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .LessonLength = moUtil.FetchLong(oCmd.Parameters.Item("@LessonLength").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .MediaURL = moUtil.FetchString(oCmd.Parameters.Item("@MediaURL").Value)
      .MediaType = moUtil.FetchLong(oCmd.Parameters.Item("@MediaType").Value)
      .MediaLength = moUtil.FetchLong(oCmd.Parameters.Item("@MediaLength").Value)
      .MediaWidth = moUtil.FetchLong(oCmd.Parameters.Item("@MediaWidth").Value)
      .MediaHeight = moUtil.FetchLong(oCmd.Parameters.Item("@MediaHeight").Value)
      .Content = moUtil.FetchLong(oCmd.Parameters.Item("@Content").Value)
      .Quiz = moUtil.FetchLong(oCmd.Parameters.Item("@Quiz").Value)
      .QuizLimit = moUtil.FetchLong(oCmd.Parameters.Item("@QuizLimit").Value)
      .QuizLength = moUtil.FetchLong(oCmd.Parameters.Item("@QuizLength").Value)
      .PassingGrade = moUtil.FetchLong(oCmd.Parameters.Item("@PassingGrade").Value)
      .QuizWeight = moUtil.FetchLong(oCmd.Parameters.Item("@QuizWeight").Value)
      .IsPassQuiz = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPassQuiz").Value)
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

Public Function ListCourse( _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvUserID As Long) As tLessonType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLessonType
   Dim vRec As tLessonType
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
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lesson_ListCourse")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LessonID = moUtil.FetchLong(.Fields.Item("LessonID").Value)
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.LessonName = moUtil.FetchString(.Fields.Item("LessonName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.LessonLength = moUtil.FetchLong(.Fields.Item("LessonLength").Value)
            vRec.MediaType = moUtil.FetchLong(.Fields.Item("MediaType").Value)
            vRec.Quiz = moUtil.FetchLong(.Fields.Item("Quiz").Value)
            vRec.IsPassQuiz = moUtil.FetchInteger(.Fields.Item("IsPassQuiz").Value)
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

Public Sub Update( _ 
   ByRef brRec As tLessonType, _ 
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
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@LessonName", adVarWChar, adParamInput, 80, brRec.LessonName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@LessonLength", adInteger, adParamInput, vbNull, CLng(brRec.LessonLength))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@MediaURL", adVarWChar, adParamInput, 250, brRec.MediaURL)
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamInput, vbNull, CLng(brRec.MediaType))
      .Parameters.Append .CreateParameter("@MediaLength", adInteger, adParamInput, vbNull, CLng(brRec.MediaLength))
      .Parameters.Append .CreateParameter("@MediaWidth", adInteger, adParamInput, vbNull, CLng(brRec.MediaWidth))
      .Parameters.Append .CreateParameter("@MediaHeight", adInteger, adParamInput, vbNull, CLng(brRec.MediaHeight))
      .Parameters.Append .CreateParameter("@Content", adInteger, adParamInput, vbNull, CLng(brRec.Content))
      .Parameters.Append .CreateParameter("@Quiz", adInteger, adParamInput, vbNull, CLng(brRec.Quiz))
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@QuizLength", adInteger, adParamInput, vbNull, CLng(brRec.QuizLength))
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamInput, vbNull, CLng(brRec.PassingGrade))
      .Parameters.Append .CreateParameter("@QuizWeight", adInteger, adParamInput, vbNull, CLng(brRec.QuizWeight))
      .Parameters.Append .CreateParameter("@IsPassQuiz", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPassQuiz))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Lesson_Update"

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
   ByRef brRec As tLessonType, _ 
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
         .LessonID = moUtil.EditLong(.LessonID, "LessonID", True, , 1) 
      End If
      .CourseID = moUtil.EditLong(.CourseID, "CourseID", False) 
      .LessonName = moUtil.EditString(.LessonName, "LessonName", True, , 1, 80) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 1000) 
      .Status = moUtil.EditLong(.Status, "Status", True) 
      .LessonLength = moUtil.EditLong(.LessonLength, "LessonLength", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .MediaURL = moUtil.EditString(.MediaURL, "MediaURL", False, , 1, 250) 
      .MediaType = moUtil.EditLong(.MediaType, "MediaType", False) 
      .MediaLength = moUtil.EditLong(.MediaLength, "MediaLength", False) 
      .MediaWidth = moUtil.EditLong(.MediaWidth, "MediaWidth", False) 
      .MediaHeight = moUtil.EditLong(.MediaHeight, "MediaHeight", False) 
      .Content = moUtil.EditLong(.Content, "Content", False) 
      .Quiz = moUtil.EditLong(.Quiz, "Quiz", False) 
      .QuizLimit = moUtil.EditLong(.QuizLimit, "QuizLimit", False) 
      .QuizLength = moUtil.EditLong(.QuizLength, "QuizLength", False) 
      .PassingGrade = moUtil.EditLong(.PassingGrade, "PassingGrade", False, , 0, 100) 
      .QuizWeight = moUtil.EditLong(.QuizWeight, "QuizWeight", False, , 0, 100) 
      .IsPassQuiz = moUtil.EditInteger(.IsPassQuiz, "IsPassQuiz", False, 0, 0, 1) 
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