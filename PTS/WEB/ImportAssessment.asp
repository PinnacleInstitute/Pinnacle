<!--#include file="Include\System.asp"-->
<%
On Error Resume Next
TrainerID = Numeric(Request.Item("TrainerID"))
CompanyID = Numeric(Request.Item("CompanyID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Import\Assessment\"

Dim oData, oFileSys, oHTMLFile, oFolder, cnt

Set oFileSys = CreateObject("Scripting.FileSystemObject")
If oFileSys Is Nothing Then
	Response.Write "Scripting.FileSystemObject failed to load"
	Response.End
End If
Set oFolder = oFileSys.GetFolder(Path)
If oFolder Is Nothing Then
	Response.Write "Couldn't open folder: " + Path
	Response.End
End If
Set oAssessment = server.CreateObject("ptsAssessmentUser.CAssessment")
If oAssessment Is Nothing Then
	Response.Write "Unable to Create Object - ptsAssessmentUser.CAssessment"
	Response.End
End If
Set oAssessQuestion = server.CreateObject("ptsAssessQuestionUser.CAssessQuestion")
If oAssessQuestion Is Nothing Then
	Response.Write "Unable to Create Object - ptsAssessQuestionUser.CAssessQuestion"
	Response.End
End If
Set oAssessChoice = server.CreateObject("ptsAssessChoiceUser.CAssessChoice")
If oAssessChoice Is Nothing Then
	Response.Write "Unable to Create Object - ptsAssessChoiceUser.CAssessChoice"
	Response.End
End If
Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
If oHTMLFile Is Nothing Then
	Response.Write "Unable to Create Object - wtHTMLFile.CHTMLFile"
	Response.End
End If

cnt = 0
For Each x in oFolder.Files

	Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
	oData.load Path + x.Name
	If oData.parseError <> 0 Then
		Response.Write "Import file " + x.Name + " failed with error code " + CStr(oData.parseError)
		Response.End
	End If

	ReadAssessment oData.selectSingleNode("ASSESSMENT")
	cnt = cnt + 1
	
	Set oData = Nothing
Next

Set oHTMLFile = Nothing
Set oAssessChoice = Nothing
Set oAssessQuestion = Nothing
Set oAssessment = Nothing
Set oFolder = Nothing
Set oFileSys = Nothing

Response.Redirect "31Import.asp?Txn=1&Cnt=" & cnt

'*******************************************************************************************
Function ReadAssessment( poData )
	On Error Resume Next
	
	With oAssessment
		.TrainerID = TrainerID
		.CompanyID = CompanyID
		.FirstQuestionCode = poData.getAttribute("firstquestioncode")
		.AssessmentName = LEFT(poData.getAttribute("assessmentname"),60)
		.Description = poData.getAttribute("description")
		.Courses = poData.getAttribute("courses")
		.Assessments = poData.getAttribute("assessments")
		.AssessDate = poData.getAttribute("assessdate")
		.Status = poData.getAttribute("status")
		.AssessmentType = poData.getAttribute("assessmenttype")
		.NewURL = poData.getAttribute("newurl")
		.EditURL = poData.getAttribute("editurl")
		.ResultType = poData.getAttribute("resulttype")
		.Formula = poData.getAttribute("formula")
		.CustomCode = poData.getAttribute("customcode")
		.Takes = poData.getAttribute("takes")
		.Delay = poData.getAttribute("delay")
		.IsTrial = poData.getAttribute("istrial")
		.IsPaid = poData.getAttribute("ispaid")
		.IsCertify = poData.getAttribute("iscertify")
		.AssessType = poData.getAttribute("assesstype")
		.AssessLevel = poData.getAttribute("assesslevel")
		.AssessLength = poData.getAttribute("assesslength")
		.ScoreFactor = poData.getAttribute("scorefactor")
		.Rating = poData.getAttribute("rating")
		.Grade = poData.getAttribute("grade")
		.Points = poData.getAttribute("points")
		.TimeLimit = poData.getAttribute("timelimit")
		.NoCertificate = poData.getAttribute("nocertificate")
		.IsCustomCertificate = poData.getAttribute("iscustomcertificate")
		AssessmentID = .Add( 1 )
	End With

	oFileSys.CreateFolder reqSysWebDirectory + "Sections\Assessment\" + CStr(AssessmentID)
	
	With oHTMLFile
		.Path = reqSysWebDirectory + "Sections\Assessment\" + CStr(AssessmentID)
		.Language = "en"
		If Not (poData.selectSingleNode("INSTRUCTION") Is Nothing) Then 
			.Filename = "Instruction.htm"
			.Data = Trim(poData.selectSingleNode("INSTRUCTION/comment()").Text)
			.Save
		End If
		If Not (poData.selectSingleNode("RESULT") Is Nothing) Then 
			.Filename = "Result.htm"
			.Data = Trim(poData.selectSingleNode("RESULT/comment()").Text)
			.Save
		End If
		If Not (poData.selectSingleNode("CERTIFICATE") Is Nothing) Then 
			.Filename = "Certificate.htm"
			.Data = Trim(poData.selectSingleNode("CERTIFICATE/comment()").Text)
			.Save
		End If
	End With

	For Each oQuestion In poData.selectNodes("QUESTION")
		Question = oQuestion.getAttribute("question")
		If Question <> "" Then
			With oAssessQuestion
				.AssessmentID = AssessmentID
				.Question = oQuestion.getAttribute("question")
				.Grp = oQuestion.getAttribute("grp")
				.Seq = oQuestion.getAttribute("seq")
				.QuestionType = oQuestion.getAttribute("questiontype")
				.RankMin = oQuestion.getAttribute("rankmin")
				.RankMax = oQuestion.getAttribute("rankmax")
				.ResultType = oQuestion.getAttribute("resulttype")
				.Answer = oQuestion.getAttribute("answer")
				.Points = oQuestion.getAttribute("points")
				.NextType = oQuestion.getAttribute("nexttype")
				.NextQuestion = oQuestion.getAttribute("nextquestion")
				.Formula = oQuestion.getAttribute("formula")
				.CustomCode = oQuestion.getAttribute("customcode")
				.MultiSelect = oQuestion.getAttribute("multiselect")
				.MediaType = oQuestion.getAttribute("mediatype")
				.MediaFile = oQuestion.getAttribute("mediafile")
				.Courses = oQuestion.getAttribute("courses")
				.Status = oQuestion.getAttribute("status")
				.Description = ""
				.Description = Trim(oQuestion.selectSingleNode("DESCRIPTION/comment()").Text)
				AssessQuestionID = .Add( 1 )
			End With

			For Each oChoice In oQuestion.selectNodes("CHOICE")
				Choice = oChoice.getAttribute("choice")
				If Choice <> "" Then
					With oAssessChoice
						.AssessQuestionID = AssessQuestionID
						.Choice = oChoice.getAttribute("choice")
						.Seq = oChoice.getAttribute("seq")
						.Points = oChoice.getAttribute("points")
						.NextQuestion = oChoice.getAttribute("nextquestion")
						.Courses = oChoice.getAttribute("courses")
						AssessChoiceID = .Add( 1 )
					End With
				End If
			Next 
		End If
	Next 

End Function

%>