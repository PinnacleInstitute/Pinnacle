VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMetricTypeB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMetricType"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMetricTypeType
   MetricTypeID As String
   CompanyID As String
   GroupID As String
   MetricTypeName As String
   Seq As String
   Pts As String
   IsActive As String
   IsResult As String
   IsLeader As String
   IsQty As String
   Description As String
   Required As String
   InputOptions As String
   AutoEvent As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMetricTypeType, _ 
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
      .Parameters.Append .CreateParameter("@MetricTypeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(brRec.GroupID))
      .Parameters.Append .CreateParameter("@MetricTypeName", adVarWChar, adParamInput, 40, brRec.MetricTypeName)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Pts", adInteger, adParamInput, vbNull, CLng(brRec.Pts))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@IsResult", adSmallInt, adParamInput, vbNull, CInt(brRec.IsResult))
      .Parameters.Append .CreateParameter("@IsLeader", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLeader))
      .Parameters.Append .CreateParameter("@IsQty", adSmallInt, adParamInput, vbNull, CInt(brRec.IsQty))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 200, brRec.Description)
      .Parameters.Append .CreateParameter("@Required", adVarWChar, adParamInput, 200, brRec.Required)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 1000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@AutoEvent", adInteger, adParamInput, vbNull, CLng(brRec.AutoEvent))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_Add"

   '-----get return values
   With brRec
      .MetricTypeID = moUtil.FetchLong(oCmd.Parameters.Item("@MetricTypeID").Value)
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
   ByRef brRec As tMetricTypeType, _ 
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
      .MetricTypeID = moUtil.EditLong(.MetricTypeID, "MetricTypeID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MetricTypeID", adInteger, adParamInput, vbNull, CLng(brRec.MetricTypeID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_Delete"

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

Public Function EnumUserCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecurityToken As Long) As tMetricTypeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMetricTypeType
   Dim vRec As tMetricTypeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_EnumUserCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MetricTypeID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.MetricTypeName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserCompany = vRecs

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

Public Function EnumUserGroup( _ 
   ByVal bvGroupID As Long, _ 
   ByVal bvSecurityToken As Long) As tMetricTypeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMetricTypeType
   Dim vRec As tMetricTypeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_EnumUserGroup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MetricTypeID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.MetricTypeName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserGroup = vRecs

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
   ByRef brRec As tMetricTypeType, _ 
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
      .MetricTypeID = moUtil.EditLong(.MetricTypeID, "MetricTypeID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MetricTypeID", adInteger, adParamInput, vbNull, CLng(brRec.MetricTypeID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MetricTypeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Pts", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsResult", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsLeader", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsQty", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Required", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@AutoEvent", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .GroupID = moUtil.FetchLong(oCmd.Parameters.Item("@GroupID").Value)
      .MetricTypeName = moUtil.FetchString(oCmd.Parameters.Item("@MetricTypeName").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .Pts = moUtil.FetchLong(oCmd.Parameters.Item("@Pts").Value)
      .IsActive = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActive").Value)
      .IsResult = moUtil.FetchInteger(oCmd.Parameters.Item("@IsResult").Value)
      .IsLeader = moUtil.FetchInteger(oCmd.Parameters.Item("@IsLeader").Value)
      .IsQty = moUtil.FetchInteger(oCmd.Parameters.Item("@IsQty").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Required = moUtil.FetchString(oCmd.Parameters.Item("@Required").Value)
      .InputOptions = moUtil.FetchString(oCmd.Parameters.Item("@InputOptions").Value)
      .AutoEvent = moUtil.FetchLong(oCmd.Parameters.Item("@AutoEvent").Value)
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
   ByVal bvCompanyID As Long) As tMetricTypeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMetricTypeType
   Dim vRec As tMetricTypeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MetricTypeID = moUtil.FetchLong(.Fields.Item("MetricTypeID").Value)
            vRec.MetricTypeName = moUtil.FetchString(.Fields.Item("MetricTypeName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Pts = moUtil.FetchLong(.Fields.Item("Pts").Value)
            vRec.IsResult = moUtil.FetchInteger(.Fields.Item("IsResult").Value)
            vRec.IsLeader = moUtil.FetchInteger(.Fields.Item("IsLeader").Value)
            vRec.IsQty = moUtil.FetchInteger(.Fields.Item("IsQty").Value)
            vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Required = moUtil.FetchString(.Fields.Item("Required").Value)
            vRec.AutoEvent = moUtil.FetchLong(.Fields.Item("AutoEvent").Value)
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

Public Function ListGroup( _ 
   ByVal bvGroupID As Long) As tMetricTypeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMetricTypeType
   Dim vRec As tMetricTypeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_ListGroup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MetricTypeID = moUtil.FetchLong(.Fields.Item("MetricTypeID").Value)
            vRec.MetricTypeName = moUtil.FetchString(.Fields.Item("MetricTypeName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Pts = moUtil.FetchLong(.Fields.Item("Pts").Value)
            vRec.IsResult = moUtil.FetchInteger(.Fields.Item("IsResult").Value)
            vRec.IsLeader = moUtil.FetchInteger(.Fields.Item("IsLeader").Value)
            vRec.IsQty = moUtil.FetchInteger(.Fields.Item("IsQty").Value)
            vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Required = moUtil.FetchString(.Fields.Item("Required").Value)
            vRec.AutoEvent = moUtil.FetchLong(.Fields.Item("AutoEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListGroup = vRecs

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
   ByRef brRec As tMetricTypeType, _ 
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
      .Parameters.Append .CreateParameter("@MetricTypeID", adInteger, adParamInput, vbNull, CLng(brRec.MetricTypeID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(brRec.GroupID))
      .Parameters.Append .CreateParameter("@MetricTypeName", adVarWChar, adParamInput, 40, brRec.MetricTypeName)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Pts", adInteger, adParamInput, vbNull, CLng(brRec.Pts))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@IsResult", adSmallInt, adParamInput, vbNull, CInt(brRec.IsResult))
      .Parameters.Append .CreateParameter("@IsLeader", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLeader))
      .Parameters.Append .CreateParameter("@IsQty", adSmallInt, adParamInput, vbNull, CInt(brRec.IsQty))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 200, brRec.Description)
      .Parameters.Append .CreateParameter("@Required", adVarWChar, adParamInput, 200, brRec.Required)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 1000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@AutoEvent", adInteger, adParamInput, vbNull, CLng(brRec.AutoEvent))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MetricType_Update"

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
   ByRef brRec As tMetricTypeType, _ 
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
         .MetricTypeID = moUtil.EditLong(.MetricTypeID, "MetricTypeID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True) 
      .GroupID = moUtil.EditLong(.GroupID, "GroupID", False) 
      .MetricTypeName = moUtil.EditString(.MetricTypeName, "MetricTypeName", True, , 1, 40) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False, , 1) 
      .Pts = moUtil.EditLong(.Pts, "Pts", False) 
      .IsActive = moUtil.EditInteger(.IsActive, "IsActive", False, 0, 0, 1) 
      .IsResult = moUtil.EditInteger(.IsResult, "IsResult", False, 0, 0, 1) 
      .IsLeader = moUtil.EditInteger(.IsLeader, "IsLeader", False, 0, 0, 1) 
      .IsQty = moUtil.EditInteger(.IsQty, "IsQty", False, 0, 0, 1) 
      .Description = moUtil.EditString(.Description, "Description", False) 
      .Required = moUtil.EditString(.Required, "Required", False) 
      .InputOptions = moUtil.EditString(.InputOptions, "InputOptions", False, , 1, 1000) 
      .AutoEvent = moUtil.EditLong(.AutoEvent, "AutoEvent", False) 
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