VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMemberTaxB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMemberTax"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMemberTaxType
   MemberTaxID As String
   MemberID As String
   Year As String
   VehicleMethod As String
   MilesStart As String
   MilesEnd As String
   TotalMiles As String
   BusMiles As String
   VehicleRate As String
   TotalSpace As String
   BusSpace As String
   SpaceRate As String
   Notes As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMemberTaxType, _ 
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
      .Parameters.Append .CreateParameter("@MemberTaxID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Year", adInteger, adParamInput, vbNull, CLng(brRec.Year))
      .Parameters.Append .CreateParameter("@VehicleMethod", adInteger, adParamInput, vbNull, CLng(brRec.VehicleMethod))
      .Parameters.Append .CreateParameter("@MilesStart", adInteger, adParamInput, vbNull, CLng(brRec.MilesStart))
      .Parameters.Append .CreateParameter("@MilesEnd", adInteger, adParamInput, vbNull, CLng(brRec.MilesEnd))
      .Parameters.Append .CreateParameter("@TotalMiles", adInteger, adParamInput, vbNull, CLng(brRec.TotalMiles))
      .Parameters.Append .CreateParameter("@BusMiles", adInteger, adParamInput, vbNull, CLng(brRec.BusMiles))
      .Parameters.Append .CreateParameter("@VehicleRate", adInteger, adParamInput, vbNull, CLng(brRec.VehicleRate))
      .Parameters.Append .CreateParameter("@TotalSpace", adInteger, adParamInput, vbNull, CLng(brRec.TotalSpace))
      .Parameters.Append .CreateParameter("@BusSpace", adInteger, adParamInput, vbNull, CLng(brRec.BusSpace))
      .Parameters.Append .CreateParameter("@SpaceRate", adInteger, adParamInput, vbNull, CLng(brRec.SpaceRate))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 2000, brRec.Notes)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberTax_Add"

   '-----get return values
   With brRec
      .MemberTaxID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberTaxID").Value)
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

Public Function Recalc( _ 
   ByRef brRec As tMemberTaxType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Recalc"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Year", adInteger, adParamInput, vbNull, CLng(brRec.Year))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberTax_Recalc"

   '-----get return values
   Recalc = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tMemberTaxType, _ 
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
      .MemberTaxID = moUtil.EditLong(.MemberTaxID, "MemberTaxID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberTaxID", adInteger, adParamInput, vbNull, CLng(brRec.MemberTaxID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberTax_Delete"

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
   ByRef brRec As tMemberTaxType, _ 
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
      .MemberTaxID = moUtil.EditLong(.MemberTaxID, "MemberTaxID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberTaxID", adInteger, adParamInput, vbNull, CLng(brRec.MemberTaxID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Year", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VehicleMethod", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MilesStart", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MilesEnd", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TotalMiles", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusMiles", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VehicleRate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TotalSpace", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusSpace", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SpaceRate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberTax_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .Year = moUtil.FetchLong(oCmd.Parameters.Item("@Year").Value)
      .VehicleMethod = moUtil.FetchLong(oCmd.Parameters.Item("@VehicleMethod").Value)
      .MilesStart = moUtil.FetchLong(oCmd.Parameters.Item("@MilesStart").Value)
      .MilesEnd = moUtil.FetchLong(oCmd.Parameters.Item("@MilesEnd").Value)
      .TotalMiles = moUtil.FetchLong(oCmd.Parameters.Item("@TotalMiles").Value)
      .BusMiles = moUtil.FetchLong(oCmd.Parameters.Item("@BusMiles").Value)
      .VehicleRate = moUtil.FetchLong(oCmd.Parameters.Item("@VehicleRate").Value)
      .TotalSpace = moUtil.FetchLong(oCmd.Parameters.Item("@TotalSpace").Value)
      .BusSpace = moUtil.FetchLong(oCmd.Parameters.Item("@BusSpace").Value)
      .SpaceRate = moUtil.FetchLong(oCmd.Parameters.Item("@SpaceRate").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
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
   ByVal bvMemberID As Long) As tMemberTaxType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberTaxType
   Dim vRec As tMemberTaxType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberTax_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberTaxID = moUtil.FetchLong(.Fields.Item("MemberTaxID").Value)
            vRec.Year = moUtil.FetchLong(.Fields.Item("Year").Value)
            vRec.VehicleMethod = moUtil.FetchLong(.Fields.Item("VehicleMethod").Value)
            vRec.MilesStart = moUtil.FetchLong(.Fields.Item("MilesStart").Value)
            vRec.MilesEnd = moUtil.FetchLong(.Fields.Item("MilesEnd").Value)
            vRec.TotalMiles = moUtil.FetchLong(.Fields.Item("TotalMiles").Value)
            vRec.BusMiles = moUtil.FetchLong(.Fields.Item("BusMiles").Value)
            vRec.VehicleRate = moUtil.FetchLong(.Fields.Item("VehicleRate").Value)
            vRec.TotalSpace = moUtil.FetchLong(.Fields.Item("TotalSpace").Value)
            vRec.BusSpace = moUtil.FetchLong(.Fields.Item("BusSpace").Value)
            vRec.SpaceRate = moUtil.FetchLong(.Fields.Item("SpaceRate").Value)
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
   ByRef brRec As tMemberTaxType, _ 
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
      .Parameters.Append .CreateParameter("@MemberTaxID", adInteger, adParamInput, vbNull, CLng(brRec.MemberTaxID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Year", adInteger, adParamInput, vbNull, CLng(brRec.Year))
      .Parameters.Append .CreateParameter("@VehicleMethod", adInteger, adParamInput, vbNull, CLng(brRec.VehicleMethod))
      .Parameters.Append .CreateParameter("@MilesStart", adInteger, adParamInput, vbNull, CLng(brRec.MilesStart))
      .Parameters.Append .CreateParameter("@MilesEnd", adInteger, adParamInput, vbNull, CLng(brRec.MilesEnd))
      .Parameters.Append .CreateParameter("@TotalMiles", adInteger, adParamInput, vbNull, CLng(brRec.TotalMiles))
      .Parameters.Append .CreateParameter("@BusMiles", adInteger, adParamInput, vbNull, CLng(brRec.BusMiles))
      .Parameters.Append .CreateParameter("@VehicleRate", adInteger, adParamInput, vbNull, CLng(brRec.VehicleRate))
      .Parameters.Append .CreateParameter("@TotalSpace", adInteger, adParamInput, vbNull, CLng(brRec.TotalSpace))
      .Parameters.Append .CreateParameter("@BusSpace", adInteger, adParamInput, vbNull, CLng(brRec.BusSpace))
      .Parameters.Append .CreateParameter("@SpaceRate", adInteger, adParamInput, vbNull, CLng(brRec.SpaceRate))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 2000, brRec.Notes)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberTax_Update"

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
   ByRef brRec As tMemberTaxType, _ 
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
         .MemberTaxID = moUtil.EditLong(.MemberTaxID, "MemberTaxID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True) 
      .Year = moUtil.EditLong(.Year, "Year", False) 
      .VehicleMethod = moUtil.EditLong(.VehicleMethod, "VehicleMethod", False) 
      .MilesStart = moUtil.EditLong(.MilesStart, "MilesStart", False) 
      .MilesEnd = moUtil.EditLong(.MilesEnd, "MilesEnd", False) 
      .TotalMiles = moUtil.EditLong(.TotalMiles, "TotalMiles", False) 
      .BusMiles = moUtil.EditLong(.BusMiles, "BusMiles", False) 
      .VehicleRate = moUtil.EditLong(.VehicleRate, "VehicleRate", False) 
      .TotalSpace = moUtil.EditLong(.TotalSpace, "TotalSpace", False) 
      .BusSpace = moUtil.EditLong(.BusSpace, "BusSpace", False) 
      .SpaceRate = moUtil.EditLong(.SpaceRate, "SpaceRate", False) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 2000) 
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