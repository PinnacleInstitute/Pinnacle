<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
On Error Resume Next

CourseID = Numeric(Request.Item("CourseID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Export\Course\"

Dim oFileSys, oFile, oHTMLFile

Set oCourse = server.CreateObject("ptsCourseUser.CCourse")
If oCourse Is Nothing Then
	Response.Write "Unable to Create Object - ptsCourseUser.CCourse"
	Response.End
End If
With oCourse
	.Load CourseID, 1
	File = CleanFileName(.CourseName) + ".xml"
End With
Set oCourse = Nothing

Set oFileSys = CreateObject("Scripting.FileSystemObject")
If oFileSys Is Nothing Then
	Response.Write "Scripting.FileSystemObject failed to load"
	Response.End
End If
Set oFile = oFileSys.CreateTextFile(Path+File, True)
If oFile Is Nothing Then
	Response.Write "Couldn't create file: " + Path + File
	Response.End
End If
Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
If oHTMLFile Is Nothing Then
	Response.Write "Unable to Create Object - wtHTMLFile.CHTMLFile"
	Response.End
End If

oFile.WriteLine( "<?xml version='1.0' encoding='windows-1252'?>" )

WriteCourse CourseID

oFile.Close

Set oHTMLFile = Nothing
Set oFile = Nothing
Set oFileSys = Nothing

Response.Write "<BR><BR>     Successfully Exported - " + Path + File 
Response.End

'*******************************************************************************************
Function WriteCourse( pCourseID )
	On Error Resume Next
	Dim oCourse, oLessons, oAttachments

	Set oCourse = server.CreateObject("ptsCourseUser.CCourse")
	If oCourse Is Nothing Then
		Response.Write "Unable to Create Object - ptsCourseUser.CCourse"
		Response.End
	End If
	Set oLessons = server.CreateObject("ptsLessonUser.CLessons")
	If oLessons Is Nothing Then
		Response.Write "Unable to Create Object - ptsLessonUser.CLessons"
		Response.End
	End If
	Set oAttachments = server.CreateObject("ptsAttachmentUser.CAttachments")
	If oAttachments Is Nothing Then
		Response.Write "Unable to Create Object - ptsAttachmentUser.CAttachments"
		Response.End
	End If
	Set oQuizQuestions = server.CreateObject("ptsQuizQuestionUser.CQuizQuestions")
	If oQuizQuestions Is Nothing Then
		Response.Write "Unable to Create Object - ptsQuizQuestionUser.CQuizQuestions"
		Response.End
	End If
	Set oQuizChoices = server.CreateObject("ptsQuizChoiceUser.CQuizChoices")
	If oQuizChoices Is Nothing Then
		Response.Write "Unable to Create Object - ptsQuizChoiceUser.CQuizChoices"
		Response.End
	End If

	With oCourse
		.Load pCourseID, 1

		oFile.WriteLine( "<COURSE" & _
		" coursename=""" & CleanXML(.CourseName) & """" &  _
		" status=""" & .Status & """" & _
		" coursetype=""" & .CourseType & """" & _
		" courselevel=""" & .CourseLevel & """" & _
		" description=""" & CleanXML(.Description) & """" & _
		" language=""" & CleanXML(.Language) & """" & _
		" courselength=""" & .CourseLength & """" &  _
		" coursedate=""" & .CourseDate & """" &  _
		" ispaid=""" & ABS(.IsPaid) & """" &  _
		" price=""" & .Price & """" &  _
		" grp=""" & .Grp & """" &  _
		" seq=""" & .Seq & """" &  _
		" passinggrade=""" & .PassingGrade & """" &  _
		" rating=""" & .Rating & """" &  _
		" ratingcnt=""" & .RatingCnt & """" &  _
		" classes=""" & .Classes & """" &  _
		" video=""" & ABS(.Video) & """" &  _
		" audio=""" & ABS(.Audio) & """" &  _
		" quiz=""" & ABS(.Quiz) & """" &  _
		" reference=""" & CleanXML(.Reference) & """" & _
		" scorefactor=""" & .ScoreFactor & """" &  _
		" nocertificate=""" & ABS(.NoCertificate) & """" &  _
		" noevaluation=""" & ABS(.NoEvaluation) & """" &  _
		" iscustomcertificate=""" & ABS(.IsCustomCertificate) & """" & _
		">" )

		With oHTMLFile
			.Path = reqSysWebDirectory + "Sections\Course\" + CStr(pCourseID)
			.Language = "en"
			.Filename = "Description.htm"
			.Load
			If Trim(.Data) <> "" Then 
				oFile.WriteLine( "<DESCRIPTION><!--  " + .Data + "  --></DESCRIPTION>" )
			End If
			.Filename = "Certificate.htm"
			.Load 
			If Trim(.Data) <> "" Then 
				oFile.WriteLine( "<CERTIFICATE><!--  " + .Data + "  --></CERTIFICATE>" )
			End If
		End With

		oLessons.ListCourse pCourseID, 1
		For Each oLesson in oLessons
			With oLesson
				.Load .LessonID, 1
				oFile.WriteLine( "<LESSON " & _
				" lessonname=""" & CleanXML(.LessonName) & """" & _
				" description=""" & CleanXML(.Description) & """" & _
				" status=""" & .Status & """" & _
				" lessonlength=""" & .LessonLength & """" & _
				" seq=""" & .Seq & """" & _
				" mediaurl=""" & CleanXML(.MediaURL) & """" & _
				" mediatype=""" & .MediaType & """" & _
				" medialength=""" & .MediaLength & """" & _
				" mediawidth=""" & .MediaWidth & """" & _
				" mediaheight=""" & .MediaHeight & """" & _
				" content=""" & .Content & """" & _
				" quiz=""" & .Quiz & """" & _
				" quizlimit=""" & .QuizLimit & """" & _
				" quizlength=""" & .QuizLength & """" & _
				" passinggrade=""" & .PassingGrade & """" & _
				" quizweight=""" & .QuizWeight & """" & _
				" ispassquiz=""" & ABS(.IsPassQuiz) & """" & _
				">" )

				With oHTMLFile
					.Path = reqSysWebDirectory + "Sections\Course\" + CStr(pCourseID)
					.Language = "en"
					.Filename = CStr(oLesson.LessonID) + ".htm"
					.Load
					If Trim(.Data) <> "" Then 
						oFile.WriteLine( "<CONTENT><!--  " + .Data + "  --></CONTENT>" )
					End If
					.Filename = CStr(oLesson.LessonID) + "q.htm"
					.Load
					If Trim(.Data) <> "" Then 
						oFile.WriteLine( "<QUIZ><!--  " + .Data + "  --></QUIZ>" )
					End If
				End With

				oAttachments.ListAttachments oLesson.LessonID, 23, 1
				For Each oAttachment in oAttachments
					With oAttachment
						oFile.WriteLine( "<ATTACHMENT " & _
						" attachname=""" & CleanXML(.AttachName) & """" & _
						" filename=""" & CleanXML(.FileName) & """" & _
						" description=""" & CleanXML(.Description) & """" & _
						" parenttype=""" & .ParentType & """" & _
						" attachsize=""" & .AttachSize & """" & _
						" attachdate=""" & .AttachDate & """" & _
						" expiredate=""" & .ExpireDate & """" & _
						" status=""" & .Status & """" & _
						" islink=""" & ABS(.IsLink) & """" & _
						" secure=""" & .Secure & """" & _
						"/>" )
					End With
				Next

				oQuizQuestions.ListQuizQuestion oLesson.LessonID, 1
				For Each oQuizQuestion in oQuizQuestions
					With oQuizQuestion
						oFile.WriteLine( "<QUESTION " & _
						" quizchoiceid=""" & .QuizChoiceID & """" & _
						" question=""" & CleanXML(.Question) & """" & _
						" explain=""" & CleanXML(.Explain) & """" & _
						" points=""" & .Points & """" & _
						" israndom=""" & ABS(.IsRandom) & """" & _
						" seq=""" & .Seq & """" & _
						" mediatype=""" & .MediaType & """" & _
						" mediafile=""" & CleanXML(.MediaFile) & """" & _
						">" )

						oQuizChoices.ListQuizChoice oQuizQuestion.QuizQuestionID, 1
						For Each oQuizChoice in oQuizChoices
							With oQuizChoice
								oFile.WriteLine( "<CHOICE " & _
								" quizchoiceid=""" & .QuizChoiceID & """" & _
								" quizchoicetext=""" & CleanXML(.QuizChoiceText) & """" & _
								" seq=""" & .Seq & """" & _
								"/>" )
							End With
						Next

						oFile.WriteLine( "</QUESTION>" )

					End With
				Next

				oFile.WriteLine( "</LESSON>" )

			End With
		Next
       		
		oFile.WriteLine( "</COURSE>" )

	End With

	Set oQuizChoices = Nothing
	Set oQuizQuestions = Nothing
	Set oAttachments = Nothing
	Set oLessons = Nothing
	Set oCourse = Nothing

End Function

'*******************************************************************************************
Function CleanFileName( pFilename )
	On Error Resume Next
	Dim File, x, total, c

	FILENAME_CHARACTERS = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'-_/"

	total = Len( pFilename)
	File = ""
	
	For x = 1 to total
		c = Mid(pFilename, x, 1)
		If InStr( FILENAME_CHARACTERS, c ) > 0 Then 
			File = File + c
		Else
			File = File + "_"
		End If	
	Next
	
	CleanFileName = File

End Function

%>