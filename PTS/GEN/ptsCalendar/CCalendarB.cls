VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CCalendarB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CCalendar"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tCalendarType
   CalendarID As String
   CompanyID As String
   MemberID As String
   CalendarName As String
   Description As String
   Layout As String
   IsPrivate As String
   IsAppt As String
   IsClass As String
   IsAssess As String
   IsGoal As String
   IsProject As String
   IsTask As String
   IsSales As String
   IsActivities As String
   IsEvents As String
   IsService As String
   IsLead As String
   Timezone As String
   Seq As String
End Type

Public Sub Add( _ 
   ByRef brRec As tCalendarType, _ 
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
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CalendarName", adVarWChar, adParamInput, 60, brRec.CalendarName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Layout", adInteger, adParamInput, vbNull, CLng(brRec.Layout))
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@IsAppt", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAppt))
      .Parameters.Append .CreateParameter("@IsClass", adSmallInt, adParamInput, vbNull, CInt(brRec.IsClass))
      .Parameters.Append .CreateParameter("@IsAssess", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAssess))
      .Parameters.Append .CreateParameter("@IsGoal", adSmallInt, adParamInput, vbNull, CInt(brRec.IsGoal))
      .Parameters.Append .CreateParameter("@IsProject", adSmallInt, adParamInput, vbNull, CInt(brRec.IsProject))
      .Parameters.Append .CreateParameter("@IsTask", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTask))
      .Parameters.Append .CreateParameter("@IsSales", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSales))
      .Parameters.Append .CreateParameter("@IsActivities", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActivities))
      .Parameters.Append .CreateParameter("@IsEvents", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEvents))
      .Parameters.Append .CreateParameter("@IsService", adSmallInt, adParamInput, vbNull, CInt(brRec.IsService))
      .Parameters.Append .CreateParameter("@IsLead", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLead))
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamInput, vbNull, CLng(brRec.Timezone))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_Add"

   '-----get return values
   With brRec
      .CalendarID = moUtil.FetchLong(oCmd.Parameters.Item("@CalendarID").Value)
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

Public Function AdjustTimezone( _ 
   ByRef brRec As tCalendarType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AdjustTimezone"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(brRec.CalendarID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_AdjustTimezone"

   '-----get return values
   AdjustTimezone = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_Count"

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
   ByRef brRec As tCalendarType, _ 
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
      .CalendarID = moUtil.EditLong(.CalendarID, "CalendarID", False, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(brRec.CalendarID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_Delete"

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
   ByRef brRec As tCalendarType, _ 
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
      .CalendarID = moUtil.EditLong(.CalendarID, "CalendarID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(brRec.CalendarID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CalendarName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Layout", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsAppt", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsClass", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsAssess", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsGoal", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsProject", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsTask", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsSales", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsActivities", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsEvents", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsService", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsLead", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .CalendarName = moUtil.FetchString(oCmd.Parameters.Item("@CalendarName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Layout = moUtil.FetchLong(oCmd.Parameters.Item("@Layout").Value)
      .IsPrivate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPrivate").Value)
      .IsAppt = moUtil.FetchInteger(oCmd.Parameters.Item("@IsAppt").Value)
      .IsClass = moUtil.FetchInteger(oCmd.Parameters.Item("@IsClass").Value)
      .IsAssess = moUtil.FetchInteger(oCmd.Parameters.Item("@IsAssess").Value)
      .IsGoal = moUtil.FetchInteger(oCmd.Parameters.Item("@IsGoal").Value)
      .IsProject = moUtil.FetchInteger(oCmd.Parameters.Item("@IsProject").Value)
      .IsTask = moUtil.FetchInteger(oCmd.Parameters.Item("@IsTask").Value)
      .IsSales = moUtil.FetchInteger(oCmd.Parameters.Item("@IsSales").Value)
      .IsActivities = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActivities").Value)
      .IsEvents = moUtil.FetchInteger(oCmd.Parameters.Item("@IsEvents").Value)
      .IsService = moUtil.FetchInteger(oCmd.Parameters.Item("@IsService").Value)
      .IsLead = moUtil.FetchInteger(oCmd.Parameters.Item("@IsLead").Value)
      .Timezone = moUtil.FetchLong(oCmd.Parameters.Item("@Timezone").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
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
   ByVal bvMemberID As Long) As tCalendarType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCalendarType
   Dim vRec As tCalendarType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CalendarID = moUtil.FetchLong(.Fields.Item("CalendarID").Value)
            vRec.CalendarName = moUtil.FetchString(.Fields.Item("CalendarName").Value)
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

Public Function ListCompany( _ 
   ByVal bvCompanyID As Long) As tCalendarType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCalendarType
   Dim vRec As tCalendarType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_ListCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CalendarID = moUtil.FetchLong(.Fields.Item("CalendarID").Value)
            vRec.CalendarName = moUtil.FetchString(.Fields.Item("CalendarName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompany = vRecs

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

Public Function ListCompanyPublic( _ 
   ByVal bvCompanyID As Long) As tCalendarType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyPublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCalendarType
   Dim vRec As tCalendarType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_ListCompanyPublic")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CalendarID = moUtil.FetchLong(.Fields.Item("CalendarID").Value)
            vRec.CalendarName = moUtil.FetchString(.Fields.Item("CalendarName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompanyPublic = vRecs

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
   ByRef brRec As tCalendarType, _ 
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
      .Parameters.Append .CreateParameter("@CalendarID", adInteger, adParamInput, vbNull, CLng(brRec.CalendarID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CalendarName", adVarWChar, adParamInput, 60, brRec.CalendarName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Layout", adInteger, adParamInput, vbNull, CLng(brRec.Layout))
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@IsAppt", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAppt))
      .Parameters.Append .CreateParameter("@IsClass", adSmallInt, adParamInput, vbNull, CInt(brRec.IsClass))
      .Parameters.Append .CreateParameter("@IsAssess", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAssess))
      .Parameters.Append .CreateParameter("@IsGoal", adSmallInt, adParamInput, vbNull, CInt(brRec.IsGoal))
      .Parameters.Append .CreateParameter("@IsProject", adSmallInt, adParamInput, vbNull, CInt(brRec.IsProject))
      .Parameters.Append .CreateParameter("@IsTask", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTask))
      .Parameters.Append .CreateParameter("@IsSales", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSales))
      .Parameters.Append .CreateParameter("@IsActivities", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActivities))
      .Parameters.Append .CreateParameter("@IsEvents", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEvents))
      .Parameters.Append .CreateParameter("@IsService", adSmallInt, adParamInput, vbNull, CInt(brRec.IsService))
      .Parameters.Append .CreateParameter("@IsLead", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLead))
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamInput, vbNull, CLng(brRec.Timezone))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Calendar_Update"

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
   ByRef brRec As tCalendarType, _ 
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
         .CalendarID = moUtil.EditLong(.CalendarID, "CalendarID", False, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .CalendarName = moUtil.EditString(.CalendarName, "CalendarName", True, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 500) 
      .Layout = moUtil.EditLong(.Layout, "Layout", False) 
      .IsPrivate = moUtil.EditInteger(.IsPrivate, "IsPrivate", False, 0, 0, 1) 
      .IsAppt = moUtil.EditInteger(.IsAppt, "IsAppt", False, 0, 0, 1) 
      .IsClass = moUtil.EditInteger(.IsClass, "IsClass", False, 0, 0, 1) 
      .IsAssess = moUtil.EditInteger(.IsAssess, "IsAssess", False, 0, 0, 1) 
      .IsGoal = moUtil.EditInteger(.IsGoal, "IsGoal", False, 0, 0, 1) 
      .IsProject = moUtil.EditInteger(.IsProject, "IsProject", False, 0, 0, 1) 
      .IsTask = moUtil.EditInteger(.IsTask, "IsTask", False, 0, 0, 1) 
      .IsSales = moUtil.EditInteger(.IsSales, "IsSales", False, 0, 0, 1) 
      .IsActivities = moUtil.EditInteger(.IsActivities, "IsActivities", False, 0, 0, 1) 
      .IsEvents = moUtil.EditInteger(.IsEvents, "IsEvents", False, 0, 0, 1) 
      .IsService = moUtil.EditInteger(.IsService, "IsService", False, 0, 0, 1) 
      .IsLead = moUtil.EditInteger(.IsLead, "IsLead", False, 0, 0, 1) 
      .Timezone = moUtil.EditLong(.Timezone, "Timezone", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False, , 1) 
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