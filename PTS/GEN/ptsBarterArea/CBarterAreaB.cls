VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CBarterAreaB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CBarterArea"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tBarterAreaType
   BarterAreaID As String
   ParentID As String
   CountryID As String
   ConsumerID As String
   CountryName As String
   BarterAreaName As String
   BarterAreaType As String
   Status As String
   Children As String
End Type

Public Sub Add( _ 
   ByRef brRec As tBarterAreaType, _ 
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
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@BarterAreaName", adVarWChar, adParamInput, 40, brRec.BarterAreaName)
      .Parameters.Append .CreateParameter("@BarterAreaType", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Children", adInteger, adParamInput, vbNull, CLng(brRec.Children))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_Add"

   '-----get return values
   With brRec
      .BarterAreaID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterAreaID").Value)
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

Public Function UpdateChildren( _ 
   ByRef brRec As tBarterAreaType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateChildren"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_UpdateChildren"

   '-----get return values
   UpdateChildren = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Custom( _ 
   ByRef brRec As tBarterAreaType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Custom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_Custom"

   '-----get return values
   Custom = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tBarterAreaType, _ 
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
      .BarterAreaID = moUtil.EditLong(.BarterAreaID, "BarterAreaID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_Delete"

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
   ByRef brRec As tBarterAreaType, _ 
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
      .BarterAreaID = moUtil.EditLong(.BarterAreaID, "BarterAreaID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@BarterAreaName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@BarterAreaType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Children", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_Fetch"

   '-----get return values
   With brRec
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .BarterAreaName = moUtil.FetchString(oCmd.Parameters.Item("@BarterAreaName").Value)
      .BarterAreaType = moUtil.FetchLong(oCmd.Parameters.Item("@BarterAreaType").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Children = moUtil.FetchLong(oCmd.Parameters.Item("@Children").Value)
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
   ByVal bvParentID As Long, _ 
   ByVal bvCountryID As Long) As tBarterAreaType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterAreaType
   Dim vRec As tBarterAreaType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(bvCountryID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BarterAreaID = moUtil.FetchLong(.Fields.Item("BarterAreaID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
            vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
            vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
            vRec.BarterAreaName = moUtil.FetchString(.Fields.Item("BarterAreaName").Value)
            vRec.BarterAreaType = moUtil.FetchLong(.Fields.Item("BarterAreaType").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
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

Public Function ListActive( _ 
   ByVal bvParentID As Long, _ 
   ByVal bvCountryID As Long) As tBarterAreaType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterAreaType
   Dim vRec As tBarterAreaType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(bvCountryID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_ListActive")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BarterAreaID = moUtil.FetchLong(.Fields.Item("BarterAreaID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
            vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
            vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
            vRec.BarterAreaName = moUtil.FetchString(.Fields.Item("BarterAreaName").Value)
            vRec.BarterAreaType = moUtil.FetchLong(.Fields.Item("BarterAreaType").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Children = moUtil.FetchLong(.Fields.Item("Children").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListActive = vRecs

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
   ByRef brRec As tBarterAreaType, _ 
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
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@BarterAreaName", adVarWChar, adParamInput, 40, brRec.BarterAreaName)
      .Parameters.Append .CreateParameter("@BarterAreaType", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Children", adInteger, adParamInput, vbNull, CLng(brRec.Children))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterArea_Update"

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
   ByRef brRec As tBarterAreaType, _ 
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
         .BarterAreaID = moUtil.EditLong(.BarterAreaID, "BarterAreaID", True, , 1) 
      End If
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", False) 
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", False) 
      .BarterAreaName = moUtil.EditString(.BarterAreaName, "BarterAreaName", False) 
      .BarterAreaType = moUtil.EditLong(.BarterAreaType, "BarterAreaType", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Children = moUtil.EditLong(.Children, "Children", False) 
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