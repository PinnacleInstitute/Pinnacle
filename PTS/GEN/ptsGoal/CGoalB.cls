VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CGoalB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CGoal"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tGoalType
   GoalID As String
   MemberID As String
   ParentID As String
   AssignID As String
   CompanyID As String
   ProspectID As String
   NameLast As String
   NameFirst As String
   MemberName As String
   AssignNameLast As String
   AssignNameFirst As String
   AssignName As String
   ProspectName As String
   GoalName As String
   Description As String
   GoalType As String
   Priority As String
   Status As String
   CreateDate As String
   CommitDate As String
   CompleteDate As String
   Variance As String
   RemindDate As String
   Template As String
   Children As String
   Qty As String
   ActQty As String
   FromDate As String
   ToDate As String
   Num1 As String
   Num2 As String
   Num3 As String
   Email As String
   FromEmail As String
   IsMsg As String
End Type

Public Sub Add( _ 
   ByRef brRec As tGoalType, _ 
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
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@AssignID", adInteger, adParamInput, vbNull, CLng(brRec.AssignID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@GoalName", adVarWChar, adParamInput, 60, brRec.GoalName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@GoalType", adInteger, adParamInput, vbNull, CLng(brRec.GoalType))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(brRec.Priority))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@CommitDate", adDate, adParamInput, vbNull, CDate(brRec.CommitDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Variance", adInteger, adParamInput, vbNull, CLng(brRec.Variance))
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamInput, vbNull, CDate(brRec.RemindDate))
      .Parameters.Append .CreateParameter("@Template", adInteger, adParamInput, vbNull, CLng(brRec.Template))
      .Parameters.Append .CreateParameter("@Children", adInteger, adParamInput, vbNull, CLng(brRec.Children))
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamInput, vbNull, CLng(brRec.Qty))
      .Parameters.Append .CreateParameter("@ActQty", adInteger, adParamInput, vbNull, CLng(brRec.ActQty))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Add"

   '-----get return values
   With brRec
      .GoalID = moUtil.FetchLong(oCmd.Parameters.Item("@GoalID").Value)
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

Public Function Copy( _ 
   ByRef brRec As tGoalType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Copy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .GoalID = moUtil.EditLong(.GoalID, "GoalID", True, 0, 1) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", False, 0) 
      .GoalName = moUtil.EditString(.GoalName, "GoalName", False, "", 1, 60) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(brRec.GoalID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@GoalName", adVarWChar, adParamInput, 60, brRec.GoalName)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@NewGoalID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Copy"

   '-----get return values
   Copy = moUtil.FetchLong(oCmd.Parameters.Item("@NewGoalID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CheckTrack( _ 
   ByRef brRec As tGoalType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckTrack"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", True, 0, 1) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_CheckTrack"

   '-----get return values
   CheckTrack = moUtil.FetchLong(oCmd.Parameters.Item("@GoalID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub CalcChildren( _ 
   ByRef brRec As tGoalType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcChildren"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .GoalID = moUtil.EditLong(.GoalID, "GoalID", True, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(brRec.GoalID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_CalcChildren"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub UpdateStatus( _ 
   ByRef brRec As tGoalType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(brRec.GoalID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@ActQty", adInteger, adParamInput, vbNull, CLng(brRec.ActQty))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_UpdateStatus"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Count"

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
   ByRef brRec As tGoalType, _ 
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
      .GoalID = moUtil.EditLong(.GoalID, "GoalID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(brRec.GoalID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Delete"

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

Public Function EnumUserMemberList( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvTemplate As Long, _ 
   ByVal bvSecurityToken As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserMemberList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Template", adInteger, adParamInput, vbNull, CLng(bvTemplate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_EnumUserMemberList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserMemberList = vRecs

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

Public Function EnumUserCompanyList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTemplate As Long, _ 
   ByVal bvSecurityToken As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserCompanyList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Template", adInteger, adParamInput, vbNull, CLng(bvTemplate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_EnumUserCompanyList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserCompanyList = vRecs

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
   ByRef brRec As tGoalType, _ 
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
      .GoalID = moUtil.EditLong(.GoalID, "GoalID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(brRec.GoalID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@AssignNameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@AssignNameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@AssignName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@ProspectName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@GoalName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@GoalType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommitDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Variance", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Template", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Children", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ActQty", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .AssignID = moUtil.FetchLong(oCmd.Parameters.Item("@AssignID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .ProspectID = moUtil.FetchLong(oCmd.Parameters.Item("@ProspectID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .AssignNameLast = moUtil.FetchString(oCmd.Parameters.Item("@AssignNameLast").Value)
      .AssignNameFirst = moUtil.FetchString(oCmd.Parameters.Item("@AssignNameFirst").Value)
      .AssignName = moUtil.FetchString(oCmd.Parameters.Item("@AssignName").Value)
      .ProspectName = moUtil.FetchString(oCmd.Parameters.Item("@ProspectName").Value)
      .GoalName = moUtil.FetchString(oCmd.Parameters.Item("@GoalName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .GoalType = moUtil.FetchLong(oCmd.Parameters.Item("@GoalType").Value)
      .Priority = moUtil.FetchLong(oCmd.Parameters.Item("@Priority").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .CreateDate = moUtil.FetchDate(oCmd.Parameters.Item("@CreateDate").Value)
      .CommitDate = moUtil.FetchDate(oCmd.Parameters.Item("@CommitDate").Value)
      .CompleteDate = moUtil.FetchDate(oCmd.Parameters.Item("@CompleteDate").Value)
      .Variance = moUtil.FetchLong(oCmd.Parameters.Item("@Variance").Value)
      .RemindDate = moUtil.FetchDate(oCmd.Parameters.Item("@RemindDate").Value)
      .Template = moUtil.FetchLong(oCmd.Parameters.Item("@Template").Value)
      .Children = moUtil.FetchLong(oCmd.Parameters.Item("@Children").Value)
      .Qty = moUtil.FetchLong(oCmd.Parameters.Item("@Qty").Value)
      .ActQty = moUtil.FetchLong(oCmd.Parameters.Item("@ActQty").Value)
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
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsGoalFindGoalName
         sProc = "pts_Goal_FindGoalName"
         MaxBookMark = 70
      Case cptsGoalFindDescription
         sProc = "pts_Goal_FindDescription"
         MaxBookMark = 2010
      Case cptsGoalFindGoalID
         sProc = "pts_Goal_FindGoalID"
         MaxBookMark = 20
      Case cptsGoalFindGoalType
         sProc = "pts_Goal_FindGoalType"
         MaxBookMark = 20
      Case cptsGoalFindPriority
         sProc = "pts_Goal_FindPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AssignID = moUtil.FetchLong(.Fields.Item("AssignID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.AssignNameLast = moUtil.FetchString(.Fields.Item("AssignNameLast").Value)
               vRec.AssignNameFirst = moUtil.FetchString(.Fields.Item("AssignNameFirst").Value)
               vRec.AssignName = moUtil.FetchString(.Fields.Item("AssignName").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.GoalType = moUtil.FetchLong(.Fields.Item("GoalType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
               vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.Template = moUtil.FetchLong(.Fields.Item("Template").Value)
               vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
               vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
               vRec.ActQty = moUtil.FetchLong(.Fields.Item("ActQty").Value)
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

Public Function FindStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvStatus = moUtil.EditLong(bvStatus, "Status", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsGoalFindGoalName
         sProc = "pts_Goal_FindStatusGoalName"
         MaxBookMark = 70
      Case cptsGoalFindDescription
         sProc = "pts_Goal_FindStatusDescription"
         MaxBookMark = 2010
      Case cptsGoalFindGoalID
         sProc = "pts_Goal_FindStatusGoalID"
         MaxBookMark = 20
      Case cptsGoalFindGoalType
         sProc = "pts_Goal_FindStatusGoalType"
         MaxBookMark = 20
      Case cptsGoalFindPriority
         sProc = "pts_Goal_FindStatusPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
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
               vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AssignID = moUtil.FetchLong(.Fields.Item("AssignID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.AssignNameLast = moUtil.FetchString(.Fields.Item("AssignNameLast").Value)
               vRec.AssignNameFirst = moUtil.FetchString(.Fields.Item("AssignNameFirst").Value)
               vRec.AssignName = moUtil.FetchString(.Fields.Item("AssignName").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.GoalType = moUtil.FetchLong(.Fields.Item("GoalType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
               vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.Template = moUtil.FetchLong(.Fields.Item("Template").Value)
               vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
               vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
               vRec.ActQty = moUtil.FetchLong(.Fields.Item("ActQty").Value)
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
   FindStatus = vRecs

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

Public Function FindPrimary( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindPrimary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsGoalFindGoalName
         sProc = "pts_Goal_FindPrimaryGoalName"
         MaxBookMark = 70
      Case cptsGoalFindDescription
         sProc = "pts_Goal_FindPrimaryDescription"
         MaxBookMark = 2010
      Case cptsGoalFindGoalID
         sProc = "pts_Goal_FindPrimaryGoalID"
         MaxBookMark = 20
      Case cptsGoalFindGoalType
         sProc = "pts_Goal_FindPrimaryGoalType"
         MaxBookMark = 20
      Case cptsGoalFindPriority
         sProc = "pts_Goal_FindPrimaryPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AssignID = moUtil.FetchLong(.Fields.Item("AssignID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.AssignNameLast = moUtil.FetchString(.Fields.Item("AssignNameLast").Value)
               vRec.AssignNameFirst = moUtil.FetchString(.Fields.Item("AssignNameFirst").Value)
               vRec.AssignName = moUtil.FetchString(.Fields.Item("AssignName").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.GoalType = moUtil.FetchLong(.Fields.Item("GoalType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
               vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.Template = moUtil.FetchLong(.Fields.Item("Template").Value)
               vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
               vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
               vRec.ActQty = moUtil.FetchLong(.Fields.Item("ActQty").Value)
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
   FindPrimary = vRecs

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

Public Function FindPrimaryStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindPrimaryStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvStatus = moUtil.EditLong(bvStatus, "Status", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsGoalFindGoalName
         sProc = "pts_Goal_FindPrimaryStatusGoalName"
         MaxBookMark = 70
      Case cptsGoalFindDescription
         sProc = "pts_Goal_FindPrimaryStatusDescription"
         MaxBookMark = 2010
      Case cptsGoalFindGoalID
         sProc = "pts_Goal_FindPrimaryStatusGoalID"
         MaxBookMark = 20
      Case cptsGoalFindGoalType
         sProc = "pts_Goal_FindPrimaryStatusGoalType"
         MaxBookMark = 20
      Case cptsGoalFindPriority
         sProc = "pts_Goal_FindPrimaryStatusPriority"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
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
               vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AssignID = moUtil.FetchLong(.Fields.Item("AssignID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.AssignNameLast = moUtil.FetchString(.Fields.Item("AssignNameLast").Value)
               vRec.AssignNameFirst = moUtil.FetchString(.Fields.Item("AssignNameFirst").Value)
               vRec.AssignName = moUtil.FetchString(.Fields.Item("AssignName").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.GoalType = moUtil.FetchLong(.Fields.Item("GoalType").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
               vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
               vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.Template = moUtil.FetchLong(.Fields.Item("Template").Value)
               vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
               vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
               vRec.ActQty = moUtil.FetchLong(.Fields.Item("ActQty").Value)
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
   FindPrimaryStatus = vRecs

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

Public Function ListParent( _ 
   ByVal bvParentID As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListParent"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ListParent")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.AssignID = moUtil.FetchLong(.Fields.Item("AssignID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
            vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
            vRec.ActQty = moUtil.FetchLong(.Fields.Item("ActQty").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListParent = vRecs

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

Public Function ListProspect( _ 
   ByVal bvProspectID As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProspect"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(bvProspectID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ListProspect")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.AssignID = moUtil.FetchLong(.Fields.Item("AssignID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.GoalType = moUtil.FetchLong(.Fields.Item("GoalType").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
            vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
            vRec.ActQty = moUtil.FetchLong(.Fields.Item("ActQty").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProspect = vRecs

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
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvGoalType As Long, _ 
   ByVal bvPriority As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
      .Parameters.Append .CreateParameter("@GoalType", adInteger, adParamInput, vbNull, CLng(bvGoalType))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(bvPriority))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ReportMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.AssignID = moUtil.FetchLong(.Fields.Item("AssignID").Value)
            vRec.AssignName = moUtil.FetchString(.Fields.Item("AssignName").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.GoalType = moUtil.FetchLong(.Fields.Item("GoalType").Value)
            vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
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

Public Function ReportBusiness( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvGoalType As Long, _ 
   ByVal bvPriority As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportBusiness"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
      .Parameters.Append .CreateParameter("@GoalType", adInteger, adParamInput, vbNull, CLng(bvGoalType))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(bvPriority))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ReportBusiness")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Num1 = moUtil.FetchLong(.Fields.Item("Num1").Value)
            vRec.Num2 = moUtil.FetchLong(.Fields.Item("Num2").Value)
            vRec.Num3 = moUtil.FetchLong(.Fields.Item("Num3").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportBusiness = vRecs

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

Public Function ReportCompany( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvGoalType As Long, _ 
   ByVal bvPriority As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
      .Parameters.Append .CreateParameter("@GoalType", adInteger, adParamInput, vbNull, CLng(bvGoalType))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(bvPriority))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ReportCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Num1 = moUtil.FetchLong(.Fields.Item("Num1").Value)
            vRec.Num2 = moUtil.FetchLong(.Fields.Item("Num2").Value)
            vRec.Num3 = moUtil.FetchLong(.Fields.Item("Num3").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportCompany = vRecs

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

Public Function Reminder( _ 
   ByVal bvRemindDate As Date) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Reminder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamInput, vbNull, CDate(bvRemindDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Reminder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.IsMsg = moUtil.FetchInteger(.Fields.Item("IsMsg").Value)
            vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Reminder = vRecs

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

Public Function ListTemplate( _ 
   ByVal bvCompanyID As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTemplate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ListTemplate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListTemplate = vRecs

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

Public Function ListMemberTrack( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvTemplate As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberTrack"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Template", adInteger, adParamInput, vbNull, CLng(bvTemplate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ListMemberTrack")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberTrack = vRecs

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

Public Function ListActiveTrack( _ 
   ByVal bvMemberID As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActiveTrack"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ListActiveTrack")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListActiveTrack = vRecs

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

Public Function ListCompanyTrack( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTemplate As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyTrack"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Template", adInteger, adParamInput, vbNull, CLng(bvTemplate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_ListCompanyTrack")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompanyTrack = vRecs

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

Public Function Goals( _ 
   ByVal bvGoalID As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Goals"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(bvGoalID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Goals")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Goals = vRecs

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

Public Function Preview( _ 
   ByVal bvGoalID As Long) As tGoalType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Preview"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGoalType
   Dim vRec As tGoalType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(bvGoalID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Preview")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GoalID = moUtil.FetchLong(.Fields.Item("GoalID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.GoalName = moUtil.FetchString(.Fields.Item("GoalName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.CommitDate = moUtil.FetchDate(.Fields.Item("CommitDate").Value)
            vRec.CompleteDate = moUtil.FetchDate(.Fields.Item("CompleteDate").Value)
            vRec.Variance = moUtil.FetchLong(.Fields.Item("Variance").Value)
            vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
            vRec.ActQty = moUtil.FetchLong(.Fields.Item("ActQty").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Preview = vRecs

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
   ByRef brRec As tGoalType, _ 
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
      .Parameters.Append .CreateParameter("@GoalID", adInteger, adParamInput, vbNull, CLng(brRec.GoalID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@AssignID", adInteger, adParamInput, vbNull, CLng(brRec.AssignID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@GoalName", adVarWChar, adParamInput, 60, brRec.GoalName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@GoalType", adInteger, adParamInput, vbNull, CLng(brRec.GoalType))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(brRec.Priority))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@CommitDate", adDate, adParamInput, vbNull, CDate(brRec.CommitDate))
      .Parameters.Append .CreateParameter("@CompleteDate", adDate, adParamInput, vbNull, CDate(brRec.CompleteDate))
      .Parameters.Append .CreateParameter("@Variance", adInteger, adParamInput, vbNull, CLng(brRec.Variance))
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamInput, vbNull, CDate(brRec.RemindDate))
      .Parameters.Append .CreateParameter("@Template", adInteger, adParamInput, vbNull, CLng(brRec.Template))
      .Parameters.Append .CreateParameter("@Children", adInteger, adParamInput, vbNull, CLng(brRec.Children))
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamInput, vbNull, CLng(brRec.Qty))
      .Parameters.Append .CreateParameter("@ActQty", adInteger, adParamInput, vbNull, CLng(brRec.ActQty))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Goal_Update"

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
   ByRef brRec As tGoalType, _ 
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
         .GoalID = moUtil.EditLong(.GoalID, "GoalID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, , 1) 
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False, , 1) 
      .AssignID = moUtil.EditLong(.AssignID, "AssignID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", False) 
      .GoalName = moUtil.EditString(.GoalName, "GoalName", True, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 2000) 
      .GoalType = moUtil.EditLong(.GoalType, "GoalType", False) 
      .Priority = moUtil.EditLong(.Priority, "Priority", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .CreateDate = moUtil.EditDate(.CreateDate, "CreateDate", False) 
      .CommitDate = moUtil.EditDate(.CommitDate, "CommitDate", False) 
      .CompleteDate = moUtil.EditDate(.CompleteDate, "CompleteDate", False) 
      .Variance = moUtil.EditLong(.Variance, "Variance", False) 
      .RemindDate = moUtil.EditDate(.RemindDate, "RemindDate", False) 
      .Template = moUtil.EditLong(.Template, "Template", False) 
      .Children = moUtil.EditLong(.Children, "Children", False) 
      .Qty = moUtil.EditLong(.Qty, "Qty", False) 
      .ActQty = moUtil.EditLong(.ActQty, "ActQty", False) 
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