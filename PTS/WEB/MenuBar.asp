<%
Function GetMenuBar()
s = "<MENU name=""MenuBar"" type=""xpbar"" bgcolor=""" & reqSysNavBarImage & """>"
      If (reqSysUserGroup = 61) Then

BOBTEST
s=s+   "<ITEM value=""" & CleanXML(reqSysUserName) & """>"

BOBTEST
s=s+      "<ITEM label=""Home"">"
s=s+         "<IMAGE name=""Home.gif""/>"
s=s+         "<LINK name=""0604""/>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"

BOBTEST
s=s+   "<ITEM label=""MyInfo"">"
s=s+      "<LINK name=""0603"">"
s=s+         "<PARAM name=""AffiliateID"" value=""" & reqSysAffiliateID & """/>"
s=s+      "</LINK>"
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup = 41) Then

BOBTEST
s=s+   "<ITEM value=""" & CleanXML(reqSysUserName) & """>"

BOBTEST
s=s+      "<ITEM label=""Home"">"
s=s+         "<IMAGE name=""Home.gif""/>"
s=s+         "<LINK name=""0404""/>"
s=s+      "</ITEM>"

BOBTEST
         If (InStr(reqSysUserOptions,"s") <> 0) Then
s=s+      "<ITEM label=""Shortcuts"">"
s=s+         "<IMAGE name=""Shortcut.gif"" width=""11"" height=""11""/>"
s=s+         "<LINK name=""9211""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (reqSysEmployeeID > 0) Then
s=s+      "<ITEM label=""ReturnEmployee"">"
s=s+         "<IMAGE name=""Affiliate.gif""/>"
s=s+         "<LINK name=""0204"" return=""false"">"
s=s+            "<PARAM name=""EmployeeID"" value=""" & reqSysEmployeeID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"

BOBTEST
      If (InStr(reqSysUserOptions,"A") <> 0) Then
s=s+   "<ITEM label=""Marketing"">"

BOBTEST
         If (InStr(reqSysUserOptions,"h") <> 0) Then
s=s+      "<ITEM label=""MySuspects"">"
s=s+         "<IMAGE name=""Suspect.gif""/>"
s=s+         "<LINK name=""2201"" target=""blank"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"E") <> 0) Then
s=s+      "<ITEM label=""MySales"">"
s=s+         "<IMAGE name=""Prospect.gif""/>"
s=s+         "<LINK name=""8101"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"6") <> 0) Then
s=s+      "<ITEM label=""MyService"">"
s=s+         "<IMAGE name=""Customer.gif""/>"
s=s+         "<LINK name=""8151"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"7") <> 0) Then
s=s+      "<ITEM label=""MyPartyPlans"">"
s=s+         "<IMAGE name=""Plan.gif""/>"
s=s+         "<LINK name=""2511"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"W") <> 0) Then
s=s+      "<ITEM label=""NewsLetters"">"
s=s+         "<IMAGE name=""NewsLetter.gif""/>"
s=s+         "<LINK name=""1813"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If

BOBTEST
      If (InStr(reqSysUserOptions,"n") <> 0) Then
s=s+   "<ITEM label=""Personal"">"

BOBTEST
         If (InStr(reqSysUserOptions,"I") <> 0) Then
s=s+      "<ITEM label=""MyInfo"">"
s=s+         "<IMAGE name=""MyInfo.gif""/>"
s=s+         "<LINK name=""0463"" target=""MyInfo"" secure=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"[") <> 0) Then
s=s+      "<ITEM label=""Performance"">"
s=s+         "<IMAGE name=""Performance.gif""/>"
s=s+         "<LINK name=""0445"" target=""blank"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"G") <> 0) Then
s=s+      "<ITEM label=""Mentoring"">"
s=s+         "<IMAGE name=""Mentor.gif""/>"
s=s+         "<LINK name=""0410"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"o") <> 0) Then
s=s+      "<ITEM label=""MyGenealogy"">"
s=s+         "<IMAGE name=""Genealogy.gif""/>"
s=s+         "<LINK name=""0470"" target=""Genealogy"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"H") <> 0) Then
s=s+      "<ITEM label=""MyGoals"">"
s=s+         "<IMAGE name=""Goal.gif""/>"
s=s+         "<LINK name=""7001"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"2") <> 0) Then
s=s+      "<ITEM label=""MyCalendar"">"
s=s+         "<IMAGE name=""Calendar.gif""/>"
s=s+         "<LINK name=""Calendar"" target=""blank"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"w") <> 0) Then
s=s+      "<ITEM label=""MyFinances"">"
s=s+         "<IMAGE name=""Finance.gif""/>"
s=s+         "<LINK name=""0475"" nodata=""true"" target=""Finances"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"/") <> 0) Then
s=s+      "<ITEM label=""MyExpenses"">"
s=s+         "<IMAGE name=""Calculator.gif""/>"
s=s+         "<LINK name=""6401"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"F") <> 0) Or (InStr(reqSysUserOptions,"f") <> 0) Then
s=s+      "<ITEM label=""MyProjects"">"
s=s+         "<IMAGE name=""Project.gif""/>"
s=s+         "<LINK name=""7501"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,".") <> 0) Then
s=s+      "<ITEM label=""MyReports"">"
s=s+         "<IMAGE name=""Report.gif""/>"
s=s+         "<LINK name=""Reports"" target=""Reports""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"a") <> 0) Then
s=s+      "<ITEM label=""MyResources"">"
s=s+         "<IMAGE name=""Resource.gif""/>"
s=s+         "<LINK name=""9304"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+            "<PARAM name=""GrpCompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If

BOBTEST
      If (InStr(reqSysUserOptions,"B") <> 0) Then
s=s+   "<ITEM label=""TrainingCaption"">"

BOBTEST
         If (InStr(reqSysUserOptions,"K") <> 0) Then
s=s+      "<ITEM label=""Sessions"">"
s=s+         "<IMAGE name=""Class.gif""/>"
s=s+         "<LINK name=""1311"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"L") <> 0) Then
s=s+      "<ITEM label=""MyAssessments"">"
s=s+         "<IMAGE name=""Assessment.gif""/>"
s=s+         "<LINK name=""3411"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"M") <> 0) Then
s=s+      "<ITEM label=""CourseCategorys"">"
s=s+         "<IMAGE name=""Catalog.gif""/>"
s=s+         "<LINK name=""1212"" return=""false"">"
s=s+            "<PARAM name=""Mode"" value=""2""/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If

BOBTEST
      If (InStr(reqSysUserOptions,"C") <> 0) Then
s=s+   "<ITEM label=""CommunicationCaption"">"

BOBTEST
         If (InStr(reqSysUserOptions,"O") <> 0) Then
s=s+      "<ITEM label=""MsgBoards"">"
s=s+         "<IMAGE name=""Mentor.gif""/>"
s=s+         "<LINK name=""84114""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"P") <> 0) Then
s=s+      "<ITEM label=""Suggestions"">"
s=s+         "<IMAGE name=""suggestion.gif""/>"
s=s+         "<LINK name=""4511""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"Q") <> 0) Then
s=s+      "<ITEM label=""Surveys"">"
s=s+         "<IMAGE name=""suggestion.gif""/>"
s=s+         "<LINK name=""4011""/>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If
If (reqSysUserMode = 10) Then
End If

BOBTEST
      If (InStr(reqSysUserOptions,"D") <> 0) And (InStr(reqSysUserOptions,"R") <> 0) Or (InStr(reqSysUserOptions,"S") <> 0) Or (InStr(reqSysUserOptions,"T") <> 0) Or (InStr(reqSysUserOptions,"U") <> 0) Then
s=s+   "<ITEM label=""SupportCaption"">"

BOBTEST
         If (InStr(reqSysUserOptions,"R") <> 0) Then
s=s+      "<ITEM label=""Attachments"">"
s=s+         "<IMAGE name=""Help.gif""/>"
s=s+         "<LINK name=""8013"" target=""Attachments"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"S") <> 0) Then
s=s+      "<ITEM label=""CompanyFAQs"">"
s=s+         "<IMAGE name=""Help.gif""/>"
s=s+         "<LINK name=""1713"" target=""FAQ"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"T") <> 0) Then
s=s+      "<ITEM label=""PinnacleFAQs"">"
s=s+         "<IMAGE name=""Help.gif""/>"
s=s+         "<LINK name=""1713"" target=""FAQ""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"U") <> 0) Then
s=s+      "<ITEM label=""PinnacleTutorials"">"
s=s+         "<IMAGE name=""Catalog.gif""/>"
s=s+         "<LINK name=""Tutorial"" target=""Tutorial"">"
s=s+            "<PARAM name=""contentpage"" value=""3""/>"
s=s+            "<PARAM name=""popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"m") <> 0) Then
s=s+      "<ITEM label=""SupportTickets"">"
s=s+         "<IMAGE name=""SupportTicket.gif""/>"
s=s+         "<LINK name=""9506"" target=""SupportTickets""/>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If
      End If
      If (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then

BOBTEST
s=s+   "<ITEM value=""" & CleanXML(reqSysUserName) & """>"

BOBTEST
s=s+      "<ITEM label=""Home"">"
s=s+         "<IMAGE name=""Home.gif""/>"
s=s+         "<LINK name=""3804"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqSysCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"

BOBTEST
         If (InStr(reqSysUserOptions,"s") <> 0) Then
s=s+      "<ITEM label=""Shortcuts"">"
s=s+         "<IMAGE name=""Shortcut.gif"" width=""11"" height=""11""/>"
s=s+         "<LINK name=""9211""/>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup = 31) Then

BOBTEST
s=s+   "<ITEM value=""" & CleanXML(reqSysUserName) & """>"

BOBTEST
s=s+      "<ITEM label=""Home"">"
s=s+         "<IMAGE name=""Home.gif""/>"
s=s+         "<LINK name=""0305""/>"
s=s+      "</ITEM>"

BOBTEST
s=s+      "<ITEM label=""Shortcuts"">"
s=s+         "<IMAGE name=""Shortcut.gif"" width=""11"" height=""11""/>"
s=s+         "<LINK name=""9211""/>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup <= 23) Then

BOBTEST
s=s+   "<ITEM value=""" & CleanXML(reqSysUserName) & """>"

BOBTEST
s=s+      "<ITEM label=""Home"">"
s=s+         "<IMAGE name=""Home.gif""/>"
s=s+         "<LINK name=""0204""/>"
s=s+      "</ITEM>"

BOBTEST
s=s+      "<ITEM label=""Shortcuts"">"
s=s+         "<IMAGE name=""Shortcut.gif"" width=""11"" height=""11""/>"
s=s+         "<LINK name=""9211""/>"
s=s+      "</ITEM>"

BOBTEST
         If (reqSysMemberID > 0) Then
s=s+      "<ITEM label=""ReturnMember"">"
s=s+         "<IMAGE name=""MyInfo.gif""/>"
s=s+         "<LINK name=""0404"" return=""false"">"
s=s+            "<PARAM name=""EmployeeID"" value=""" & reqSysEmployeeID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqSysMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"

BOBTEST
      If (InStr(reqSysUserOptions,"A") <> 0) Then
s=s+   "<ITEM label=""CustomerCaption"">"

BOBTEST
         If (InStr(reqSysUserOptions,"E") <> 0) Then
s=s+      "<ITEM label=""Companies"">"
s=s+         "<LINK name=""3801""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"F") <> 0) Then
s=s+      "<ITEM label=""Members"">"
s=s+         "<LINK name=""0401""/>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If

BOBTEST
      If (InStr(reqSysUserOptions,"B") <> 0) Then
s=s+   "<ITEM label=""TrainerCaption"">"

BOBTEST
         If (InStr(reqSysUserOptions,"G") <> 0) Then
s=s+      "<ITEM label=""Trainers"">"
s=s+         "<LINK name=""0301""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"H") <> 0) Then
s=s+      "<ITEM label=""Courses"">"
s=s+         "<LINK name=""1101""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"I") <> 0) Then
s=s+      "<ITEM label=""Assessments"">"
s=s+         "<LINK name=""3101""/>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If

BOBTEST
      If (InStr(reqSysUserOptions,"C") <> 0) Then
s=s+   "<ITEM label=""BusinessCaption"">"

BOBTEST
         If (InStr(reqSysUserOptions,"J") <> 0) Then
s=s+      "<ITEM label=""Reports"">"
s=s+         "<LINK name=""0060""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
s=s+      "<ITEM label=""Reports"">"
s=s+         "<IMAGE name=""Report.gif""/>"
s=s+         "<LINK name=""Reports"" target=""Reports"">"
s=s+            "<PARAM name=""RptType"" value=""system""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"

BOBTEST
         If (InStr(reqSysUserOptions,"K") <> 0) Then
s=s+      "<ITEM label=""Accounting"">"
s=s+         "<LINK name=""1020""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"L") <> 0) Then
s=s+      "<ITEM label=""EmailManager"">"
s=s+         "<LINK name=""8801""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"M") <> 0) Then
s=s+      "<ITEM label=""Billing"">"
s=s+         "<LINK name=""1001"">"
s=s+            "<PARAM name=""CompanyID"" value=""-1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"N") <> 0) Then
s=s+      "<ITEM label=""Commissions"">"
s=s+         "<LINK name=""0901""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"O") <> 0) Then
s=s+      "<ITEM label=""Payouts"">"
s=s+         "<LINK name=""0801""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"P") <> 0) Then
s=s+      "<ITEM label=""Issues"">"
s=s+         "<LINK name=""9501"" target=""Issue""/>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If

BOBTEST
      If (InStr(reqSysUserOptions,"D") <> 0) Then
s=s+   "<ITEM label=""SetupCaption"">"

BOBTEST
         If (InStr(reqSysUserOptions,"Q") <> 0) Then
s=s+      "<ITEM label=""PageSections"">"
s=s+         "<LINK name=""9101""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"R") <> 0) Then
s=s+      "<ITEM label=""PinnacleFAQs"">"
s=s+         "<LINK name=""1701"" target=""EditQuestions""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"S") <> 0) Then
s=s+      "<ITEM label=""Employees"">"
s=s+         "<LINK name=""0201""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"T") <> 0) Then
s=s+      "<ITEM label=""Business"">"
s=s+         "<LINK name=""0003"">"
s=s+            "<PARAM name=""BusinessID"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If

BOBTEST
         If (InStr(reqSysUserOptions,"v") <> 0) Then
s=s+      "<ITEM label=""ExpenseManager"">"
s=s+         "<LINK name=""6511""/>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
      End If
      End If
      If (reqSysUserID <> 99) And (InStr(reqSysUserOptions,"~!") = 0) Then

BOBTEST
s=s+   "<ITEM label=""LogonPassword"">"

BOBTEST
         If (reqSysUserGroup <> 1) And (InStr(reqSysUserOptions,"~y") = 0) Then
s=s+      "<ITEM label=""ChangeLogon"">"
s=s+         "<IMAGE name=""logon.gif""/>"
s=s+         "<LINK name=""0103""/>"
s=s+      "</ITEM>"
         End If

BOBTEST
s=s+      "<ITEM label=""ChangePassword"">"
s=s+         "<IMAGE name=""logon.gif""/>"
s=s+         "<LINK name=""0106""/>"
s=s+      "</ITEM>"

BOBTEST
s=s+      "<ITEM label=""SignOut"">"
s=s+         "<IMAGE name=""close.gif""/>"
s=s+         "<LINK name=""0101"">"
s=s+            "<PARAM name=""ActionCode"" value=""9""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
      End If
s=s+"</MENU>"
GetMenuBar = s
End Function
%>