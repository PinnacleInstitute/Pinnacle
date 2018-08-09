Attribute VB_Name = "AdaptiveTestDB"
Option Explicit
Private Const cModName As String = "AdaptiveTestDB"

Public Function GetAnswers(bvMemberAssessID As Long, ByVal bvUserID As Long) As ptsAssessAnswerUser.CAssessAnswers
    Dim UserService As ptsAssessAnswerUser.CAssessAnswers

    Set UserService = New ptsAssessAnswerUser.CAssessAnswers
    UserService.ListAssessment bvMemberAssessID, bvUserID

    Set GetAnswers = UserService
End Function

Public Function GetQuestion(bvAssessQuestionID As Long, ByVal bvUserID As Long) As ptsAssessQuestionUser.CAssessQuestion
    Dim UserService As ptsAssessQuestionUser.CAssessQuestion

    Set UserService = New ptsAssessQuestionUser.CAssessQuestion
    UserService.Load bvAssessQuestionID, bvUserID

    Set GetQuestion = UserService
End Function

Public Function GetGroup(bvGroupMin As Double, bvGroupMax As Double, bvAssessQuestionID As Long) As Long
    Dim UserService As ptsAssessQuestionUser.CAssessQuestion

    Set UserService = New ptsAssessQuestionUser.CAssessQuestion
    
    GetGroup = UserService.CATGroupCount(bvAssessQuestionID, bvGroupMin, bvGroupMax)

    Set UserService = Nothing
End Function

Public Function GetGroupCorrect(bvGroupMin As Double, bvGroupMax As Double, bvAssessQuestionID As Long) As Long
    Dim UserService As ptsAssessQuestionUser.CAssessQuestion

    Set UserService = New ptsAssessQuestionUser.CAssessQuestion
    
    GetGroupCorrect = UserService.CATGroupCorrectCount(bvAssessQuestionID, bvGroupMin, bvGroupMax)

    Set UserService = Nothing
End Function

