VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CTrainerB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CTrainer"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tTrainerType
   TrainerID As String
   AuthUserID As String
   SponsorID As String
   UserGroup As String
   UserStatus As String
   SponsorName As String
   CompanyName As String
   NameLast As String
   NameFirst As String
   TrainerName As String
   Email As String
   Street As String
   Unit As String
   City As String
   State As String
   Zip As String
   Country As String
   Phone1 As String
   Phone2 As String
   Fax As String
   Status As String
   Tier As String
   Website As String
   URL As String
   Image As String
   EnrollDate As String
   NewLogon As String
   NewPassword As String
End Type

Public Sub Add( _ 
   ByRef brRec As tTrainerType, _ 
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
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamInput, 60, brRec.CompanyName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Tier", adInteger, adParamInput, vbNull, CLng(brRec.Tier))
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamInput, 80, brRec.Website)
      .Parameters.Append .CreateParameter("@URL", adVarWChar, adParamInput, 80, brRec.URL)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 30, brRec.Image)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_Add"

   '-----get return values
   With brRec
      .TrainerID = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_Count"

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
   ByRef brRec As tTrainerType, _ 
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
      .TrainerID = moUtil.EditLong(.TrainerID, "TrainerID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_Delete"

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

Public Function Enumerate( _ 
   ByVal bvUserID As Long) As tTrainerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Enumerate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTrainerType
   Dim vRec As tTrainerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_Enum")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Enumerate = vRecs

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
   ByRef brRec As tTrainerType, _ 
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
      .TrainerID = moUtil.EditLong(.TrainerID, "TrainerID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SponsorName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@TrainerName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Tier", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@URL", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_Fetch"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .SponsorID = moUtil.FetchLong(oCmd.Parameters.Item("@SponsorID").Value)
      .UserGroup = moUtil.FetchLong(oCmd.Parameters.Item("@UserGroup").Value)
      .UserStatus = moUtil.FetchLong(oCmd.Parameters.Item("@UserStatus").Value)
      .SponsorName = moUtil.FetchString(oCmd.Parameters.Item("@SponsorName").Value)
      .CompanyName = moUtil.FetchString(oCmd.Parameters.Item("@CompanyName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .TrainerName = moUtil.FetchString(oCmd.Parameters.Item("@TrainerName").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Street = moUtil.FetchString(oCmd.Parameters.Item("@Street").Value)
      .Unit = moUtil.FetchString(oCmd.Parameters.Item("@Unit").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Country = moUtil.FetchString(oCmd.Parameters.Item("@Country").Value)
      .Phone1 = moUtil.FetchString(oCmd.Parameters.Item("@Phone1").Value)
      .Phone2 = moUtil.FetchString(oCmd.Parameters.Item("@Phone2").Value)
      .Fax = moUtil.FetchString(oCmd.Parameters.Item("@Fax").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Tier = moUtil.FetchLong(oCmd.Parameters.Item("@Tier").Value)
      .Website = moUtil.FetchString(oCmd.Parameters.Item("@Website").Value)
      .URL = moUtil.FetchString(oCmd.Parameters.Item("@URL").Value)
      .Image = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)
      .EnrollDate = moUtil.FetchDate(oCmd.Parameters.Item("@EnrollDate").Value)
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

Public Sub FetchAuthUserID( _ 
   ByRef brRec As tTrainerType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchAuthUserID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .TrainerID = moUtil.EditLong(.TrainerID, "TrainerID", True, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_FetchAuthUserID"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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

Public Sub LoadAuthUser( _ 
   ByRef brRec As tTrainerType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadAuthUser"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_LoadAuthUser"

   '-----get return values
   With brRec
      .TrainerID = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerID").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tTrainerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTrainerType
   Dim vRec As tTrainerType
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
      Case cptsTrainerFindCompanyName
         sProc = "pts_Trainer_FindCompanyName"
         MaxBookMark = 70
      Case cptsTrainerFindTrainerName
         sProc = "pts_Trainer_FindTrainerName"
         MaxBookMark = 72
      Case cptsTrainerFindTrainerID
         sProc = "pts_Trainer_FindTrainerID"
         MaxBookMark = 20
      Case cptsTrainerFindTier
         sProc = "pts_Trainer_FindTier"
         MaxBookMark = 20
      Case cptsTrainerFindStatus
         sProc = "pts_Trainer_FindStatus"
         MaxBookMark = 20
      Case cptsTrainerFindEnrollDate
         sProc = "pts_Trainer_FindEnrollDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
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
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.SponsorID = moUtil.FetchLong(.Fields.Item("SponsorID").Value)
               vRec.UserGroup = moUtil.FetchLong(.Fields.Item("UserGroup").Value)
               vRec.UserStatus = moUtil.FetchLong(.Fields.Item("UserStatus").Value)
               vRec.SponsorName = moUtil.FetchString(.Fields.Item("SponsorName").Value)
               vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Tier = moUtil.FetchLong(.Fields.Item("Tier").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.URL = moUtil.FetchString(.Fields.Item("URL").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
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

Public Function ListEmail( _ 
   ByVal bvEmail As String, _ 
   ByVal bvUserID As Long) As tTrainerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tTrainerType
   Dim vRec As tTrainerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, bvEmail)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_ListEmail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListEmail = vRecs

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
   ByRef brRec As tTrainerType, _ 
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
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamInput, 60, brRec.CompanyName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Tier", adInteger, adParamInput, vbNull, CLng(brRec.Tier))
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamInput, 80, brRec.Website)
      .Parameters.Append .CreateParameter("@URL", adVarWChar, adParamInput, 80, brRec.URL)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 30, brRec.Image)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Trainer_Update"

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
   ByRef brRec As tTrainerType, _ 
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
         .TrainerID = moUtil.EditLong(.TrainerID, "TrainerID", True, , 1) 
      End If
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .SponsorID = moUtil.EditLong(.SponsorID, "SponsorID", False) 
      .CompanyName = moUtil.EditString(.CompanyName, "CompanyName", False, , 1, 60) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", True, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", True, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80) 
      .Street = moUtil.EditString(.Street, "Street", True, , 1, 60) 
      .Unit = moUtil.EditString(.Unit, "Unit", False, , 1, 40) 
      .City = moUtil.EditString(.City, "City", True, , 1, 30) 
      .State = moUtil.EditString(.State, "State", True, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", True, , 1, 20) 
      .Country = moUtil.EditString(.Country, "Country", True, , 1, 30) 
      .Phone1 = moUtil.EditString(.Phone1, "Phone1", True, , 1, 30) 
      .Phone2 = moUtil.EditString(.Phone2, "Phone2", False, , 1, 30) 
      .Fax = moUtil.EditString(.Fax, "Fax", False, , 1, 30) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Tier = moUtil.EditLong(.Tier, "Tier", False) 
      .Website = moUtil.EditString(.Website, "Website", False, , 1, 80) 
      .URL = moUtil.EditString(.URL, "URL", False, , 1, 80) 
      .Image = moUtil.EditString(.Image, "Image", False, , 1, 30) 
      .EnrollDate = moUtil.EditDate(.EnrollDate, "EnrollDate", True) 
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