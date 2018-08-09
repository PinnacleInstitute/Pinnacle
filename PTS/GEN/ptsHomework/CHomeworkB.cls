VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CHomeworkB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CHomework"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tHomeworkType
   HomeworkID As String
   LessonID As String
   LessonName As String
   Name As String
   Description As String
   Seq As String
   Weight As String
   IsGrade As String
   SessionLessonID As String
   AttachmentID As String
   Score As String
   CourseID As String
   SessionID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tHomeworkType, _ 
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
      .Parameters.Append .CreateParameter("@HomeworkID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@Name", adVarWChar, adParamInput, 60, brRec.Name)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Weight", adInteger, adParamInput, vbNull, CLng(brRec.Weight))
      .Parameters.Append .CreateParameter("@IsGrade", adSmallInt, adParamInput, vbNull, CInt(brRec.IsGrade))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_Add"

   '-----get return values
   With brRec
      .HomeworkID = moUtil.FetchLong(oCmd.Parameters.Item("@HomeworkID").Value)
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

Public Sub Delete( _ 
   ByRef brRec As tHomeworkType, _ 
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
      .HomeworkID = moUtil.EditLong(.HomeworkID, "HomeworkID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@HomeworkID", adInteger, adParamInput, vbNull, CLng(brRec.HomeworkID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_Delete"

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
   ByRef brRec As tHomeworkType, _ 
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
      .HomeworkID = moUtil.EditLong(.HomeworkID, "HomeworkID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@HomeworkID", adInteger, adParamInput, vbNull, CLng(brRec.HomeworkID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LessonName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Name", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Weight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsGrade", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_Fetch"

   '-----get return values
   With brRec
      .LessonID = moUtil.FetchLong(oCmd.Parameters.Item("@LessonID").Value)
      .LessonName = moUtil.FetchString(oCmd.Parameters.Item("@LessonName").Value)
      .Name = moUtil.FetchString(oCmd.Parameters.Item("@Name").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .Weight = moUtil.FetchLong(oCmd.Parameters.Item("@Weight").Value)
      .IsGrade = moUtil.FetchInteger(oCmd.Parameters.Item("@IsGrade").Value)
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
   ByVal bvLessonID As Long) As tHomeworkType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tHomeworkType
   Dim vRec As tHomeworkType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvLessonID = moUtil.EditLong(bvLessonID, "LessonID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(bvLessonID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.HomeworkID = moUtil.FetchLong(.Fields.Item("HomeworkID").Value)
            vRec.Name = moUtil.FetchString(.Fields.Item("Name").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Weight = moUtil.FetchLong(.Fields.Item("Weight").Value)
            vRec.IsGrade = moUtil.FetchInteger(.Fields.Item("IsGrade").Value)
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

Public Function ListAttachment( _ 
   ByVal bvSessionLessonID As Long) As tHomeworkType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAttachment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tHomeworkType
   Dim vRec As tHomeworkType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvSessionLessonID = moUtil.EditLong(bvSessionLessonID, "SessionLessonID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(bvSessionLessonID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_ListAttachment")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.HomeworkID = moUtil.FetchLong(.Fields.Item("HomeworkID").Value)
            vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
            vRec.Name = moUtil.FetchString(.Fields.Item("Name").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Weight = moUtil.FetchLong(.Fields.Item("Weight").Value)
            vRec.IsGrade = moUtil.FetchInteger(.Fields.Item("IsGrade").Value)
            vRec.Score = moUtil.FetchLong(.Fields.Item("Score").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAttachment = vRecs

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

Public Function ListSession( _ 
   ByVal bvSessionID As Long) As tHomeworkType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSession"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tHomeworkType
   Dim vRec As tHomeworkType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvSessionID = moUtil.EditLong(bvSessionID, "SessionID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionID", adInteger, adParamInput, vbNull, CLng(bvSessionID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_ListSession")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.HomeworkID = moUtil.FetchLong(.Fields.Item("HomeworkID").Value)
            vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
            vRec.Name = moUtil.FetchString(.Fields.Item("Name").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Weight = moUtil.FetchLong(.Fields.Item("Weight").Value)
            vRec.IsGrade = moUtil.FetchInteger(.Fields.Item("IsGrade").Value)
            vRec.Score = moUtil.FetchLong(.Fields.Item("Score").Value)
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

Public Function ListGrade( _ 
   ByVal bvCourseID As Long) As tHomeworkType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGrade"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tHomeworkType
   Dim vRec As tHomeworkType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCourseID = moUtil.EditLong(bvCourseID, "CourseID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(bvCourseID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_ListGrade")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.HomeworkID = moUtil.FetchLong(.Fields.Item("HomeworkID").Value)
            vRec.Name = moUtil.FetchString(.Fields.Item("Name").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListGrade = vRecs

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
   ByRef brRec As tHomeworkType, _ 
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
      .Parameters.Append .CreateParameter("@HomeworkID", adInteger, adParamInput, vbNull, CLng(brRec.HomeworkID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@Name", adVarWChar, adParamInput, 60, brRec.Name)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Weight", adInteger, adParamInput, vbNull, CLng(brRec.Weight))
      .Parameters.Append .CreateParameter("@IsGrade", adSmallInt, adParamInput, vbNull, CInt(brRec.IsGrade))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Homework_Update"

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
   ByRef brRec As tHomeworkType, _ 
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
         .HomeworkID = moUtil.EditLong(.HomeworkID, "HomeworkID", True, , 1) 
      End If
      .LessonID = moUtil.EditLong(.LessonID, "LessonID", False) 
      .Name = moUtil.EditString(.Name, "Name", False) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 2000) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .Weight = moUtil.EditLong(.Weight, "Weight", False) 
      .IsGrade = moUtil.EditInteger(.IsGrade, "IsGrade", False, 0, 0, 1) 
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