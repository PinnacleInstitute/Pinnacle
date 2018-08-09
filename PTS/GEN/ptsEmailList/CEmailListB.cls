VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CEmailListB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CEmailList"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tEmailListType
   EmailListID As String
   CompanyID As String
   EmailSourceID As String
   EmailListName As String
   SourceType As String
   CustomID As String
   Param1 As String
   Param2 As String
   Param3 As String
   Param4 As String
   Param5 As String
   Unsubscribe As String
   Query As String
End Type

Public Sub Add( _ 
   ByRef brRec As tEmailListType, _ 
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
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@EmailSourceID", adInteger, adParamInput, vbNull, CLng(brRec.EmailSourceID))
      .Parameters.Append .CreateParameter("@EmailListName", adVarWChar, adParamInput, 60, brRec.EmailListName)
      .Parameters.Append .CreateParameter("@SourceType", adInteger, adParamInput, vbNull, CLng(brRec.SourceType))
      .Parameters.Append .CreateParameter("@CustomID", adInteger, adParamInput, vbNull, CLng(brRec.CustomID))
      .Parameters.Append .CreateParameter("@Param1", adVarWChar, adParamInput, 30, brRec.Param1)
      .Parameters.Append .CreateParameter("@Param2", adVarWChar, adParamInput, 30, brRec.Param2)
      .Parameters.Append .CreateParameter("@Param3", adVarWChar, adParamInput, 30, brRec.Param3)
      .Parameters.Append .CreateParameter("@Param4", adVarWChar, adParamInput, 30, brRec.Param4)
      .Parameters.Append .CreateParameter("@Param5", adVarWChar, adParamInput, 30, brRec.Param5)
      .Parameters.Append .CreateParameter("@Unsubscribe", adSmallInt, adParamInput, vbNull, CInt(brRec.Unsubscribe))
      .Parameters.Append .CreateParameter("@Query", adVarWChar, adParamInput, 500, brRec.Query)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_EmailList_Add"

   '-----get return values
   With brRec
      .EmailListID = moUtil.FetchLong(oCmd.Parameters.Item("@EmailListID").Value)
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
   ByRef brRec As tEmailListType, _ 
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
      .EmailListID = moUtil.EditLong(.EmailListID, "EmailListID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_EmailList_Delete"

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
   ByVal bvSecurityToken As Long) As tEmailListType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailListType
   Dim vRec As tEmailListType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_EmailList_EnumUserList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailListID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.EmailListName = moUtil.FetchString(.Fields.Item("Name").Value)
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
   ByRef brRec As tEmailListType, _ 
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
      .EmailListID = moUtil.EditLong(.EmailListID, "EmailListID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailSourceID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailListName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@SourceType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CustomID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Param1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Param2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Param3", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Param4", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Param5", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Unsubscribe", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Query", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_EmailList_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .EmailSourceID = moUtil.FetchLong(oCmd.Parameters.Item("@EmailSourceID").Value)
      .EmailListName = moUtil.FetchString(oCmd.Parameters.Item("@EmailListName").Value)
      .SourceType = moUtil.FetchLong(oCmd.Parameters.Item("@SourceType").Value)
      .CustomID = moUtil.FetchLong(oCmd.Parameters.Item("@CustomID").Value)
      .Param1 = moUtil.FetchString(oCmd.Parameters.Item("@Param1").Value)
      .Param2 = moUtil.FetchString(oCmd.Parameters.Item("@Param2").Value)
      .Param3 = moUtil.FetchString(oCmd.Parameters.Item("@Param3").Value)
      .Param4 = moUtil.FetchString(oCmd.Parameters.Item("@Param4").Value)
      .Param5 = moUtil.FetchString(oCmd.Parameters.Item("@Param5").Value)
      .Unsubscribe = moUtil.FetchInteger(oCmd.Parameters.Item("@Unsubscribe").Value)
      .Query = moUtil.FetchString(oCmd.Parameters.Item("@Query").Value)
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

Public Function List( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tEmailListType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailListType
   Dim vRec As tEmailListType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_EmailList_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailListID = moUtil.FetchLong(.Fields.Item("EmailListID").Value)
            vRec.EmailListName = moUtil.FetchString(.Fields.Item("EmailListName").Value)
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
   ByRef brRec As tEmailListType, _ 
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
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@EmailSourceID", adInteger, adParamInput, vbNull, CLng(brRec.EmailSourceID))
      .Parameters.Append .CreateParameter("@EmailListName", adVarWChar, adParamInput, 60, brRec.EmailListName)
      .Parameters.Append .CreateParameter("@SourceType", adInteger, adParamInput, vbNull, CLng(brRec.SourceType))
      .Parameters.Append .CreateParameter("@CustomID", adInteger, adParamInput, vbNull, CLng(brRec.CustomID))
      .Parameters.Append .CreateParameter("@Param1", adVarWChar, adParamInput, 30, brRec.Param1)
      .Parameters.Append .CreateParameter("@Param2", adVarWChar, adParamInput, 30, brRec.Param2)
      .Parameters.Append .CreateParameter("@Param3", adVarWChar, adParamInput, 30, brRec.Param3)
      .Parameters.Append .CreateParameter("@Param4", adVarWChar, adParamInput, 30, brRec.Param4)
      .Parameters.Append .CreateParameter("@Param5", adVarWChar, adParamInput, 30, brRec.Param5)
      .Parameters.Append .CreateParameter("@Unsubscribe", adSmallInt, adParamInput, vbNull, CInt(brRec.Unsubscribe))
      .Parameters.Append .CreateParameter("@Query", adVarWChar, adParamInput, 500, brRec.Query)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_EmailList_Update"

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
   ByRef brRec As tEmailListType, _ 
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
         .EmailListID = moUtil.EditLong(.EmailListID, "EmailListID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .EmailSourceID = moUtil.EditLong(.EmailSourceID, "EmailSourceID", False, , 1) 
      .EmailListName = moUtil.EditString(.EmailListName, "EmailListName", True, , 1, 60) 
      .SourceType = moUtil.EditLong(.SourceType, "SourceType", False) 
      .CustomID = moUtil.EditLong(.CustomID, "CustomID", False) 
      .Param1 = moUtil.EditString(.Param1, "Param1", False) 
      .Param2 = moUtil.EditString(.Param2, "Param2", False) 
      .Param3 = moUtil.EditString(.Param3, "Param3", False) 
      .Param4 = moUtil.EditString(.Param4, "Param4", False) 
      .Param5 = moUtil.EditString(.Param5, "Param5", False) 
      .Unsubscribe = moUtil.EditInteger(.Unsubscribe, "Unsubscribe", False, 0, 0, 1) 
      .Query = moUtil.EditString(.Query, "Query", False, , 1, 500) 
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