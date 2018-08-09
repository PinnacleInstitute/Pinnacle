VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CInventoryB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CInventory"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tInventoryType
   InventoryID As String
   MemberID As String
   ProductID As String
   ProductName As String
   ProductAttribute1 As String
   ProductAttribute2 As String
   ProductAttribute3 As String
   Attribute1 As String
   Attribute2 As String
   Attribute3 As String
   InStock As String
   ReOrder As String
End Type

Public Sub Add( _ 
   ByRef brRec As tInventoryType, _ 
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
      .Parameters.Append .CreateParameter("@InventoryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@Attribute1", adVarWChar, adParamInput, 15, brRec.Attribute1)
      .Parameters.Append .CreateParameter("@Attribute2", adVarWChar, adParamInput, 15, brRec.Attribute2)
      .Parameters.Append .CreateParameter("@Attribute3", adVarWChar, adParamInput, 15, brRec.Attribute3)
      .Parameters.Append .CreateParameter("@InStock", adInteger, adParamInput, vbNull, CLng(brRec.InStock))
      .Parameters.Append .CreateParameter("@ReOrder", adInteger, adParamInput, vbNull, CLng(brRec.ReOrder))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Inventory_Add"

   '-----get return values
   With brRec
      .InventoryID = moUtil.FetchLong(oCmd.Parameters.Item("@InventoryID").Value)
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
   ByRef brRec As tInventoryType, _ 
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
      .InventoryID = moUtil.EditLong(.InventoryID, "InventoryID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@InventoryID", adInteger, adParamInput, vbNull, CLng(brRec.InventoryID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Inventory_Delete"

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
   ByRef brRec As tInventoryType, _ 
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
      .InventoryID = moUtil.EditLong(.InventoryID, "InventoryID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@InventoryID", adInteger, adParamInput, vbNull, CLng(brRec.InventoryID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@ProductAttribute1", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@ProductAttribute2", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@ProductAttribute3", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Attribute1", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Attribute2", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Attribute3", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@InStock", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ReOrder", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Inventory_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .ProductID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductID").Value)
      .ProductName = moUtil.FetchString(oCmd.Parameters.Item("@ProductName").Value)
      .ProductAttribute1 = moUtil.FetchString(oCmd.Parameters.Item("@ProductAttribute1").Value)
      .ProductAttribute2 = moUtil.FetchString(oCmd.Parameters.Item("@ProductAttribute2").Value)
      .ProductAttribute3 = moUtil.FetchString(oCmd.Parameters.Item("@ProductAttribute3").Value)
      .Attribute1 = moUtil.FetchString(oCmd.Parameters.Item("@Attribute1").Value)
      .Attribute2 = moUtil.FetchString(oCmd.Parameters.Item("@Attribute2").Value)
      .Attribute3 = moUtil.FetchString(oCmd.Parameters.Item("@Attribute3").Value)
      .InStock = moUtil.FetchLong(oCmd.Parameters.Item("@InStock").Value)
      .ReOrder = moUtil.FetchLong(oCmd.Parameters.Item("@ReOrder").Value)
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

Public Function ListInventory( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvProductID As Long) As tInventoryType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListInventory"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tInventoryType
   Dim vRec As tInventoryType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(bvProductID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Inventory_ListInventory")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.InventoryID = moUtil.FetchLong(.Fields.Item("InventoryID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Attribute1 = moUtil.FetchString(.Fields.Item("Attribute1").Value)
            vRec.Attribute2 = moUtil.FetchString(.Fields.Item("Attribute2").Value)
            vRec.Attribute3 = moUtil.FetchString(.Fields.Item("Attribute3").Value)
            vRec.InStock = moUtil.FetchLong(.Fields.Item("InStock").Value)
            vRec.ReOrder = moUtil.FetchLong(.Fields.Item("ReOrder").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListInventory = vRecs

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
   ByRef brRec As tInventoryType, _ 
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
      .Parameters.Append .CreateParameter("@InventoryID", adInteger, adParamInput, vbNull, CLng(brRec.InventoryID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@Attribute1", adVarWChar, adParamInput, 15, brRec.Attribute1)
      .Parameters.Append .CreateParameter("@Attribute2", adVarWChar, adParamInput, 15, brRec.Attribute2)
      .Parameters.Append .CreateParameter("@Attribute3", adVarWChar, adParamInput, 15, brRec.Attribute3)
      .Parameters.Append .CreateParameter("@InStock", adInteger, adParamInput, vbNull, CLng(brRec.InStock))
      .Parameters.Append .CreateParameter("@ReOrder", adInteger, adParamInput, vbNull, CLng(brRec.ReOrder))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Inventory_Update"

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
   ByRef brRec As tInventoryType, _ 
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
         .InventoryID = moUtil.EditLong(.InventoryID, "InventoryID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .ProductID = moUtil.EditLong(.ProductID, "ProductID", False) 
      .Attribute1 = moUtil.EditString(.Attribute1, "Attribute1", False, , 1, 15) 
      .Attribute2 = moUtil.EditString(.Attribute2, "Attribute2", False, , 1, 15) 
      .Attribute3 = moUtil.EditString(.Attribute3, "Attribute3", False, , 1, 15) 
      .InStock = moUtil.EditLong(.InStock, "InStock", False) 
      .ReOrder = moUtil.EditLong(.ReOrder, "ReOrder", False) 
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