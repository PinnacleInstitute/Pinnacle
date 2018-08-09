VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CAuthUser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAuthUser"
'-----properties
Private Const cEntityID As Long = 1
Private Const cDefaultLanguage As String = "en"
'-----properties
Private mDataRec As CSQL.tAuthUserType
Private mCurrentLanguage As String
'-----enumerators
Public Enum ptsAuthUserEnumConstants
   ptsAuthUserEnumUserStatus = cptsAuthUserEnumUserStatus
   ptsAuthUserEnumUserGroup = cptsAuthUserEnumUserGroup
   ptsAuthUserEnumUserType = cptsAuthUserEnumUserType
End Enum

Public Enum ptsAuthUserUserTypeConstants
   ptsAuthUserUserTypeSysAdmin = cptsAuthUserUserTypeSysAdmin
   ptsAuthUserUserTypeEmployee = cptsAuthUserUserTypeEmployee
   ptsAuthUserUserTypeTrainer = cptsAuthUserUserTypeTrainer
   ptsAuthUserUserTypeMember = cptsAuthUserUserTypeMember
   ptsAuthUserUserTypeOrg = cptsAuthUserUserTypeOrg
   ptsAuthUserUserTypeAffiliate = cptsAuthUserUserTypeAffiliate
End Enum

Public Enum ptsAuthUserUserGroupConstants
   ptsAuthUserUserGroupSysAdmin = cptsAuthUserUserGroupSysAdmin
   ptsAuthUserUserGroupManager = cptsAuthUserUserGroupManager
   ptsAuthUserUserGroupAdministrator = cptsAuthUserUserGroupAdministrator
   ptsAuthUserUserGroupEmployee = cptsAuthUserUserGroupEmployee
   ptsAuthUserUserGroupTrainer = cptsAuthUserUserGroupTrainer
   ptsAuthUserUserGroupMember = cptsAuthUserUserGroupMember
   ptsAuthUserUserGroupOrg = cptsAuthUserUserGroupOrg
   ptsAuthUserUserGroupAffiliate = cptsAuthUserUserGroupAffiliate
End Enum

Public Enum ptsAuthUserUserStatusConstants
   ptsAuthUserUserStatusActive = cptsAuthUserUserStatusActive
   ptsAuthUserUserStatusInActive = cptsAuthUserUserStatusInActive
   ptsAuthUserUserStatusReadOnly = cptsAuthUserUserStatusReadOnly
End Enum

Private mClient As String
Private mProject As String

Public Sub SysClientProject(ByVal bvClient As String, ByVal bvProject As String)
   mClient = bvClient
   mProject = bvProject
End Sub

Public Sub UpdateLogonPassword( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Save the logon ID and Password for a user.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateLogonPassword"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.UpdateLogonPassword mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub UpdateUserType( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Save the User Type for a user.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateUserType"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.UpdateUserType mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ChangeLogon( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Changes the logon ID for a user.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ChangeLogon"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.ChangeLogon mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub
Public Function IsLogon( _
   ByVal bvLogon As String) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsLogon"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   IsLogon = SQL.IsLogon(bvLogon)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub ChangePassword( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Changes the password for a user.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ChangePassword"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.ChangePassword mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Load( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Retrieves the record
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Load"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.Fetch mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub EmailLoad( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Retrieves the record by Email Address
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EmailLoad"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.EmailFetch mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ResetLogon( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Resets the logon ID for a user.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ResetLogon"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.ResetLogon mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ResetPassword( _
   ByVal bvSecurityToken As Long)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Resets the password for a user.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ResetPassword"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.ResetPassword mDataRec, bvSecurityToken
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub SignIn()
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Validates the security credentials and logs the user in
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SignIn"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   SQL.SignIn mDataRec
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Private Function SQL() As ptsAuthUser.CSQL
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns a reference to the object's data service object
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SQL"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
      
   Set SQL = New ptsAuthUser.CSQL
   SQL.SysClientProject mClient, mProject
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XML() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns the XML for the item
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim sChildren As String
   Dim sAttributes As String
   Dim sValue As String
   
   On Error GoTo ErrorHandler
   
   '-----create the XML for the children
   sChildren = ""
   
   '-----create the XML for the attributes
   sAttributes = ""
   sAttributes = sAttributes + XMLAttribute("AuthUserID", AuthUserID)
   sAttributes = sAttributes + XMLAttribute("TrainerID", TrainerID)
   sAttributes = sAttributes + XMLAttribute("EmployeeID", EmployeeID)
   sAttributes = sAttributes + XMLAttribute("MemberID", MemberID)
   sAttributes = sAttributes + XMLAttribute("OrgID", OrgID)
   sAttributes = sAttributes + XMLAttribute("AffiliateID", AffiliateID)
   sAttributes = sAttributes + XMLAttribute("Logon", Logon)
   sAttributes = sAttributes + XMLAttribute("NewLogon", NewLogon)
   sAttributes = sAttributes + XMLAttribute("ConfirmLogon", ConfirmLogon)
   sAttributes = sAttributes + XMLAttribute("Password", Password)
   sAttributes = sAttributes + XMLAttribute("NewPassword", NewPassword)
   sAttributes = sAttributes + XMLAttribute("ConfirmPassword", ConfirmPassword)
   sAttributes = sAttributes + XMLAttribute("Email", Email)
   sAttributes = sAttributes + XMLAttribute("NameLast", NameLast)
   sAttributes = sAttributes + XMLAttribute("NameFirst", NameFirst)
   sAttributes = sAttributes + XMLAttribute("AuthUserName", AuthUserName)
   sAttributes = sAttributes + XMLAttribute("UserType", UserType)
   sAttributes = sAttributes + XMLAttribute("UserGroup", UserGroup)
   sAttributes = sAttributes + XMLAttribute("UserStatus", UserStatus)

   '-----create the XML for the value
   sValue = ""
   
   '-----create the XML for the object
   XML = FormatXML(XMLElement("ptsAuthUser", sAttributes, sValue, sChildren))
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Property Get EnumUserType() As wtSystem.CEnumItems
   '----------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '----------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserType"
   '----------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems

   On Error GoTo ErrorHandler

   Set oEnums = New wtSystem.CEnumItems

   oEnums.Add cptsAuthUserUserTypeSysAdmin, "SysAdmin"
   oEnums.Add cptsAuthUserUserTypeEmployee, "Employee"
   oEnums.Add cptsAuthUserUserTypeTrainer, "Trainer"
   oEnums.Add cptsAuthUserUserTypeMember, "Member"
   oEnums.Add cptsAuthUserUserTypeOrg, "Organization"
   oEnums.Add cptsAuthUserUserTypeAffiliate, "Affiliate"

   Set EnumUserType = oEnums
   Set oEnums = Nothing

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get EnumUserGroup( _
   ByVal bvUserType As ptsAuthUserUserTypeConstants) As wtSystem.CEnumItems
   '----------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '----------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserGroup"
   '----------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems

   On Error GoTo ErrorHandler

   Set oEnums = New wtSystem.CEnumItems

   Select Case bvUserType
      Case cptsAuthUserUserTypeSysAdmin
         oEnums.Add cptsAuthUserUserGroupSysAdmin, "SysAdmin"
      Case cptsAuthUserUserTypeEmployee
         oEnums.Add cptsAuthUserUserGroupManager, "Manager"
         oEnums.Add cptsAuthUserUserGroupAdministrator, "Administrator"
         oEnums.Add cptsAuthUserUserGroupEmployee, "Employee"
      Case cptsAuthUserUserTypeTrainer
         oEnums.Add cptsAuthUserUserGroupTrainer, "Trainer"
      Case cptsAuthUserUserTypeMember
         oEnums.Add cptsAuthUserUserGroupMember, "Member"
      Case cptsAuthUserUserTypeOrg
         oEnums.Add cptsAuthUserUserGroupOrg, "Organization"
      Case cptsAuthUserUserTypeAffiliate
         oEnums.Add cptsAuthUserUserGroupAffiliate, "Affiliate"
   End Select

   Set EnumUserGroup = oEnums
   Set oEnums = Nothing

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get EnumUserStatus() As wtSystem.CEnumItems
   '----------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '----------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserStatus"
   '----------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems

   On Error GoTo ErrorHandler

   Set oEnums = New wtSystem.CEnumItems

   oEnums.Add cptsAuthUserUserStatusActive, "Active"
   oEnums.Add cptsAuthUserUserStatusInActive, "InActive"
   oEnums.Add cptsAuthUserUserStatusReadOnly, "ReadOnly"

   Set EnumUserStatus = oEnums
   Set oEnums = Nothing

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Friend Property Get DataRec() As ptsAuthUser.tAuthUserType
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   DataRec = mDataRec
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Friend Property Let DataRec( _
   ByRef brRec As ptsAuthUser.tAuthUserType)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   mDataRec = brRec
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get AuthUserID() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AuthUserID_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   AuthUserID = mDataRec.AuthUserID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let AuthUserID( _
   ByVal bvAuthUserID As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AuthUserID_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   mDataRec.AuthUserID = bvAuthUserID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get TrainerID() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TrainerID_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   TrainerID = mDataRec.TrainerID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let TrainerID( _
   ByVal bvTrainerID As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TrainerID_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   mDataRec.TrainerID = bvTrainerID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get EmployeeID() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EmployeeID_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   EmployeeID = mDataRec.EmployeeID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let EmployeeID( _
   ByVal bvEmployeeID As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EmployeeID_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   mDataRec.EmployeeID = bvEmployeeID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get MemberID() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   MemberID = mDataRec.MemberID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let MemberID( _
   ByVal bvMemberID As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   mDataRec.MemberID = bvMemberID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property
Public Property Get OrgID() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "OrgID_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   OrgID = mDataRec.OrgID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let OrgID( _
   ByVal bvOrgID As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "OrgID_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   mDataRec.OrgID = bvOrgID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property
Public Property Get AffiliateID() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AffiliateID_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   AffiliateID = mDataRec.AffiliateID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let AffiliateID( _
   ByVal bvAffiliateID As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AffiliateID_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   mDataRec.AffiliateID = bvAffiliateID
   
   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Logon() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Logon_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Logon = mDataRec.Logon

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Logon( _
   ByVal bvLogon As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Logon_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Logon = bvLogon

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get NewLogon() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewLogon_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   NewLogon = mDataRec.NewLogon

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let NewLogon( _
   ByVal bvNewLogon As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewLogon_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.NewLogon = bvNewLogon

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ConfirmLogon() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ConfirmLogon_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ConfirmLogon = mDataRec.ConfirmLogon

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ConfirmLogon( _
   ByVal bvConfirmLogon As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ConfirmLogon_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ConfirmLogon = bvConfirmLogon

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Password() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Password_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Password = mDataRec.Password

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Password( _
   ByVal bvPassword As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Password_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Password = bvPassword

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get NewPassword() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewPassword_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   NewPassword = mDataRec.NewPassword

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let NewPassword( _
   ByVal bvNewPassword As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewPassword_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.NewPassword = bvNewPassword

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ConfirmPassword() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ConfirmPassword_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ConfirmPassword = mDataRec.ConfirmPassword

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ConfirmPassword( _
   ByVal bvConfirmPassword As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ConfirmPassword_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ConfirmPassword = bvConfirmPassword

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Email() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Email_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Email = mDataRec.Email

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Email( _
   ByVal bvEmail As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Email_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Email = bvEmail

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get NameLast() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameLast_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   NameLast = mDataRec.NameLast

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let NameLast( _
   ByVal bvNameLast As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameLast_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.NameLast = bvNameLast

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get NameFirst() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameFirst_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   NameFirst = mDataRec.NameFirst

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let NameFirst( _
   ByVal bvNameFirst As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameFirst_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.NameFirst = bvNameFirst

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get AuthUserName() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AuthUserName_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   AuthUserName = mDataRec.AuthUserName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get UserType() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UserType_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   UserType = mDataRec.UserType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let UserType( _
   ByVal bvUserType As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UserType_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.UserType = bvUserType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get UserGroup() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Return the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UserGroup_Get"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   UserGroup = mDataRec.UserGroup

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let UserGroup( _
   ByVal bvUserGroup As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the value of the attribute.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UserGroup_Let"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.UserGroup = bvUserGroup

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get UserStatus() As String
   '----------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '----------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UserStatus_Get"
   '----------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   UserStatus = mDataRec.UserStatus

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let UserStatus( _
   ByVal bvUserStatus As String)
   '----------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '----------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UserStatus_Let"
   '----------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.UserStatus = bvUserStatus

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let SysCurrentLanguage( _
   ByVal bvLanguage As String)
   '--------------------------------------------------
   'Sets the value of the attribute.
   '--------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Language_Let"
   '--------------------------------------------------
   On Error GoTo ErrorHandler

   mCurrentLanguage = bvLanguage

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Private Sub Class_Initialize()
   mCurrentLanguage = cDefaultLanguage
   mClient = "Pinnacle"
   mProject = "pts"
End Sub


