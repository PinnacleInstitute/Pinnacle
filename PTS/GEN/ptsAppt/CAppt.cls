VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CAppt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAppt"
Private Const cEntityID As Long = 48
Private Const cDefaultLanguage As String = "en"
'-----properties
Private mDataRec As CApptB.tApptType
Private mSecurityToken As Long
Private mCurrentLanguage As String
'-----enumerators
Public Enum ptsApptEnumConstants
   ptsApptEnumStatus = cptsApptEnumStatus
   ptsApptEnumApptType = cptsApptEnumApptType
   ptsApptEnumImportance = cptsApptEnumImportance
   ptsApptEnumShow = cptsApptEnumShow
   ptsApptEnumReminder = cptsApptEnumReminder
   ptsApptEnumRecur = cptsApptEnumRecur
End Enum

Public Enum ptsApptStatusConstants
   ptsApptStatusActive = cptsApptStatusActive
   ptsApptStatusInactive = cptsApptStatusInactive
   ptsApptStatusPending = cptsApptStatusPending
End Enum

Public Enum ptsApptApptTypeConstants
   ptsApptApptTypeAppt = cptsApptApptTypeAppt
   ptsApptApptTypePhone = cptsApptApptTypePhone
   ptsApptApptTypeMeeting = cptsApptApptTypeMeeting
   ptsApptApptTypeSeminar = cptsApptApptTypeSeminar
   ptsApptApptTypeTradeShow = cptsApptApptTypeTradeShow
   ptsApptApptTypeMeal = cptsApptApptTypeMeal
   ptsApptApptTypeParty = cptsApptApptTypeParty
   ptsApptApptTypeBirthday = cptsApptApptTypeBirthday
   ptsApptApptTypeAnniversary = cptsApptApptTypeAnniversary
   ptsApptApptTypePersonal = cptsApptApptTypePersonal
   ptsApptApptTypeFamily = cptsApptApptTypeFamily
   ptsApptApptTypeSports = cptsApptApptTypeSports
   ptsApptApptTypeEducation = cptsApptApptTypeEducation
   ptsApptApptTypeEntertainment = cptsApptApptTypeEntertainment
   ptsApptApptTypeVacation = cptsApptApptTypeVacation
   ptsApptApptTypeMedical = cptsApptApptTypeMedical
End Enum

Public Enum ptsApptImportanceConstants
   ptsApptImportanceLow = cptsApptImportanceLow
   ptsApptImportanceNormal = cptsApptImportanceNormal
   ptsApptImportanceHigh = cptsApptImportanceHigh
End Enum

Public Enum ptsApptShowConstants
   ptsApptShowNormal = cptsApptShowNormal
   ptsApptShowPrivate = cptsApptShowPrivate
   ptsApptShowBusy = cptsApptShowBusy
End Enum

Public Enum ptsApptReminderConstants
   ptsApptReminder30m = cptsApptReminder30m
   ptsApptReminder1h = cptsApptReminder1h
   ptsApptReminder2h = cptsApptReminder2h
   ptsApptReminder3h = cptsApptReminder3h
   ptsApptReminder4h = cptsApptReminder4h
   ptsApptReminder5h = cptsApptReminder5h
   ptsApptReminder6h = cptsApptReminder6h
   ptsApptReminder7h = cptsApptReminder7h
   ptsApptReminder8h = cptsApptReminder8h
   ptsApptReminder9h = cptsApptReminder9h
   ptsApptReminder10h = cptsApptReminder10h
   ptsApptReminder11h = cptsApptReminder11h
   ptsApptReminder12h = cptsApptReminder12h
   ptsApptReminder18h = cptsApptReminder18h
   ptsApptReminder1d = cptsApptReminder1d
   ptsApptReminder2d = cptsApptReminder2d
   ptsApptReminder3d = cptsApptReminder3d
   ptsApptReminder4d = cptsApptReminder4d
   ptsApptReminder1w = cptsApptReminder1w
   ptsApptReminder2w = cptsApptReminder2w
End Enum

Public Enum ptsApptRecurConstants
   ptsApptRecurWeek = cptsApptRecurWeek
   ptsApptRecurMonth = cptsApptRecurMonth
   ptsApptRecurYear = cptsApptRecurYear
End Enum

Public Function Add( _ 
   Optional ByVal bvSecurityToken As Long = 0) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Adds a new record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Add"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Add mDataRec, mSecurityToken

   '-----return the new item
   Add = mDataRec.ApptID

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Function BusnService() As CApptB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CApptB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Delete( _ 
   Optional ByVal bvApptID As Long = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Deletes the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Delete"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----initialize the ID if provided
   If bvApptID > 0 Then ApptID = bvApptID

   BusnService.Delete mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Property Get EnumItems( _ 
   ByVal bvType As ptsApptEnumConstants) As wtSystem.CEnumItems
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumItems"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems

   On Error GoTo ErrorHandler

   Set oEnums = New wtSystem.CEnumItems

   Select Case bvType
      Case cptsApptEnumStatus
         oEnums.Add cptsApptStatusActive, "Active"
         oEnums.Add cptsApptStatusInactive, "Inactive"
         oEnums.Add cptsApptStatusPending, "Pending"
      Case cptsApptEnumApptType
         oEnums.Add cptsApptApptTypeAppt, "Appt"
         oEnums.Add cptsApptApptTypePhone, "Phone"
         oEnums.Add cptsApptApptTypeMeeting, "Meeting"
         oEnums.Add cptsApptApptTypeSeminar, "Seminar"
         oEnums.Add cptsApptApptTypeTradeShow, "TradeShow"
         oEnums.Add cptsApptApptTypeMeal, "Meal"
         oEnums.Add cptsApptApptTypeParty, "Party"
         oEnums.Add cptsApptApptTypeBirthday, "Birthday"
         oEnums.Add cptsApptApptTypeAnniversary, "Anniversary"
         oEnums.Add cptsApptApptTypePersonal, "Personal"
         oEnums.Add cptsApptApptTypeFamily, "Family"
         oEnums.Add cptsApptApptTypeSports, "Sports"
         oEnums.Add cptsApptApptTypeEducation, "Education"
         oEnums.Add cptsApptApptTypeEntertainment, "Entertainment"
         oEnums.Add cptsApptApptTypeVacation, "Vacation"
         oEnums.Add cptsApptApptTypeMedical, "Medical"
      Case cptsApptEnumImportance
         oEnums.Add cptsApptImportanceLow, "Low"
         oEnums.Add cptsApptImportanceNormal, "Normal"
         oEnums.Add cptsApptImportanceHigh, "High"
      Case cptsApptEnumShow
         oEnums.Add cptsApptShowNormal, "Normal"
         oEnums.Add cptsApptShowPrivate, "Private"
         oEnums.Add cptsApptShowBusy, "Busy"
      Case cptsApptEnumReminder
         oEnums.Add cptsApptReminder30m, "30m"
         oEnums.Add cptsApptReminder1h, "1h"
         oEnums.Add cptsApptReminder2h, "2h"
         oEnums.Add cptsApptReminder3h, "3h"
         oEnums.Add cptsApptReminder4h, "4h"
         oEnums.Add cptsApptReminder5h, "5h"
         oEnums.Add cptsApptReminder6h, "6h"
         oEnums.Add cptsApptReminder7h, "7h"
         oEnums.Add cptsApptReminder8h, "8h"
         oEnums.Add cptsApptReminder9h, "9h"
         oEnums.Add cptsApptReminder10h, "10h"
         oEnums.Add cptsApptReminder11h, "11h"
         oEnums.Add cptsApptReminder12h, "12h"
         oEnums.Add cptsApptReminder18h, "18h"
         oEnums.Add cptsApptReminder1d, "1d"
         oEnums.Add cptsApptReminder2d, "2d"
         oEnums.Add cptsApptReminder3d, "3d"
         oEnums.Add cptsApptReminder4d, "4d"
         oEnums.Add cptsApptReminder1w, "1w"
         oEnums.Add cptsApptReminder2w, "2w"
      Case cptsApptEnumRecur
         oEnums.Add cptsApptRecurWeek, "Week"
         oEnums.Add cptsApptRecurMonth, "Month"
         oEnums.Add cptsApptRecurYear, "Year"
   End Select

   Set EnumItems = oEnums
   Set oEnums = Nothing

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Sub Load( _ 
   Optional ByVal bvApptID As Long = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Load"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----initialize the ID if provided
   If bvApptID > 0 Then ApptID = bvApptID

   BusnService.Fetch mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function CalendarEmail( _ 
   ByVal bvCalendarID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalendarEmail"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvCalendarID <> 0 Then CalendarID = bvCalendarID

   CalendarEmail = BusnService.CalendarEmail(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub ClearReminder( _ 
   ByVal bvApptID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Executes a Command. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ClearReminder"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvApptID <> 0 Then ApptID = bvApptID

   BusnService.ClearReminder mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Save( _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Adds or updates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Save"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Update mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Validate( _ 
   Optional ByVal bvNew As Integer = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Validates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Validate"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Validate mDataRec, mSecurityToken, bvNew

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function XML( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Appt") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the item.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim sChildren As String
   Dim sAttributes As String
   Dim sValue As String
   Dim sOption As String
   Dim bLookup As Integer
   Dim bFilter As Integer
   Dim bStatic As Integer
   Dim bAttrib As Integer

   On Error GoTo ErrorHandler

   'Handle Common Options for item classes
   Select Case bvOption
      Case 2: bvOption = 1111    ' attributes with all enums
      Case 3: bvOption = 1001    ' attributes with static enums only
   End Select
   sOption = Format(bvOption, "0000")
   bAttrib = (Mid(sOption, 1, 1) = "1")
   bFilter = (Mid(sOption, 2, 1) = "1")
   bLookup = (Mid(sOption, 3, 1) = "1")
   bStatic = (Mid(sOption, 4, 1) = "1")

   '-----create the XML for the children
   sChildren = ""
   If bStatic Then
      If IsNumeric(Status) Then
         sChildren = sChildren + EnumItems(4813).XML("ptsStatuss", Status)
      Else
         sChildren = sChildren + EnumItems (4813).XML("ptsStatuss")
      End If

      If IsNumeric(ApptType) Then
         sChildren = sChildren + EnumItems(4814).XML("ptsApptTypes", ApptType)
      Else
         sChildren = sChildren + EnumItems (4814).XML("ptsApptTypes")
      End If

      If IsNumeric(Importance) Then
         sChildren = sChildren + EnumItems(4815).XML("ptsImportances", Importance)
      Else
         sChildren = sChildren + EnumItems (4815).XML("ptsImportances")
      End If

      If IsNumeric(Show) Then
         sChildren = sChildren + EnumItems(4816).XML("ptsShows", Show)
      Else
         sChildren = sChildren + EnumItems (4816).XML("ptsShows")
      End If

      If IsNumeric(Reminder) Then
         sChildren = sChildren + EnumItems(4817).XML("ptsReminders", Reminder)
      Else
         sChildren = sChildren + EnumItems (4817).XML("ptsReminders")
      End If

      If IsNumeric(Recur) Then
         sChildren = sChildren + EnumItems(4819).XML("ptsRecurs", Recur)
      Else
         sChildren = sChildren + EnumItems (4819).XML("ptsRecurs")
      End If

   End If
   '-----create the XML for the attributes
   sAttributes = ""

   If bAttrib Then
      If (Len(ApptID) > 0) Then sAttributes = sAttributes + XMLAttribute("ApptID", ApptID, False)
      If (Len(CalendarID) > 0) Then sAttributes = sAttributes + XMLAttribute("CalendarID", CalendarID, False)
      If (Len(ApptName) > 0) Then sAttributes = sAttributes + XMLAttribute("ApptName", ApptName, False)
      If (Len(Location) > 0) Then sAttributes = sAttributes + XMLAttribute("Location", Location, False)
      If (Len(Note) > 0) Then sAttributes = sAttributes + XMLAttribute("Note", Note, False)
      If (Len(StartDate) > 0) And (StartDate <> "0") Then sAttributes = sAttributes + XMLAttribute("StartDate", Format$(StartDate, "m/d/yyyy"), False)
      If (Len(StartTime) > 0) Then sAttributes = sAttributes + XMLAttribute("StartTime", StartTime, False)
      If (Len(EndDate) > 0) And (EndDate <> "0") Then sAttributes = sAttributes + XMLAttribute("EndDate", Format$(EndDate, "m/d/yyyy"), False)
      If (Len(EndTime) > 0) Then sAttributes = sAttributes + XMLAttribute("EndTime", EndTime, False)
      If (Len(IsAllDay) > 0) Then sAttributes = sAttributes + XMLAttribute("IsAllDay", IsAllDay, False)
      If (Len(Status) > 0) Then sAttributes = sAttributes + XMLAttribute("Status", Status, False)
      If (Len(ApptType) > 0) Then sAttributes = sAttributes + XMLAttribute("ApptType", ApptType, False)
      If (Len(Importance) > 0) Then sAttributes = sAttributes + XMLAttribute("Importance", Importance, False)
      If (Len(Show) > 0) Then sAttributes = sAttributes + XMLAttribute("Show", Show, False)
      If (Len(Reminder) > 0) Then sAttributes = sAttributes + XMLAttribute("Reminder", Reminder, False)
      If (Len(RemindDate) > 0) And (RemindDate <> "0") Then sAttributes = sAttributes + XMLAttribute("RemindDate", Format$(RemindDate, "m-d-yy h:mmam/pm"), False)
      If (Len(Recur) > 0) Then sAttributes = sAttributes + XMLAttribute("Recur", Recur, False)
      If (Len(RecurDate) > 0) And (RecurDate <> "0") Then sAttributes = sAttributes + XMLAttribute("RecurDate", Format$(RecurDate, "m/d/yyyy"), False)
      If (Len(IsEdit) > 0) Then sAttributes = sAttributes + XMLAttribute("IsEdit", IsEdit, False)
      If (Len(IsPlan) > 0) Then sAttributes = sAttributes + XMLAttribute("IsPlan", IsPlan, False)
      If (Len(FromDate) > 0) And (FromDate <> "0") Then sAttributes = sAttributes + XMLAttribute("FromDate", Format$(FromDate, "m/d/yyyy"), False)
      If (Len(ToDate) > 0) And (ToDate <> "0") Then sAttributes = sAttributes + XMLAttribute("ToDate", Format$(ToDate, "m/d/yyyy"), False)
      If (Len(Opt) > 0) Then sAttributes = sAttributes + XMLAttribute("Opt", Opt, False)
      If (Len(Email) > 0) Then sAttributes = sAttributes + XMLAttribute("Email", Email, False)
      If (Len(MemberID) > 0) Then sAttributes = sAttributes + XMLAttribute("MemberID", MemberID, False)
      If (Len(IsMsg) > 0) Then sAttributes = sAttributes + XMLAttribute("IsMsg", IsMsg, False)
   End If
   '-----create the XML for the value
   sValue = ""

   '-----create the XML for the object
   If bAttrib Then
      XML = XMLElement("pts" + bvElementName, sAttributes, sValue, sChildren)
   Else
      XML = sChildren
   End If

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XMLDashboard() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the item.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLDashboard"
   '------------------------------------------------------------------------------------------------------------------------
   Dim sChildren As String
   Dim sAttributes As String

   On Error GoTo ErrorHandler

   '-----create the XML for the attributes
   sAttributes = ""
   If (Len(ApptID) > 0) Then sAttributes = sAttributes + XMLAttribute("id", ApptID, False)
   If (Len(ApptName) > 0) Then sAttributes = sAttributes + XMLAttribute("name", ApptName, False)
   If (Len(ApptType) > 0) Then sAttributes = sAttributes + XMLAttribute("type", ApptType, False)
   If (Len(Status) > 0) Then sAttributes = sAttributes + XMLAttribute("status", Status, False)

   '-----create the XML for the object
   XMLDashboard = XMLElement("Appt", sAttributes, , sChildren)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Friend Property Get DataRec() As CApptB.tApptType
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   DataRec = mDataRec

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Friend Property Let DataRec( _ 
   ByRef brDataRec As CApptB.tApptType)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec = brDataRec

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)
   mCurrentLanguage = bvLanguage
End Property


Public Property Get ApptID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ApptID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ApptID = mDataRec.ApptID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ApptID( _ 
   ByVal bvApptID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ApptID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ApptID = bvApptID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get CalendarID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalendarID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   CalendarID = mDataRec.CalendarID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CalendarID( _ 
   ByVal bvCalendarID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalendarID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CalendarID = bvCalendarID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ApptName() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ApptName_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ApptName = mDataRec.ApptName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ApptName( _ 
   ByVal bvApptName As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ApptName_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ApptName = bvApptName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Location() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Location_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Location = mDataRec.Location

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Location( _ 
   ByVal bvLocation As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Location_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Location = bvLocation

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Note() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Note_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Note = mDataRec.Note

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Note( _ 
   ByVal bvNote As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Note_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Note = bvNote

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get StartDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "StartDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.StartDate) Then StartDate = mDataRec.StartDate Else StartDate = 0
   If mDataRec.StartDate = "1/1/1900" Then StartDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let StartDate( _ 
   ByVal bvStartDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "StartDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.StartDate = bvStartDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get StartTime() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "StartTime_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   StartTime = mDataRec.StartTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let StartTime( _ 
   ByVal bvStartTime As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "StartTime_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.StartTime = bvStartTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get EndDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EndDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.EndDate) Then EndDate = mDataRec.EndDate Else EndDate = 0
   If mDataRec.EndDate = "1/1/1900" Then EndDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let EndDate( _ 
   ByVal bvEndDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EndDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.EndDate = bvEndDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get EndTime() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EndTime_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   EndTime = mDataRec.EndTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let EndTime( _ 
   ByVal bvEndTime As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EndTime_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.EndTime = bvEndTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get IsAllDay() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsAllDay_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   IsAllDay = mDataRec.IsAllDay

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let IsAllDay( _ 
   ByVal bvIsAllDay As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsAllDay_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.IsAllDay = bvIsAllDay

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Status() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Status_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Status = mDataRec.Status

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Status( _ 
   ByVal bvStatus As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Status_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Status = bvStatus

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ApptType() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ApptType_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ApptType = mDataRec.ApptType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ApptType( _ 
   ByVal bvApptType As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ApptType_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ApptType = bvApptType

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Importance() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Importance_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Importance = mDataRec.Importance

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Importance( _ 
   ByVal bvImportance As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Importance_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Importance = bvImportance

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Show() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Show_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Show = mDataRec.Show

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Show( _ 
   ByVal bvShow As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Show_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Show = bvShow

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Reminder() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Reminder_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Reminder = mDataRec.Reminder

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Reminder( _ 
   ByVal bvReminder As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Reminder_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Reminder = bvReminder

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get RemindDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RemindDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.RemindDate) Then RemindDate = mDataRec.RemindDate Else RemindDate = 0
   If mDataRec.RemindDate = "1/1/1900" Then RemindDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let RemindDate( _ 
   ByVal bvRemindDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RemindDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.RemindDate = bvRemindDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Recur() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Recur_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Recur = mDataRec.Recur

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Recur( _ 
   ByVal bvRecur As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Recur_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Recur = bvRecur

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get RecurDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RecurDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.RecurDate) Then RecurDate = mDataRec.RecurDate Else RecurDate = 0
   If mDataRec.RecurDate = "1/1/1900" Then RecurDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let RecurDate( _ 
   ByVal bvRecurDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RecurDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.RecurDate = bvRecurDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get IsEdit() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsEdit_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   IsEdit = mDataRec.IsEdit

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let IsEdit( _ 
   ByVal bvIsEdit As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsEdit_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.IsEdit = bvIsEdit

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get IsPlan() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsPlan_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   IsPlan = mDataRec.IsPlan

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let IsPlan( _ 
   ByVal bvIsPlan As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsPlan_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.IsPlan = bvIsPlan

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get FromDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FromDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.FromDate) Then FromDate = mDataRec.FromDate Else FromDate = 0
   If mDataRec.FromDate = "1/1/1900" Then FromDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let FromDate( _ 
   ByVal bvFromDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FromDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.FromDate = bvFromDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ToDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ToDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.ToDate) Then ToDate = mDataRec.ToDate Else ToDate = 0
   If mDataRec.ToDate = "1/1/1900" Then ToDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ToDate( _ 
   ByVal bvToDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ToDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ToDate = bvToDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Opt() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Opt_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Opt = mDataRec.Opt

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Opt( _ 
   ByVal bvOpt As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Opt_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Opt = bvOpt

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Email() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Email_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Email = mDataRec.Email

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Email( _ 
   ByVal bvEmail As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Email_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Email = bvEmail

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get MemberID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   MemberID = mDataRec.MemberID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let MemberID( _ 
   ByVal bvMemberID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.MemberID = bvMemberID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get IsMsg() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsMsg_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   IsMsg = mDataRec.IsMsg

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let IsMsg( _ 
   ByVal bvIsMsg As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsMsg_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.IsMsg = bvIsMsg

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Private Sub Class_Initialize()
   mCurrentLanguage = cDefaultLanguage
End Sub