VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CIssueCategoryB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CIssueCategory"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tIssueCategoryType
   IssueCategoryID As String
   CompanyID As String
   IssueCategoryName As String
   Seq As String
   UserType As String
   AssignedTo As String
   InputOptions As String
   Email As String
End Type

Public Sub Add( _ 
   ByRef brRec As tIssueCategoryType, _ 
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
      .Parameters.Append .CreateParameter("@IssueCategoryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@IssueCategoryName", adVarWChar, adParamInput, 40, brRec.IssueCategoryName)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserType", adInteger, adParamInput, vbNull, CLng(brRec.UserType))
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, brRec.AssignedTo)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 1000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 100, brRec.Email)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_IssueCategory_Add"

   '-----get return values
   With brRec
      .IssueCategoryID = moUtil.FetchLong(oCmd.Parameters.Item("@IssueCategoryID").Value)
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
   ByRef brRec As tIssueCategoryType, _ 
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
      .IssueCategoryID = moUtil.EditLong(.IssueCategoryID, "IssueCategoryID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@IssueCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.IssueCategoryID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_IssueCategory_Delete"

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

Public Function EnumUserList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserType As Long, _ 
   ByVal bvSecurityToken As Long) As tIssueCategoryType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueCategoryType
   Dim vRec As tIssueCategoryType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserType", adInteger, adParamInput, vbNull, CLng(bvUserType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_IssueCategory_EnumUserList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserList = vRecs

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
   ByRef brRec As tIssueCategoryType, _ 
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
      .IssueCategoryID = moUtil.EditLong(.IssueCategoryID, "IssueCategoryID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@IssueCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.IssueCategoryID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IssueCategoryName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_IssueCategory_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .IssueCategoryName = moUtil.FetchString(oCmd.Parameters.Item("@IssueCategoryName").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .UserType = moUtil.FetchLong(oCmd.Parameters.Item("@UserType").Value)
      .AssignedTo = moUtil.FetchString(oCmd.Parameters.Item("@AssignedTo").Value)
      .InputOptions = moUtil.FetchString(oCmd.Parameters.Item("@InputOptions").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
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

Public Function ListAll( _ 
   ByVal bvCompanyID As Long) As tIssueCategoryType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tIssueCategoryType
   Dim vRec As tIssueCategoryType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_IssueCategory_ListAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.IssueCategoryID = moUtil.FetchLong(.Fields.Item("IssueCategoryID").Value)
            vRec.IssueCategoryName = moUtil.FetchString(.Fields.Item("IssueCategoryName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.UserType = moUtil.FetchLong(.Fields.Item("UserType").Value)
            vRec.AssignedTo = moUtil.FetchString(.Fields.Item("AssignedTo").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAll = vRecs

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
   ByRef brRec As tIssueCategoryType, _ 
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
      .Parameters.Append .CreateParameter("@IssueCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.IssueCategoryID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@IssueCategoryName", adVarWChar, adParamInput, 40, brRec.IssueCategoryName)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserType", adInteger, adParamInput, vbNull, CLng(brRec.UserType))
      .Parameters.Append .CreateParameter("@AssignedTo", adVarWChar, adParamInput, 15, brRec.AssignedTo)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 1000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 100, brRec.Email)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_IssueCategory_Update"

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
   ByRef brRec As tIssueCategoryType, _ 
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
         .IssueCategoryID = moUtil.EditLong(.IssueCategoryID, "IssueCategoryID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .IssueCategoryName = moUtil.EditString(.IssueCategoryName, "IssueCategoryName", True, , 1, 40) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False, , 1) 
      .UserType = moUtil.EditLong(.UserType, "UserType", False) 
      .AssignedTo = moUtil.EditString(.AssignedTo, "AssignedTo", False, , 1, 15) 
      .InputOptions = moUtil.EditString(.InputOptions, "InputOptions", False, , 1, 1000) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 100) 
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