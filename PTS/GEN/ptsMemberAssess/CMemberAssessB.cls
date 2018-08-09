VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMemberAssessB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMemberAssess"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMemberAssessType
   MemberAssessID As String
   MemberID As String
   AssessmentID As String
   AssessmentName As String
   IsCertify As String
   NoCertificate As String
   IsCustomCertificate As String
   CompanyID As String
   MemberName As String
   StartDate As String
   CompleteDate As String
   Status As String
   ExternalID As String
   Result As String
   Score As String
   TrainerScore As String
   CommStatus As String
   IsPrivate As String
   IsRemoved As String
   NewResult As String
   Num1 As String
   Num2 As String
   Num3 As String
   Num4 As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMemberAssessType, _ 
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
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@ExternalID", adVarWChar, adParamInput, 30, brRec.ExternalID)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamInput, 1000, brRec.Result)
      Dim tmpParamScore As ADODB.Parameter
      Set tmpParamScore = .CreateParameter("@Score", adNumeric, adParamInput, 10, CDbl(brRec.Score))
      tmpParamScore.Precision = 10
      tmpParamScore.NumericScale = 6
      .Parameters.Append tmpParamScore
      .Parameters.Append .CreateParameter("@TrainerScore", adInteger, adParamInput, vbNull, CLng(brRec.TrainerScore))
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@IsRemoved", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRemoved))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_Add"

   '-----get return values
   With brRec
      .MemberAssessID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberAssessID").Value)
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

Public Function CalcResult( _ 
   ByRef brRec As tMemberAssessType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcResult"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@NewResult", adVarWChar, adParamInput, 1000, brRec.NewResult)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CalcResult"

   '-----get return values
   CalcResult = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetPrivate( _ 
   ByRef brRec As tMemberAssessType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetPrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_SetPrivate"

   '-----get return values
   SetPrivate = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetCourses( _ 
   ByRef brRec As tMemberAssessType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetCourses"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamOutput, 100, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_GetCourses"

   '-----get return values
   GetCourses = moUtil.FetchString(oCmd.Parameters.Item("@Courses").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CalcMaster( _ 
   ByRef brRec As tMemberAssessType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcMaster"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CalcMaster"

   '-----get return values
   CalcMaster = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CheckAssessment( _ 
   ByRef brRec As tMemberAssessType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckAssessment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CheckAssessment"

   '-----get return values
   CheckAssessment = moUtil.FetchLong(oCmd.Parameters.Item("@MemberAssessID").Value)

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
   ByRef brRec As tMemberAssessType, _ 
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
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_Reset"

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_Count"

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
   ByRef brRec As tMemberAssessType, _ 
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
      .MemberAssessID = moUtil.EditLong(.MemberAssessID, "MemberAssessID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_Delete"

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
   ByRef brRec As tMemberAssessType, _ 
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
      .MemberAssessID = moUtil.EditLong(.MemberAssessID, "MemberAssessID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessmentName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@IsCertify", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExternalID", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
      Dim tmpParamScore As ADODB.Parameter
      Set tmpParamScore = .CreateParameter("@Score", adNumeric, adParamOutput, 10, vbNull)
      tmpParamScore.Precision = 10
      tmpParamScore.NumericScale = 6
      .Parameters.Append tmpParamScore
      .Parameters.Append .CreateParameter("@TrainerScore", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsRemoved", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .AssessmentID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessmentID").Value)
      .AssessmentName = moUtil.FetchString(oCmd.Parameters.Item("@AssessmentName").Value)
      .IsCertify = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCertify").Value)
      .NoCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@NoCertificate").Value)
      .IsCustomCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCustomCertificate").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .CompleteDate = moUtil.FetchDate(oCmd.Parameters.Item("@CompleteDate").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .ExternalID = moUtil.FetchString(oCmd.Parameters.Item("@ExternalID").Value)
      .Result = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)
      .Score = moUtil.FetchDouble(oCmd.Parameters.Item("@Score").Value)
      .TrainerScore = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerScore").Value)
      .CommStatus = moUtil.FetchLong(oCmd.Parameters.Item("@CommStatus").Value)
      .IsPrivate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPrivate").Value)
      .IsRemoved = moUtil.FetchInteger(oCmd.Parameters.Item("@IsRemoved").Value)
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

Public Function ListAssessmentAll( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessmentAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_ListAssessmentAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ExternalID = moUtil.FetchString(.Fields.Item("ExternalID").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
            vRec.Score = moUtil.FetchDouble(.Fields.Item("Score").Value)
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
            vRec.NoCertificate = moUtil.FetchInteger(.Fields.Item("NoCertificate").Value)
            vRec.IsCustomCertificate = moUtil.FetchInteger(.Fields.Item("IsCustomCertificate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
            vRec.IsRemoved = moUtil.FetchInteger(.Fields.Item("IsRemoved").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessmentAll = vRecs

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

Public Function ListAssessment( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvUserID As Long) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_ListAssessment")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ExternalID = moUtil.FetchString(.Fields.Item("ExternalID").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
            vRec.Score = moUtil.FetchDouble(.Fields.Item("Score").Value)
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
            vRec.NoCertificate = moUtil.FetchInteger(.Fields.Item("NoCertificate").Value)
            vRec.IsCustomCertificate = moUtil.FetchInteger(.Fields.Item("IsCustomCertificate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
            vRec.IsRemoved = moUtil.FetchInteger(.Fields.Item("IsRemoved").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessment = vRecs

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

Public Function ListCompany( _ 
   ByVal bvAssessmentID As Long, _ 
   ByVal bvCompanyID As Long) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAssessmentID = moUtil.EditLong(bvAssessmentID, "AssessmentID", True, 0) 
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_ListCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompany = vRecs

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

Public Function CertifyLookup( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvMemberName As String, _ 
   ByVal bvAssessmentID As Long) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CertifyLookup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamInput, 60, bvMemberName)
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CertifyLookup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
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
   CertifyLookup = vRecs

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

Public Function CertifyMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CertifyMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(bvStartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(bvCompleteDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CertifyMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
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
   CertifyMember = vRecs

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

Public Function CertifyBusiness( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date, _ 
   ByVal bvAssessmentID As Long) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CertifyBusiness"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(bvStartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(bvCompleteDate))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CertifyBusiness")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
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
   CertifyBusiness = vRecs

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

Public Function CertifyCompany( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date, _ 
   ByVal bvAssessmentID As Long) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CertifyCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(bvStartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(bvCompleteDate))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CertifyCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
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
   CertifyCompany = vRecs

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

Public Function CertifyCompanyGrp( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStartDate As Date, _ 
   ByVal bvCompleteDate As Date, _ 
   ByVal bvAssessmentID As Long) As tMemberAssessType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CertifyCompanyGrp"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberAssessType
   Dim vRec As tMemberAssessType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(bvStartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(bvCompleteDate))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_CertifyCompanyGrp")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberAssessID = moUtil.FetchLong(.Fields.Item("MemberAssessID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
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
   CertifyCompanyGrp = vRecs

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
   ByRef brRec As tMemberAssessType, _ 
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
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@ExternalID", adVarWChar, adParamInput, 30, brRec.ExternalID)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamInput, 1000, brRec.Result)
      Dim tmpParamScore As ADODB.Parameter
      Set tmpParamScore = .CreateParameter("@Score", adNumeric, adParamInput, 10, CDbl(brRec.Score))
      tmpParamScore.Precision = 10
      tmpParamScore.NumericScale = 6
      .Parameters.Append tmpParamScore
      .Parameters.Append .CreateParameter("@TrainerScore", adInteger, adParamInput, vbNull, CLng(brRec.TrainerScore))
      .Parameters.Append .CreateParameter("@CommStatus", adInteger, adParamInput, vbNull, CLng(brRec.CommStatus))
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@IsRemoved", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRemoved))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberAssess_Update"

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
   ByRef brRec As tMemberAssessType, _ 
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
         .MemberAssessID = moUtil.EditLong(.MemberAssessID, "MemberAssessID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True) 
      .AssessmentID = moUtil.EditLong(.AssessmentID, "AssessmentID", True) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .CompleteDate = moUtil.EditDate(.CompleteDate, "CompleteDate", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .ExternalID = moUtil.EditString(.ExternalID, "ExternalID", False, , 1, 30) 
      .Result = moUtil.EditString(.Result, "Result", False, , 1, 1000) 
      .Score = moUtil.EditDouble(.Score, "Score", False) 
      .TrainerScore = moUtil.EditLong(.TrainerScore, "TrainerScore", False) 
      .CommStatus = moUtil.EditLong(.CommStatus, "CommStatus", False) 
      .IsPrivate = moUtil.EditInteger(.IsPrivate, "IsPrivate", False, 0, 0, 1) 
      .IsRemoved = moUtil.EditInteger(.IsRemoved, "IsRemoved", False, 0, 0, 1) 
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