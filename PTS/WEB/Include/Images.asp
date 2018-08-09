<%
Function CreateThumbNail(byval bvFilename, byval bvWidth, byval bvHeight, byval bvTarget)
	On Error Resume Next
	
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH")

	bvFilename = FilePath + bvFilename

	ToFilename = bvTarget
	pos = InStr(bvTarget, "." )
	If pos = 0 Then
		pos = InStr(bvFilename, "." )
		If pos > 0 Then
			ToFilename = Left(bvFilename, pos-1) + bvTarget + Mid(bvFilename, pos)
		Else   
			ToFilename = bvFilename + bvTarget + ".jpg"
		End If
	Else	
		ToFilename = FilePath + ToFilename
	End If

	Set img = CreateObject("ImageMagickObject.MagickImage.1")

	If bvWidth > 0 And bvHeight > 0 Then
		If bvHeight < bvWidth Then
			p1 = bvFilename
			p2 = "-resize"	
			p3 = CStr(bvWidth) + "x"
			p4 = "-resize"	
			p5 = "x<" + CStr(bvHeight)
			p6 = "-gravity"	
			p7 = "center"	
			p8 = "-extent"	
			p9 = CStr(bvWidth) + "x" + CStr(bvHeight)	
			p10 = ToFilename
			msgs = img.Convert(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 )
		Else
			p1 = bvFilename
			p2 = "-resize"	
			p3 = "x" + CStr(bvHeight)
			p4 = "-resize"	
			p5 = CStr(bvWidth) + "x<"
			p6 = "-gravity"	
			p7 = "center"	
			p8 = "-extent"	
			p9 = CStr(bvWidth) + "x" + CStr(bvHeight)	
			p10 = ToFilename
			msgs = img.Convert(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 )
		End If
	End If
	If bvWidth > 0 And bvHeight = 0 Then
		p1 = bvFilename
		p2 = "-resize"	
		p3 = CStr(bvWidth) + "x"
		p4 = ToFilename
		msgs = img.Convert(p1, p2, p3, p4)
	End If
	If bvWidth = 0 And bvHeight > 0 Then
		p1 = bvFilename
		p2 = "-resize"	
		p3 = "x" + CStr(bvHeight)
		p4 = ToFilename
		msgs = img.Convert(p1, p2, p3, p4)
	End If

	Set img = Nothing


	CreateThumbNail = ToFilename
    
End Function


%>

