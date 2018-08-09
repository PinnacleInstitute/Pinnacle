VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CFriendB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CFriend"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tFriendType
   FriendID As String
   MemberID As String
   FriendGroupID As String
   CountryID As String
   FriendGroupName As String
   CountryName As String
   NameLast As String
   NameFirst As String
   FriendName As String
   Email As String
   FriendDate As String
   Status As String
   Zip As String
   DOB As String
End Type

Public Sub Add( _ 
   ByRef brRec As tFriendType, _ 
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
      .Parameters.Append .CreateParameter("@FriendID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamInput, vbNull, CLng(brRec.FriendGroupID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@FriendDate", adDate, adParamInput, vbNull, CDate(brRec.FriendDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 10, brRec.Zip)
      .Parameters.Append .CreateParameter("@DOB", adDate, adParamInput, vbNull, CDate(brRec.DOB))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Friend_Add"

   '-----get return values
   With brRec
      .FriendID = moUtil.FetchLong(oCmd.Parameters.Item("@FriendID").Value)
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

Public Function UpdateStatus( _ 
   ByRef brRec As tFriendType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .FriendID = moUtil.EditLong(.FriendID, "FriendID", True, 0, 1) 
      .Status = moUtil.EditLong(.Status, "Status", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FriendID", adInteger, adParamInput, vbNull, CLng(brRec.FriendID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Friend_UpdateStatus"

   '-----get return values
   UpdateStatus = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Duplicate( _ 
   ByRef brRec As tFriendType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Duplicate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Email = moUtil.EditString(.Email, "Email", True, "", 1, 80) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Friend_Duplicate"

   '-----get return values
   Duplicate = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Friend_Count"

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
   ByRef brRec As tFriendType, _ 
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
      .FriendID = moUtil.EditLong(.FriendID, "FriendID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FriendID", adInteger, adParamInput, vbNull, CLng(brRec.FriendID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Friend_Delete"

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
   ByRef brRec As tFriendType, _ 
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
      .FriendID = moUtil.EditLong(.FriendID, "FriendID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FriendID", adInteger, adParamInput, vbNull, CLng(brRec.FriendID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FriendGroupName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@FriendName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@FriendDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@DOB", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Friend_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .FriendGroupID = moUtil.FetchLong(oCmd.Parameters.Item("@FriendGroupID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .FriendGroupName = moUtil.FetchString(oCmd.Parameters.Item("@FriendGroupName").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .FriendName = moUtil.FetchString(oCmd.Parameters.Item("@FriendName").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .FriendDate = moUtil.FetchDate(oCmd.Parameters.Item("@FriendDate").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .DOB = moUtil.FetchDate(oCmd.Parameters.Item("@DOB").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tFriendType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFriendType
   Dim vRec As tFriendType
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
      Case cptsFriendFindFriendName
         sProc = "pts_Friend_FindFriendName"
         MaxBookMark = 72
      Case cptsFriendFindEmail
         sProc = "pts_Friend_FindEmail"
         MaxBookMark = 90
      Case cptsFriendFindFriendDate
         sProc = "pts_Friend_FindFriendDate"
         MaxBookMark = 30
      Case cptsFriendFindFriendGroupName
         sProc = "pts_Friend_FindFriendGroupName"
         MaxBookMark = 50
      Case cptsFriendFindCountryName
         sProc = "pts_Friend_FindCountryName"
         MaxBookMark = 60
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
               vRec.FriendID = moUtil.FetchLong(.Fields.Item("FriendID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.FriendGroupID = moUtil.FetchLong(.Fields.Item("FriendGroupID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.FriendGroupName = moUtil.FetchString(.Fields.Item("FriendGroupName").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.FriendName = moUtil.FetchString(.Fields.Item("FriendName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.FriendDate = moUtil.FetchDate(.Fields.Item("FriendDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.DOB = moUtil.FetchDate(.Fields.Item("DOB").Value)
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

Public Sub Update( _ 
   ByRef brRec As tFriendType, _ 
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
      .Parameters.Append .CreateParameter("@FriendID", adInteger, adParamInput, vbNull, CLng(brRec.FriendID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@FriendGroupID", adInteger, adParamInput, vbNull, CLng(brRec.FriendGroupID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@FriendDate", adDate, adParamInput, vbNull, CDate(brRec.FriendDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 10, brRec.Zip)
      .Parameters.Append .CreateParameter("@DOB", adDate, adParamInput, vbNull, CDate(brRec.DOB))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Friend_Update"

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
   ByRef brRec As tFriendType, _ 
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
         .FriendID = moUtil.EditLong(.FriendID, "FriendID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, , 1) 
      .FriendGroupID = moUtil.EditLong(.FriendGroupID, "FriendGroupID", False, , 1) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", False, , 1) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", True, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", True, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80) 
      .FriendDate = moUtil.EditDate(.FriendDate, "FriendDate", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 10) 
      .DOB = moUtil.EditDate(.DOB, "DOB", False) 
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