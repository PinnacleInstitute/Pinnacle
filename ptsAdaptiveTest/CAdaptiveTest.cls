VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CAdaptiveTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'-----CONSTANTS-----------------------------------------------
Private Const cModName As String = "CAdaptiveTest"

'-----error codes
Private Const cErrNoInputName As Long = vbObjectError + 1024

'-----math constants
Private Const cD As Double = -1.702 'First Normal Ogive scaling approximation
Private Const cEpsilon As Double = 0.0001 'Epsilon value determines precision of newtonian method

'-----app constants
Private Const cMinTheta As Double = -3.5
Private Const cMaxTheta As Double = 3.5
Private Const cCalibrateGranularity As Double = 0.2
'-------------------------------------------------------------

'-----properties


Private Sub Class_Terminate()

End Sub

'Probability function for 1PL Item Response
Private Function Probability1P(bvTheta As Double, _
                    bvB As Double) As Double
                    
    Dim L As Double
    
    L = Math.Exp(bvTheta - bvB)
    Probability1P = L / (1 + L)
End Function
'Probability function for 2PL Item Response
Private Function Probability2P(bvTheta As Double, _
                    bvA As Double, _
                    bvB As Double) As Double
                    
    Probability2P = 1 / (1 + Math.Exp(cD * bvA * (bvTheta - bvB)))
End Function

'Probability function for 3PL Item Response
Private Function Probability3P(bvTheta As Double, _
                    bvA As Double, _
                    bvB As Double, _
                    bvC As Double) As Double
                    
    Dim L As Double
    
    'P(theta, a, b, c) = c + (1-c)/(1+exp(-1.702a(theta-b))
    
    L = Math.Exp(cD * bvA * (bvTheta - bvB))
    Probability3P = bvC + ((1 - bvC) / (1 + L))
    'Probability3P = (bvC + L) / (1 + L)
End Function

'Item Information function for 1PL Item Response
Private Function Item1P(bvTheta As Double, _
                    bvProb As Double) As Double
                       
    Item1P = bvProb * (1 - bvProb)
End Function

'Item Information function for 3PL Item Response
Private Function Item3P(bvTheta As Double, _
                    bvA As Double, _
                    bvB As Double, _
                    bvC As Double, _
                    bvProb As Double) As Double
                    
    Dim L As Double
    L = (bvProb - bvC) / (1 - bvC)
    Item3P = (bvA * bvA) * ((1 - bvProb) / bvProb) * (L * L)
End Function

Private Function S3P(bvTheta As Double, _
                    ByRef brAnswers As ptsAssessAnswerUser.CAssessAnswers) As Double
                    
    Dim Answer As ptsAssessAnswerUser.CAssessAnswer
    Dim Prob2 As Double
    Dim Prob3 As Double
    Dim Total As Double
    Total = 0
    For Each Answer In brAnswers
        With Answer
            Prob2 = Probability3P(bvTheta, .Discrimination, .Difficulty, .Guessing)
            Prob3 = Probability2P(bvTheta, .Discrimination, .Difficulty)
            Total = Total + (.Discrimination * (Prob2 * (CDbl(.Score) - Prob3)) / Prob3)
        End With
    Next
    S3P = Total
End Function

'Calculates the standard error of a given theta for a set of answers
Private Function StandardError(bvTheta As Double, _
                    ByRef brAnswers As ptsAssessAnswerUser.CAssessAnswers) As Double
                    
    Dim Answer As ptsAssessAnswerUser.CAssessAnswer
    Dim SE As Double
    Dim Prob As Double
    SE = 0
    For Each Answer In brAnswers
        With Answer
            Prob = Probability3P(bvTheta, .Discrimination, .Difficulty, .Guessing)
            SE = SE + Item3P(bvTheta, .Discrimination, .Difficulty, .Guessing, Prob)
        End With
    Next
    If SE <> 0 Then
        SE = 1 / Math.Sqr(SE)
    End If
    StandardError = SE
End Function

'Calculates the Maximum Likelihood estimated ability score for a given set of answers
Private Function Ability(ByRef brAnswers As ptsAssessAnswerUser.CAssessAnswers) As Double
                    
    Dim Diff As Double
    Dim NewTheta As Double
    Dim Theta As Double
    Dim Upper As Double
    Dim Lower As Double
    Dim Average As Double
    Dim Counter As Integer
    
    'Initialize values before entering loop
    Diff = 2 * cEpsilon
    Upper = cMaxTheta
    Lower = cMinTheta
    Theta = S3P(Lower, brAnswers) 'initial estimate of proficiency level
    Counter = 0
    
    'Use the newtonian method to converge on the maximum likelihood estimation of theta
    Do While (Diff > cEpsilon) And (Counter < 15)
        Average = (Lower + Upper) / 2
        NewTheta = S3P(Average, brAnswers)
               
        'Calculate the difference in theta
        If NewTheta = 0 Then
            'Set end flag
            Diff = cEpsilon
        Else
            Diff = Math.Abs(Theta - NewTheta)
            If (Theta * NewTheta) > 0 Then
                Theta = NewTheta
                Lower = Average
            Else
                Upper = Average
            End If
        End If
        
        Counter = Counter + 1
    Loop
    
    'Bound Theta on (-cMinTheta, cMaxTheta)
    Theta = (Lower + Upper) / 2
    If (Theta < cMinTheta) Then Theta = cMinTheta
    If (Theta > cMaxTheta) Then Theta = cMaxTheta
    
    Ability = Theta
End Function

Private Function GetGroup(bvGroupMin As Double, bvGroupMax As Double, bvAssessQuestionID As Long) As ptsAssessAnswerUser.CAssessAnswers
    'TODO: this will call a stored procedure to retrieve the group of answers belonging to
    'members who have take a test with this question, and had an overall(?) ability
    'estimate between bvGroupMin and bvGroupMax
    
End Function

Private Function ProportionCorrect(ByRef brGroup As ptsAssessAnswerUser.CAssessAnswers) As Double

    Dim CorrectCount As Integer
    Dim TotalCount As Integer
    Dim Prop As Double
    Dim Answer As ptsAssessAnswerUser.CAssessAnswer
    
    CorrectCount = 0
    TotalCount = 0
    
    For Each Answer In brGroup
    With Answer
        If .Score <> 0 Then
            CorrectCount = CorrectCount + 1
        End If
        TotalCount = TotalCount + 1
    End With
    Next

    If TotalCount > 0 Then
        Prop = CorrectCount / TotalCount
    Else
        Prop = 0
    End If
    
    ProportionCorrect = Prop
    
End Function

'Returns the Chi-Squared Goodness of Fit index for the question, with all members who have taken
'a test with this question as a sample
Private Function GoodnessOfFit(bvAssessQuestionID As Long, ByVal bvUserID As Long) As Double

    Dim Counter As Double
    Dim Sum As Double
    Dim GroupCount As Integer
    Dim Correct As Double
    Dim Diff As Double
    Dim ProbCorrect As Double
    Dim GroupAnswers As ptsAssessAnswerUser.CAssessAnswers
    Dim Question As ptsAssessQuestionUser.CAssessQuestion
    
    Question = GetQuestion(bvAssessQuestionID, bvUserID)
    Counter = 0
    Sum = 0
    For Counter = cMinTheta To cMaxTheta Step cCalibrateGranularity
        Set GroupAnswers = GetGroup(Counter, (Counter + cCalibrateGranularity), bvAssessQuestionID)
        GroupCount = GroupAnswers.Count
        Correct = ProportionCorrect(GroupAnswers)
        ProbCorrect = Probability3P((Counter + (cCalibrateGranularity / 2)), Question.Discrimination, Question.Difficulty, Question.Guessing)
        
        Diff = Correct - ProbCorrect
        Sum = Sum + ((GroupCount * Diff * Diff) / (ProbCorrect * (1 - ProbCorrect)))
        
        Set GroupAnswers = Nothing
    Next Counter
    
    Question = Nothing
    
    GoodnessOfFit = Sum
End Function

'Calculate the next question in a computer adaptive test
Public Function NextQuestion(bvMemberAssessID As Long, ByVal bvUserID As Long) As Long
    Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
    Const cProcName As String = "GetAnswers"
    
    Dim Theta As Double
    Dim StdErr As Double
    Dim Answers As ptsAssessAnswerUser.CAssessAnswers

    On Error GoTo ErrorHandler
    
    'Initialize values before entering loop
    Set Answers = GetAnswers(bvMemberAssessID, bvUserID)
    
    'Calculate the Maximum Likelihood estimation of ability
    Theta = Ability(Answers)
    
    'Calculate standard error.
    'if user is above standard error, then mix in new questions for calibration
    StdErr = StandardError(Theta, Answers)
    
    'Find a random, unasked question with difficulty near the estimated theta value
    Dim UserService As ptsAssessQuestionUser.CAssessQuestion

    'Lookup the next question from the database
    Set UserService = New ptsAssessQuestionUser.CAssessQuestion
    NextQuestion = UserService.NextCATQuestion(bvMemberAssessID, Theta)
    
    Set UserService = Nothing
    Set Answers = Nothing
    
    Exit Function
   
ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub CalibrateQuestion(bvAssessQuestionID As Long, ByVal bvUserID As Long)
    Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
    Const cProcName As String = "CalibrateQuestion"
    
    On Error GoTo ErrorHandler
    
    
    
    Exit Sub
   
ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function Score(bvMemberAssessID As Long, ByVal bvUserID As Long) As Double
    Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
    Const cProcName As String = "Score"
    
    Dim Answers As ptsAssessAnswerUser.CAssessAnswers

    On Error GoTo ErrorHandler
    
    Set Answers = GetAnswers(bvMemberAssessID, bvUserID)
    
    Score = Ability(Answers)
    
    Set Answers = Nothing
    
    Exit Function
   
ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Function GetAnswers(bvMemberAssessID As Long, ByVal bvUserID As Long) As ptsAssessAnswerUser.CAssessAnswers
    Dim UserService As ptsAssessAnswerUser.CAssessAnswers

    Set UserService = New ptsAssessAnswerUser.CAssessAnswers
    UserService.ListAssessment bvMemberAssessID, bvUserID

    Set GetAnswers = UserService
End Function

Private Function GetQuestion(bvAssessQuestionID As Long, ByVal bvUserID As Long) As ptsAssessQuestionUser.CAssessQuestion
    Dim UserService As ptsAssessQuestionUser.CAssessQuestion

    Set UserService = New ptsAssessQuestionUser.CAssessQuestion
    UserService.Load bvAssessQuestionID, bvUserID

    Set GetQuestion = UserService
End Function
