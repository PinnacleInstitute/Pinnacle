<!--#include file="Cookies.asp"-->
<%
'Released under the (Modified) BSD license
'Copyright (c) 2002-2003, S Babu, vsbabu@vsbabu.org, http://vsbabu.org/
'All rights reserved.

'Modifications, security addon and adaptation to htmlArea released
'under the (Modified) BSD license
'Copyright (c) 2002-2003, P Engvall, pengvall@engvall.nu, http://www.engvall.nu/
'All rights reserved.

'Redistribution and use in source and binary forms, with or without modification, 
'are permitted provided that the following conditions are met:

'Redistributions of source code must retain the above copyright notice, this list 
'of conditions and the following disclaimer. 

'Redistributions in binary form must reproduce the above copyright notice, this list of 
'conditions and the following disclaimer in the documentation and/or other materials 
'provided with the distribution. 

'Neither the name of S Babu nor the names of its contributors may 
'be used to endorse or promote products derived from this software without specific 
'prior written permission. 

'THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
'OR IMPLIED WARRANTIES, 'INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
'MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 'DISCLAIMED. IN NO EVENT SHALL THE
'COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 'SPECIAL, 
'EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
'SUBSTITUTE GOODS OR 'SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
'HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 'WHETHER IN CONTRACT, STRICT LIABILITY, 
'OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 'USE OF THIS 
'SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


Dim asp_self
' 
' *** PatRaven Addition; strCurrentFolderSec, CurrentDir, CurrentCheck, CurrentCheckUcase, CurrentCheckLcase
Dim objFSO, strCurrentFolder, objFolder, strCurrentFolderSec, CurrentDir, CurrentCheck, CurrentCheckUcase, CurrentCheckLcase

' Constants
' What is the maximum size of a file in bytes? 0=Display every files size in bytes
' If you set this value to eg 100000 all files below 100000 will not have the show
' bytes text

Const MaxSize = 0

'What is the root of the site? Be careful. If you keep it as C:\ or something, hackers can
'easily go through your machine and download any file they choose to! The last \ is required

'Const strRootFolder = "c:\Inetpub\wwwroot\"
dim strRootFolder
strRootFolder = Request.Servervariables("APPL_PHYSICAL_PATH")

'dim reqSysServerPath
'reqSysServerPath = Request.ServerVariables("PATH_INFO")
'Response.Write strRootFolder
'Response.Write reqSysServerPath

'this script's name. It is better than hard coding :-)
asp_self = Request.Servervariables("PATH_INFO")

' Folder to browse in. Script should also be placed here. Notice that you can use "" here but because of
' security reasons we urge you not to set it to root

dim ImagePath
ImagePath = GetCache("IMAGEPATH")
If ImagePath <> "" Then
	strCurrentFolder = ImagePath
Else
	strCurrentFolder = "images\"
	dim ImageFolder
	ImageFolder = GetCache("IMAGEFOLDER")
	If ImageFolder <> "" Then
		strCurrentFolder = strCurrentFolder & ImageFolder & "/"
	End If
End If

' *** PatRaven Addition; Check security! Do not allow browsing to root, set folder to same as above
' *** Only checking if the path starts with a e.g a W or w (in e.g Wysiwyg)

strCurrentFolderSec = strCurrentFolder

Dim arrValidFileTypes
'This array determines what kind of file types are visible to the users
'MODIFIED 2/16/04 RAW
'arrValidFileTypes =  Array("html","htm","doc","pdf","xls","ppt","txt","jpg","gif")
arrValidFileTypes =  Array("jpg","gif")

Sub MainProcess()


CurrentDir = Request.QueryString("dir")
CurrentCheck = Left(strCurrentFolderSec, 1)  
CurrentCheckUcase = Ucase(CurrentCheck)
CurrentCheckLCase = LCase(CurrentCheck)

	If Request.QueryString("dir") <> "" Then
	strCurrentFolder = Request.QueryString("dir")
	End If


' *** PatRaven Addition; Security precaution do not allow to browse higher then strCurrentFolderSec
' *** Therefore we check if a folder is not containg the first letter from strCurrentFolderSec
' *** If true then we reset the folder to strCurrentFolderSec. We check upper and lowercase here.

	if not Left(CurrentDir, 1) = CurrentCheckUcase and not Left(CurrentDir, 1) = CurrentCheckLCase then
'	Response.Write "You are not permitted to browse this directory."
	strCurrentFolder = strCurrentFolderSec
	End If

	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFSO.GetFolder(strRootFolder & strCurrentFolder)

	DisplayDirectory objFolder

	'many thanks to Microsoft's memory management "features".
	Set objFSO = Nothing
	Set objFolder = Nothing
End Sub


''' The following is the main function here.
''' This guy shows the contents of a folder
''' and makes links to this script for showing the
''' contents of a sub folder
Sub DisplayDirectory(objFolder)

	Dim objFile, objSubFolder

	'make link(s) to the parent(s)
'	PrintHeaderLinks(CutRootFolder(objFolder.Path))

	'Now make links to see the sub folders
	For Each objSubFolder in objFolder.SubFolders
		Response.Write "<a href=""" & asp_self & "?dir="& Server.URLEncode(CutRootFolder(objSubFolder.Path)) &"""><img hspace=""2"" src=""images/closefold.gif"" alt=""expand"" border=""0""></a> " & objSubFolder.Name & "<BR>" & vbCrLf
		'''Iteration might be very time consuming for large directories
		'''If you choose to, you can experiment by uncommenting the
		'''line below. May be with a Javascript that can manipulate
		'''tree?
		'DisplayDirectory objSubFolder
	Next
	'Display every file in the folder, that matches the
	'extension given in arrValidFileTypes
	For Each objFile in objFolder.Files
		If UBound(Filter(arrValidFileTypes,GetExtension(objFile.Name),True,vbTextCompare)) = 0 Then
		' print an icon for the extension
		Response.Write "<img hspace=""2"" src=""images/" & GetExtension(objFile.Name) & ".gif"" border=""0"" alt="""">"
		''' make the link to copy it to some form field
		PrintCopyLink objFile.Path, objFile.Name
		'''Two samples for spicying up things
		'' You can keep a library of icons and using the file extension
		'' show the relevant icon
	    '''Here is a sample to see if the file is a restricted one
	    If GetExtension(objFile.Name) = "exe" then
			Response.Write " <b>EXE?</b>"
	    End if
	    '''Another sample to warn for large file size

' *** PatRaven Addition; Display filesize in bytes
	    If objFile.Size > MaxSize then
			Response.Write " (" & objFile.Size & " bytes)"
	    End If
		Response.Write "<br>" & vbCrLf
		End If
	Next

End Sub

'''Get the extension of a file. You might want to see objFile.Type too
Function GetExtension(strFileName)
  GetExtension = LCase(Right(strFileName,(Len(strFileName)-InStrRev(strFileName,"."))))
End Function

'''Utility function. Returns the path minus root folder path
Function CutRootFolder(strSubFolder)
	If Len(strSubFolder) > Len(strRootFolder) Then
		CutRootFolder = Right(strSubFolder,(Len(strSubFolder)-Len(strRootFolder)))
	Else
		CutRootFolder = ""
	End If
End Function

'''Utility function. Make a navigation bar to go to parent folders
Sub PrintHeaderLinks(strFolderPath)
	Dim arrFolders, i, prevFolder, x
	arrFolders = split(strFolderPath,"\")
	prevFolder = ""
	If strFolderPath <> "" Then
		Response.Write "<a href=""" & asp_self & """><img hspace=""2"" src=""images/openfold.gif"" alt=""Go to"" border=""0""></a> " & vbCrLf
		For i = 0 To UBound(arrFolders) 
		    Response.Write "<br>" & vbCrLf
			For x = 0 To i
				Response.Write "&nbsp;"
			Next
			If i = UBound(arrFolders) Then
				Response.Write "<b>" & arrFolders(i) & "</b><br>" & vbCrLf
			Else
				Response.Write "<a href=""" & asp_self & "?dir=" & Server.URLEncode(prevFolder & "\" & arrFolders(i)) & """><img hspace=""2"" src=""images/openfold.gif"" border=""0"" alt=""Go To"">" & arrFolders(i) & "</a>" & vbCrLf
			End If
			prevFolder = prevFolder & "\" & arrFolders(i)
		Next
	End If
End Sub

%>
