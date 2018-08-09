VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CEmaileeB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CEmailee"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tEmaileeType
   EmaileeID As String
   CompanyID As String
   EmailListID As String
   Email As String
   FirstName As String
   LastName As String
   EmaileeName As String
   Data1 As String
   Data2 As String
   Data3 As String
   Data4 As String
   Data5 As String
   Status As String
End Type

Public Sub Add( _ 
   ByRef brRec As tEmaileeType, _ 
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
      .Parameters.Append .CreateParameter("@EmaileeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@FirstName", adVarWChar, adParamInput, 30, brRec.FirstName)
      .Parameters.Append .CreateParameter("@LastName", adVarWChar, adParamInput, 30, brRec.LastName)
      .Parameters.Append .CreateParameter("@Data1", adVarWChar, adParamInput, 80, brRec.Data1)
      .Parameters.Append .CreateParameter("@Data2", adVarWChar, adParamInput, 80, brRec.Data2)
      .Parameters.Append .CreateParameter("@Data3", adVarWChar, adParamInput, 80, brRec.Data3)
      .Parameters.Append .CreateParameter("@Data4", adVarWChar, adParamInput, 80, brRec.Data4)
      .Parameters.Append .CreateParameter("@Data5", adVarWChar, adParamInput, 80, brRec.Data5)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_Add"

   '-----get return values
   With brRec
      .EmaileeID = moUtil.FetchLong(oCmd.Parameters.Item("@EmaileeID").Value)
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

Public Function Unsubscribe( _ 
   ByRef brRec As tEmaileeType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Unsubscribe"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmaileeID", adInteger, adParamInput, vbNull, CLng(brRec.EmaileeID))
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("Return", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_Unsubscribe"

   '-----get return values
   Unsubscribe = moUtil.FetchLong(oCmd.Parameters.Item("Return").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_Count"

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
   ByRef brRec As tEmaileeType, _ 
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
      .EmaileeID = moUtil.EditLong(.EmaileeID, "EmaileeID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmaileeID", adInteger, adParamInput, vbNull, CLng(brRec.EmaileeID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_Delete"

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
   ByRef brRec As tEmaileeType, _ 
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
      .EmaileeID = moUtil.EditLong(.EmaileeID, "EmaileeID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmaileeID", adInteger, adParamInput, vbNull, CLng(brRec.EmaileeID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@FirstName", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@LastName", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@EmaileeName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Data1", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Data2", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Data3", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Data4", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Data5", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .EmailListID = moUtil.FetchLong(oCmd.Parameters.Item("@EmailListID").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .FirstName = moUtil.FetchString(oCmd.Parameters.Item("@FirstName").Value)
      .LastName = moUtil.FetchString(oCmd.Parameters.Item("@LastName").Value)
      .EmaileeName = moUtil.FetchString(oCmd.Parameters.Item("@EmaileeName").Value)
      .Data1 = moUtil.FetchString(oCmd.Parameters.Item("@Data1").Value)
      .Data2 = moUtil.FetchString(oCmd.Parameters.Item("@Data2").Value)
      .Data3 = moUtil.FetchString(oCmd.Parameters.Item("@Data3").Value)
      .Data4 = moUtil.FetchString(oCmd.Parameters.Item("@Data4").Value)
      .Data5 = moUtil.FetchString(oCmd.Parameters.Item("@Data5").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tEmaileeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmaileeType
   Dim vRec As tEmaileeType
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
      Case cptsEmaileeFindEmail
         sProc = "pts_Emailee_FindEmail"
         MaxBookMark = 90
      Case cptsEmaileeFindEmaileeName
         sProc = "pts_Emailee_FindEmaileeName"
         MaxBookMark = 72
      Case cptsEmaileeFindEmailListID
         sProc = "pts_Emailee_FindEmailListID"
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
               vRec.EmaileeID = moUtil.FetchLong(.Fields.Item("EmaileeID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.EmailListID = moUtil.FetchLong(.Fields.Item("EmailListID").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.FirstName = moUtil.FetchString(.Fields.Item("FirstName").Value)
               vRec.LastName = moUtil.FetchString(.Fields.Item("LastName").Value)
               vRec.EmaileeName = moUtil.FetchString(.Fields.Item("EmaileeName").Value)
               vRec.Data1 = moUtil.FetchString(.Fields.Item("Data1").Value)
               vRec.Data2 = moUtil.FetchString(.Fields.Item("Data2").Value)
               vRec.Data3 = moUtil.FetchString(.Fields.Item("Data3").Value)
               vRec.Data4 = moUtil.FetchString(.Fields.Item("Data4").Value)
               vRec.Data5 = moUtil.FetchString(.Fields.Item("Data5").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
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

Public Function ListStandard( _ 
   ByVal bvEmailListID As Long) As tEmaileeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListStandard"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmaileeType
   Dim vRec As tEmaileeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(bvEmailListID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_ListStandard")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmaileeID = moUtil.FetchLong(.Fields.Item("EmaileeID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.FirstName = moUtil.FetchString(.Fields.Item("FirstName").Value)
            vRec.LastName = moUtil.FetchString(.Fields.Item("LastName").Value)
            vRec.Data1 = moUtil.FetchString(.Fields.Item("Data1").Value)
            vRec.Data2 = moUtil.FetchString(.Fields.Item("Data2").Value)
            vRec.Data3 = moUtil.FetchString(.Fields.Item("Data3").Value)
            vRec.Data4 = moUtil.FetchString(.Fields.Item("Data4").Value)
            vRec.Data5 = moUtil.FetchString(.Fields.Item("Data5").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListStandard = vRecs

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

Public Function ListCustom( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvEmailListID As Long, _ 
   ByVal bvData1 As String, _ 
   ByVal bvData2 As String, _ 
   ByVal bvData3 As String, _ 
   ByVal bvData4 As String, _ 
   ByVal bvData5 As String) As tEmaileeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCustom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmaileeType
   Dim vRec As tEmaileeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(bvEmailListID))
      .Parameters.Append .CreateParameter("@Data1", adVarWChar, adParamInput, 80, bvData1)
      .Parameters.Append .CreateParameter("@Data2", adVarWChar, adParamInput, 80, bvData2)
      .Parameters.Append .CreateParameter("@Data3", adVarWChar, adParamInput, 80, bvData3)
      .Parameters.Append .CreateParameter("@Data4", adVarWChar, adParamInput, 80, bvData4)
      .Parameters.Append .CreateParameter("@Data5", adVarWChar, adParamInput, 80, bvData5)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_ListCustom")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmaileeID = moUtil.FetchLong(.Fields.Item("EmaileeID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.FirstName = moUtil.FetchString(.Fields.Item("FirstName").Value)
            vRec.LastName = moUtil.FetchString(.Fields.Item("LastName").Value)
            vRec.Data1 = moUtil.FetchString(.Fields.Item("Data1").Value)
            vRec.Data2 = moUtil.FetchString(.Fields.Item("Data2").Value)
            vRec.Data3 = moUtil.FetchString(.Fields.Item("Data3").Value)
            vRec.Data4 = moUtil.FetchString(.Fields.Item("Data4").Value)
            vRec.Data5 = moUtil.FetchString(.Fields.Item("Data5").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCustom = vRecs

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

Public Function ListUserDefined( _ 
   ByVal bvData1 As String, _ 
   ByVal bvData2 As String, _ 
   ByVal bvData3 As String) As tEmaileeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListUserDefined"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmaileeType
   Dim vRec As tEmaileeType
   Dim idxRec As Integer
   Dim sSQL As String

   On Error GoTo ErrorHandler

   '-----execute the command
   sSQL = UserDefinedEmailListSQL(bvData1, bvData2, bvData3)
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sSQL, 0)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmaileeID = moUtil.FetchLong(.Fields.Item("EmaileeID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.FirstName = moUtil.FetchString(.Fields.Item("FirstName").Value)
            vRec.LastName = moUtil.FetchString(.Fields.Item("LastName").Value)
            vRec.Data1 = moUtil.FetchString(.Fields.Item("Data1").Value)
            vRec.Data2 = moUtil.FetchString(.Fields.Item("Data2").Value)
            vRec.Data3 = moUtil.FetchString(.Fields.Item("Data3").Value)
            vRec.Data4 = moUtil.FetchString(.Fields.Item("Data4").Value)
            vRec.Data5 = moUtil.FetchString(.Fields.Item("Data5").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListUserDefined = vRecs

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

Public Function ListTeam( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvData1 As String, _ 
   ByVal bvData2 As String, _ 
   ByVal bvData3 As String, _ 
   ByVal bvData4 As String, _ 
   ByVal bvData5 As String) As tEmaileeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTeam"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmaileeType
   Dim vRec As tEmaileeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Data1", adVarWChar, adParamInput, 80, bvData1)
      .Parameters.Append .CreateParameter("@Data2", adVarWChar, adParamInput, 80, bvData2)
      .Parameters.Append .CreateParameter("@Data3", adVarWChar, adParamInput, 80, bvData3)
      .Parameters.Append .CreateParameter("@Data4", adVarWChar, adParamInput, 80, bvData4)
      .Parameters.Append .CreateParameter("@Data5", adVarWChar, adParamInput, 80, bvData5)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_ListTeam")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmaileeID = moUtil.FetchLong(.Fields.Item("EmaileeID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.FirstName = moUtil.FetchString(.Fields.Item("FirstName").Value)
            vRec.LastName = moUtil.FetchString(.Fields.Item("LastName").Value)
            vRec.Data1 = moUtil.FetchString(.Fields.Item("Data1").Value)
            vRec.Data2 = moUtil.FetchString(.Fields.Item("Data2").Value)
            vRec.Data3 = moUtil.FetchString(.Fields.Item("Data3").Value)
            vRec.Data4 = moUtil.FetchString(.Fields.Item("Data4").Value)
            vRec.Data5 = moUtil.FetchString(.Fields.Item("Data5").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListTeam = vRecs

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
   ByRef brRec As tEmaileeType, _ 
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
      .Parameters.Append .CreateParameter("@EmaileeID", adInteger, adParamInput, vbNull, CLng(brRec.EmaileeID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@FirstName", adVarWChar, adParamInput, 30, brRec.FirstName)
      .Parameters.Append .CreateParameter("@LastName", adVarWChar, adParamInput, 30, brRec.LastName)
      .Parameters.Append .CreateParameter("@Data1", adVarWChar, adParamInput, 80, brRec.Data1)
      .Parameters.Append .CreateParameter("@Data2", adVarWChar, adParamInput, 80, brRec.Data2)
      .Parameters.Append .CreateParameter("@Data3", adVarWChar, adParamInput, 80, brRec.Data3)
      .Parameters.Append .CreateParameter("@Data4", adVarWChar, adParamInput, 80, brRec.Data4)
      .Parameters.Append .CreateParameter("@Data5", adVarWChar, adParamInput, 80, brRec.Data5)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Emailee_Update"

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
   ByRef brRec As tEmaileeType, _ 
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
         .EmaileeID = moUtil.EditLong(.EmaileeID, "EmaileeID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .EmailListID = moUtil.EditLong(.EmailListID, "EmailListID", True, , 1) 
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80) 
      .FirstName = moUtil.EditString(.FirstName, "FirstName", False) 
      .LastName = moUtil.EditString(.LastName, "LastName", False) 
      .Data1 = moUtil.EditString(.Data1, "Data1", False) 
      .Data2 = moUtil.EditString(.Data2, "Data2", False) 
      .Data3 = moUtil.EditString(.Data3, "Data3", False) 
      .Data4 = moUtil.EditString(.Data4, "Data4", False) 
      .Data5 = moUtil.EditString(.Data5, "Data5", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
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