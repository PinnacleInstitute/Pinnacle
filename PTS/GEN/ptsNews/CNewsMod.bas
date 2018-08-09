Attribute VB_Name = "CNewsMod"
Option Explicit
'-----constants
Private Const cModName As String = "CNewsMod"

'-----enum item type constants
Public Const cptsNewsEnumFindType As Long = 1
Public Const cptsNewsEnumStatus As Long = 9816
Public Const cptsNewsEnumLeadMain As Long = 9818
Public Const cptsNewsEnumLeadTopic As Long = 9819
Public Const cptsNewsEnumUserRole As Long = 9825

'-----enum FindType constants
Public Const cptsNewsFindActiveDate As Long = 9813
Public Const cptsNewsFindTitle As Long = 9810
Public Const cptsNewsFindDescription As Long = 9811
Public Const cptsNewsFindTags As Long = 9815
Public Const cptsNewsFindStatus As Long = 9816

'-----enum Status constants
Public Const cptsNewsStatusPending As Long = 1
Public Const cptsNewsStatusSubmitted As Long = 2
Public Const cptsNewsStatusApproved As Long = 3
Public Const cptsNewsStatusActive As Long = 4
Public Const cptsNewsStatusInActive As Long = 5
Public Const cptsNewsStatusCancelled As Long = 6

'-----enum LeadMain constants
Public Const cptsNewsLeadMainPrimary As Long = 1
Public Const cptsNewsLeadMainSecondary As Long = 2

'-----enum LeadTopic constants
Public Const cptsNewsLeadTopicPrimary As Long = 1
Public Const cptsNewsLeadTopicSecondary As Long = 2

'-----enum UserRole constants
Public Const cptsNewsUserRoleAuthor As Long = 1
Public Const cptsNewsUserRolePublisher As Long = 2