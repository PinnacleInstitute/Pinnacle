<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
On Error Resume Next

AssessmentID = Numeric(Request.Item("AssessmentID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Export\Assessment\"

Dim oFileSys, oFile, oHTMLFile

Set oAssessment = server.CreateObject("ptsAssessmentUser.CAssessment")
If oAssessment Is Nothing Then
	Response.Write "Unable to Create Object - ptsAssessmentUser.CAssessment"
	Response.End
End If
With oAssessment
	.Load AssessmentID, 1
	File = CleanFileName(.AssessmentName) + ".xml"
End With
Set oAssessment = Nothing

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

WriteAssessment AssessmentID

oFile.Close

Set oHTMLFile = Nothing
Set oFile = Nothing
Set oFileSys = Nothing

Response.Write "<BR><BR>     Successfully Exported - " + Path + File 
Response.End

'*******************************************************************************************
Function WriteAssessment( pAssessmentID )
	On Error Resume Next
	Dim oAssessment, oQuestions, oChoices

	Set oAssessment = server.CreateObject("ptsAssessmentUser.CAssessment")
	If oAssessment Is Nothing Then
		Response.Write "Unable to Create Object - ptsAssessmentUser.CAssessment"
		Response.End
	End If
	Set oQuestions = server.CreateObject("ptsAssessQuestionUser.CAssessQuestions")
	If oQuestions Is Nothing Then
		Response.Write "Unable to Create Object - ptsAssessQuestionUser.CAssessQuestions"
		Response.End
	End If
	Set oChoices = server.CreateObject("ptsAssessChoiceUser.CAssessChoices")
	If oChoices Is Nothing Then
		Response.Write "Unable to Create Object - ptsAssessChoiceUser.CAssessChoices"
		Response.End
	End If

	With oAssessment
		.Load pAssessmentID, 1

		oFile.WriteLine( "<ASSESSMENT" & _
		" firstquestioncode=""" & .FirstQuestionCode & """" & _
		" assessmentname=""" & CleanXML(.AssessmentName) & """" &  _
		" description=""" & CleanXML(.Description) & """" & _
		" courses=""" & CleanXML(.Courses) & """" & _
		" assessments=""" & CleanXML(.Assessments) & """" & _
		" assessdate=""" & .AssessDate & """" &  _
		" status=""" & .Status & """" & _
		" assessmenttype=""" & .AssessmentType & """" & _
		" newurl=""" & CleanXML(.NewURL) & """" & _
		" editurl=""" & CleanXML(.EditURL) & """" & _
		" resulttype=""" & .ResultType & """" & _
		" formula=""" & CleanXML(.Formula) & """" & _
		" customcode=""" & .CustomCode & """" & _
		" takes=""" & .Takes & """" & _
		" delay=""" & .Delay & """" & _
		" istrial=""" & ABS(.IsTrial) & """" & _
		" ispaid=""" & ABS(.IsPaid) & """" & _
		" iscertify=""" & ABS(.IsCertify) & """" &  _
		" assesstype=""" & .AssessType & """" & _
		" assesslevel=""" & .AssessLevel & """" & _
		" assesslength=""" & .AssessLength & """" & _
		" scorefactor=""" & .ScoreFactor & """" & _
		" rating=""" & .Rating & """" & _
		" grade=""" & .Grade & """" & _
		" points=""" & .Points & """" & _
		" timelimit=""" & .TimeLimit & """" & _
		" nocertificate=""" & ABS(.NoCertificate) & """" & _
		" iscustomcertificate=""" & ABS(.IsCustomCertificate) & """" & _
		">" )

		With oHTMLFile
			.Filename = "Instruction.htm"
			.Path = reqSysWebDirectory + "Sections\Assessment\" + CStr(pAssessmentID)
			.Language = "en"
			.Load
			If Trim(.Data) <> "" Then 
				oFile.WriteLine( "<INSTRUCTION><!--  " + .Data + "  --></INSTRUCTION>" )
			End If
			.Filename = "Result.htm"
			.Load 
			If Trim(.Data) <> "" Then 
				oFile.WriteLine( "<RESULT><!--  " + .Data + "  --></RESULT>" )
			End If
			.Filename = "Certificate.htm"
			.Load 
			If Trim(.Data) <> "" Then 
				oFile.WriteLine( "<CERTIFICATE><!--  " + .Data + "  --></CERTIFICATE>" )
			End If
		End With

		oQuestions.ListAssessment pAssessmentID, 1
		For Each oQuestion in oQuestions
			With oQuestion
				oFile.WriteLine( "<QUESTION " & _
				" question=""" & CleanXML(.Question) & """" & _
				" grp=""" & .Grp & """" & _
				" seq=""" & .Seq & """" & _
				" questiontype=""" & .QuestionType & """" & _
				" rankmin=""" & .RankMin & """" & _
				" rankmax=""" & .RankMax & """" & _
				" resulttype=""" & .ResultType & """" & _
				" answer=""" & .Answer & """" & _
				" points=""" & .Points & """" & _
				" nexttype=""" & .NextType & """" & _
				" nextquestion=""" & .NextQuestion & """" & _
				" formula=""" & CleanXML(.Formula) & """" & _
				" customcode=""" & .CustomCode & """" & _
				" multiselect=""" & ABS(.MultiSelect) & """" & _
				" mediatype=""" & .MediaType & """" & _
				" mediafile=""" & CleanXML(.MediaFile) & """" & _
				" courses=""" & CleanXML(.Courses) & """" & _
				" status=""" & .Status & """" & _
				">" )

				If .Description <> "" Then
					oFile.WriteLine( "<DESCRIPTION><!--  " + .Description + "  --></DESCRIPTION>" )
				End If

				oChoices.ListAssessQuestion oQuestion.AssessQuestionID, 1
				For Each oChoice in oChoices
					With oChoice
						oFile.WriteLine( "<CHOICE " & _
						" choice=""" & CleanXML(.Choice) & """" & _
						" seq=""" & .Seq & """" & _
						" points=""" & .Points & """" & _
						" nextquestion=""" & .NextQuestion & """" & _
						" courses=""" & CleanXML(.Courses) & """" & _
						"/>" )
					End With
				Next

				oFile.WriteLine( "</QUESTION>" )

			End With
		Next
       		
		oFile.WriteLine( "</ASSESSMENT>" )

	End With

	Set oChoices = Nothing
	Set oQuestions = Nothing
	Set oAssessment = Nothing

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