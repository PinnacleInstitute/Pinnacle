VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CSalesAreaB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSalesArea"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tSalesAreaType
   SalesAreaID As String
   ParentID As String
   MemberID As String
   NameLast As String
   NameFirst As String
   MemberName As String
   SalesAreaName As String
   Status As String
   StatusDate As String
   Level As String
   Density As String
   Population As String
   FTE As String
End Type

Public Sub Add( _ 
   ByRef brRec As tSalesAreaType, _ 
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
      .Parameters.Append .CreateParameter("@SalesAreaID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SalesAreaName", adVarWChar, adParamInput, 40, brRec.SalesAreaName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@StatusDate", adDate, adParamInput, vbNull, CDate(brRec.StatusDate))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(brRec.Level))
      .Parameters.Append .CreateParameter("@Density", adInteger, adParamInput, vbNull, CLng(brRec.Density))
      .Parameters.Append .CreateParameter("@Population", adInteger, adParamInput, vbNull, CLng(brRec.Population))
      .Parameters.Append .CreateParameter("@FTE", adCurrency, adParamInput, vbNull, CCur(brRec.FTE))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesArea_Add"

   '-----get return values
   With brRec
      .SalesAreaID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesAreaID").Value)
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
   ByRef brRec As tSalesAreaType, _ 
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
      .SalesAreaID = moUtil.EditLong(.SalesAreaID, "SalesAreaID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesAreaID", adInteger, adParamInput, vbNull, CLng(brRec.SalesAreaID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesArea_Delete"

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
   ByRef brRec As tSalesAreaType, _ 
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
      .SalesAreaID = moUtil.EditLong(.SalesAreaID, "SalesAreaID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesAreaID", adInteger, adParamInput, vbNull, CLng(brRec.SalesAreaID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 61, vbNull)
      .Parameters.Append .CreateParameter("@SalesAreaName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StatusDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Density", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Population", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FTE", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesArea_Fetch"

   '-----get return values
   With brRec
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .SalesAreaName = moUtil.FetchString(oCmd.Parameters.Item("@SalesAreaName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .StatusDate = moUtil.FetchDate(oCmd.Parameters.Item("@StatusDate").Value)
      .Level = moUtil.FetchLong(oCmd.Parameters.Item("@Level").Value)
      .Density = moUtil.FetchLong(oCmd.Parameters.Item("@Density").Value)
      .Population = moUtil.FetchLong(oCmd.Parameters.Item("@Population").Value)
      .FTE = moUtil.FetchCurrency(oCmd.Parameters.Item("@FTE").Value)
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
   ByVal bvParentID As Long) As tSalesAreaType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesAreaType
   Dim vRec As tSalesAreaType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesArea_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesAreaID = moUtil.FetchLong(.Fields.Item("SalesAreaID").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.SalesAreaName = moUtil.FetchString(.Fields.Item("SalesAreaName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.StatusDate = moUtil.FetchDate(.Fields.Item("StatusDate").Value)
            vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
            vRec.Density = moUtil.FetchLong(.Fields.Item("Density").Value)
            vRec.Population = moUtil.FetchLong(.Fields.Item("Population").Value)
            vRec.FTE = moUtil.FetchCurrency(.Fields.Item("FTE").Value)
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
   ByRef brRec As tSalesAreaType, _ 
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
      .Parameters.Append .CreateParameter("@SalesAreaID", adInteger, adParamInput, vbNull, CLng(brRec.SalesAreaID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SalesAreaName", adVarWChar, adParamInput, 40, brRec.SalesAreaName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@StatusDate", adDate, adParamInput, vbNull, CDate(brRec.StatusDate))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(brRec.Level))
      .Parameters.Append .CreateParameter("@Density", adInteger, adParamInput, vbNull, CLng(brRec.Density))
      .Parameters.Append .CreateParameter("@Population", adInteger, adParamInput, vbNull, CLng(brRec.Population))
      .Parameters.Append .CreateParameter("@FTE", adCurrency, adParamInput, vbNull, CCur(brRec.FTE))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesArea_Update"

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
   ByRef brRec As tSalesAreaType, _ 
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
         .SalesAreaID = moUtil.EditLong(.SalesAreaID, "SalesAreaID", True, , 1) 
      End If
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .SalesAreaName = moUtil.EditString(.SalesAreaName, "SalesAreaName", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .StatusDate = moUtil.EditDate(.StatusDate, "StatusDate", False) 
      .Level = moUtil.EditLong(.Level, "Level", False) 
      .Density = moUtil.EditLong(.Density, "Density", False) 
      .Population = moUtil.EditLong(.Population, "Population", False) 
      .FTE = moUtil.EditCurrency(.FTE, "FTE", False) 
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