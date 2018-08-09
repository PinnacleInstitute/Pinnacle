VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMoptionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMoption"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMoptionType
   MoptionID As String
   MemberID As String
   IsActivity As String
   ActivityTracks As String
   TrackTheme As String
   MenuColors As String
   Portal As String
   Options0 As String
   Options1 As String
   Options2 As String
   Options3 As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMoptionType, _ 
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
      .Parameters.Append .CreateParameter("@MoptionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@IsActivity", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActivity))
      .Parameters.Append .CreateParameter("@ActivityTracks", adVarWChar, adParamInput, 20, brRec.ActivityTracks)
      .Parameters.Append .CreateParameter("@TrackTheme", adInteger, adParamInput, vbNull, CLng(brRec.TrackTheme))
      .Parameters.Append .CreateParameter("@MenuColors", adVarWChar, adParamInput, 200, brRec.MenuColors)
      .Parameters.Append .CreateParameter("@Portal", adVarWChar, adParamInput, 100, brRec.Portal)
      .Parameters.Append .CreateParameter("@Options0", adVarWChar, adParamInput, 50, brRec.Options0)
      .Parameters.Append .CreateParameter("@Options1", adVarWChar, adParamInput, 50, brRec.Options1)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamInput, 50, brRec.Options2)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamInput, 50, brRec.Options3)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Moption_Add"

   '-----get return values
   With brRec
      .MoptionID = moUtil.FetchLong(oCmd.Parameters.Item("@MoptionID").Value)
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
   ByRef brRec As tMoptionType, _ 
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
      .MoptionID = moUtil.EditLong(.MoptionID, "MoptionID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MoptionID", adInteger, adParamInput, vbNull, CLng(brRec.MoptionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Moption_Delete"

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
   ByRef brRec As tMoptionType, _ 
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
      .MoptionID = moUtil.EditLong(.MoptionID, "MoptionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MoptionID", adInteger, adParamInput, vbNull, CLng(brRec.MoptionID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsActivity", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ActivityTracks", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@TrackTheme", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MenuColors", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Portal", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Options0", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options1", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Moption_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .IsActivity = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActivity").Value)
      .ActivityTracks = moUtil.FetchString(oCmd.Parameters.Item("@ActivityTracks").Value)
      .TrackTheme = moUtil.FetchLong(oCmd.Parameters.Item("@TrackTheme").Value)
      .MenuColors = moUtil.FetchString(oCmd.Parameters.Item("@MenuColors").Value)
      .Portal = moUtil.FetchString(oCmd.Parameters.Item("@Portal").Value)
      .Options0 = moUtil.FetchString(oCmd.Parameters.Item("@Options0").Value)
      .Options1 = moUtil.FetchString(oCmd.Parameters.Item("@Options1").Value)
      .Options2 = moUtil.FetchString(oCmd.Parameters.Item("@Options2").Value)
      .Options3 = moUtil.FetchString(oCmd.Parameters.Item("@Options3").Value)
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

Public Sub FetchMember( _ 
   ByRef brRec As tMoptionType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@MoptionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ActivityTracks", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@TrackTheme", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MenuColors", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Portal", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Options0", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options1", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamOutput, 50, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Moption_FetchMember"

   '-----get return values
   With brRec
      .MoptionID = moUtil.FetchLong(oCmd.Parameters.Item("@MoptionID").Value)
      .ActivityTracks = moUtil.FetchString(oCmd.Parameters.Item("@ActivityTracks").Value)
      .TrackTheme = moUtil.FetchLong(oCmd.Parameters.Item("@TrackTheme").Value)
      .MenuColors = moUtil.FetchString(oCmd.Parameters.Item("@MenuColors").Value)
      .Portal = moUtil.FetchString(oCmd.Parameters.Item("@Portal").Value)
      .Options0 = moUtil.FetchString(oCmd.Parameters.Item("@Options0").Value)
      .Options1 = moUtil.FetchString(oCmd.Parameters.Item("@Options1").Value)
      .Options2 = moUtil.FetchString(oCmd.Parameters.Item("@Options2").Value)
      .Options3 = moUtil.FetchString(oCmd.Parameters.Item("@Options3").Value)
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

Public Sub Update( _ 
   ByRef brRec As tMoptionType, _ 
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
      .Parameters.Append .CreateParameter("@MoptionID", adInteger, adParamInput, vbNull, CLng(brRec.MoptionID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@IsActivity", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActivity))
      .Parameters.Append .CreateParameter("@ActivityTracks", adVarWChar, adParamInput, 20, brRec.ActivityTracks)
      .Parameters.Append .CreateParameter("@TrackTheme", adInteger, adParamInput, vbNull, CLng(brRec.TrackTheme))
      .Parameters.Append .CreateParameter("@MenuColors", adVarWChar, adParamInput, 200, brRec.MenuColors)
      .Parameters.Append .CreateParameter("@Portal", adVarWChar, adParamInput, 100, brRec.Portal)
      .Parameters.Append .CreateParameter("@Options0", adVarWChar, adParamInput, 50, brRec.Options0)
      .Parameters.Append .CreateParameter("@Options1", adVarWChar, adParamInput, 50, brRec.Options1)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamInput, 50, brRec.Options2)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamInput, 50, brRec.Options3)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Moption_Update"

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
   ByRef brRec As tMoptionType, _ 
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
         .MoptionID = moUtil.EditLong(.MoptionID, "MoptionID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .IsActivity = moUtil.EditInteger(.IsActivity, "IsActivity", False, 0, 0, 1) 
      .ActivityTracks = moUtil.EditString(.ActivityTracks, "ActivityTracks", False) 
      .TrackTheme = moUtil.EditLong(.TrackTheme, "TrackTheme", False) 
      .MenuColors = moUtil.EditString(.MenuColors, "MenuColors", False) 
      .Portal = moUtil.EditString(.Portal, "Portal", False) 
      .Options0 = moUtil.EditString(.Options0, "Options0", False) 
      .Options1 = moUtil.EditString(.Options1, "Options1", False) 
      .Options2 = moUtil.EditString(.Options2, "Options2", False) 
      .Options3 = moUtil.EditString(.Options3, "Options3", False) 
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