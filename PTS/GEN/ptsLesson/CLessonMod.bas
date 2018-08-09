Attribute VB_Name = "CLessonMod"
Option Explicit
'-----constants
Private Const cModName As String = "CLessonMod"

'-----enum item type constants
Public Const cptsLessonEnumStatus As Long = 2312
Public Const cptsLessonEnumMediaType As Long = 2321
Public Const cptsLessonEnumContent As Long = 2330
Public Const cptsLessonEnumQuiz As Long = 2331
Public Const cptsLessonEnumQuizLimit As Long = 2332

'-----enum Status constants
Public Const cptsLessonStatusInActive As Long = 1
Public Const cptsLessonStatusActive As Long = 2

'-----enum MediaType constants
Public Const cptsLessonMediaTypeVideo As Long = 1
Public Const cptsLessonMediaTypeAudio As Long = 2
Public Const cptsLessonMediaTypeLink As Long = 3
Public Const cptsLessonMediaTypeEmbed As Long = 4

'-----enum Content constants
Public Const cptsLessonContentNoContent As Long = 1
Public Const cptsLessonContentContentAbove As Long = 2
Public Const cptsLessonContentContentBelow As Long = 3
Public Const cptsLessonContentContentBoth As Long = 4

'-----enum Quiz constants
Public Const cptsLessonQuizNoQuiz As Long = 1
Public Const cptsLessonQuizHasQuiz As Long = 2
Public Const cptsLessonQuizAutoQuiz As Long = 3

'-----enum QuizLimit constants
Public Const cptsLessonQuizLimitNoRetake As Long = 1
Public Const cptsLessonQuizLimitNoAnswer As Long = 2