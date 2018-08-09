VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "COrgCourseB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "COrgCourse"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tOrgCourseType
   OrgCourseID As String
   OrgID As String
   CourseID As String
   Status As String
   QuizLimit As String
   Seq As String
End Type

Public Sub Add( _ 
   ByRef brRec As tOrgCourseType, _ 
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
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_OrgCourse_Add"

   '-----get return values
   With brRec
      .OrgCourseID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgCourseID").Value)
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

Public Function GetOrgCourse( _ 
   ByRef brRec As tOrgCourseType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetOrgCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_OrgCourse_GetOrgCourse"

   '-----get return values
   GetOrgCourse = moUtil.FetchLong(oCmd.Parameters.Item("@OrgCourseID").Value)

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
   ByRef brRec As tOrgCourseType, _ 
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
      .OrgCourseID = moUtil.EditLong(.OrgCourseID, "OrgCourseID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamInput, vbNull, CLng(brRec.OrgCourseID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_OrgCourse_Delete"

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
   ByRef brRec As tOrgCourseType, _ 
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
      .OrgCourseID = moUtil.EditLong(.OrgCourseID, "OrgCourseID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamInput, vbNull, CLng(brRec.OrgCourseID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_OrgCourse_Fetch"

   '-----get return values
   With brRec
      .OrgID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgID").Value)
      .CourseID = moUtil.FetchLong(oCmd.Parameters.Item("@CourseID").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .QuizLimit = moUtil.FetchLong(oCmd.Parameters.Item("@QuizLimit").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
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

Public Sub Update( _ 
   ByRef brRec As tOrgCourseType, _ 
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
      .Parameters.Append .CreateParameter("@OrgCourseID", adInteger, adParamInput, vbNull, CLng(brRec.OrgCourseID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_OrgCourse_Update"

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
   ByRef brRec As tOrgCourseType, _ 
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
         .OrgCourseID = moUtil.EditLong(.OrgCourseID, "OrgCourseID", True, , 1) 
      End If
      .OrgID = moUtil.EditLong(.OrgID, "OrgID", False) 
      .CourseID = moUtil.EditLong(.CourseID, "CourseID", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .QuizLimit = moUtil.EditLong(.QuizLimit, "QuizLimit", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
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