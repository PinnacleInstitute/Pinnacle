VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CProjectB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CProject"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tProjectType
   ProjectID As String
   CompanyID As String
   MemberID As String
   ParentID As String
   ForumID As String
   ProjectTypeID As String
   NameLast As String
   NameFirst As String
   MemberName As String
   ProjectTypeName As String
   ProjectName As String
   Description As String
   Status As String
   Seq As String
   IsChat As String
   IsForum As String
   Secure As String
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
   Hierarchy As String
   ChangeDate As String
   RefType As String
   RefID As String
   FromDate As String
   ToDate As String
   Notes As String
   Documents As String
   Messages As String
End Type

Public Sub Add( _ 
   ByRef brRec As tProjectType, _ 
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
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(brRec.ForumID))
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectTypeID))
      .Parameters.Append .CreateParameter("@ProjectName", adVarWChar, adParamInput, 60, brRec.ProjectName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsChat", adSmallInt, adParamInput, vbNull, CInt(brRec.IsChat))
      .Parameters.Append .CreateParameter("@IsForum", adSmallInt, adParamInput, vbNull, CInt(brRec.IsForum))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
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
      .Parameters.Append .CreateParameter("@Hierarchy", adVarWChar, adParamInput, 30, brRec.Hierarchy)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@RefType", adInteger, adParamInput, vbNull, CLng(brRec.RefType))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Add"

   '-----get return values
   With brRec
      .ProjectID = moUtil.FetchLong(oCmd.Parameters.Item("@ProjectID").Value)
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
   ByRef brRec As tProjectType, _ 
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
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", True, 0, 1) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True, 0, 1) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, 0, 1) 
      .ProjectName = moUtil.EditString(.ProjectName, "ProjectName", False, "", 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", True, "", 1, 1000) 
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProjectName", adVarWChar, adParamInput, 60, brRec.ProjectName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@NewProjectID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Copy"

   '-----get return values
   Copy = moUtil.FetchLong(oCmd.Parameters.Item("@NewProjectID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ComputeTotalCost( _ 
   ByRef brRec As tProjectType, _ 
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
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ComputeTotalCost"

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

Public Function UpdateHierarchy( _ 
   ByRef brRec As tProjectType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateHierarchy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_UpdateHierarchy"

   '-----get return values
   UpdateHierarchy = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Change( _ 
   ByRef brRec As tProjectType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Change"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Change"

   '-----get return values
   Change = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Access( _ 
   ByRef brRec As tProjectType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Access"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", True, 0, 1) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Access"

   '-----get return values
   Access = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Count"

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
   ByRef brRec As tProjectType, _ 
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
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Delete"

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

Public Function EnumUserMember( _ 
   ByVal bvProjectID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecurityToken As Long) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_EnumUserMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserMember = vRecs

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
   ByRef brRec As tProjectType, _ 
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
      .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@ProjectTypeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@ProjectName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsChat", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsForum", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamOutput, vbNull, vbNull)
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
      .Parameters.Append .CreateParameter("@Hierarchy", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RefType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .ForumID = moUtil.FetchLong(oCmd.Parameters.Item("@ForumID").Value)
      .ProjectTypeID = moUtil.FetchLong(oCmd.Parameters.Item("@ProjectTypeID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .ProjectTypeName = moUtil.FetchString(oCmd.Parameters.Item("@ProjectTypeName").Value)
      .ProjectName = moUtil.FetchString(oCmd.Parameters.Item("@ProjectName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .IsChat = moUtil.FetchInteger(oCmd.Parameters.Item("@IsChat").Value)
      .IsForum = moUtil.FetchInteger(oCmd.Parameters.Item("@IsForum").Value)
      .Secure = moUtil.FetchLong(oCmd.Parameters.Item("@Secure").Value)
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
      .Hierarchy = moUtil.FetchString(oCmd.Parameters.Item("@Hierarchy").Value)
      .ChangeDate = moUtil.FetchDate(oCmd.Parameters.Item("@ChangeDate").Value)
      .RefType = moUtil.FetchLong(oCmd.Parameters.Item("@RefType").Value)
      .RefID = moUtil.FetchLong(oCmd.Parameters.Item("@RefID").Value)
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
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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

Public Function FindSecure( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecure"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindSecureProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindSecureDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindSecureProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindSecure = vRecs

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

Public Function FindAssigned( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindAssignedProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindAssignedDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindAssignedProjectID"
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindAssigned = vRecs

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
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindStatusProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindStatusDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindStatusProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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

Public Function FindSecureStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecureStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindSecureStatusProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindSecureStatusDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindSecureStatusProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindSecureStatus = vRecs

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

Public Function FindAssignedStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssignedStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindAssignedStatusProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindAssignedStatusDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindAssignedStatusProjectID"
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindAssignedStatus = vRecs

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

Public Function FindType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvProjectTypeID = moUtil.EditLong(bvProjectTypeID, "ProjectTypeID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindTypeProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindTypeDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindTypeProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(bvProjectTypeID))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindType = vRecs

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

Public Function FindSecureType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecureType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvProjectTypeID = moUtil.EditLong(bvProjectTypeID, "ProjectTypeID", True) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindSecureTypeProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindSecureTypeDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindSecureTypeProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(bvProjectTypeID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindSecureType = vRecs

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

Public Function FindAssignedType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssignedType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvProjectTypeID = moUtil.EditLong(bvProjectTypeID, "ProjectTypeID", True) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindAssignedTypeProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindAssignedTypeDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindAssignedTypeProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(bvProjectTypeID))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindAssignedType = vRecs

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

Public Function FindStatusType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvProjectTypeID = moUtil.EditLong(bvProjectTypeID, "ProjectTypeID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindStatusTypeProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindStatusTypeDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindStatusTypeProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(bvProjectTypeID))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindStatusType = vRecs

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

Public Function FindSecureStatusType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSecureStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, , 1) 
   bvProjectTypeID = moUtil.EditLong(bvProjectTypeID, "ProjectTypeID", True) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindSecureStatusTypeProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindSecureStatusTypeDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindSecureStatusTypeProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(bvProjectTypeID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindSecureStatusType = vRecs

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

Public Function FindAssignedStatusType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvProjectTypeID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAssignedStatusType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   bvProjectTypeID = moUtil.EditLong(bvProjectTypeID, "ProjectTypeID", True) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProjectFindProjectName
         sProc = "pts_Project_FindAssignedStatusTypeProjectName"
         MaxBookMark = 70
      Case cptsProjectFindDescription
         sProc = "pts_Project_FindAssignedStatusTypeDescription"
         MaxBookMark = 1010
      Case cptsProjectFindProjectID
         sProc = "pts_Project_FindAssignedStatusTypeProjectID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(bvProjectTypeID))
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
               vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
               vRec.ProjectTypeID = moUtil.FetchLong(.Fields.Item("ProjectTypeID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
               vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
               vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
               vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
               vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
               vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
               vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
               vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
               vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
               vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
               vRec.VarCost = moUtil.FetchCurrency(.Fields.Item("VarCost").Value)
               vRec.Cost = moUtil.FetchCurrency(.Fields.Item("Cost").Value)
               vRec.Hrs = moUtil.FetchCurrency(.Fields.Item("Hrs").Value)
               vRec.TotHrs = moUtil.FetchCurrency(.Fields.Item("TotHrs").Value)
               vRec.Hierarchy = moUtil.FetchString(.Fields.Item("Hierarchy").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.RefType = moUtil.FetchLong(.Fields.Item("RefType").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
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
   FindAssignedStatusType = vRecs

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
   ByVal bvParentID As Long) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListParent"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ListParent")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.ProjectTypeName = moUtil.FetchString(.Fields.Item("ProjectTypeName").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.EstStartDate = moUtil.FetchDate(.Fields.Item("EstStartDate").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.EstEndDate = moUtil.FetchDate(.Fields.Item("EstEndDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.EstCost = moUtil.FetchCurrency(.Fields.Item("EstCost").Value)
            vRec.TotCost = moUtil.FetchCurrency(.Fields.Item("TotCost").Value)
            vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
            vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
            vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
            vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
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

Public Function Projects( _ 
   ByVal bvProjectID As Long) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Projects"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Projects")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
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

Public Function ListCompanyPending( _ 
   ByVal bvCompanyID As Long) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ListCompanyPending")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
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
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompanyPending = vRecs

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

Public Function ListCompanyStarted( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyStarted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ListCompanyStarted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
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
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompanyStarted = vRecs

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

Public Function ListCompanyCompleted( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyCompleted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ListCompanyCompleted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
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
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompanyCompleted = vRecs

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
   ByVal bvMemberID As Long) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberPending"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ListMemberPending")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
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
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberStarted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ListMemberStarted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
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
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberCompleted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_ListMemberCompleted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
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

Public Function WhatsNewOwn( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewOwn"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_WhatsNewOwn")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
            vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
            vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
            vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
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
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewBelong"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_WhatsNewBelong")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
            vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
            vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
            vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
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
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNewAccess"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
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
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_WhatsNewAccess")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
            vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
            vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
            vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
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
   ByVal bvToDate As Date) As tProjectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WhatsNew"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProjectType
   Dim vRec As tProjectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(bvProjectID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_WhatsNew")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProjectID = moUtil.FetchLong(.Fields.Item("ProjectID").Value)
            vRec.ProjectName = moUtil.FetchString(.Fields.Item("ProjectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActStartDate = moUtil.FetchDate(.Fields.Item("ActStartDate").Value)
            vRec.VarStartDate = moUtil.FetchLong(.Fields.Item("VarStartDate").Value)
            vRec.ActEndDate = moUtil.FetchDate(.Fields.Item("ActEndDate").Value)
            vRec.VarEndDate = moUtil.FetchLong(.Fields.Item("VarEndDate").Value)
            vRec.Notes = moUtil.FetchLong(.Fields.Item("Notes").Value)
            vRec.Documents = moUtil.FetchLong(.Fields.Item("Documents").Value)
            vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
            vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
            vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
            vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
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

Public Sub Update( _ 
   ByRef brRec As tProjectType, _ 
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
      .Parameters.Append .CreateParameter("@ProjectID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(brRec.ForumID))
      .Parameters.Append .CreateParameter("@ProjectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProjectTypeID))
      .Parameters.Append .CreateParameter("@ProjectName", adVarWChar, adParamInput, 60, brRec.ProjectName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsChat", adSmallInt, adParamInput, vbNull, CInt(brRec.IsChat))
      .Parameters.Append .CreateParameter("@IsForum", adSmallInt, adParamInput, vbNull, CInt(brRec.IsForum))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
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
      .Parameters.Append .CreateParameter("@Hierarchy", adVarWChar, adParamInput, 30, brRec.Hierarchy)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@RefType", adInteger, adParamInput, vbNull, CLng(brRec.RefType))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Project_Update"

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
   ByRef brRec As tProjectType, _ 
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
         .ProjectID = moUtil.EditLong(.ProjectID, "ProjectID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, , 1) 
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False, , 1) 
      .ForumID = moUtil.EditLong(.ForumID, "ForumID", False) 
      .ProjectTypeID = moUtil.EditLong(.ProjectTypeID, "ProjectTypeID", False) 
      .ProjectName = moUtil.EditString(.ProjectName, "ProjectName", True, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 1000) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .IsChat = moUtil.EditInteger(.IsChat, "IsChat", False, 0, 0, 1) 
      .IsForum = moUtil.EditInteger(.IsForum, "IsForum", False, 0, 0, 1) 
      .Secure = moUtil.EditLong(.Secure, "Secure", False) 
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
      .Hierarchy = moUtil.EditString(.Hierarchy, "Hierarchy", False, , 1, 30) 
      .ChangeDate = moUtil.EditDate(.ChangeDate, "ChangeDate", False) 
      .RefType = moUtil.EditLong(.RefType, "RefType", False) 
      .RefID = moUtil.EditLong(.RefID, "RefID", False) 
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