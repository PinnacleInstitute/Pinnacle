Attribute VB_Name = "CBillingMod"
Option Explicit
'-----constants
Private Const cModName As String = "CBillingMod"

'-----enum item type constants
Public Const cptsBillingEnumPayType As Long = 2920
Public Const cptsBillingEnumCommType As Long = 2921
Public Const cptsBillingEnumCardType As Long = 2922
Public Const cptsBillingEnumCardMo As Long = 2924
Public Const cptsBillingEnumCardYr As Long = 2925
Public Const cptsBillingEnumCheckAcctType As Long = 2931

'-----enum PayType constants
Public Const cptsBillingPayTypeCreditCard As Long = 1
Public Const cptsBillingPayTypeeCheck As Long = 2
Public Const cptsBillingPayTypeCash As Long = 3
Public Const cptsBillingPayTypeeWallet As Long = 4
Public Const cptsBillingPayTypeNoPay As Long = 5

'-----enum CommType constants
Public Const cptsBillingCommTypeCreditCard As Long = 1
Public Const cptsBillingCommTypeeCheck As Long = 2
Public Const cptsBillingCommTypeCheck As Long = 3
Public Const cptsBillingCommTypeeWallet As Long = 4
Public Const cptsBillingCommTypeNoComm As Long = 5

'-----enum CardType constants
Public Const cptsBillingCardTypeVisa As Long = 1
Public Const cptsBillingCardTypeMasterCard As Long = 2
Public Const cptsBillingCardTypeDiscover As Long = 3
Public Const cptsBillingCardTypeAmex As Long = 4
Public Const cptsBillingCardTypeWallet As Long = 10
Public Const cptsBillingCardTypeiPayout As Long = 11
Public Const cptsBillingCardTypePayQuicker As Long = 12
Public Const cptsBillingCardTypeSolidTrust As Long = 13
Public Const cptsBillingCardTypeBitCoin As Long = 14
Public Const cptsBillingCardTypeCardType15 As Long = 15
Public Const cptsBillingCardTypeCardType16 As Long = 16
Public Const cptsBillingCardTypeCardType17 As Long = 17
Public Const cptsBillingCardTypeCardType18 As Long = 18

'-----enum CardMo constants
Public Const cptsBillingCardMoJanuary As Long = 1
Public Const cptsBillingCardMoFebruary As Long = 2
Public Const cptsBillingCardMoMarch As Long = 3
Public Const cptsBillingCardMoApril As Long = 4
Public Const cptsBillingCardMoMay As Long = 5
Public Const cptsBillingCardMoJune As Long = 6
Public Const cptsBillingCardMoJuly As Long = 7
Public Const cptsBillingCardMoAugust As Long = 8
Public Const cptsBillingCardMoSeptember As Long = 9
Public Const cptsBillingCardMoOctober As Long = 10
Public Const cptsBillingCardMoNovember As Long = 11
Public Const cptsBillingCardMoDecember As Long = 12

'-----enum CardYr constants
Public Const cptsBillingCardYr2013 As Long = 13
Public Const cptsBillingCardYr2014 As Long = 14
Public Const cptsBillingCardYr2015 As Long = 15
Public Const cptsBillingCardYr2016 As Long = 16
Public Const cptsBillingCardYr2017 As Long = 17
Public Const cptsBillingCardYr2018 As Long = 18
Public Const cptsBillingCardYr2019 As Long = 19
Public Const cptsBillingCardYr2020 As Long = 20
Public Const cptsBillingCardYr2021 As Long = 21
Public Const cptsBillingCardYr2022 As Long = 22
Public Const cptsBillingCardYr2023 As Long = 23
Public Const cptsBillingCardYr2024 As Long = 24
Public Const cptsBillingCardYr2025 As Long = 25
Public Const cptsBillingCardYr2026 As Long = 26
Public Const cptsBillingCardYr2027 As Long = 27
Public Const cptsBillingCardYr2028 As Long = 28
Public Const cptsBillingCardYr2029 As Long = 29
Public Const cptsBillingCardYr2030 As Long = 30
Public Const cptsBillingCardYr2031 As Long = 31
Public Const cptsBillingCardYr2032 As Long = 32
Public Const cptsBillingCardYr2033 As Long = 33
Public Const cptsBillingCardYr2034 As Long = 34
Public Const cptsBillingCardYr2035 As Long = 35

'-----enum CheckAcctType constants
Public Const cptsBillingCheckAcctTypeChecking As Long = 1
Public Const cptsBillingCheckAcctTypeSavings As Long = 2
Public Const cptsBillingCheckAcctTypeBusinessChecking As Long = 3