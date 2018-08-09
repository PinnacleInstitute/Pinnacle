VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CPartyB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CParty"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tPartyType
   PartyID As String
   ApptID As String
   PartyName As String
   StartDate As String
   StartTime As String
   EndDate As String
   EndTime As String
   NameLast As String
   NameFirst As String
   HostName As String
   Email As String
   IsTrained As String
   Phone As String
   Location As String
   Street As String
   Unit As String
   City As String
   State As String
   Zip As String
   Country As String
   IsMap As String
   Message As String
   Theme As String
   CustomTheme As String
   Sales As String
   IsShop As String
   MemberID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tPartyType, _ 
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
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamInput, vbNull, CLng(brRec.ApptID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 15, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 15, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@IsTrained", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTrained))
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 60, brRec.Location)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@IsMap", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMap))
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamInput, 2000, brRec.Message)
      .Parameters.Append .CreateParameter("@Theme", adInteger, adParamInput, vbNull, CLng(brRec.Theme))
      .Parameters.Append .CreateParameter("@CustomTheme", adInteger, adParamInput, vbNull, CLng(brRec.CustomTheme))
      .Parameters.Append .CreateParameter("@Sales", adCurrency, adParamInput, vbNull, CCur(brRec.Sales))
      .Parameters.Append .CreateParameter("@IsShop", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShop))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_Add"

   '-----get return values
   With brRec
      .PartyID = moUtil.FetchLong(oCmd.Parameters.Item("@PartyID").Value)
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

Public Sub CalcSales( _ 
   ByRef brRec As tPartyType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcSales"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(brRec.PartyID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_CalcSales"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Delete( _ 
   ByRef brRec As tPartyType, _ 
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
      .PartyID = moUtil.EditLong(.PartyID, "PartyID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(brRec.PartyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_Delete"

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
   ByRef brRec As tPartyType, _ 
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
      .PartyID = moUtil.EditLong(.PartyID, "PartyID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(brRec.PartyID))
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PartyName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartTime", adVarWChar, adParamOutput, 8, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndTime", adVarWChar, adParamOutput, 8, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@HostName", adVarWChar, adParamOutput, 32, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@IsTrained", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@IsMap", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Theme", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CustomTheme", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Sales", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsShop", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_Fetch"

   '-----get return values
   With brRec
      .ApptID = moUtil.FetchLong(oCmd.Parameters.Item("@ApptID").Value)
      .PartyName = moUtil.FetchString(oCmd.Parameters.Item("@PartyName").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .StartTime = moUtil.FetchString(oCmd.Parameters.Item("@StartTime").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .EndTime = moUtil.FetchString(oCmd.Parameters.Item("@EndTime").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .HostName = moUtil.FetchString(oCmd.Parameters.Item("@HostName").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .IsTrained = moUtil.FetchInteger(oCmd.Parameters.Item("@IsTrained").Value)
      .Phone = moUtil.FetchString(oCmd.Parameters.Item("@Phone").Value)
      .Location = moUtil.FetchString(oCmd.Parameters.Item("@Location").Value)
      .Street = moUtil.FetchString(oCmd.Parameters.Item("@Street").Value)
      .Unit = moUtil.FetchString(oCmd.Parameters.Item("@Unit").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Country = moUtil.FetchString(oCmd.Parameters.Item("@Country").Value)
      .IsMap = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMap").Value)
      .Message = moUtil.FetchString(oCmd.Parameters.Item("@Message").Value)
      .Theme = moUtil.FetchLong(oCmd.Parameters.Item("@Theme").Value)
      .CustomTheme = moUtil.FetchLong(oCmd.Parameters.Item("@CustomTheme").Value)
      .Sales = moUtil.FetchCurrency(oCmd.Parameters.Item("@Sales").Value)
      .IsShop = moUtil.FetchInteger(oCmd.Parameters.Item("@IsShop").Value)
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

Public Sub FetchPartyID( _ 
   ByRef brRec As tPartyType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchPartyID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ApptID = moUtil.EditLong(.ApptID, "ApptID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamInput, vbNull, CLng(brRec.ApptID))
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_FetchPartyID"

   '-----get return values
   With brRec
      .PartyID = moUtil.FetchLong(oCmd.Parameters.Item("@PartyID").Value)
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

Public Sub FetchMemberID( _ 
   ByRef brRec As tPartyType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchMemberID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .PartyID = moUtil.EditLong(.PartyID, "PartyID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(brRec.PartyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_FetchMemberID"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
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

Public Function ListMember( _ 
   ByVal bvMemberID As Long) As tPartyType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPartyType
   Dim vRec As tPartyType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PartyID = moUtil.FetchLong(.Fields.Item("PartyID").Value)
            vRec.PartyName = moUtil.FetchString(.Fields.Item("PartyName").Value)
            vRec.HostName = moUtil.FetchString(.Fields.Item("HostName").Value)
            vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
            vRec.StartTime = moUtil.FetchString(.Fields.Item("StartTime").Value)
            vRec.Sales = moUtil.FetchCurrency(.Fields.Item("Sales").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMember = vRecs

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
   ByRef brRec As tPartyType, _ 
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
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(brRec.PartyID))
      .Parameters.Append .CreateParameter("@ApptID", adInteger, adParamInput, vbNull, CLng(brRec.ApptID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 15, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 15, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@IsTrained", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTrained))
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 60, brRec.Location)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@IsMap", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMap))
      .Parameters.Append .CreateParameter("@Message", adVarWChar, adParamInput, 2000, brRec.Message)
      .Parameters.Append .CreateParameter("@Theme", adInteger, adParamInput, vbNull, CLng(brRec.Theme))
      .Parameters.Append .CreateParameter("@CustomTheme", adInteger, adParamInput, vbNull, CLng(brRec.CustomTheme))
      .Parameters.Append .CreateParameter("@Sales", adCurrency, adParamInput, vbNull, CCur(brRec.Sales))
      .Parameters.Append .CreateParameter("@IsShop", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShop))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Party_Update"

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
   ByRef brRec As tPartyType, _ 
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
         .PartyID = moUtil.EditLong(.PartyID, "PartyID", True, , 1) 
      End If
      .ApptID = moUtil.EditLong(.ApptID, "ApptID", False) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 15) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 15) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .IsTrained = moUtil.EditInteger(.IsTrained, "IsTrained", False, 0, 0, 1) 
      .Phone = moUtil.EditString(.Phone, "Phone", False, , 1, 30) 
      .Location = moUtil.EditString(.Location, "Location", False, , 1, 60) 
      .Street = moUtil.EditString(.Street, "Street", False, , 1, 60) 
      .Unit = moUtil.EditString(.Unit, "Unit", False, , 1, 40) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .Country = moUtil.EditString(.Country, "Country", False, , 1, 30) 
      .IsMap = moUtil.EditInteger(.IsMap, "IsMap", False, 0, 0, 1) 
      .Message = moUtil.EditString(.Message, "Message", False, , 1, 2000) 
      .Theme = moUtil.EditLong(.Theme, "Theme", False) 
      .CustomTheme = moUtil.EditLong(.CustomTheme, "CustomTheme", False) 
      .Sales = moUtil.EditCurrency(.Sales, "Sales", False) 
      .IsShop = moUtil.EditInteger(.IsShop, "IsShop", False, 0, 0, 1) 
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