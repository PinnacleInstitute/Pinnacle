VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CFolderItemB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CFolderItem"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tFolderItemType
   FolderItemID As String
   FolderID As String
   MemberID As String
   FolderName As String
   MemberName As String
   Entity As String
   ItemID As String
   ItemDate As String
   Status As String
   ItemName As String
   IsShare As String
   CompanyID As String
   DripCampaignID As String
   Days As String
   Target As String
   Data As String
End Type

Public Sub Add( _ 
   ByRef brRec As tFolderItemType, _ 
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
      .Parameters.Append .CreateParameter("@FolderItemID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(brRec.Entity))
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamInput, vbNull, CLng(brRec.ItemID))
      .Parameters.Append .CreateParameter("@ItemDate", adDate, adParamInput, vbNull, CDate(brRec.ItemDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_Add"

   '-----get return values
   With brRec
      .FolderItemID = moUtil.FetchLong(oCmd.Parameters.Item("@FolderItemID").Value)
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
   ByRef brRec As tFolderItemType, _ 
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
      .FolderItemID = moUtil.EditLong(.FolderItemID, "FolderItemID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FolderItemID", adInteger, adParamInput, vbNull, CLng(brRec.FolderItemID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_Delete"

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
   ByRef brRec As tFolderItemType, _ 
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
      .FolderItemID = moUtil.EditLong(.FolderItemID, "FolderItemID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FolderItemID", adInteger, adParamInput, vbNull, CLng(brRec.FolderItemID))
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FolderName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ItemDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_Fetch"

   '-----get return values
   With brRec
      .FolderID = moUtil.FetchLong(oCmd.Parameters.Item("@FolderID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .FolderName = moUtil.FetchString(oCmd.Parameters.Item("@FolderName").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .Entity = moUtil.FetchLong(oCmd.Parameters.Item("@Entity").Value)
      .ItemID = moUtil.FetchLong(oCmd.Parameters.Item("@ItemID").Value)
      .ItemDate = moUtil.FetchDate(oCmd.Parameters.Item("@ItemDate").Value)
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

Public Sub FetchItemID( _ 
   ByRef brRec As tFolderItemType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchItemID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .FolderID = moUtil.EditLong(.FolderID, "FolderID", False, 0) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, 0) 
      .Entity = moUtil.EditLong(.Entity, "Entity", False, 0) 
      .ItemID = moUtil.EditLong(.ItemID, "ItemID", False, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(brRec.Entity))
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamInput, vbNull, CLng(brRec.ItemID))
      .Parameters.Append .CreateParameter("@FolderItemID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_FetchItemID"

   '-----get return values
   With brRec
      .FolderItemID = moUtil.FetchLong(oCmd.Parameters.Item("@FolderItemID").Value)
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
   ByVal bvFolderID As Long, _ 
   ByVal bvMemberID As Long) As tFolderItemType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFolder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderItemType
   Dim vRec As tFolderItemType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(bvFolderID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_ListFolder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderItemID = moUtil.FetchLong(.Fields.Item("FolderItemID").Value)
            vRec.Entity = moUtil.FetchLong(.Fields.Item("Entity").Value)
            vRec.ItemID = moUtil.FetchLong(.Fields.Item("ItemID").Value)
            vRec.ItemName = moUtil.FetchString(.Fields.Item("ItemName").Value)
            vRec.ItemDate = moUtil.FetchDate(.Fields.Item("ItemDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
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

Public Function ListItem( _ 
   ByVal bvItemID As Long, _ 
   ByVal bvEntity As Long) As tFolderItemType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListItem"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderItemType
   Dim vRec As tFolderItemType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamInput, vbNull, CLng(bvItemID))
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(bvEntity))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_ListItem")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderItemID = moUtil.FetchLong(.Fields.Item("FolderItemID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.FolderID = moUtil.FetchLong(.Fields.Item("FolderID").Value)
            vRec.ItemName = moUtil.FetchString(.Fields.Item("ItemName").Value)
            vRec.ItemDate = moUtil.FetchDate(.Fields.Item("ItemDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.IsShare = moUtil.FetchInteger(.Fields.Item("IsShare").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListItem = vRecs

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

Public Function ListDrip( _ 
   ByVal bvDripCampaignID As Long, _ 
   ByVal bvTarget As Long, _ 
   ByVal bvDays As Long) As tFolderItemType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListDrip"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderItemType
   Dim vRec As tFolderItemType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@DripCampaignID", adInteger, adParamInput, vbNull, CLng(bvDripCampaignID))
      .Parameters.Append .CreateParameter("@Target", adInteger, adParamInput, vbNull, CLng(bvTarget))
      .Parameters.Append .CreateParameter("@Days", adInteger, adParamInput, vbNull, CLng(bvDays))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_ListDrip")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderItemID = moUtil.FetchLong(.Fields.Item("FolderItemID").Value)
            vRec.ItemID = moUtil.FetchLong(.Fields.Item("ItemID").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListDrip = vRecs

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

Public Function ListVirtualDrip( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTarget As Long, _ 
   ByVal bvDays As Long) As tFolderItemType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListVirtualDrip"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tFolderItemType
   Dim vRec As tFolderItemType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Target", adInteger, adParamInput, vbNull, CLng(bvTarget))
      .Parameters.Append .CreateParameter("@Days", adInteger, adParamInput, vbNull, CLng(bvDays))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_ListVirtualDrip")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.FolderItemID = moUtil.FetchLong(.Fields.Item("FolderItemID").Value)
            vRec.ItemID = moUtil.FetchLong(.Fields.Item("ItemID").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListVirtualDrip = vRecs

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
   ByRef brRec As tFolderItemType, _ 
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
      .Parameters.Append .CreateParameter("@FolderItemID", adInteger, adParamInput, vbNull, CLng(brRec.FolderItemID))
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(brRec.FolderID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Entity", adInteger, adParamInput, vbNull, CLng(brRec.Entity))
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamInput, vbNull, CLng(brRec.ItemID))
      .Parameters.Append .CreateParameter("@ItemDate", adDate, adParamInput, vbNull, CDate(brRec.ItemDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_FolderItem_Update"

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
   ByRef brRec As tFolderItemType, _ 
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
         .FolderItemID = moUtil.EditLong(.FolderItemID, "FolderItemID", True, , 1) 
      End If
      .FolderID = moUtil.EditLong(.FolderID, "FolderID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .Entity = moUtil.EditLong(.Entity, "Entity", False) 
      .ItemID = moUtil.EditLong(.ItemID, "ItemID", False) 
      .ItemDate = moUtil.EditDate(.ItemDate, "ItemDate", False) 
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