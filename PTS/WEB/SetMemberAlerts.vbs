'*****************************************************************************
' Set Alerts for all Members
'*****************************************************************************
On Error Resume Next

Set oCloudZow = CreateObject("ptsCloudZowUser.CCloudZow")
oCloudZow.Custom 11, 0, 0, 0
Set oCloudZow = Nothing
