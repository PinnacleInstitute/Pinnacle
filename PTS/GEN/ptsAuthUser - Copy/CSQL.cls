VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "CSQL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSQL"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAuthUserType
   AuthUserID As String
   TrainerID As String
   EmployeeID As String
   MemberID As String
   OrgID As String
   AffiliateID As String
   Logon As String
   NewLogon As String
   ConfirmLogon As String
   Password As String
   NewPassword As String
   ConfirmPassword As String
   Email As String
   NameLast As String
   NameFirst As String
   AuthUserName As String
   UserType As String
   UserGroup As String
   UserStatus As String
End Type

Private mClient As String
Private mProject As String

Public Sub SysClientProject(ByVal bvClient As String, ByVal bvProject As String)
   mClient = bvClient
   mProject = bvProject
End Sub

Public Sub UpdateLogonPassword( _
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Updates the user's logon ID.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateLogonPassword"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext
 
   On Error GoTo ErrorHandler
 
   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()
 
   '-----edit the input parameters
   With brRec
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", True, , 1)
      .Logon = moUtil.EditString(.Logon, "Current Logon", True, , 3, 80)
      .Password = moUtil.EditString(.Password, "Current Password", True, , 3, 30)
      bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1)
   End With
      
    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamInput, 80, brRec.Logon)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 30, brRec.Password)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With
      
   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_UpdateLogonPassword"
   
   '-----cleanup
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

Public Sub UpdateUserType( _
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Updates the user's logon ID.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateUserType"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext
 
   On Error GoTo ErrorHandler
 
   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()
 
   '-----edit the input parameters
   With brRec
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", True, , 1)
      .UserType = moUtil.EditLong(.UserType, "UserType", False, , 1)
      bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1)
   End With
      
    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@UserType", adInteger, adParamInput, vbNull, CLng(brRec.UserType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With
      
   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_UpdateUserType"
   
   '-----cleanup
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

Public Sub ChangeLogon( _
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Updates the user's logon ID.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ChangeLogon"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext
 
   On Error GoTo ErrorHandler
 
   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()
 
   '-----edit the input parameters
   With brRec
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", True, , 1)
      .Logon = moUtil.EditString(.Logon, "Current Logon", True, , 3, 80)
      .NewLogon = moUtil.EditString(.NewLogon, "New Logon", True, , 3, 80)
      .NewLogon = moUtil.EditMask(.NewLogon, "New Logon", "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", False)
      .ConfirmLogon = moUtil.EditString(.ConfirmLogon, "Confirm Logon", True, , 3, 80)
      bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1)
   End With
      
    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamInputOutput, 80, brRec.Logon)
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInputOutput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@ConfirmLogon", adVarWChar, adParamInputOutput, 80, brRec.ConfirmLogon)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With
      
   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_ChangeLogon"
   
   '-----get return values
   With brRec
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
      .NewLogon = moUtil.FetchString(oCmd.Parameters.Item("@NewLogon").Value)
      .ConfirmLogon = moUtil.FetchString(oCmd.Parameters.Item("@ConfirmLogon").Value)
   End With
   
   '-----cleanup
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

Public Sub ChangePassword( _
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Updates the user's password
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ChangePassword"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext
 
   On Error GoTo ErrorHandler
 
   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()
 
   '-----edit the input parameters
   With brRec
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", True, , 1)
      .Password = moUtil.EditString(.Password, "Current Password", True, , 3, 30)
      .NewPassword = moUtil.EditString(.NewPassword, "New Password", True, , 3, 30)
      .NewPassword = moUtil.EditMask(.NewPassword, "New Password", "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", False)
      .ConfirmPassword = moUtil.EditString(.ConfirmPassword, "Confirm Password", True, , 3, 30)
      bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1)
   End With
      
    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInputOutput, 30, brRec.Password)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInputOutput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@ConfirmPassword", adVarWChar, adParamInputOutput, 30, brRec.ConfirmPassword)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With
   
   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_ChangePassword"
   
   '-----get return values
   With brRec
      .Password = moUtil.FetchString(oCmd.Parameters.Item("@Password").Value)
      .NewPassword = moUtil.FetchString(oCmd.Parameters.Item("@NewPassword").Value)
      .ConfirmPassword = moUtil.FetchString(oCmd.Parameters.Item("@ConfirmPassword").Value)
   End With
   
   '-----cleanup
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
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Retrieves the record.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Fetch"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
 
   On Error GoTo ErrorHandler
 
   '-----edit the input parameters
   With brRec
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", True, , 1)
      bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1)
   End With

    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmployeeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@UserType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_Fetch"

   '-----get return values
   With brRec
      .TrainerID = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerID").Value)
      .EmployeeID = moUtil.FetchLong(oCmd.Parameters.Item("@EmployeeID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .OrgID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgID").Value)
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
      .Password = moUtil.FetchString(oCmd.Parameters.Item("@Password").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .AuthUserName = moUtil.FetchString(oCmd.Parameters.Item("@AuthUserName").Value)
      .UserType = moUtil.FetchLong(oCmd.Parameters.Item("@UserType").Value)
      .UserGroup = moUtil.FetchLong(oCmd.Parameters.Item("@UserGroup").Value)
      .UserStatus = moUtil.FetchLong(oCmd.Parameters.Item("@UserStatus").Value)
   End With
   
   '-----cleanup
   Set oCmd = Nothing
   
   Exit Sub
 
ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function IsLogon(ByVal bvLogon As String) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsLogon"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamInput, 80, bvLogon)
      .Parameters.Append .CreateParameter("@IsAvailable", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_IsLogon"

   '-----get return values
   IsLogon = moUtil.FetchString(oCmd.Parameters.Item("@IsAvailable").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub EmailFetch( _
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Retrieves the record.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EmailFetch"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
 
   On Error GoTo ErrorHandler
 
   '-----edit the input parameters
   With brRec
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80)
   End With
      
    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamOutput, 30, vbNull)
   End With
      
   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_EmailFetch"
      
   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchString(oCmd.Parameters.Item("@AuthUserID").Value)
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
      .Password = moUtil.FetchString(oCmd.Parameters.Item("@Password").Value)
   End With
   
   '-----cleanup
   Set oCmd = Nothing
   
   Exit Sub
 
ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ResetLogon( _
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Updates the user's logon
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ResetLogon"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext
 
   On Error GoTo ErrorHandler
 
   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()
 
   '-----edit the input parameters
   With brRec
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", True, , 1)
      bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1)
   End With

    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With
      
   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_ResetLogon"
   
   '-----get return values
   With brRec
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
   End With
   
   '-----cleanup
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

Public Sub ResetPassword( _
   ByRef brRec As tAuthUserType, _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Updates the user's password
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ResetPassword"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext
 
   On Error GoTo ErrorHandler
 
   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()
 
   '-----edit the input parameters
   With brRec
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", True, , 1)
      bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1)
   End With
   
    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With
      
   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_ResetPassword"

   '-----cleanup
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

Public Sub SignIn( _
   ByRef brRec As tAuthUserType)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  validates the user and logs them in
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SignIn"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext
 
   On Error GoTo ErrorHandler
 
   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()
 
   '-----edit the input parameters
   With brRec
      .Logon = moUtil.EditString(.Logon, "Logon", True, , 3, 80)
      .Password = moUtil.EditString(.Password, "Password", True, , 3, 30)
   End With
 
    '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamInput, 80, brRec.Logon)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 30, brRec.Password)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmployeeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@UserType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString(mClient, mProject), "pts_AuthUser_SignIn"
   
   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .TrainerID = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerID").Value)
      .EmployeeID = moUtil.FetchLong(oCmd.Parameters.Item("@EmployeeID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .OrgID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgID").Value)
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .AuthUserName = moUtil.FetchString(oCmd.Parameters.Item("@AuthUserName").Value)
      .UserType = moUtil.FetchLong(oCmd.Parameters.Item("@UserType").Value)
      .UserGroup = moUtil.FetchLong(oCmd.Parameters.Item("@UserGroup").Value)
      .UserStatus = moUtil.FetchLong(oCmd.Parameters.Item("@UserStatus").Value)
   End With
   
   '-----cleanup
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

Private Sub Class_Initialize()
   Set moSys = New wtSystem.CSystem
   Set moUtil = New wtSystem.CUtility
End Sub

Private Sub Class_Terminate()
   Set moSys = Nothing
   Set moUtil = Nothing
End Sub
