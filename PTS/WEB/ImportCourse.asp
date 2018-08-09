<!--#include file="Include\System.asp"-->
<%
On Error Resume Next
TrainerID = Numeric(Request.Item("TrainerID"))
CompanyID = Numeric(Request.Item("CompanyID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Import\Course\"

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
Set oCourse = server.CreateObject("ptsCourseUser.CCourse")
If oCourse Is Nothing Then
	Response.Write "Unable to Create Object - ptsCourseUser.CCourse"
	Response.End
End If
Set oLesson = server.CreateObject("ptsLessonUser.CLesson")
If oLesson Is Nothing Then
	Response.Write "Unable to Create Object - ptsLessonUser.CLesson"
	Response.End
End If
Set oAttachment = server.CreateObject("ptsAttachmentUser.CAttachment")
If oAttachment Is Nothing Then
	Response.Write "Unable to Create Object - ptsAttachmentUser.CAttachment"
	Response.End
End If
Set oQuizQuestion = server.CreateObject("ptsQuizQuestionUser.CQuizQuestion")
If oQuizQuestion Is Nothing Then
	Response.Write "Unable to Create Object - ptsQuizQuestionUser.CQuizQuestion"
	Response.End
End If
Set oQuizChoice = server.CreateObject("ptsQuizChoiceUser.CQuizChoice")
If oQuizChoice Is Nothing Then
	Response.Write "Unable to Create Object - ptsQuizChoiceUser.CQuizChoice"
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

	ReadCourse oData.selectSingleNode("COURSE")
	cnt = cnt + 1
	
	Set oData = Nothing
Next

Set oHTMLFile = Nothing
Set oQuizChoice = Nothing
Set oQuizQuestion = Nothing
Set oAttachment = Nothing
Set oLesson = Nothing
Set oCourse = Nothing
Set oFolder = Nothing
Set oFileSys = Nothing

Response.Redirect "11Import.asp?Txn=1&Cnt=" & cnt

'*******************************************************************************************
Function ReadCourse( poData )
	On Error Resume Next
	
	With oCourse
		.TrainerID = TrainerID
		.CompanyID = CompanyID
		.CourseName = poData.getAttribute("coursename")
		.Status = poData.getAttribute("status")
		.CourseType = poData.getAttribute("coursetype")
		.CourseLevel = poData.getAttribute("courselevel")
		.Description = poData.getAttribute("description")
		.Language = poData.getAttribute("language")
		.CourseLength = poData.getAttribute("courselength")
		.CourseDate = poData.getAttribute("coursedate")
		.IsPaid = poData.getAttribute("ispaid")
		.Price = poData.getAttribute("price")
		.Grp = poData.getAttribute("grp")
		.Seq = poData.getAttribute("seq")
		.PassingGrade = poData.getAttribute("passinggrade")
		.Rating = poData.getAttribute("rating")
		.RatingCnt = poData.getAttribute("ratingcnt")
		.Classes = poData.getAttribute("classes")
		.Video = poData.getAttribute("video")
		.Audio = poData.getAttribute("audio")
		.Quiz = poData.getAttribute("quiz")
		.Reference = poData.getAttribute("reference")
		.ScoreFactor = poData.getAttribute("scorefactor")
		.NoCertificate = poData.getAttribute("nocertificate")
		.NoEvaluation = poData.getAttribute("noevaluation")
		.IsCustomCertificate = poData.getAttribute("iscustomcertificate")
		CourseID = .Add( 1 )
	End With

	oFileSys.CreateFolder reqSysWebDirectory + "Sections\Course\" + CStr(CourseID)
	
	With oHTMLFile
		.Path = reqSysWebDirectory + "Sections\Course\" + CStr(CourseID)
		.Language = "en"
		If Not (poData.selectSingleNode("DESCRIPTION") Is Nothing) Then 
			.Filename = "Description.htm"
			.Data = Trim(poData.selectSingleNode("DESCRIPTION/comment()").Text)
			.Save
		End If
		If Not (poData.selectSingleNode("CERTIFICATE") Is Nothing) Then 
			.Filename = "Certificate.htm"
			.Data = Trim(poData.selectSingleNode("CERTIFICATE/comment()").Text)
			.Save
		End If
	End With

	For Each nLesson In poData.selectNodes("LESSON")
		LessonName = nLesson.getAttribute("lessonname")
		If LessonName <> "" Then
			With oLesson
				.CourseID = CourseID
				.LessonName = nLesson.getAttribute("lessonname")
				.Description = nLesson.getAttribute("description")
				.Status = nLesson.getAttribute("status")
				.LessonLength = nLesson.getAttribute("lessonlength")
				.Seq = nLesson.getAttribute("seq")
				.MediaURL = nLesson.getAttribute("mediaurl")
				.MediaType = nLesson.getAttribute("mediatype")
				.MediaLength = nLesson.getAttribute("medialength")
				.MediaWidth = nLesson.getAttribute("mediawidth")
				.MediaHeight = nLesson.getAttribute("mediaheight")
				.Content = nLesson.getAttribute("content")
				.Quiz = nLesson.getAttribute("quiz")
				.QuizLimit = nLesson.getAttribute("quizlimit")
				.QuizLength = nLesson.getAttribute("quizlength")
				.PassingGrade = nLesson.getAttribute("passinggrade")
				.QuizWeight = nLesson.getAttribute("quizweight")
				.IsPassQuiz = nLesson.getAttribute("ispassquiz")
				LessonID = .Add( 1 )

				With oHTMLFile
					.Path = reqSysWebDirectory + "Sections\Course\" + CStr(CourseID)
					.Language = "en"
					If Not (nLesson.selectSingleNode("CONTENT") Is Nothing) Then 
						.Filename = CStr(LessonID) + ".htm"
						.Data = Trim(nLesson.selectSingleNode("CONTENT/comment()").Text)
						.Save
					End If
					If Not (nLesson.selectSingleNode("QUIZ") Is Nothing) Then 
						.Filename = CStr(LessonID) + "q.htm"
						.Data = Trim(nLesson.selectSingleNode("QUIZ/comment()").Text)
						.Save
					End If
				End With

			End With

			For Each nAttachment In nLesson.selectNodes("ATTACHMENT")
				AttachName = nAttachment.getAttribute("attachname")
				If AttachName <> "" Then
					With oAttachment
						.ParentID = LessonID
						.AttachName = nAttachment.getAttribute("attachname")
						.FileName = nAttachment.getAttribute("filename")
						.Description = nAttachment.getAttribute("description")
						.ParentType = nAttachment.getAttribute("parenttype")
						.AttachSize = nAttachment.getAttribute("attachsize")
						.AttachDate = nAttachment.getAttribute("attachdate")
						.ExpireDate = nAttachment.getAttribute("expiredate")
						.Status = nAttachment.getAttribute("status")
						.IsLink = nAttachment.getAttribute("islink")
						.Secure = nAttachment.getAttribute("secure")
						'Get CompanyID from ParentType and ParentID
				        .CompanyID = .GetCompanyID(.ParentType, .ParentID)
						AttachmentID = .Add( 1 )
					End With
				End If
			Next 

			For Each nQuestion In nLesson.selectNodes("QUESTION")
				Question = nQuestion.getAttribute("question")
				If Question <> "" Then
					With oQuizQuestion
						.LessonID = LessonID
						tmpQuizChoiceID = nQuestion.getAttribute("quizchoiceid")
						.QuizChoiceID = 0
						.Question = nQuestion.getAttribute("question")
						.Explain = nQuestion.getAttribute("explain")
						.Points = nQuestion.getAttribute("points")
						.IsRandom = nQuestion.getAttribute("israndom")
						.Seq = nQuestion.getAttribute("seq")
						.MediaType = nQuestion.getAttribute("mediatype")
						.MediaFile = nQuestion.getAttribute("mediafile")
						QuizQuestionID = .Add( 1 )
					End With

					For Each nChoice In nQuestion.selectNodes("CHOICE")
						QuizChoiceText = nChoice.getAttribute("quizchoicetext")
						If QuizChoiceText <> "" Then
							With oQuizChoice
								.QuizQuestionID = QuizQuestionID
								oldQuizChoiceID = nChoice.getAttribute("quizchoiceid")
								.QuizChoiceText = nChoice.getAttribute("quizchoicetext")
								.Seq = nChoice.getAttribute("seq")
								QuizChoiceID = .Add( 1 )
							End With
							'Set the correct choice for the question
							If tmpQuizChoiceID > 0 AND tmpQuizChoiceID = oldQuizChoiceID Then
								With oQuizQuestion
									.QuizChoiceID = QuizChoiceID
									.Save( 1 )
								End With
							End If
						End If
					Next 
				End If
			Next 
		End If
	Next 

End Function

%>