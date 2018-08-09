Attribute VB_Name = "CExpenseTypeMod"
Option Explicit
'-----constants
Private Const cModName As String = "CExpenseTypeMod"

'-----enum item type constants
Public Const cptsExpenseTypeEnumExpType As Long = 6502
Public Const cptsExpenseTypeEnumTaxType As Long = 6505

'-----enum ExpType constants
Public Const cptsExpenseTypeExpTypeStandardMileage As Long = 1
Public Const cptsExpenseTypeExpTypeMeals As Long = 2
Public Const cptsExpenseTypeExpTypeTravel As Long = 3
Public Const cptsExpenseTypeExpTypeHomeOffice As Long = 4
Public Const cptsExpenseTypeExpTypeMisc As Long = 5
Public Const cptsExpenseTypeExpTypeVehicleCost As Long = 11

'-----enum TaxType constants
Public Const cptsExpenseTypeTaxTypeBusinessUse As Long = -1
Public Const cptsExpenseTypeTaxTypeDirectExpense As Long = 0
Public Const cptsExpenseTypeTaxTypeBusinessMiles As Long = 1
Public Const cptsExpenseTypeTaxTypeCharityMiles As Long = 2
Public Const cptsExpenseTypeTaxTypeMovingMiles As Long = 3
Public Const cptsExpenseTypeTaxTypeBusinessMeal As Long = 4
Public Const cptsExpenseTypeTaxTypeBusinessFood As Long = 5
Public Const cptsExpenseTypeTaxTypeTaxType6 As Long = 6
Public Const cptsExpenseTypeTaxTypeTaxType7 As Long = 7
Public Const cptsExpenseTypeTaxTypeTaxType8 As Long = 8
Public Const cptsExpenseTypeTaxTypeTaxType9 As Long = 9
Public Const cptsExpenseTypeTaxTypeTaxType10 As Long = 10