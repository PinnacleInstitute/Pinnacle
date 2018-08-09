VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CProfileB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CProfile"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tProfileType
   ProfileID As String
   MemberID As String
   ProfileDate As String
   ProfileType As String
   Status As String
   VQResponse As String
   SQResponse As String
   VQDiff As String
   VQDimPerc As String
   VQDimPos_I As String
   VQDimPos_E As String
   VQDimPos_S As String
   VQDimNeg_I As String
   VQDimNeg_E As String
   VQDimNeg_S As String
   VQIntCate_I As String
   VQIntCate_E As String
   VQIntCate_S As String
   VQInt As String
   VQIntPerc As String
   VQDI As String
   VQDIS As String
   VQLeft As String
   VQRight As String
   VQAI As String
   SQDiff As String
   SQDimPerc As String
   SQDimPos_I As String
   SQDimPos_E As String
   SQDimPos_S As String
   SQDimNeg_I As String
   SQDimNeg_E As String
   SQDimNeg_S As String
   SQIntCate_I As String
   SQIntCate_E As String
   SQIntCate_S As String
   SQInt As String
   SQIntPerc As String
   SQDI As String
   SQDIS As String
   SQLeft As String
   SQRight As String
   SQAI As String
   BQrLeft As String
   BQrRight As String
   BQaLeft As String
   BQaRight As String
   CQLeft As String
   CQRight As String
   RQLeft As String
   RQRight As String
   VQClarity_I As String
   VQClarity_E As String
   VQClarity_S As String
   VQBias_I As String
   VQBias_E As String
   VQBias_S As String
   SQClarity_I As String
   SQClarity_E As String
   SQClarity_S As String
   SQBias_I As String
   SQBias_E As String
   SQBias_S As String
   xVQClarity_I As String
   xVQClarity_E As String
   xVQClarity_S As String
   xVQBias_I As String
   xVQBias_E As String
   xVQBias_S As String
   xSQClarity_I As String
   xSQClarity_E As String
   xSQClarity_S As String
   xSQBias_I As String
   xSQBias_E As String
   xSQBias_S As String
End Type

Public Sub Add( _ 
   ByRef brRec As tProfileType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Add the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Add"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   Validate brRec, bvUserID, 1

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProfileID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProfileDate", adDate, adParamInput, vbNull, CDate(brRec.ProfileDate))
      .Parameters.Append .CreateParameter("@ProfileType", adInteger, adParamInput, vbNull, CLng(brRec.ProfileType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@VQResponse", adVarWChar, adParamInput, 50, brRec.VQResponse)
      .Parameters.Append .CreateParameter("@SQResponse", adVarWChar, adParamInput, 50, brRec.SQResponse)
      .Parameters.Append .CreateParameter("@VQDiff", adInteger, adParamInput, vbNull, CLng(brRec.VQDiff))
      .Parameters.Append .CreateParameter("@VQDimPerc", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPerc))
      .Parameters.Append .CreateParameter("@VQDimPos_I", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPos_I))
      .Parameters.Append .CreateParameter("@VQDimPos_E", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPos_E))
      .Parameters.Append .CreateParameter("@VQDimPos_S", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPos_S))
      .Parameters.Append .CreateParameter("@VQDimNeg_I", adInteger, adParamInput, vbNull, CLng(brRec.VQDimNeg_I))
      .Parameters.Append .CreateParameter("@VQDimNeg_E", adInteger, adParamInput, vbNull, CLng(brRec.VQDimNeg_E))
      .Parameters.Append .CreateParameter("@VQDimNeg_S", adInteger, adParamInput, vbNull, CLng(brRec.VQDimNeg_S))
      .Parameters.Append .CreateParameter("@VQIntCate_I", adInteger, adParamInput, vbNull, CLng(brRec.VQIntCate_I))
      .Parameters.Append .CreateParameter("@VQIntCate_E", adInteger, adParamInput, vbNull, CLng(brRec.VQIntCate_E))
      .Parameters.Append .CreateParameter("@VQIntCate_S", adInteger, adParamInput, vbNull, CLng(brRec.VQIntCate_S))
      .Parameters.Append .CreateParameter("@VQInt", adInteger, adParamInput, vbNull, CLng(brRec.VQInt))
      .Parameters.Append .CreateParameter("@VQIntPerc", adInteger, adParamInput, vbNull, CLng(brRec.VQIntPerc))
      .Parameters.Append .CreateParameter("@VQDI", adInteger, adParamInput, vbNull, CLng(brRec.VQDI))
      .Parameters.Append .CreateParameter("@VQDIS", adInteger, adParamInput, vbNull, CLng(brRec.VQDIS))
      .Parameters.Append .CreateParameter("@VQLeft", adInteger, adParamInput, vbNull, CLng(brRec.VQLeft))
      .Parameters.Append .CreateParameter("@VQRight", adInteger, adParamInput, vbNull, CLng(brRec.VQRight))
      .Parameters.Append .CreateParameter("@VQAI", adInteger, adParamInput, vbNull, CLng(brRec.VQAI))
      .Parameters.Append .CreateParameter("@SQDiff", adInteger, adParamInput, vbNull, CLng(brRec.SQDiff))
      .Parameters.Append .CreateParameter("@SQDimPerc", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPerc))
      .Parameters.Append .CreateParameter("@SQDimPos_I", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPos_I))
      .Parameters.Append .CreateParameter("@SQDimPos_E", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPos_E))
      .Parameters.Append .CreateParameter("@SQDimPos_S", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPos_S))
      .Parameters.Append .CreateParameter("@SQDimNeg_I", adInteger, adParamInput, vbNull, CLng(brRec.SQDimNeg_I))
      .Parameters.Append .CreateParameter("@SQDimNeg_E", adInteger, adParamInput, vbNull, CLng(brRec.SQDimNeg_E))
      .Parameters.Append .CreateParameter("@SQDimNeg_S", adInteger, adParamInput, vbNull, CLng(brRec.SQDimNeg_S))
      .Parameters.Append .CreateParameter("@SQIntCate_I", adInteger, adParamInput, vbNull, CLng(brRec.SQIntCate_I))
      .Parameters.Append .CreateParameter("@SQIntCate_E", adInteger, adParamInput, vbNull, CLng(brRec.SQIntCate_E))
      .Parameters.Append .CreateParameter("@SQIntCate_S", adInteger, adParamInput, vbNull, CLng(brRec.SQIntCate_S))
      .Parameters.Append .CreateParameter("@SQInt", adInteger, adParamInput, vbNull, CLng(brRec.SQInt))
      .Parameters.Append .CreateParameter("@SQIntPerc", adInteger, adParamInput, vbNull, CLng(brRec.SQIntPerc))
      .Parameters.Append .CreateParameter("@SQDI", adInteger, adParamInput, vbNull, CLng(brRec.SQDI))
      .Parameters.Append .CreateParameter("@SQDIS", adInteger, adParamInput, vbNull, CLng(brRec.SQDIS))
      .Parameters.Append .CreateParameter("@SQLeft", adInteger, adParamInput, vbNull, CLng(brRec.SQLeft))
      .Parameters.Append .CreateParameter("@SQRight", adInteger, adParamInput, vbNull, CLng(brRec.SQRight))
      .Parameters.Append .CreateParameter("@SQAI", adInteger, adParamInput, vbNull, CLng(brRec.SQAI))
      .Parameters.Append .CreateParameter("@BQrLeft", adCurrency, adParamInput, vbNull, CCur(brRec.BQrLeft))
      .Parameters.Append .CreateParameter("@BQrRight", adCurrency, adParamInput, vbNull, CCur(brRec.BQrRight))
      .Parameters.Append .CreateParameter("@BQaLeft", adInteger, adParamInput, vbNull, CLng(brRec.BQaLeft))
      .Parameters.Append .CreateParameter("@BQaRight", adInteger, adParamInput, vbNull, CLng(brRec.BQaRight))
      .Parameters.Append .CreateParameter("@CQLeft", adInteger, adParamInput, vbNull, CLng(brRec.CQLeft))
      .Parameters.Append .CreateParameter("@CQRight", adInteger, adParamInput, vbNull, CLng(brRec.CQRight))
      .Parameters.Append .CreateParameter("@RQLeft", adCurrency, adParamInput, vbNull, CCur(brRec.RQLeft))
      .Parameters.Append .CreateParameter("@RQRight", adCurrency, adParamInput, vbNull, CCur(brRec.RQRight))
      .Parameters.Append .CreateParameter("@VQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.VQClarity_I))
      .Parameters.Append .CreateParameter("@VQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.VQClarity_E))
      .Parameters.Append .CreateParameter("@VQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.VQClarity_S))
      .Parameters.Append .CreateParameter("@VQBias_I", adInteger, adParamInput, vbNull, CLng(brRec.VQBias_I))
      .Parameters.Append .CreateParameter("@VQBias_E", adInteger, adParamInput, vbNull, CLng(brRec.VQBias_E))
      .Parameters.Append .CreateParameter("@VQBias_S", adInteger, adParamInput, vbNull, CLng(brRec.VQBias_S))
      .Parameters.Append .CreateParameter("@SQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.SQClarity_I))
      .Parameters.Append .CreateParameter("@SQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.SQClarity_E))
      .Parameters.Append .CreateParameter("@SQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.SQClarity_S))
      .Parameters.Append .CreateParameter("@SQBias_I", adInteger, adParamInput, vbNull, CLng(brRec.SQBias_I))
      .Parameters.Append .CreateParameter("@SQBias_E", adInteger, adParamInput, vbNull, CLng(brRec.SQBias_E))
      .Parameters.Append .CreateParameter("@SQBias_S", adInteger, adParamInput, vbNull, CLng(brRec.SQBias_S))
      .Parameters.Append .CreateParameter("@xVQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.xVQClarity_I))
      .Parameters.Append .CreateParameter("@xVQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.xVQClarity_E))
      .Parameters.Append .CreateParameter("@xVQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.xVQClarity_S))
      .Parameters.Append .CreateParameter("@xVQBias_I", adCurrency, adParamInput, vbNull, CCur(brRec.xVQBias_I))
      .Parameters.Append .CreateParameter("@xVQBias_E", adCurrency, adParamInput, vbNull, CCur(brRec.xVQBias_E))
      .Parameters.Append .CreateParameter("@xVQBias_S", adCurrency, adParamInput, vbNull, CCur(brRec.xVQBias_S))
      .Parameters.Append .CreateParameter("@xSQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.xSQClarity_I))
      .Parameters.Append .CreateParameter("@xSQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.xSQClarity_E))
      .Parameters.Append .CreateParameter("@xSQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.xSQClarity_S))
      .Parameters.Append .CreateParameter("@xSQBias_I", adCurrency, adParamInput, vbNull, CCur(brRec.xSQBias_I))
      .Parameters.Append .CreateParameter("@xSQBias_E", adCurrency, adParamInput, vbNull, CCur(brRec.xSQBias_E))
      .Parameters.Append .CreateParameter("@xSQBias_S", adCurrency, adParamInput, vbNull, CCur(brRec.xSQBias_S))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Profile_Add"

   '-----get return values
   With brRec
      .ProfileID = moUtil.FetchLong(oCmd.Parameters.Item("@ProfileID").Value)
   End With

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Delete( _ 
   ByRef brRec As tProfileType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Delete the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Delete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   With brRec
      .ProfileID = moUtil.EditLong(.ProfileID, "ProfileID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProfileID", adInteger, adParamInput, vbNull, CLng(brRec.ProfileID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Profile_Delete"

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Fetch( _ 
   ByRef brRec As tProfileType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Fetch"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ProfileID = moUtil.EditLong(.ProfileID, "ProfileID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProfileID", adInteger, adParamInput, vbNull, CLng(brRec.ProfileID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProfileDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProfileType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQResponse", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@SQResponse", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@VQDiff", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDimPerc", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDimPos_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDimPos_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDimPos_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDimNeg_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDimNeg_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDimNeg_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQIntCate_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQIntCate_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQIntCate_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQInt", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQIntPerc", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDI", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQDIS", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQLeft", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQRight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQAI", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDiff", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDimPerc", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDimPos_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDimPos_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDimPos_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDimNeg_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDimNeg_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDimNeg_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQIntCate_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQIntCate_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQIntCate_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQInt", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQIntPerc", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDI", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQDIS", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQLeft", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQRight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQAI", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BQrLeft", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BQrRight", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BQaLeft", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BQaRight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CQLeft", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CQRight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RQLeft", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RQRight", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQClarity_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQClarity_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQClarity_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQBias_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQBias_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VQBias_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQClarity_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQClarity_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQClarity_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQBias_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQBias_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SQBias_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xVQClarity_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xVQClarity_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xVQClarity_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xVQBias_I", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xVQBias_E", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xVQBias_S", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xSQClarity_I", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xSQClarity_E", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xSQClarity_S", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xSQBias_I", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xSQBias_E", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@xSQBias_S", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Profile_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .ProfileDate = moUtil.FetchDate(oCmd.Parameters.Item("@ProfileDate").Value)
      .ProfileType = moUtil.FetchLong(oCmd.Parameters.Item("@ProfileType").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .VQResponse = moUtil.FetchString(oCmd.Parameters.Item("@VQResponse").Value)
      .SQResponse = moUtil.FetchString(oCmd.Parameters.Item("@SQResponse").Value)
      .VQDiff = moUtil.FetchLong(oCmd.Parameters.Item("@VQDiff").Value)
      .VQDimPerc = moUtil.FetchLong(oCmd.Parameters.Item("@VQDimPerc").Value)
      .VQDimPos_I = moUtil.FetchLong(oCmd.Parameters.Item("@VQDimPos_I").Value)
      .VQDimPos_E = moUtil.FetchLong(oCmd.Parameters.Item("@VQDimPos_E").Value)
      .VQDimPos_S = moUtil.FetchLong(oCmd.Parameters.Item("@VQDimPos_S").Value)
      .VQDimNeg_I = moUtil.FetchLong(oCmd.Parameters.Item("@VQDimNeg_I").Value)
      .VQDimNeg_E = moUtil.FetchLong(oCmd.Parameters.Item("@VQDimNeg_E").Value)
      .VQDimNeg_S = moUtil.FetchLong(oCmd.Parameters.Item("@VQDimNeg_S").Value)
      .VQIntCate_I = moUtil.FetchLong(oCmd.Parameters.Item("@VQIntCate_I").Value)
      .VQIntCate_E = moUtil.FetchLong(oCmd.Parameters.Item("@VQIntCate_E").Value)
      .VQIntCate_S = moUtil.FetchLong(oCmd.Parameters.Item("@VQIntCate_S").Value)
      .VQInt = moUtil.FetchLong(oCmd.Parameters.Item("@VQInt").Value)
      .VQIntPerc = moUtil.FetchLong(oCmd.Parameters.Item("@VQIntPerc").Value)
      .VQDI = moUtil.FetchLong(oCmd.Parameters.Item("@VQDI").Value)
      .VQDIS = moUtil.FetchLong(oCmd.Parameters.Item("@VQDIS").Value)
      .VQLeft = moUtil.FetchLong(oCmd.Parameters.Item("@VQLeft").Value)
      .VQRight = moUtil.FetchLong(oCmd.Parameters.Item("@VQRight").Value)
      .VQAI = moUtil.FetchLong(oCmd.Parameters.Item("@VQAI").Value)
      .SQDiff = moUtil.FetchLong(oCmd.Parameters.Item("@SQDiff").Value)
      .SQDimPerc = moUtil.FetchLong(oCmd.Parameters.Item("@SQDimPerc").Value)
      .SQDimPos_I = moUtil.FetchLong(oCmd.Parameters.Item("@SQDimPos_I").Value)
      .SQDimPos_E = moUtil.FetchLong(oCmd.Parameters.Item("@SQDimPos_E").Value)
      .SQDimPos_S = moUtil.FetchLong(oCmd.Parameters.Item("@SQDimPos_S").Value)
      .SQDimNeg_I = moUtil.FetchLong(oCmd.Parameters.Item("@SQDimNeg_I").Value)
      .SQDimNeg_E = moUtil.FetchLong(oCmd.Parameters.Item("@SQDimNeg_E").Value)
      .SQDimNeg_S = moUtil.FetchLong(oCmd.Parameters.Item("@SQDimNeg_S").Value)
      .SQIntCate_I = moUtil.FetchLong(oCmd.Parameters.Item("@SQIntCate_I").Value)
      .SQIntCate_E = moUtil.FetchLong(oCmd.Parameters.Item("@SQIntCate_E").Value)
      .SQIntCate_S = moUtil.FetchLong(oCmd.Parameters.Item("@SQIntCate_S").Value)
      .SQInt = moUtil.FetchLong(oCmd.Parameters.Item("@SQInt").Value)
      .SQIntPerc = moUtil.FetchLong(oCmd.Parameters.Item("@SQIntPerc").Value)
      .SQDI = moUtil.FetchLong(oCmd.Parameters.Item("@SQDI").Value)
      .SQDIS = moUtil.FetchLong(oCmd.Parameters.Item("@SQDIS").Value)
      .SQLeft = moUtil.FetchLong(oCmd.Parameters.Item("@SQLeft").Value)
      .SQRight = moUtil.FetchLong(oCmd.Parameters.Item("@SQRight").Value)
      .SQAI = moUtil.FetchLong(oCmd.Parameters.Item("@SQAI").Value)
      .BQrLeft = moUtil.FetchCurrency(oCmd.Parameters.Item("@BQrLeft").Value)
      .BQrRight = moUtil.FetchCurrency(oCmd.Parameters.Item("@BQrRight").Value)
      .BQaLeft = moUtil.FetchLong(oCmd.Parameters.Item("@BQaLeft").Value)
      .BQaRight = moUtil.FetchLong(oCmd.Parameters.Item("@BQaRight").Value)
      .CQLeft = moUtil.FetchLong(oCmd.Parameters.Item("@CQLeft").Value)
      .CQRight = moUtil.FetchLong(oCmd.Parameters.Item("@CQRight").Value)
      .RQLeft = moUtil.FetchCurrency(oCmd.Parameters.Item("@RQLeft").Value)
      .RQRight = moUtil.FetchCurrency(oCmd.Parameters.Item("@RQRight").Value)
      .VQClarity_I = moUtil.FetchLong(oCmd.Parameters.Item("@VQClarity_I").Value)
      .VQClarity_E = moUtil.FetchLong(oCmd.Parameters.Item("@VQClarity_E").Value)
      .VQClarity_S = moUtil.FetchLong(oCmd.Parameters.Item("@VQClarity_S").Value)
      .VQBias_I = moUtil.FetchLong(oCmd.Parameters.Item("@VQBias_I").Value)
      .VQBias_E = moUtil.FetchLong(oCmd.Parameters.Item("@VQBias_E").Value)
      .VQBias_S = moUtil.FetchLong(oCmd.Parameters.Item("@VQBias_S").Value)
      .SQClarity_I = moUtil.FetchLong(oCmd.Parameters.Item("@SQClarity_I").Value)
      .SQClarity_E = moUtil.FetchLong(oCmd.Parameters.Item("@SQClarity_E").Value)
      .SQClarity_S = moUtil.FetchLong(oCmd.Parameters.Item("@SQClarity_S").Value)
      .SQBias_I = moUtil.FetchLong(oCmd.Parameters.Item("@SQBias_I").Value)
      .SQBias_E = moUtil.FetchLong(oCmd.Parameters.Item("@SQBias_E").Value)
      .SQBias_S = moUtil.FetchLong(oCmd.Parameters.Item("@SQBias_S").Value)
      .xVQClarity_I = moUtil.FetchLong(oCmd.Parameters.Item("@xVQClarity_I").Value)
      .xVQClarity_E = moUtil.FetchLong(oCmd.Parameters.Item("@xVQClarity_E").Value)
      .xVQClarity_S = moUtil.FetchLong(oCmd.Parameters.Item("@xVQClarity_S").Value)
      .xVQBias_I = moUtil.FetchCurrency(oCmd.Parameters.Item("@xVQBias_I").Value)
      .xVQBias_E = moUtil.FetchCurrency(oCmd.Parameters.Item("@xVQBias_E").Value)
      .xVQBias_S = moUtil.FetchCurrency(oCmd.Parameters.Item("@xVQBias_S").Value)
      .xSQClarity_I = moUtil.FetchLong(oCmd.Parameters.Item("@xSQClarity_I").Value)
      .xSQClarity_E = moUtil.FetchLong(oCmd.Parameters.Item("@xSQClarity_E").Value)
      .xSQClarity_S = moUtil.FetchLong(oCmd.Parameters.Item("@xSQClarity_S").Value)
      .xSQBias_I = moUtil.FetchCurrency(oCmd.Parameters.Item("@xSQBias_I").Value)
      .xSQBias_E = moUtil.FetchCurrency(oCmd.Parameters.Item("@xSQBias_E").Value)
      .xSQBias_S = moUtil.FetchCurrency(oCmd.Parameters.Item("@xSQBias_S").Value)
   End With

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function ListMember( _ 
   ByVal bvMemberID As Long) As tProfileType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProfileType
   Dim vRec As tProfileType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Profile_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProfileID = moUtil.FetchLong(.Fields.Item("ProfileID").Value)
            vRec.ProfileDate = moUtil.FetchDate(.Fields.Item("ProfileDate").Value)
            vRec.ProfileType = moUtil.FetchLong(.Fields.Item("ProfileType").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.VQClarity_I = moUtil.FetchLong(.Fields.Item("VQClarity_I").Value)
            vRec.VQClarity_E = moUtil.FetchLong(.Fields.Item("VQClarity_E").Value)
            vRec.VQClarity_S = moUtil.FetchLong(.Fields.Item("VQClarity_S").Value)
            vRec.VQBias_I = moUtil.FetchLong(.Fields.Item("VQBias_I").Value)
            vRec.VQBias_E = moUtil.FetchLong(.Fields.Item("VQBias_E").Value)
            vRec.VQBias_S = moUtil.FetchLong(.Fields.Item("VQBias_S").Value)
            vRec.SQClarity_I = moUtil.FetchLong(.Fields.Item("SQClarity_I").Value)
            vRec.SQClarity_E = moUtil.FetchLong(.Fields.Item("SQClarity_E").Value)
            vRec.SQClarity_S = moUtil.FetchLong(.Fields.Item("SQClarity_S").Value)
            vRec.SQBias_I = moUtil.FetchLong(.Fields.Item("SQBias_I").Value)
            vRec.SQBias_E = moUtil.FetchLong(.Fields.Item("SQBias_E").Value)
            vRec.SQBias_S = moUtil.FetchLong(.Fields.Item("SQBias_S").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMember = vRecs

   '-----clean up
   Set oRecs = Nothing
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oRecs = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Update( _ 
   ByRef brRec As tProfileType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Updates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Update"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   Validate brRec, bvUserID

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProfileID", adInteger, adParamInput, vbNull, CLng(brRec.ProfileID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProfileDate", adDate, adParamInput, vbNull, CDate(brRec.ProfileDate))
      .Parameters.Append .CreateParameter("@ProfileType", adInteger, adParamInput, vbNull, CLng(brRec.ProfileType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@VQResponse", adVarWChar, adParamInput, 50, brRec.VQResponse)
      .Parameters.Append .CreateParameter("@SQResponse", adVarWChar, adParamInput, 50, brRec.SQResponse)
      .Parameters.Append .CreateParameter("@VQDiff", adInteger, adParamInput, vbNull, CLng(brRec.VQDiff))
      .Parameters.Append .CreateParameter("@VQDimPerc", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPerc))
      .Parameters.Append .CreateParameter("@VQDimPos_I", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPos_I))
      .Parameters.Append .CreateParameter("@VQDimPos_E", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPos_E))
      .Parameters.Append .CreateParameter("@VQDimPos_S", adInteger, adParamInput, vbNull, CLng(brRec.VQDimPos_S))
      .Parameters.Append .CreateParameter("@VQDimNeg_I", adInteger, adParamInput, vbNull, CLng(brRec.VQDimNeg_I))
      .Parameters.Append .CreateParameter("@VQDimNeg_E", adInteger, adParamInput, vbNull, CLng(brRec.VQDimNeg_E))
      .Parameters.Append .CreateParameter("@VQDimNeg_S", adInteger, adParamInput, vbNull, CLng(brRec.VQDimNeg_S))
      .Parameters.Append .CreateParameter("@VQIntCate_I", adInteger, adParamInput, vbNull, CLng(brRec.VQIntCate_I))
      .Parameters.Append .CreateParameter("@VQIntCate_E", adInteger, adParamInput, vbNull, CLng(brRec.VQIntCate_E))
      .Parameters.Append .CreateParameter("@VQIntCate_S", adInteger, adParamInput, vbNull, CLng(brRec.VQIntCate_S))
      .Parameters.Append .CreateParameter("@VQInt", adInteger, adParamInput, vbNull, CLng(brRec.VQInt))
      .Parameters.Append .CreateParameter("@VQIntPerc", adInteger, adParamInput, vbNull, CLng(brRec.VQIntPerc))
      .Parameters.Append .CreateParameter("@VQDI", adInteger, adParamInput, vbNull, CLng(brRec.VQDI))
      .Parameters.Append .CreateParameter("@VQDIS", adInteger, adParamInput, vbNull, CLng(brRec.VQDIS))
      .Parameters.Append .CreateParameter("@VQLeft", adInteger, adParamInput, vbNull, CLng(brRec.VQLeft))
      .Parameters.Append .CreateParameter("@VQRight", adInteger, adParamInput, vbNull, CLng(brRec.VQRight))
      .Parameters.Append .CreateParameter("@VQAI", adInteger, adParamInput, vbNull, CLng(brRec.VQAI))
      .Parameters.Append .CreateParameter("@SQDiff", adInteger, adParamInput, vbNull, CLng(brRec.SQDiff))
      .Parameters.Append .CreateParameter("@SQDimPerc", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPerc))
      .Parameters.Append .CreateParameter("@SQDimPos_I", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPos_I))
      .Parameters.Append .CreateParameter("@SQDimPos_E", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPos_E))
      .Parameters.Append .CreateParameter("@SQDimPos_S", adInteger, adParamInput, vbNull, CLng(brRec.SQDimPos_S))
      .Parameters.Append .CreateParameter("@SQDimNeg_I", adInteger, adParamInput, vbNull, CLng(brRec.SQDimNeg_I))
      .Parameters.Append .CreateParameter("@SQDimNeg_E", adInteger, adParamInput, vbNull, CLng(brRec.SQDimNeg_E))
      .Parameters.Append .CreateParameter("@SQDimNeg_S", adInteger, adParamInput, vbNull, CLng(brRec.SQDimNeg_S))
      .Parameters.Append .CreateParameter("@SQIntCate_I", adInteger, adParamInput, vbNull, CLng(brRec.SQIntCate_I))
      .Parameters.Append .CreateParameter("@SQIntCate_E", adInteger, adParamInput, vbNull, CLng(brRec.SQIntCate_E))
      .Parameters.Append .CreateParameter("@SQIntCate_S", adInteger, adParamInput, vbNull, CLng(brRec.SQIntCate_S))
      .Parameters.Append .CreateParameter("@SQInt", adInteger, adParamInput, vbNull, CLng(brRec.SQInt))
      .Parameters.Append .CreateParameter("@SQIntPerc", adInteger, adParamInput, vbNull, CLng(brRec.SQIntPerc))
      .Parameters.Append .CreateParameter("@SQDI", adInteger, adParamInput, vbNull, CLng(brRec.SQDI))
      .Parameters.Append .CreateParameter("@SQDIS", adInteger, adParamInput, vbNull, CLng(brRec.SQDIS))
      .Parameters.Append .CreateParameter("@SQLeft", adInteger, adParamInput, vbNull, CLng(brRec.SQLeft))
      .Parameters.Append .CreateParameter("@SQRight", adInteger, adParamInput, vbNull, CLng(brRec.SQRight))
      .Parameters.Append .CreateParameter("@SQAI", adInteger, adParamInput, vbNull, CLng(brRec.SQAI))
      .Parameters.Append .CreateParameter("@BQrLeft", adCurrency, adParamInput, vbNull, CCur(brRec.BQrLeft))
      .Parameters.Append .CreateParameter("@BQrRight", adCurrency, adParamInput, vbNull, CCur(brRec.BQrRight))
      .Parameters.Append .CreateParameter("@BQaLeft", adInteger, adParamInput, vbNull, CLng(brRec.BQaLeft))
      .Parameters.Append .CreateParameter("@BQaRight", adInteger, adParamInput, vbNull, CLng(brRec.BQaRight))
      .Parameters.Append .CreateParameter("@CQLeft", adInteger, adParamInput, vbNull, CLng(brRec.CQLeft))
      .Parameters.Append .CreateParameter("@CQRight", adInteger, adParamInput, vbNull, CLng(brRec.CQRight))
      .Parameters.Append .CreateParameter("@RQLeft", adCurrency, adParamInput, vbNull, CCur(brRec.RQLeft))
      .Parameters.Append .CreateParameter("@RQRight", adCurrency, adParamInput, vbNull, CCur(brRec.RQRight))
      .Parameters.Append .CreateParameter("@VQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.VQClarity_I))
      .Parameters.Append .CreateParameter("@VQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.VQClarity_E))
      .Parameters.Append .CreateParameter("@VQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.VQClarity_S))
      .Parameters.Append .CreateParameter("@VQBias_I", adInteger, adParamInput, vbNull, CLng(brRec.VQBias_I))
      .Parameters.Append .CreateParameter("@VQBias_E", adInteger, adParamInput, vbNull, CLng(brRec.VQBias_E))
      .Parameters.Append .CreateParameter("@VQBias_S", adInteger, adParamInput, vbNull, CLng(brRec.VQBias_S))
      .Parameters.Append .CreateParameter("@SQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.SQClarity_I))
      .Parameters.Append .CreateParameter("@SQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.SQClarity_E))
      .Parameters.Append .CreateParameter("@SQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.SQClarity_S))
      .Parameters.Append .CreateParameter("@SQBias_I", adInteger, adParamInput, vbNull, CLng(brRec.SQBias_I))
      .Parameters.Append .CreateParameter("@SQBias_E", adInteger, adParamInput, vbNull, CLng(brRec.SQBias_E))
      .Parameters.Append .CreateParameter("@SQBias_S", adInteger, adParamInput, vbNull, CLng(brRec.SQBias_S))
      .Parameters.Append .CreateParameter("@xVQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.xVQClarity_I))
      .Parameters.Append .CreateParameter("@xVQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.xVQClarity_E))
      .Parameters.Append .CreateParameter("@xVQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.xVQClarity_S))
      .Parameters.Append .CreateParameter("@xVQBias_I", adCurrency, adParamInput, vbNull, CCur(brRec.xVQBias_I))
      .Parameters.Append .CreateParameter("@xVQBias_E", adCurrency, adParamInput, vbNull, CCur(brRec.xVQBias_E))
      .Parameters.Append .CreateParameter("@xVQBias_S", adCurrency, adParamInput, vbNull, CCur(brRec.xVQBias_S))
      .Parameters.Append .CreateParameter("@xSQClarity_I", adInteger, adParamInput, vbNull, CLng(brRec.xSQClarity_I))
      .Parameters.Append .CreateParameter("@xSQClarity_E", adInteger, adParamInput, vbNull, CLng(brRec.xSQClarity_E))
      .Parameters.Append .CreateParameter("@xSQClarity_S", adInteger, adParamInput, vbNull, CLng(brRec.xSQClarity_S))
      .Parameters.Append .CreateParameter("@xSQBias_I", adCurrency, adParamInput, vbNull, CCur(brRec.xSQBias_I))
      .Parameters.Append .CreateParameter("@xSQBias_E", adCurrency, adParamInput, vbNull, CCur(brRec.xSQBias_E))
      .Parameters.Append .CreateParameter("@xSQBias_S", adCurrency, adParamInput, vbNull, CCur(brRec.xSQBias_S))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Profile_Update"

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Validate( _ 
   ByRef brRec As tProfileType, _ 
   ByVal bvUserID As Long, _ 
   Optional ByVal bvNew As Integer = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Validates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Validate"
   '------------------------------------------------------------------------------------------------------------------------

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      If bvNew = 0 Then
         .ProfileID = moUtil.EditLong(.ProfileID, "ProfileID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .ProfileDate = moUtil.EditDate(.ProfileDate, "ProfileDate", False) 
      .ProfileType = moUtil.EditLong(.ProfileType, "ProfileType", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .VQResponse = moUtil.EditString(.VQResponse, "VQResponse", False) 
      .SQResponse = moUtil.EditString(.SQResponse, "SQResponse", False) 
      .VQDiff = moUtil.EditLong(.VQDiff, "VQDiff", False) 
      .VQDimPerc = moUtil.EditLong(.VQDimPerc, "VQDimPerc", False) 
      .VQDimPos_I = moUtil.EditLong(.VQDimPos_I, "VQDimPos_I", False) 
      .VQDimPos_E = moUtil.EditLong(.VQDimPos_E, "VQDimPos_E", False) 
      .VQDimPos_S = moUtil.EditLong(.VQDimPos_S, "VQDimPos_S", False) 
      .VQDimNeg_I = moUtil.EditLong(.VQDimNeg_I, "VQDimNeg_I", False) 
      .VQDimNeg_E = moUtil.EditLong(.VQDimNeg_E, "VQDimNeg_E", False) 
      .VQDimNeg_S = moUtil.EditLong(.VQDimNeg_S, "VQDimNeg_S", False) 
      .VQIntCate_I = moUtil.EditLong(.VQIntCate_I, "VQIntCate_I", False) 
      .VQIntCate_E = moUtil.EditLong(.VQIntCate_E, "VQIntCate_E", False) 
      .VQIntCate_S = moUtil.EditLong(.VQIntCate_S, "VQIntCate_S", False) 
      .VQInt = moUtil.EditLong(.VQInt, "VQInt", False) 
      .VQIntPerc = moUtil.EditLong(.VQIntPerc, "VQIntPerc", False) 
      .VQDI = moUtil.EditLong(.VQDI, "VQDI", False) 
      .VQDIS = moUtil.EditLong(.VQDIS, "VQDIS", False) 
      .VQLeft = moUtil.EditLong(.VQLeft, "VQLeft", False) 
      .VQRight = moUtil.EditLong(.VQRight, "VQRight", False) 
      .VQAI = moUtil.EditLong(.VQAI, "VQAI", False) 
      .SQDiff = moUtil.EditLong(.SQDiff, "SQDiff", False) 
      .SQDimPerc = moUtil.EditLong(.SQDimPerc, "SQDimPerc", False) 
      .SQDimPos_I = moUtil.EditLong(.SQDimPos_I, "SQDimPos_I", False) 
      .SQDimPos_E = moUtil.EditLong(.SQDimPos_E, "SQDimPos_E", False) 
      .SQDimPos_S = moUtil.EditLong(.SQDimPos_S, "SQDimPos_S", False) 
      .SQDimNeg_I = moUtil.EditLong(.SQDimNeg_I, "SQDimNeg_I", False) 
      .SQDimNeg_E = moUtil.EditLong(.SQDimNeg_E, "SQDimNeg_E", False) 
      .SQDimNeg_S = moUtil.EditLong(.SQDimNeg_S, "SQDimNeg_S", False) 
      .SQIntCate_I = moUtil.EditLong(.SQIntCate_I, "SQIntCate_I", False) 
      .SQIntCate_E = moUtil.EditLong(.SQIntCate_E, "SQIntCate_E", False) 
      .SQIntCate_S = moUtil.EditLong(.SQIntCate_S, "SQIntCate_S", False) 
      .SQInt = moUtil.EditLong(.SQInt, "SQInt", False) 
      .SQIntPerc = moUtil.EditLong(.SQIntPerc, "SQIntPerc", False) 
      .SQDI = moUtil.EditLong(.SQDI, "SQDI", False) 
      .SQDIS = moUtil.EditLong(.SQDIS, "SQDIS", False) 
      .SQLeft = moUtil.EditLong(.SQLeft, "SQLeft", False) 
      .SQRight = moUtil.EditLong(.SQRight, "SQRight", False) 
      .SQAI = moUtil.EditLong(.SQAI, "SQAI", False) 
      .BQrLeft = moUtil.EditCurrency(.BQrLeft, "BQrLeft", False) 
      .BQrRight = moUtil.EditCurrency(.BQrRight, "BQrRight", False) 
      .BQaLeft = moUtil.EditLong(.BQaLeft, "BQaLeft", False) 
      .BQaRight = moUtil.EditLong(.BQaRight, "BQaRight", False) 
      .CQLeft = moUtil.EditLong(.CQLeft, "CQLeft", False) 
      .CQRight = moUtil.EditLong(.CQRight, "CQRight", False) 
      .RQLeft = moUtil.EditCurrency(.RQLeft, "RQLeft", False) 
      .RQRight = moUtil.EditCurrency(.RQRight, "RQRight", False) 
      .VQClarity_I = moUtil.EditLong(.VQClarity_I, "VQClarity_I", False) 
      .VQClarity_E = moUtil.EditLong(.VQClarity_E, "VQClarity_E", False) 
      .VQClarity_S = moUtil.EditLong(.VQClarity_S, "VQClarity_S", False) 
      .VQBias_I = moUtil.EditLong(.VQBias_I, "VQBias_I", False) 
      .VQBias_E = moUtil.EditLong(.VQBias_E, "VQBias_E", False) 
      .VQBias_S = moUtil.EditLong(.VQBias_S, "VQBias_S", False) 
      .SQClarity_I = moUtil.EditLong(.SQClarity_I, "SQClarity_I", False) 
      .SQClarity_E = moUtil.EditLong(.SQClarity_E, "SQClarity_E", False) 
      .SQClarity_S = moUtil.EditLong(.SQClarity_S, "SQClarity_S", False) 
      .SQBias_I = moUtil.EditLong(.SQBias_I, "SQBias_I", False) 
      .SQBias_E = moUtil.EditLong(.SQBias_E, "SQBias_E", False) 
      .SQBias_S = moUtil.EditLong(.SQBias_S, "SQBias_S", False) 
      .xVQClarity_I = moUtil.EditLong(.xVQClarity_I, "xVQClarity_I", False) 
      .xVQClarity_E = moUtil.EditLong(.xVQClarity_E, "xVQClarity_E", False) 
      .xVQClarity_S = moUtil.EditLong(.xVQClarity_S, "xVQClarity_S", False) 
      .xVQBias_I = moUtil.EditCurrency(.xVQBias_I, "xVQBias_I", False) 
      .xVQBias_E = moUtil.EditCurrency(.xVQBias_E, "xVQBias_E", False) 
      .xVQBias_S = moUtil.EditCurrency(.xVQBias_S, "xVQBias_S", False) 
      .xSQClarity_I = moUtil.EditLong(.xSQClarity_I, "xSQClarity_I", False) 
      .xSQClarity_E = moUtil.EditLong(.xSQClarity_E, "xSQClarity_E", False) 
      .xSQClarity_S = moUtil.EditLong(.xSQClarity_S, "xSQClarity_S", False) 
      .xSQBias_I = moUtil.EditCurrency(.xSQBias_I, "xSQBias_I", False) 
      .xSQBias_E = moUtil.EditCurrency(.xSQBias_E, "xSQBias_E", False) 
      .xSQBias_S = moUtil.EditCurrency(.xSQBias_S, "xSQBias_S", False) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Private Sub Class_Initialize()
   Set moSys = New wtSystem.CSystem
   Set moUtil = New wtSystem.CUtility
End Sub

Private Sub Class_Terminate()
   Set moSys = Nothing
   Set moUtil = Nothing
End Sub