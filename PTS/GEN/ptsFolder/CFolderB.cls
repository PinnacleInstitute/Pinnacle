VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CFolderB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CFolder"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tFolderType
   FolderID As String
   ParentID As String
   CompanyID As String
   MemberID As String
   DripCampaignID As String
   FolderName As String
   Entity As String
   Seq As String
   IsShare As String
   Virtual As String
   Data As String
   GroupID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tFolderType, _ 
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
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@DripCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.DripCampaignID))
      .Parameters.Append .CreateParameter("@FolderName", adVarWChar, adParamInput, 60, brRec.FolderName)
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(brRec.Entity))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShare))
      .Parameters.Append .CreateParameter("@Virtual", adInteger, adParamInput, vbNull, CLng(brRec.Virtual))
      .Parameters.Append .CreateParameter("@Data", adVarWChar, adParamInput, 20, brRec.Data)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_Add"

   '-----get return values
   With brRec
      .FolderID = moUtil.FetchLong(oCmd.Parameters.Item("@FolderID").Value)
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

Public Function FullName( _ 
   ByRef brRec As tFolderType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FullName"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_FullName"

   '-----get return values
   FullName = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tFolderType, _ 
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
      .FolderID = moUtil.EditLong(.FolderID, "FolderID", False, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_Delete"

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

Public Function EnumFolderList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvEntity As Long, _ 
   ByVal bvSecurityToken As Long) As tFolderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumFolderList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderType
   Dim vRec As tFolderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(bvEntity))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_EnumFolderList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.FolderName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumFolderList = vRecs

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

Public Function EnumFolderAllList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvEntity As Long, _ 
   ByVal bvSecurityToken As Long) As tFolderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumFolderAllList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderType
   Dim vRec As tFolderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(bvEntity))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_EnumFolderAllList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.FolderName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumFolderAllList = vRecs

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
   ByRef brRec As tFolderType, _ 
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
      .FolderID = moUtil.EditLong(.FolderID, "FolderID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DripCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FolderName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Virtual", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Data", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_Fetch"

   '-----get return values
   With brRec
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .DripCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@DripCampaignID").Value)
      .FolderName = moUtil.FetchString(oCmd.Parameters.Item("@FolderName").Value)
      .Entity = moUtil.FetchLong(oCmd.Parameters.Item("@Entity").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .IsShare = moUtil.FetchInteger(oCmd.Parameters.Item("@IsShare").Value)
      .Virtual = moUtil.FetchLong(oCmd.Parameters.Item("@Virtual").Value)
      .Data = moUtil.FetchString(oCmd.Parameters.Item("@Data").Value)
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

Public Function ListFolder( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvEntity As Long) As tFolderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFolder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderType
   Dim vRec As tFolderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(bvEntity))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_ListFolder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderID = moUtil.FetchLong(.Fields.Item("FolderID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.DripCampaignID = moUtil.FetchLong(.Fields.Item("DripCampaignID").Value)
            vRec.FolderName = moUtil.FetchString(.Fields.Item("FolderName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.IsShare = moUtil.FetchInteger(.Fields.Item("IsShare").Value)
            vRec.Virtual = moUtil.FetchLong(.Fields.Item("Virtual").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListFolder = vRecs

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

Public Function ListVirtualFolder( _ 
   ByVal bvSecurityToken As Long) As tFolderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListVirtualFolder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderType
   Dim vRec As tFolderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_ListVirtualFolder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderID = moUtil.FetchLong(.Fields.Item("FolderID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.DripCampaignID = moUtil.FetchLong(.Fields.Item("DripCampaignID").Value)
            vRec.Virtual = moUtil.FetchLong(.Fields.Item("Virtual").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListVirtualFolder = vRecs

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
   ByRef brRec As tFolderType, _ 
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
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@DripCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.DripCampaignID))
      .Parameters.Append .CreateParameter("@FolderName", adVarWChar, adParamInput, 60, brRec.FolderName)
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(brRec.Entity))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShare))
      .Parameters.Append .CreateParameter("@Virtual", adInteger, adParamInput, vbNull, CLng(brRec.Virtual))
      .Parameters.Append .CreateParameter("@Data", adVarWChar, adParamInput, 20, brRec.Data)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Folder_Update"

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
   ByRef brRec As tFolderType, _ 
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
         .FolderID = moUtil.EditLong(.FolderID, "FolderID", False, , 1) 
      End If
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .DripCampaignID = moUtil.EditLong(.DripCampaignID, "DripCampaignID", False) 
      .FolderName = moUtil.EditString(.FolderName, "FolderName", True, , 1, 60) 
      .Entity = moUtil.EditLong(.Entity, "Entity", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .IsShare = moUtil.EditInteger(.IsShare, "IsShare", False, 0, 0, 1) 
      .Virtual = moUtil.EditLong(.Virtual, "Virtual", False) 
      .Data = moUtil.EditString(.Data, "Data", False, , 1, 20) 
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