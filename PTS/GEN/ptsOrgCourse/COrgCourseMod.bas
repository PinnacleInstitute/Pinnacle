Attribute VB_Name = "COrgCourseMod"
Option Explicit
'-----constants
Private Const cModName As String = "COrgCourseMod"

'-----enum item type constants
Public Const cptsOrgCourseEnumStatus As Long = 3010
Public Const cptsOrgCourseEnumQuizLimit As Long = 3011

'-----enum Status constants
Public Const cptsOrgCourseStatusRecommended As Long = 1
Public Const cptsOrgCourseStatusRequired As Long = 2

'-----enum QuizLimit constants
Public Const cptsOrgCourseQuizLimitNoRetake As Long = 1
Public Const cptsOrgCourseQuizLimitNoAnswer As Long = 2