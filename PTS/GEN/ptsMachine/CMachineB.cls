VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMachineB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMachine"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMachineType
   MachineID As String
   MemberID As String
   MemberNameFirst As String
   MemberNameLast As String
   MemberEmail As String
   LiveDriveID As String
   NameLast As String
   NameFirst As String
   MachineName As String
   Email As String
   Password As String
   WebName As String
   Status As String
   Service As String
   ActiveDate As String
   CancelDate As String
   RemoveDate As String
   BackupUsed As String
   BackupCapacity As String
   BriefcaseUsed As String
   BriefcaseCapacity As String
   Qty As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMachineType, _ 
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
      .Parameters.Append .CreateParameter("@MachineID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@LiveDriveID", adInteger, adParamInput, vbNull, CLng(brRec.LiveDriveID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@WebName", adVarWChar, adParamInput, 80, brRec.WebName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Service", adInteger, adParamInput, vbNull, CLng(brRec.Service))
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamInput, vbNull, CDate(brRec.ActiveDate))
      .Parameters.Append .CreateParameter("@CancelDate", adDate, adParamInput, vbNull, CDate(brRec.CancelDate))
      .Parameters.Append .CreateParameter("@RemoveDate", adDate, adParamInput, vbNull, CDate(brRec.RemoveDate))
      .Parameters.Append .CreateParameter("@BackupUsed", adVarWChar, adParamInput, 10, brRec.BackupUsed)
      .Parameters.Append .CreateParameter("@BackupCapacity", adVarWChar, adParamInput, 10, brRec.BackupCapacity)
      .Parameters.Append .CreateParameter("@BriefcaseUsed", adVarWChar, adParamInput, 10, brRec.BriefcaseUsed)
      .Parameters.Append .CreateParameter("@BriefcaseCapacity", adVarWChar, adParamInput, 10, brRec.BriefcaseCapacity)
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamInput, vbNull, CLng(brRec.Qty))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_Add"

   '-----get return values
   With brRec
      .MachineID = moUtil.FetchLong(oCmd.Parameters.Item("@MachineID").Value)
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

Public Function MemberCount( _ 
   ByRef brRec As tMachineType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_MemberCount"

   '-----get return values
   MemberCount = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetCustomerPrice( _ 
   ByRef brRec As tMachineType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetCustomerPrice"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_SetCustomerPrice"

   '-----get return values
   SetCustomerPrice = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Logon( _ 
   ByRef brRec As tMachineType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Logon"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Email = moUtil.EditString(.Email, "Email", True, "", 1, 80) 
      .Password = moUtil.EditString(.Password, "Password", True, "", 1, 20) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 20, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_Logon"

   '-----get return values
   Logon = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tMachineType, _ 
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
      .MachineID = moUtil.EditLong(.MachineID, "MachineID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MachineID", adInteger, adParamInput, vbNull, CLng(brRec.MachineID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_Delete"

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
   ByRef brRec As tMachineType, _ 
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
      .MachineID = moUtil.EditLong(.MachineID, "MachineID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MachineID", adInteger, adParamInput, vbNull, CLng(brRec.MachineID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberNameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberNameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@LiveDriveID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MachineName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@WebName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Service", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CancelDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RemoveDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BackupUsed", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@BackupCapacity", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@BriefcaseUsed", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@BriefcaseCapacity", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .MemberNameFirst = moUtil.FetchString(oCmd.Parameters.Item("@MemberNameFirst").Value)
      .MemberNameLast = moUtil.FetchString(oCmd.Parameters.Item("@MemberNameLast").Value)
      .MemberEmail = moUtil.FetchString(oCmd.Parameters.Item("@MemberEmail").Value)
      .LiveDriveID = moUtil.FetchLong(oCmd.Parameters.Item("@LiveDriveID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MachineName = moUtil.FetchString(oCmd.Parameters.Item("@MachineName").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Password = moUtil.FetchString(oCmd.Parameters.Item("@Password").Value)
      .WebName = moUtil.FetchString(oCmd.Parameters.Item("@WebName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Service = moUtil.FetchLong(oCmd.Parameters.Item("@Service").Value)
      .ActiveDate = moUtil.FetchDate(oCmd.Parameters.Item("@ActiveDate").Value)
      .CancelDate = moUtil.FetchDate(oCmd.Parameters.Item("@CancelDate").Value)
      .RemoveDate = moUtil.FetchDate(oCmd.Parameters.Item("@RemoveDate").Value)
      .BackupUsed = moUtil.FetchString(oCmd.Parameters.Item("@BackupUsed").Value)
      .BackupCapacity = moUtil.FetchString(oCmd.Parameters.Item("@BackupCapacity").Value)
      .BriefcaseUsed = moUtil.FetchString(oCmd.Parameters.Item("@BriefcaseUsed").Value)
      .BriefcaseCapacity = moUtil.FetchString(oCmd.Parameters.Item("@BriefcaseCapacity").Value)
      .Qty = moUtil.FetchLong(oCmd.Parameters.Item("@Qty").Value)
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

Public Sub FetchEmail( _ 
   ByRef brRec As tMachineType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Email = moUtil.EditString(.Email, "Email", True, "", 1, 80) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@MachineID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_FetchEmail"

   '-----get return values
   With brRec
      .MachineID = moUtil.FetchLong(oCmd.Parameters.Item("@MachineID").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tMachineType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMachineType
   Dim vRec As tMachineType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsMachineFindMachineName
         sProc = "pts_Machine_FindMachineName"
         MaxBookMark = 72
      Case cptsMachineFindEmail
         sProc = "pts_Machine_FindEmail"
         MaxBookMark = 90
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
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
               vRec.MachineID = moUtil.FetchLong(.Fields.Item("MachineID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MemberNameFirst = moUtil.FetchString(.Fields.Item("MemberNameFirst").Value)
               vRec.MemberNameLast = moUtil.FetchString(.Fields.Item("MemberNameLast").Value)
               vRec.MemberEmail = moUtil.FetchString(.Fields.Item("MemberEmail").Value)
               vRec.LiveDriveID = moUtil.FetchLong(.Fields.Item("LiveDriveID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MachineName = moUtil.FetchString(.Fields.Item("MachineName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.WebName = moUtil.FetchString(.Fields.Item("WebName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Service = moUtil.FetchLong(.Fields.Item("Service").Value)
               vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
               vRec.CancelDate = moUtil.FetchDate(.Fields.Item("CancelDate").Value)
               vRec.RemoveDate = moUtil.FetchDate(.Fields.Item("RemoveDate").Value)
               vRec.BackupUsed = moUtil.FetchString(.Fields.Item("BackupUsed").Value)
               vRec.BackupCapacity = moUtil.FetchString(.Fields.Item("BackupCapacity").Value)
               vRec.BriefcaseUsed = moUtil.FetchString(.Fields.Item("BriefcaseUsed").Value)
               vRec.BriefcaseCapacity = moUtil.FetchString(.Fields.Item("BriefcaseCapacity").Value)
               vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
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

Public Function ListAll( _ 
   ByVal bvMemberID As Long) As tMachineType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMachineType
   Dim vRec As tMachineType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0, 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_ListAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MachineID = moUtil.FetchLong(.Fields.Item("MachineID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.LiveDriveID = moUtil.FetchLong(.Fields.Item("LiveDriveID").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
            vRec.WebName = moUtil.FetchString(.Fields.Item("WebName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Service = moUtil.FetchLong(.Fields.Item("Service").Value)
            vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
            vRec.CancelDate = moUtil.FetchDate(.Fields.Item("CancelDate").Value)
            vRec.RemoveDate = moUtil.FetchDate(.Fields.Item("RemoveDate").Value)
            vRec.BackupUsed = moUtil.FetchString(.Fields.Item("BackupUsed").Value)
            vRec.BackupCapacity = moUtil.FetchString(.Fields.Item("BackupCapacity").Value)
            vRec.BriefcaseUsed = moUtil.FetchString(.Fields.Item("BriefcaseUsed").Value)
            vRec.BriefcaseCapacity = moUtil.FetchString(.Fields.Item("BriefcaseCapacity").Value)
            vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
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

Public Function List( _ 
   ByVal bvMemberID As Long) As tMachineType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMachineType
   Dim vRec As tMachineType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0, 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MachineID = moUtil.FetchLong(.Fields.Item("MachineID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.LiveDriveID = moUtil.FetchLong(.Fields.Item("LiveDriveID").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
            vRec.WebName = moUtil.FetchString(.Fields.Item("WebName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Service = moUtil.FetchLong(.Fields.Item("Service").Value)
            vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
            vRec.CancelDate = moUtil.FetchDate(.Fields.Item("CancelDate").Value)
            vRec.RemoveDate = moUtil.FetchDate(.Fields.Item("RemoveDate").Value)
            vRec.BackupUsed = moUtil.FetchString(.Fields.Item("BackupUsed").Value)
            vRec.BackupCapacity = moUtil.FetchString(.Fields.Item("BackupCapacity").Value)
            vRec.BriefcaseUsed = moUtil.FetchString(.Fields.Item("BriefcaseUsed").Value)
            vRec.BriefcaseCapacity = moUtil.FetchString(.Fields.Item("BriefcaseCapacity").Value)
            vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   List = vRecs

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
   ByRef brRec As tMachineType, _ 
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
      .Parameters.Append .CreateParameter("@MachineID", adInteger, adParamInput, vbNull, CLng(brRec.MachineID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@LiveDriveID", adInteger, adParamInput, vbNull, CLng(brRec.LiveDriveID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@WebName", adVarWChar, adParamInput, 80, brRec.WebName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Service", adInteger, adParamInput, vbNull, CLng(brRec.Service))
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamInput, vbNull, CDate(brRec.ActiveDate))
      .Parameters.Append .CreateParameter("@CancelDate", adDate, adParamInput, vbNull, CDate(brRec.CancelDate))
      .Parameters.Append .CreateParameter("@RemoveDate", adDate, adParamInput, vbNull, CDate(brRec.RemoveDate))
      .Parameters.Append .CreateParameter("@BackupUsed", adVarWChar, adParamInput, 10, brRec.BackupUsed)
      .Parameters.Append .CreateParameter("@BackupCapacity", adVarWChar, adParamInput, 10, brRec.BackupCapacity)
      .Parameters.Append .CreateParameter("@BriefcaseUsed", adVarWChar, adParamInput, 10, brRec.BriefcaseUsed)
      .Parameters.Append .CreateParameter("@BriefcaseCapacity", adVarWChar, adParamInput, 10, brRec.BriefcaseCapacity)
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamInput, vbNull, CLng(brRec.Qty))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Machine_Update"

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
   ByRef brRec As tMachineType, _ 
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
         .MachineID = moUtil.EditLong(.MachineID, "MachineID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, , 1) 
      .LiveDriveID = moUtil.EditLong(.LiveDriveID, "LiveDriveID", False, , 1) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", True, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", True, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80) 
      .Password = moUtil.EditString(.Password, "Password", True, , 1, 20) 
      .WebName = moUtil.EditString(.WebName, "WebName", True, , 1, 80) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Service = moUtil.EditLong(.Service, "Service", False) 
      .ActiveDate = moUtil.EditDate(.ActiveDate, "ActiveDate", False) 
      .CancelDate = moUtil.EditDate(.CancelDate, "CancelDate", False) 
      .RemoveDate = moUtil.EditDate(.RemoveDate, "RemoveDate", False) 
      .BackupUsed = moUtil.EditString(.BackupUsed, "BackupUsed", False, , 1, 10) 
      .BackupCapacity = moUtil.EditString(.BackupCapacity, "BackupCapacity", False, , 1, 10) 
      .BriefcaseUsed = moUtil.EditString(.BriefcaseUsed, "BriefcaseUsed", False, , 1, 10) 
      .BriefcaseCapacity = moUtil.EditString(.BriefcaseCapacity, "BriefcaseCapacity", False, , 1, 10) 
      .Qty = moUtil.EditLong(.Qty, "Qty", False, , 1) 
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