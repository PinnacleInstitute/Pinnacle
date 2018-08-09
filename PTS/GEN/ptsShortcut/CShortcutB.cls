VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CShortcutB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CShortcut"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tShortcutType
   ShortcutID As String
   AuthUserID As String
   EntityID As String
   ItemID As String
   ShortcutName As String
   URL As String
   IsPinned As String
   IsPopup As String
End Type

Public Sub Add( _ 
   ByRef brRec As tShortcutType, _ 
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
      .Parameters.Append .CreateParameter("@ShortcutID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@EntityID", adInteger, adParamInput, vbNull, CLng(brRec.EntityID))
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamInput, vbNull, CLng(brRec.ItemID))
      .Parameters.Append .CreateParameter("@ShortcutName", adVarWChar, adParamInput, 80, brRec.ShortcutName)
      .Parameters.Append .CreateParameter("@URL", adVarWChar, adParamInput, 100, brRec.URL)
      .Parameters.Append .CreateParameter("@IsPinned", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPinned))
      .Parameters.Append .CreateParameter("@IsPopup", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPopup))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Shortcut_Add"

   '-----get return values
   With brRec
      .ShortcutID = moUtil.FetchLong(oCmd.Parameters.Item("@ShortcutID").Value)
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
   ByRef brRec As tShortcutType, _ 
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
      .ShortcutID = moUtil.EditLong(.ShortcutID, "ShortcutID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ShortcutID", adInteger, adParamInput, vbNull, CLng(brRec.ShortcutID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Shortcut_Delete"

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
   ByRef brRec As tShortcutType, _ 
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
      .ShortcutID = moUtil.EditLong(.ShortcutID, "ShortcutID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ShortcutID", adInteger, adParamInput, vbNull, CLng(brRec.ShortcutID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EntityID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ShortcutName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@URL", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@IsPinned", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPopup", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Shortcut_Fetch"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .EntityID = moUtil.FetchLong(oCmd.Parameters.Item("@EntityID").Value)
      .ItemID = moUtil.FetchLong(oCmd.Parameters.Item("@ItemID").Value)
      .ShortcutName = moUtil.FetchString(oCmd.Parameters.Item("@ShortcutName").Value)
      .URL = moUtil.FetchString(oCmd.Parameters.Item("@URL").Value)
      .IsPinned = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPinned").Value)
      .IsPopup = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPopup").Value)
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
   ByVal bvAuthUserID As Long, _ 
   ByVal bvUserID As Long) As tShortcutType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tShortcutType
   Dim vRec As tShortcutType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(bvAuthUserID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Shortcut_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ShortcutID = moUtil.FetchLong(.Fields.Item("ShortcutID").Value)
            vRec.EntityID = moUtil.FetchLong(.Fields.Item("EntityID").Value)
            vRec.ShortcutName = moUtil.FetchString(.Fields.Item("ShortcutName").Value)
            vRec.URL = moUtil.FetchString(.Fields.Item("URL").Value)
            vRec.IsPinned = moUtil.FetchInteger(.Fields.Item("IsPinned").Value)
            vRec.IsPopup = moUtil.FetchInteger(.Fields.Item("IsPopup").Value)
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

Public Function ListPinned( _ 
   ByVal bvAuthUserID As Long, _ 
   ByVal bvUserID As Long) As tShortcutType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPinned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tShortcutType
   Dim vRec As tShortcutType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(bvAuthUserID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Shortcut_ListPinned")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ShortcutID = moUtil.FetchLong(.Fields.Item("ShortcutID").Value)
            vRec.EntityID = moUtil.FetchLong(.Fields.Item("EntityID").Value)
            vRec.ShortcutName = moUtil.FetchString(.Fields.Item("ShortcutName").Value)
            vRec.URL = moUtil.FetchString(.Fields.Item("URL").Value)
            vRec.IsPinned = moUtil.FetchInteger(.Fields.Item("IsPinned").Value)
            vRec.IsPopup = moUtil.FetchInteger(.Fields.Item("IsPopup").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPinned = vRecs

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
   ByRef brRec As tShortcutType, _ 
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
      .Parameters.Append .CreateParameter("@ShortcutID", adInteger, adParamInput, vbNull, CLng(brRec.ShortcutID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@EntityID", adInteger, adParamInput, vbNull, CLng(brRec.EntityID))
      .Parameters.Append .CreateParameter("@ItemID", adInteger, adParamInput, vbNull, CLng(brRec.ItemID))
      .Parameters.Append .CreateParameter("@ShortcutName", adVarWChar, adParamInput, 80, brRec.ShortcutName)
      .Parameters.Append .CreateParameter("@URL", adVarWChar, adParamInput, 100, brRec.URL)
      .Parameters.Append .CreateParameter("@IsPinned", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPinned))
      .Parameters.Append .CreateParameter("@IsPopup", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPopup))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Shortcut_Update"

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
   ByRef brRec As tShortcutType, _ 
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
         .ShortcutID = moUtil.EditLong(.ShortcutID, "ShortcutID", True, , 1) 
      End If
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .EntityID = moUtil.EditLong(.EntityID, "EntityID", False) 
      .ItemID = moUtil.EditLong(.ItemID, "ItemID", False) 
      .ShortcutName = moUtil.EditString(.ShortcutName, "ShortcutName", True, , 1, 80) 
      .URL = moUtil.EditString(.URL, "URL", True, , 1, 100) 
      .IsPinned = moUtil.EditInteger(.IsPinned, "IsPinned", False, 0, 0, 1) 
      .IsPopup = moUtil.EditInteger(.IsPopup, "IsPopup", False, 0, 0, 1) 
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