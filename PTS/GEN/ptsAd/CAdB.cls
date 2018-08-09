VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAdB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAd"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAdType
   AdID As String
   CompanyID As String
   MemberID As String
   MemberName As String
   AdName As String
   Status As String
   Msg As String
   Placement As String
   RefID As String
   Priority As String
   POrder As String
   Zip As String
   City As String
   MTA As String
   State As String
   StartAge As String
   EndAge As String
   StartDate As String
   EndDate As String
   MaxPlace As String
   Places As String
   Clicks As String
   Rotation As String
   Weight As String
   AdTrackID As String
   UType As String
   UID As String
   ClickRate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAdType, _ 
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
      .Parameters.Append .CreateParameter("@AdID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AdName", adVarWChar, adParamInput, 60, brRec.AdName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Msg", adVarWChar, adParamInput, 2000, brRec.Msg)
      .Parameters.Append .CreateParameter("@Placement", adInteger, adParamInput, vbNull, CLng(brRec.Placement))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(brRec.Priority))
      .Parameters.Append .CreateParameter("@POrder", adInteger, adParamInput, vbNull, CLng(brRec.POrder))
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@MTA", adVarWChar, adParamInput, 15, brRec.MTA)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@StartAge", adInteger, adParamInput, vbNull, CLng(brRec.StartAge))
      .Parameters.Append .CreateParameter("@EndAge", adInteger, adParamInput, vbNull, CLng(brRec.EndAge))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@MaxPlace", adInteger, adParamInput, vbNull, CLng(brRec.MaxPlace))
      .Parameters.Append .CreateParameter("@Places", adInteger, adParamInput, vbNull, CLng(brRec.Places))
      .Parameters.Append .CreateParameter("@Clicks", adInteger, adParamInput, vbNull, CLng(brRec.Clicks))
      .Parameters.Append .CreateParameter("@Rotation", adVarWChar, adParamInput, 10, brRec.Rotation)
      .Parameters.Append .CreateParameter("@Weight", adInteger, adParamInput, vbNull, CLng(brRec.Weight))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Ad_Add"

   '-----get return values
   With brRec
      .AdID = moUtil.FetchLong(oCmd.Parameters.Item("@AdID").Value)
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

Public Function Custom( _ 
   ByRef brRec As tAdType, _ 
   ByVal bvUserID As Long) As Long
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
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@AdID", adInteger, adParamInput, vbNull, CLng(brRec.AdID))
      .Parameters.Append .CreateParameter("@Places", adInteger, adParamInput, vbNull, CLng(brRec.Places))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Ad_Custom"

   '-----get return values
   Custom = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Ad_Count"

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
   ByRef brRec As tAdType, _ 
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
      .AdID = moUtil.EditLong(.AdID, "AdID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AdID", adInteger, adParamInput, vbNull, CLng(brRec.AdID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Ad_Delete"

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
   ByRef brRec As tAdType, _ 
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
      .AdID = moUtil.EditLong(.AdID, "AdID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AdID", adInteger, adParamInput, vbNull, CLng(brRec.AdID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@AdName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Msg", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Placement", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@POrder", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MTA", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@StartAge", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndAge", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MaxPlace", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Places", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Clicks", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Rotation", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Weight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Ad_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .AdName = moUtil.FetchString(oCmd.Parameters.Item("@AdName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Msg = moUtil.FetchString(oCmd.Parameters.Item("@Msg").Value)
      .Placement = moUtil.FetchLong(oCmd.Parameters.Item("@Placement").Value)
      .RefID = moUtil.FetchLong(oCmd.Parameters.Item("@RefID").Value)
      .Priority = moUtil.FetchLong(oCmd.Parameters.Item("@Priority").Value)
      .POrder = moUtil.FetchLong(oCmd.Parameters.Item("@POrder").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .MTA = moUtil.FetchString(oCmd.Parameters.Item("@MTA").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .StartAge = moUtil.FetchLong(oCmd.Parameters.Item("@StartAge").Value)
      .EndAge = moUtil.FetchLong(oCmd.Parameters.Item("@EndAge").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .MaxPlace = moUtil.FetchLong(oCmd.Parameters.Item("@MaxPlace").Value)
      .Places = moUtil.FetchLong(oCmd.Parameters.Item("@Places").Value)
      .Clicks = moUtil.FetchLong(oCmd.Parameters.Item("@Clicks").Value)
      .Rotation = moUtil.FetchString(oCmd.Parameters.Item("@Rotation").Value)
      .Weight = moUtil.FetchLong(oCmd.Parameters.Item("@Weight").Value)
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
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tAdType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAdType
   Dim vRec As tAdType
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
      Case cptsAdFindAdName
         sProc = "pts_Ad_FindAdName"
         MaxBookMark = 70
      Case cptsAdFindMemberName
         sProc = "pts_Ad_FindMemberName"
         MaxBookMark = 70
      Case cptsAdFindPlacement
         sProc = "pts_Ad_FindPlacement"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
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
               vRec.AdID = moUtil.FetchLong(.Fields.Item("AdID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.AdName = moUtil.FetchString(.Fields.Item("AdName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Msg = moUtil.FetchString(.Fields.Item("Msg").Value)
               vRec.Placement = moUtil.FetchLong(.Fields.Item("Placement").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.POrder = moUtil.FetchLong(.Fields.Item("POrder").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.MTA = moUtil.FetchString(.Fields.Item("MTA").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.StartAge = moUtil.FetchLong(.Fields.Item("StartAge").Value)
               vRec.EndAge = moUtil.FetchLong(.Fields.Item("EndAge").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.MaxPlace = moUtil.FetchLong(.Fields.Item("MaxPlace").Value)
               vRec.Places = moUtil.FetchLong(.Fields.Item("Places").Value)
               vRec.Clicks = moUtil.FetchLong(.Fields.Item("Clicks").Value)
               vRec.Rotation = moUtil.FetchString(.Fields.Item("Rotation").Value)
               vRec.Weight = moUtil.FetchLong(.Fields.Item("Weight").Value)
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

Public Function FindMember( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tAdType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAdType
   Dim vRec As tAdType
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
      Case cptsAdFindAdName
         sProc = "pts_Ad_FindMemberAdName"
         MaxBookMark = 70
      Case cptsAdFindMemberName
         sProc = "pts_Ad_FindMemberMemberName"
         MaxBookMark = 70
      Case cptsAdFindPlacement
         sProc = "pts_Ad_FindMemberPlacement"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.AdID = moUtil.FetchLong(.Fields.Item("AdID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.AdName = moUtil.FetchString(.Fields.Item("AdName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Msg = moUtil.FetchString(.Fields.Item("Msg").Value)
               vRec.Placement = moUtil.FetchLong(.Fields.Item("Placement").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.Priority = moUtil.FetchLong(.Fields.Item("Priority").Value)
               vRec.POrder = moUtil.FetchLong(.Fields.Item("POrder").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.MTA = moUtil.FetchString(.Fields.Item("MTA").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.StartAge = moUtil.FetchLong(.Fields.Item("StartAge").Value)
               vRec.EndAge = moUtil.FetchLong(.Fields.Item("EndAge").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.MaxPlace = moUtil.FetchLong(.Fields.Item("MaxPlace").Value)
               vRec.Places = moUtil.FetchLong(.Fields.Item("Places").Value)
               vRec.Clicks = moUtil.FetchLong(.Fields.Item("Clicks").Value)
               vRec.Rotation = moUtil.FetchString(.Fields.Item("Rotation").Value)
               vRec.Weight = moUtil.FetchLong(.Fields.Item("Weight").Value)
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
   FindMember = vRecs

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

Public Function ListAds( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvPlacement As Long, _ 
   ByVal bvRefID As Long, _ 
   ByVal bvUType As Long, _ 
   ByVal bvUID As Long) As tAdType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAds"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAdType
   Dim vRec As tAdType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Placement", adInteger, adParamInput, vbNull, CLng(bvPlacement))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(bvRefID))
      .Parameters.Append .CreateParameter("@UType", adInteger, adParamInput, vbNull, CLng(bvUType))
      .Parameters.Append .CreateParameter("@UID", adInteger, adParamInput, vbNull, CLng(bvUID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Ad_ListAds")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AdID = moUtil.FetchLong(.Fields.Item("AdID").Value)
            vRec.AdTrackID = moUtil.FetchLong(.Fields.Item("AdTrackID").Value)
            vRec.Msg = moUtil.FetchString(.Fields.Item("Msg").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAds = vRecs

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
   ByRef brRec As tAdType, _ 
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
      .Parameters.Append .CreateParameter("@AdID", adInteger, adParamInput, vbNull, CLng(brRec.AdID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AdName", adVarWChar, adParamInput, 60, brRec.AdName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Msg", adVarWChar, adParamInput, 2000, brRec.Msg)
      .Parameters.Append .CreateParameter("@Placement", adInteger, adParamInput, vbNull, CLng(brRec.Placement))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@Priority", adInteger, adParamInput, vbNull, CLng(brRec.Priority))
      .Parameters.Append .CreateParameter("@POrder", adInteger, adParamInput, vbNull, CLng(brRec.POrder))
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@MTA", adVarWChar, adParamInput, 15, brRec.MTA)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@StartAge", adInteger, adParamInput, vbNull, CLng(brRec.StartAge))
      .Parameters.Append .CreateParameter("@EndAge", adInteger, adParamInput, vbNull, CLng(brRec.EndAge))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@MaxPlace", adInteger, adParamInput, vbNull, CLng(brRec.MaxPlace))
      .Parameters.Append .CreateParameter("@Places", adInteger, adParamInput, vbNull, CLng(brRec.Places))
      .Parameters.Append .CreateParameter("@Clicks", adInteger, adParamInput, vbNull, CLng(brRec.Clicks))
      .Parameters.Append .CreateParameter("@Rotation", adVarWChar, adParamInput, 10, brRec.Rotation)
      .Parameters.Append .CreateParameter("@Weight", adInteger, adParamInput, vbNull, CLng(brRec.Weight))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Ad_Update"

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
   ByRef brRec As tAdType, _ 
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
         .AdID = moUtil.EditLong(.AdID, "AdID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .AdName = moUtil.EditString(.AdName, "AdName", False, , 1, 60) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Msg = moUtil.EditString(.Msg, "Msg", False, , 1, 2000) 
      .Placement = moUtil.EditLong(.Placement, "Placement", False) 
      .RefID = moUtil.EditLong(.RefID, "RefID", False) 
      .Priority = moUtil.EditLong(.Priority, "Priority", False) 
      .POrder = moUtil.EditLong(.POrder, "POrder", False) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .MTA = moUtil.EditString(.MTA, "MTA", False, , 1, 15) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .StartAge = moUtil.EditLong(.StartAge, "StartAge", False) 
      .EndAge = moUtil.EditLong(.EndAge, "EndAge", False) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .MaxPlace = moUtil.EditLong(.MaxPlace, "MaxPlace", False) 
      .Places = moUtil.EditLong(.Places, "Places", False) 
      .Clicks = moUtil.EditLong(.Clicks, "Clicks", False) 
      .Rotation = moUtil.EditString(.Rotation, "Rotation", False, , 1, 10) 
      .Weight = moUtil.EditLong(.Weight, "Weight", False) 
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