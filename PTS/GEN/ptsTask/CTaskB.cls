VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CTaskB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CTask"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tTaskType
   TaskID As String
   MemberID As String
   ParentID As String
   ProjectID As String
   DependentID As String
   NameLast As String
   NameFirst As String
   MemberName As String
   ProjectName As String
   TaskName As String
   Description As String
   Status As String
   Seq As String
   IsMilestone As String
   EstStartDate As String
   ActStartDate As String
   VarStartDate As String
   EstEndDate As String
   ActEndDate As String
   VarEndDate As String
   EstCost As String
   TotCost As String
   VarCost As String
   Cost As String
   Hrs As String
   TotHrs As String
   FromDate As String
   ToDate As String
   Notes As String
   Documents As String
   CompanyID As String
   Secure As String
   Email As String
   FromEmail As String
   IsMsg As String
End Type

Public Sub Add( _ 
   ByRef brRec As tTaskType, _ 
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
      .Parameters.Append .CreateParameter("@TaskID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@DependentID", adInteger, adParamInput, vbNull, CLng(brRec.DependentID))
      .Parameters.Append .CreateParameter("@TaskName", adVarWChar, adParamInput, 60, brRec.TaskName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsMilestone", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMilestone))
      .Parameters.Append .CreateParameter("@EstStartDate", adDate, adParamInput, vbNull, CDate(brRec.EstStartDate))
      .Parameters.Append .CreateParameter("@ActStartDate", adDate, adParamInput, vbNull, CDate(brRec.ActStartDate))
      .Parameters.Append .CreateParameter("@VarStartDate", adInteger, adParamInput, vbNull, CLng(brRec.VarStartDate))
      .Parameters.Append .CreateParameter("@EstEndDate", adDate, adParamInput, vbNull, CDate(brRec.EstEndDate))
      .Parameters.Append .CreateParameter("@ActEndDate", adDate, adParamInput, vbNull, CDate(brRec.ActEndDate))
      .Parameters.Append .CreateParameter("@VarEndDate", adInteger, adParamInput, vbNull, CLng(brRec.VarEndDate))
      .Parameters.Append .CreateParameter("@EstCost", adCurrency, adParamInput, vbNull, CCur(brRec.EstCost))
      .Parameters.Append .CreateParameter("@TotCost", adCurrency, adParamInput, vbNull, CCur(brRec.TotCost))
      .Parameters.Append .CreateParameter("@VarCost", adCurrency, adParamInput, vbNull, CCur(brRec.VarCost))
      .Parameters.Append .CreateParameter("@Cost", adCurrency, adParamInput, vbNull, CCur(brRec.Cost))
      .Parameters.Append .CreateParameter("@Hrs", adCurrency, adParamInput, vbNull, CCur(brRec.Hrs))
      .Parameters.Append .CreateParameter("@TotHrs", adCurrency, adParamInput, vbNull, CCur(brRec.TotHrs))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_Add"

   '-----get return values
   With brRec
      .TaskID = moUtil.FetchLong(oCmd.Parameters.Item("@TaskID").Value)
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

Public Function ComputeTotalCost( _ 
   ByRef brRec As tTaskType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ComputeTotalCost"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .TaskID = moUtil.EditLong(.TaskID, "TaskID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@TaskID", adInteger, adParamInput, vbNull, CLng(brRec.TaskID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ComputeTotalCost"

   '-----get return values
   ComputeTotalCost = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_Count"

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
   ByRef brRec As tTaskType, _ 
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
      .TaskID = moUtil.EditLong(.TaskID, "TaskID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@TaskID", adInteger, adParamInput, vbNull, CLng(brRec.TaskID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_Delete"

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
   ByRef brRec As tTaskType, _ 
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
      .TaskID = moUtil.EditLong(.TaskID, "TaskID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@TaskID", adInteger, adParamInput, vbNull, CLng(brRec.TaskID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DependentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@ProjectName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@TaskName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsMilestone", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EstStartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ActStartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VarStartDate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EstEndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ActEndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VarEndDate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EstCost", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TotCost", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VarCost", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Cost", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Hrs", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TotHrs", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .ProjectID = moUtil.FetchLong(oCmd.Parameters.Item("@ProjectID").Value)
      .DependentID = moUtil.FetchLong(oCmd.Parameters.Item("@DependentID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .ProjectName = moUtil.FetchString(oCmd.Parameters.Item("@ProjectName").Value)
      .TaskName = moUtil.FetchString(oCmd.Parameters.Item("@TaskName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .IsMilestone = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMilestone").Value)
      .EstStartDate = moUtil.FetchDate(oCmd.Parameters.Item("@EstStartDate").Value)
      .ActStartDate = moUtil.FetchDate(oCmd.Parameters.Item("@ActStartDate").Value)
      .VarStartDate = moUtil.FetchLong(oCmd.Parameters.Item("@VarStartDate").Value)
      .EstEndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EstEndDate").Value)
      .ActEndDate = moUtil.FetchDate(oCmd.Parameters.Item("@ActEndDate").Value)
      .VarEndDate = moUtil.FetchLong(oCmd.Parameters.Item("@VarEndDate").Value)
      .EstCost = moUtil.FetchCurrency(oCmd.Parameters.Item("@EstCost").Value)
      .TotCost = moUtil.FetchCurrency(oCmd.Parameters.Item("@TotCost").Value)
      .VarCost = moUtil.FetchCurrency(oCmd.Parameters.Item("@VarCost").Value)
      .Cost = moUtil.FetchCurrency(oCmd.Parameters.Item("@Cost").Value)
      .Hrs = moUtil.FetchCurrency(oCmd.Parameters.Item("@Hrs").Value)
      .TotHrs = moUtil.FetchCurrency(oCmd.Parameters.Item("@TotHrs").Value)
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

Public Function ListParent( _ 
   ByVal bvParentID As Long) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListParent"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListParent")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
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

Public Function ListProject( _ 
   ByVal bvProjectID As Long) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProject"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProject")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProject = vRecs

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

Public Function Projects( _ 
   ByVal bvProjectID As Long) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Projects"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_Projects")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Projects = vRecs

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

Public Function ListMemberPending( _ 
   ByVal bvMemberID As Long) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListMemberPending")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberPending = vRecs

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

Public Function ListMemberStarted( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberStarted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListMemberStarted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberStarted = vRecs

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

Public Function ListMemberCompleted( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberCompleted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListMemberCompleted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberCompleted = vRecs

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

Public Function ListProjectMemberPending( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvMemberID As Long) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProjectMemberPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProjectMemberPending")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProjectMemberPending = vRecs

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

Public Function ListProjectMemberStarted( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProjectMemberStarted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProjectMemberStarted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProjectMemberStarted = vRecs

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

Public Function ListProjectMemberCompleted( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProjectMemberCompleted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProjectMemberCompleted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProjectMemberCompleted = vRecs

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

Public Function ListProjectUnassigned( _ 
   ByVal bvProjectID As Long) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProjectUnassigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProjectUnassigned")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProjectUnassigned = vRecs

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

Public Function ListProjectPending( _ 
   ByVal bvProjectID As Long) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProjectPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProjectPending")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProjectPending = vRecs

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

Public Function ListProjectStarted( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProjectStarted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProjectStarted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProjectStarted = vRecs

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

Public Function ListProjectCompleted( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProjectCompleted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_ListProjectCompleted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.IsMilestone = moUtil.FetchInteger(.Fields.Item("IsMilestone").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProjectCompleted = vRecs

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

Public Function WhatsNewOwn( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewOwn"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_WhatsNewOwn")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   WhatsNewOwn = vRecs

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

Public Function WhatsNewBelong( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewBelong"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_WhatsNewBelong")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   WhatsNewBelong = vRecs

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

Public Function WhatsNewAccess( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewAccess"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_WhatsNewAccess")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   WhatsNewAccess = vRecs

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

Public Function WhatsNew( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNew"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_WhatsNew")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   WhatsNew = vRecs

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

Public Function PastDue( _ 
   ByVal bvEstEndDate As Date) As tTaskType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "PastDue"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTaskType
   Dim vRec As tTaskType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EstEndDate", adDate, adParamInput, vbNull, CDate(bvEstEndDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_PastDue")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TaskID = moUtil.FetchLong(.Fields.Item("TaskID").Value)
            vRec.TaskName = moUtil.FetchString(.Fields.Item("TaskName").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.IsMsg = moUtil.FetchInteger(.Fields.Item("IsMsg").Value)
            vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   PastDue = vRecs

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
   ByRef brRec As tTaskType, _ 
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
      .Parameters.Append .CreateParameter("@TaskID", adInteger, adParamInput, vbNull, CLng(brRec.TaskID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@DependentID", adInteger, adParamInput, vbNull, CLng(brRec.DependentID))
      .Parameters.Append .CreateParameter("@TaskName", adVarWChar, adParamInput, 60, brRec.TaskName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsMilestone", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMilestone))
      .Parameters.Append .CreateParameter("@EstStartDate", adDate, adParamInput, vbNull, CDate(brRec.EstStartDate))
      .Parameters.Append .CreateParameter("@ActStartDate", adDate, adParamInput, vbNull, CDate(brRec.ActStartDate))
      .Parameters.Append .CreateParameter("@VarStartDate", adInteger, adParamInput, vbNull, CLng(brRec.VarStartDate))
      .Parameters.Append .CreateParameter("@EstEndDate", adDate, adParamInput, vbNull, CDate(brRec.EstEndDate))
      .Parameters.Append .CreateParameter("@ActEndDate", adDate, adParamInput, vbNull, CDate(brRec.ActEndDate))
      .Parameters.Append .CreateParameter("@VarEndDate", adInteger, adParamInput, vbNull, CLng(brRec.VarEndDate))
      .Parameters.Append .CreateParameter("@EstCost", adCurrency, adParamInput, vbNull, CCur(brRec.EstCost))
      .Parameters.Append .CreateParameter("@TotCost", adCurrency, adParamInput, vbNull, CCur(brRec.TotCost))
      .Parameters.Append .CreateParameter("@VarCost", adCurrency, adParamInput, vbNull, CCur(brRec.VarCost))
      .Parameters.Append .CreateParameter("@Cost", adCurrency, adParamInput, vbNull, CCur(brRec.Cost))
      .Parameters.Append .CreateParameter("@Hrs", adCurrency, adParamInput, vbNull, CCur(brRec.Hrs))
      .Parameters.Append .CreateParameter("@TotHrs", adCurrency, adParamInput, vbNull, CCur(brRec.TotHrs))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Task_Update"

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
   ByRef brRec As tTaskType, _ 
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
         .TaskID = moUtil.EditLong(.TaskID, "TaskID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, , 1) 
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False, , 1) 
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", False) 
      .DependentID = moUtil.EditLong(.DependentID, "DependentID", False) 
      .TaskName = moUtil.EditString(.TaskName, "TaskName", True, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 1000) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .IsMilestone = moUtil.EditInteger(.IsMilestone, "IsMilestone", False, 0, 0, 1) 
      .EstStartDate = moUtil.EditDate(.EstStartDate, "EstStartDate", False) 
      .ActStartDate = moUtil.EditDate(.ActStartDate, "ActStartDate", False) 
      .VarStartDate = moUtil.EditLong(.VarStartDate, "VarStartDate", False) 
      .EstEndDate = moUtil.EditDate(.EstEndDate, "EstEndDate", False) 
      .ActEndDate = moUtil.EditDate(.ActEndDate, "ActEndDate", False) 
      .VarEndDate = moUtil.EditLong(.VarEndDate, "VarEndDate", False) 
      .EstCost = moUtil.EditCurrency(.EstCost, "EstCost", False) 
      .TotCost = moUtil.EditCurrency(.TotCost, "TotCost", False) 
      .VarCost = moUtil.EditCurrency(.VarCost, "VarCost", False) 
      .Cost = moUtil.EditCurrency(.Cost, "Cost", False) 
      .Hrs = moUtil.EditCurrency(.Hrs, "Hrs", False, , 0, 999999.9999) 
      .TotHrs = moUtil.EditCurrency(.TotHrs, "TotHrs", False, , 0, 999999.9999) 
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