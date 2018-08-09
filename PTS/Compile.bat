rem @echo off
REM Note: if this code fails to execute or asks for a login name and password
REM you need to modify your source safe ini file to point to the source safe
REM database on the network, rather than your local machine. To do this,
REM modify C:\Program Files\Microsoft\Visual Studio\Common\VSS\srcsafe.ini
REM Data_Path = \\Wt-source\Visual Source Safe\data
REM Temp_Path = \\Wt-source\Visual Source Safe\temp
REM Users_Path = \\Wt-source\Visual Source Safe\users
REM Users_Txt = \\Wt-source\Visual Source Safe\users.txt

REM ----- stop Norton AntiVirus Auto-Protect
REM net stop "NAV Auto-Protect" /y

REM ----- stop IIS service
rem net stop iisadmin /y

SET PATH=""
rem SET PATH="%PATH%;C:\Program Files (x86)\Microsoft Visual Studio\vb98"

REM ----- components
CALL CompilePgm.bat ptsAd
CALL CompilePgm.bat ptsAddress
CALL CompilePgm.bat ptsAdTrack
CALL CompilePgm.bat ptsAdvance
CALL CompilePgm.bat ptsAffiliate
CALL CompilePgm.bat ptsAppt
CALL CompilePgm.bat ptsAssessAnswer   
CALL CompilePgm.bat ptsAssessChoice   
CALL CompilePgm.bat ptsAssessment   
CALL CompilePgm.bat ptsAssessQuestion   
CALL CompilePgm.bat ptsAttachment   
CALL CompilePgm.bat ptsAttendee   
CALL CompilePgm.bat ptsAudit
CALL CompilePgm.bat ptsAuthLog
CALL CompilePgm.bat ptsAuthUser
CALL CompilePgm.bat ptsAuthUser2
CALL CompilePgm.bat ptsAward
CALL CompilePgm.bat ptsBarterAd
CALL CompilePgm.bat ptsBarterArea
CALL CompilePgm.bat ptsBarterCampaign
CALL CompilePgm.bat ptsBarterCategory
CALL CompilePgm.bat ptsBarterCredit
CALL CompilePgm.bat ptsBarterImage
CALL CompilePgm.bat ptsBilling
CALL CompilePgm.bat ptsBinarySale
CALL CompilePgm.bat ptsBlock
CALL CompilePgm.bat ptsBoardUser    
CALL CompilePgm.bat ptsBonus
CALL CompilePgm.bat ptsBonusItem
CALL CompilePgm.bat ptsBroadcast
CALL CompilePgm.bat ptsBroadcastNews
CALL CompilePgm.bat ptsBusiness
CALL CompilePgm.bat ptsCalendar
CALL CompilePgm.bat ptsCash
CALL CompilePgm.bat ptsChannel
CALL CompilePgm.bat ptsCoin     
CALL CompilePgm.bat ptsCoinAddress     
CALL CompilePgm.bat ptsCoinPrice
CALL CompilePgm.bat ptsComment     
CALL CompilePgm.bat ptsCommission     
CALL CompilePgm.bat ptsCommPlan
CALL CompilePgm.bat ptsCommType
CALL CompilePgm.bat ptsCompany
CALL CompilePgm.bat ptsConsumer
CALL CompilePgm.bat ptsContest
CALL CompilePgm.bat ptsCoption
CALL CompilePgm.bat ptsCountry
CALL CompilePgm.bat ptsCourse
CALL CompilePgm.bat ptsCourseCategory 
CALL CompilePgm.bat ptsCredit
CALL CompilePgm.bat ptsDebt
CALL CompilePgm.bat ptsDomain
CALL CompilePgm.bat ptsDownline
CALL CompilePgm.bat ptsDownTitle
CALL CompilePgm.bat ptsDripCampaign
CALL CompilePgm.bat ptsDripPage
CALL CompilePgm.bat ptsDripTarget
CALL CompilePgm.bat ptsEmail       
CALL CompilePgm.bat ptsEmailee     
CALL CompilePgm.bat ptsEmailList   
CALL CompilePgm.bat ptsEmailSource  
CALL CompilePgm.bat ptsEmployee
CALL CompilePgm.bat ptsEvent
CALL CompilePgm.bat ptsExchange
CALL CompilePgm.bat ptsExchangeArea
CALL CompilePgm.bat ptsExpense
CALL CompilePgm.bat ptsExpenseType
CALL CompilePgm.bat ptsFavorite
CALL CompilePgm.bat ptsFinance
CALL CompilePgm.bat ptsFolder
CALL CompilePgm.bat ptsFolderItem
CALL CompilePgm.bat ptsForum
CALL CompilePgm.bat ptsForumModerator
CALL CompilePgm.bat ptsFriend
CALL CompilePgm.bat ptsFriendGroup
CALL CompilePgm.bat ptsGenealogy
CALL CompilePgm.bat ptsGift
CALL CompilePgm.bat ptsGoal
CALL CompilePgm.bat ptsGovID
CALL CompilePgm.bat ptsGuest
CALL CompilePgm.bat ptsHometax
CALL CompilePgm.bat ptsHomework
CALL CompilePgm.bat ptsInventory
CALL CompilePgm.bat ptsIssue
CALL CompilePgm.bat ptsIssueCategory
CALL CompilePgm.bat ptsLead
CALL CompilePgm.bat ptsLeadAd
CALL CompilePgm.bat ptsLeadCampaign
CALL CompilePgm.bat ptsLeadLog
CALL CompilePgm.bat ptsLeadPage
CALL CompilePgm.bat ptsLesson
CALL CompilePgm.bat ptsMachine
CALL CompilePgm.bat ptsMail
CALL CompilePgm.bat ptsMeeting
CALL CompilePgm.bat ptsMember
CALL CompilePgm.bat ptsMemberAssess  
CALL CompilePgm.bat ptsMemberContest
CALL CompilePgm.bat ptsMemberDomain
CALL CompilePgm.bat ptsMemberNews
CALL CompilePgm.bat ptsMemberSales
CALL CompilePgm.bat ptsMemberTax
CALL CompilePgm.bat ptsMemberTitle
CALL CompilePgm.bat ptsMerchant
CALL CompilePgm.bat ptsMessage
CALL CompilePgm.bat ptsMetric
CALL CompilePgm.bat ptsMetricType
CALL CompilePgm.bat ptsMoption
CALL CompilePgm.bat ptsMsg
CALL CompilePgm.bat ptsNews
CALL CompilePgm.bat ptsNewsLetter
CALL CompilePgm.bat ptsNewsTopic
CALL CompilePgm.bat ptsNexxus
CALL CompilePgm.bat ptsNote
CALL CompilePgm.bat ptsOrg            
CALL CompilePgm.bat ptsOrgCourse
CALL CompilePgm.bat ptsPage
CALL CompilePgm.bat ptsPageSection   
CALL CompilePgm.bat ptsParty     
CALL CompilePgm.bat ptsPayment        
CALL CompilePgm.bat ptsPayment2        
CALL CompilePgm.bat ptsPayout         
CALL CompilePgm.bat ptsPool
CALL CompilePgm.bat ptsPrepaid
CALL CompilePgm.bat ptsProduct
CALL CompilePgm.bat ptsProductType
CALL CompilePgm.bat ptsProfile
CALL CompilePgm.bat ptsProject
CALL CompilePgm.bat ptsProjectMember
CALL CompilePgm.bat ptsProjectType
CALL CompilePgm.bat ptsPromo
CALL CompilePgm.bat ptsPromotion
CALL CompilePgm.bat ptsProspect
CALL CompilePgm.bat ptsProspectType
CALL CompilePgm.bat ptsQuestion
CALL CompilePgm.bat ptsQuestionType
CALL CompilePgm.bat ptsQuizAnswer 
CALL CompilePgm.bat ptsQuizChoice    
CALL CompilePgm.bat ptsQuizQuestion 
CALL CompilePgm.bat ptsResource
CALL CompilePgm.bat ptsReward
CALL CompilePgm.bat ptsSalesArea
CALL CompilePgm.bat ptsSalesCampaign
CALL CompilePgm.bat ptsSalesItem
CALL CompilePgm.bat ptsSalesMember
CALL CompilePgm.bat ptsSalesOrder
CALL CompilePgm.bat ptsSalesStep
CALL CompilePgm.bat ptsSalesZip
CALL CompilePgm.bat ptsSeminar
CALL CompilePgm.bat ptsSeminarLog
CALL CompilePgm.bat ptsSession       
CALL CompilePgm.bat ptsSessionLesson  
CALL CompilePgm.bat ptsShortcut
CALL CompilePgm.bat ptsSignature
CALL CompilePgm.bat ptsStaff 
CALL CompilePgm.bat ptsStatement 
CALL CompilePgm.bat ptsSuggestion 
CALL CompilePgm.bat ptsSurvey    
CALL CompilePgm.bat ptsSurveyAnswer  
CALL CompilePgm.bat ptsSurveyChoice 
CALL CompilePgm.bat ptsSurveyQuestion 
CALL CompilePgm.bat ptsTask
CALL CompilePgm.bat ptsTaxRate
CALL CompilePgm.bat ptsTitle
CALL CompilePgm.bat ptsTrainer
CALL CompilePgm.bat ptsVenue

REM ----- Delete *.LIB and *.EXP from LIB folder
Del LIB\*.lib
Del LIB\*.exp

REM ----- re-start IIS service
rem net start w3svc /y
rem net start "IIS Admin Service" /y
rem net start "FTP Publishing Service" /y
rem net start "Simple Mail Transport Protocol (SMTP)" /y

REM ----- start Norton AntiVirus Auto-Protect
REM net start "NAV Auto-Protect" /y

:end
echo .................... end of script ....................  

rem path

pause
