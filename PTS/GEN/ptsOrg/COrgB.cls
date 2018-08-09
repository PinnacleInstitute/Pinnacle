VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "COrgB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "COrg"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tOrgType
   OrgID As String
   AuthUserID As String
   ParentID As String
   CompanyID As String
   ForumID As String
   MemberID As String
   PrivateID As String
   UserGroup As String
   UserStatus As String
   Logon As String
   OrgName As String
   Description As String
   Status As String
   NameLast As String
   NameFirst As String
   ContactName As String
   Email As String
   IsCatalog As String
   Level As String
   Hierarchy As String
   CourseCount As String
   MemberCount As String
   IsPublic As String
   IsChat As String
   IsForum As String
   IsSuggestion As String
   IsFavorite As String
   IsProgram As String
   NoCertificate As String
   IsCustomCertificate As String
   Secure As String
   Credits As String
   NewLogon As String
   NewPassword As String
   CourseDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tOrgType, _ 
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
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(brRec.ForumID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@PrivateID", adInteger, adParamInput, vbNull, CLng(brRec.PrivateID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@OrgName", adVarWChar, adParamInput, 60, brRec.OrgName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@IsCatalog", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCatalog))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(brRec.Level))
      .Parameters.Append .CreateParameter("@Hierarchy", adVarWChar, adParamInput, 100, brRec.Hierarchy)
      .Parameters.Append .CreateParameter("@CourseCount", adInteger, adParamInput, vbNull, CLng(brRec.CourseCount))
      .Parameters.Append .CreateParameter("@MemberCount", adInteger, adParamInput, vbNull, CLng(brRec.MemberCount))
      .Parameters.Append .CreateParameter("@IsPublic", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPublic))
      .Parameters.Append .CreateParameter("@IsChat", adSmallInt, adParamInput, vbNull, CInt(brRec.IsChat))
      .Parameters.Append .CreateParameter("@IsForum", adSmallInt, adParamInput, vbNull, CInt(brRec.IsForum))
      .Parameters.Append .CreateParameter("@IsSuggestion", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSuggestion))
      .Parameters.Append .CreateParameter("@IsFavorite", adSmallInt, adParamInput, vbNull, CInt(brRec.IsFavorite))
      .Parameters.Append .CreateParameter("@IsProgram", adSmallInt, adParamInput, vbNull, CInt(brRec.IsProgram))
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.NoCertificate))
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCustomCertificate))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
      .Parameters.Append .CreateParameter("@Credits", adInteger, adParamInput, vbNull, CLng(brRec.Credits))
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_Add"

   '-----get return values
   With brRec
      .OrgID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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

Public Function IsPublicCatalog( _ 
   ByRef brRec As tOrgType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsPublicCatalog"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Public", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_IsPublicCatalog"

   '-----get return values
   IsPublicCatalog = moUtil.FetchLong(oCmd.Parameters.Item("@Public").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetEmail( _ 
   ByRef brRec As tOrgType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_GetEmail"

   '-----get return values
   GetEmail = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)

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
   ByRef brRec As tOrgType, _ 
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
      .OrgID = moUtil.EditLong(.OrgID, "OrgID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_Delete"

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

Public Function EnumCompanyDocList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvSecurityToken As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumCompanyDocList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_EnumCompanyDocList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumCompanyDocList = vRecs

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
   ByRef brRec As tOrgType, _ 
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
      .OrgID = moUtil.EditLong(.OrgID, "OrgID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PrivateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@OrgName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ContactName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@IsCatalog", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Hierarchy", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@CourseCount", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberCount", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPublic", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsChat", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsForum", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsSuggestion", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsFavorite", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsProgram", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Credits", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_Fetch"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .ForumID = moUtil.FetchLong(oCmd.Parameters.Item("@ForumID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .PrivateID = moUtil.FetchLong(oCmd.Parameters.Item("@PrivateID").Value)
      .UserGroup = moUtil.FetchLong(oCmd.Parameters.Item("@UserGroup").Value)
      .UserStatus = moUtil.FetchLong(oCmd.Parameters.Item("@UserStatus").Value)
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
      .OrgName = moUtil.FetchString(oCmd.Parameters.Item("@OrgName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .ContactName = moUtil.FetchString(oCmd.Parameters.Item("@ContactName").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .IsCatalog = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCatalog").Value)
      .Level = moUtil.FetchLong(oCmd.Parameters.Item("@Level").Value)
      .Hierarchy = moUtil.FetchString(oCmd.Parameters.Item("@Hierarchy").Value)
      .CourseCount = moUtil.FetchLong(oCmd.Parameters.Item("@CourseCount").Value)
      .MemberCount = moUtil.FetchLong(oCmd.Parameters.Item("@MemberCount").Value)
      .IsPublic = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPublic").Value)
      .IsChat = moUtil.FetchInteger(oCmd.Parameters.Item("@IsChat").Value)
      .IsForum = moUtil.FetchInteger(oCmd.Parameters.Item("@IsForum").Value)
      .IsSuggestion = moUtil.FetchInteger(oCmd.Parameters.Item("@IsSuggestion").Value)
      .IsFavorite = moUtil.FetchInteger(oCmd.Parameters.Item("@IsFavorite").Value)
      .IsProgram = moUtil.FetchInteger(oCmd.Parameters.Item("@IsProgram").Value)
      .NoCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@NoCertificate").Value)
      .IsCustomCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCustomCertificate").Value)
      .Secure = moUtil.FetchLong(oCmd.Parameters.Item("@Secure").Value)
      .Credits = moUtil.FetchLong(oCmd.Parameters.Item("@Credits").Value)
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

Public Sub FetchAuthUserID( _ 
   ByRef brRec As tOrgType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchAuthUserID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .OrgID = moUtil.EditLong(.OrgID, "OrgID", True, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_FetchAuthUserID"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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

Public Sub LoadAuthUser( _ 
   ByRef brRec As tOrgType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadAuthUser"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_LoadAuthUser"

   '-----get return values
   With brRec
      .OrgID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgID").Value)
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

Public Sub LoadLogon( _ 
   ByRef brRec As tOrgType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadLogon"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamInput, 80, brRec.Logon)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_LoadLogon"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
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

Public Function ListTree( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTree"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListTree")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            vRec.CourseCount = moUtil.FetchLong(.Fields.Item("CourseCount").Value)
            vRec.MemberCount = moUtil.FetchLong(.Fields.Item("MemberCount").Value)
            vRec.IsPublic = moUtil.FetchInteger(.Fields.Item("IsPublic").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListTree = vRecs

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

Public Function ListBranch( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListBranch"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListBranch")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            vRec.CourseCount = moUtil.FetchLong(.Fields.Item("CourseCount").Value)
            vRec.MemberCount = moUtil.FetchLong(.Fields.Item("MemberCount").Value)
            vRec.IsPublic = moUtil.FetchInteger(.Fields.Item("IsPublic").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListBranch = vRecs

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

Public Function ListMember( _ 
   ByVal bvMemberID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMember = vRecs

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

Public Function ListMemberHierarchy( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberHierarchy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListMemberHierarchy")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            vRec.ForumID = moUtil.FetchLong(.Fields.Item("ForumID").Value)
            vRec.IsChat = moUtil.FetchInteger(.Fields.Item("IsChat").Value)
            vRec.IsForum = moUtil.FetchInteger(.Fields.Item("IsForum").Value)
            vRec.IsSuggestion = moUtil.FetchInteger(.Fields.Item("IsSuggestion").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberHierarchy = vRecs

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

Public Function ListProgram( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListProgram")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProgram = vRecs

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

Public Function ListFavoritePrivate( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFavoritePrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListFavoritePrivate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListFavoritePrivate = vRecs

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

Public Function ListFavorite( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvCourseDate As Date, _ 
   ByVal bvStatus As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFavorite"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamInput, vbNull, CDate(bvCourseDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListFavorite")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            vRec.CourseCount = moUtil.FetchLong(.Fields.Item("CourseCount").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListFavorite = vRecs

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

Public Function ListActiveUsers( _ 
   ByVal bvCompanyID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActiveUsers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListActiveUsers")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListActiveUsers = vRecs

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

Public Function ListUsers( _ 
   ByVal bvCompanyID As Long) As tOrgType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListUsers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tOrgType
   Dim vRec As tOrgType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_ListUsers")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
            vRec.UserGroup = moUtil.FetchLong(.Fields.Item("UserGroup").Value)
            vRec.UserStatus = moUtil.FetchLong(.Fields.Item("UserStatus").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListUsers = vRecs

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
   ByRef brRec As tOrgType, _ 
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
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ForumID", adInteger, adParamInput, vbNull, CLng(brRec.ForumID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@PrivateID", adInteger, adParamInput, vbNull, CLng(brRec.PrivateID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@OrgName", adVarWChar, adParamInput, 60, brRec.OrgName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@IsCatalog", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCatalog))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(brRec.Level))
      .Parameters.Append .CreateParameter("@Hierarchy", adVarWChar, adParamInput, 100, brRec.Hierarchy)
      .Parameters.Append .CreateParameter("@CourseCount", adInteger, adParamInput, vbNull, CLng(brRec.CourseCount))
      .Parameters.Append .CreateParameter("@MemberCount", adInteger, adParamInput, vbNull, CLng(brRec.MemberCount))
      .Parameters.Append .CreateParameter("@IsPublic", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPublic))
      .Parameters.Append .CreateParameter("@IsChat", adSmallInt, adParamInput, vbNull, CInt(brRec.IsChat))
      .Parameters.Append .CreateParameter("@IsForum", adSmallInt, adParamInput, vbNull, CInt(brRec.IsForum))
      .Parameters.Append .CreateParameter("@IsSuggestion", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSuggestion))
      .Parameters.Append .CreateParameter("@IsFavorite", adSmallInt, adParamInput, vbNull, CInt(brRec.IsFavorite))
      .Parameters.Append .CreateParameter("@IsProgram", adSmallInt, adParamInput, vbNull, CInt(brRec.IsProgram))
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.NoCertificate))
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCustomCertificate))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
      .Parameters.Append .CreateParameter("@Credits", adInteger, adParamInput, vbNull, CLng(brRec.Credits))
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Org_Update"

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
   ByRef brRec As tOrgType, _ 
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
         .OrgID = moUtil.EditLong(.OrgID, "OrgID", True, , 1) 
      End If
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .ForumID = moUtil.EditLong(.ForumID, "ForumID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .PrivateID = moUtil.EditLong(.PrivateID, "PrivateID", False) 
      .OrgName = moUtil.EditString(.OrgName, "OrgName", False, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 1000) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .IsCatalog = moUtil.EditInteger(.IsCatalog, "IsCatalog", False, 0, 0, 1) 
      .Level = moUtil.EditLong(.Level, "Level", False) 
      .Hierarchy = moUtil.EditString(.Hierarchy, "Hierarchy", False, , 1, 100) 
      .CourseCount = moUtil.EditLong(.CourseCount, "CourseCount", False) 
      .MemberCount = moUtil.EditLong(.MemberCount, "MemberCount", False) 
      .IsPublic = moUtil.EditInteger(.IsPublic, "IsPublic", False, 0, 0, 1) 
      .IsChat = moUtil.EditInteger(.IsChat, "IsChat", False, 0, 0, 1) 
      .IsForum = moUtil.EditInteger(.IsForum, "IsForum", False, 0, 0, 1) 
      .IsSuggestion = moUtil.EditInteger(.IsSuggestion, "IsSuggestion", False, 0, 0, 1) 
      .IsFavorite = moUtil.EditInteger(.IsFavorite, "IsFavorite", False, 0, 0, 1) 
      .IsProgram = moUtil.EditInteger(.IsProgram, "IsProgram", False, 0, 0, 1) 
      .NoCertificate = moUtil.EditInteger(.NoCertificate, "NoCertificate", False, 0, 0, 1) 
      .IsCustomCertificate = moUtil.EditInteger(.IsCustomCertificate, "IsCustomCertificate", False, 0, 0, 1) 
      .Secure = moUtil.EditLong(.Secure, "Secure", False) 
      .Credits = moUtil.EditLong(.Credits, "Credits", False) 
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