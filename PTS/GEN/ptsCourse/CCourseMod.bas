Attribute VB_Name = "CCourseMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCourseMod"

'-----enum item type constants
Public Const cptsCourseEnumFindType As Long = 1
Public Const cptsCourseEnumStatus As Long = 1111
Public Const cptsCourseEnumCourseType As Long = 1112
Public Const cptsCourseEnumCourseLevel As Long = 1113

'-----enum FindType constants
Public Const cptsCourseFindCourseName As Long = 1110
Public Const cptsCourseFindCourseID As Long = 1101
Public Const cptsCourseFindStatus As Long = 1111
Public Const cptsCourseFindCourseDate As Long = 1118

'-----enum Status constants
Public Const cptsCourseStatusPending As Long = 1
Public Const cptsCourseStatusReview As Long = 2
Public Const cptsCourseStatusActive As Long = 3
Public Const cptsCourseStatusInActive As Long = 4

'-----enum CourseType constants
Public Const cptsCourseCourseTypePersonal As Long = 1
Public Const cptsCourseCourseTypeAcademic As Long = 2
Public Const cptsCourseCourseTypeProfessional As Long = 3
Public Const cptsCourseCourseTypeTechnical As Long = 4

'-----enum CourseLevel constants
Public Const cptsCourseCourseLevelBeginner As Long = 1
Public Const cptsCourseCourseLevelIntermediate As Long = 2
Public Const cptsCourseCourseLevelAdvanced As Long = 3
Public Const cptsCourseCourseLevelExpert As Long = 4