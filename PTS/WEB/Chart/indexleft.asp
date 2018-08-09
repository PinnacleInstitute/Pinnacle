<html>
<script language="Javascript">
var charts = [
    ['', "Pie Chart Samples"],
    ['simplepie.asp', "Simple Pie Chart", 1],
    ['threedpie.asp', "3D Pie Chart", 1],
    ['multidepthpie.asp', "Multi-Depth Pie Chart", 1],
    ['sidelabelpie.asp', "Side Label Layout", 1],
    ['circlelabelpie.asp', "Circular Label Layout", 2],
    ['legendpie.asp', "Pie Chart with Legend", 1],
    ['smallsectorpie.asp', "Pie with Small Sectors", 1],
    ['iconpie.asp', "Icon Pie Chart", 1],
    ['iconpie2.asp', "Icon Pie Chart (2)", 1],
    ['fontpie.asp', "Text Style and Colors", 1],
    ['goldpie.asp', "Metallic Background Coloring", 1],
    ['colorpie.asp', "Coloring and Wallpaper", 4],
    ['borderpie.asp', "Sectors with Borders", 1],
    ['threedanglepie.asp', "3D Angle", 7],
    ['threeddepthpie.asp', "3D Depth", 5],
    ['shadowpie.asp', "3D Shadow Mode", 4],
    ['anglepie.asp', "Start Angle and Direction", 2],
    ['', ""],
    ['', "Bar Chart Samples"],
    ['simplebar.asp', "Simple Bar Chart", 1],
    ['threedbar.asp', "3D Bar Chart", 1],
    ['colorbar.asp', "Multi-Color Bar Chart", 1],
    ['stackedbar.asp', "Stacked Bar Chart", 1],
    ['percentbar.asp', "Percentage Bar Chart", 1],
    ['multibar.asp', "Multi-Bar Chart", 1],
    ['multistackbar.asp', "Multi-Stacked Bar Chart", 1],
    ['depthbar.asp', "Depth Bar Chart", 1],
    ['posnegbar.asp', "Positive Negative Bars", 1],
    ['hbar.asp', "Borderless Bar Chart", 1],
    ['dualhbar.asp', "Dual Horizontal Bar Charts", 1],
    ['pareto.asp', "Pareto Chart", 1],
    ['gapbar.asp', "Bar Gap", 6],
    ['', ""],
    ['', "Line Chart Samples"],
    ['simpleline.asp', "Simple Line Chart", 1],
    ['enhancedline.asp', "Enhanced Line Chart", 1],
    ['threedline.asp', "3D Line Chart", 1],
    ['multiline.asp', "Multiline Chart", 1],
    ['symbolline.asp', "Symbol Line Chart", 1],
    ['splineline.asp', "Spline Line Chart", 1],
    ['stepline.asp', "Step Line Chart", 1],
    ['linecompare.asp', "Line Comparison", 1],
    ['errline.asp', "Line with Error Symbols", 1],
    ['customsymbolline.asp', "Custom Symbols", 1],
    ['rotatedline.asp', "Rotated Line Chart", 1],
    ['xyline.asp', "Arbitrary XY Line Chart", 1],
    ['discontline.asp', "Discontinuous Lines", 1],
    ['', ""],
    ['', "Trending and Curve Fitting"],
    ['trendline.asp', "Trend Line Chart", 1],
    ['scattertrend.asp', "Scatter Trend Chart", 1],
    ['confidenceband.asp', "Confidence Band", 1],
    ['curvefitting.asp', "General Curve Fitting", 1],
    ['', ""],
    ['', "Scatter/Bubble Charts"],
    ['scatter.asp', "Scatter Chart", 1],
    ['scattersymbols.asp', "Custom Scatter Symbols", 1],
    ['scatterlabels.asp', "Custom Scatter Labels", 1],
    ['bubble.asp', "Bubble Chart", 1],
    ['bubblescale.asp', "Bubble XY Scaling", 1],
    ['', ""],
    ['', "Area Chart Samples"],
    ['simplearea.asp', "Simple Area Chart", 1],
    ['enhancedarea.asp', "Enhanced Area Chart", 1],
    ['threedarea.asp', "3D Area Chart", 1],
    ['patternarea.asp', "Pattern Area Chart", 1],
    ['stackedarea.asp', "Stacked Area Chart", 1],
    ['threedstackarea.asp', "3D Stacked Area Chart", 1],
    ['percentarea.asp', "Percentage Area Chart", 1],
    ['deptharea.asp', "Depth Area Chart", 1],
    ['rotatedarea.asp', "Rotated Area Chart", 1],
    ['', ""],
    ['', "Box Whisker Charts"],
    ['boxwhisker.asp', "Box Whisker Chart", 1],
    ['boxwhisker2.asp', "Box Whisker Chart (2)", 1],
    ['gantt.asp', "Simple Gantt Chart", 1],
    ['', ""],
    ['', "Finance Charts"],
    ['hloc.asp', "Simple HLOC Chart", 1],
    ['candlestick.asp', "Simple Candlestick Chart", 1],
    ['finance.asp', "Finance Chart (1)", 1],
    ['finance2.asp', "Finance Chart (2)", 1],
    ['', ""],
    ['', "Other XY Chart Features"],
    ['markzone.asp', "Marks and Zones", 1],
    ['markzone2.asp', "Marks and Zones (2)", 1],
    ['yzonecolor.asp', "Y Zone Coloring", 1],
    ['xzonecolor.asp', "X Zone Coloring", 1],
    ['dualyaxis.asp', "Dual Y-Axis", 1],
    ['dualxaxis.asp', "Dual X-Axis", 1],
    ['fontxy.asp', "Text Style and Colors", 1],
    ['background.asp', "Background and Wallpaper", 4],
    ['logaxis.asp', "Log Scale Axis", 2],
    ['axisscale.asp', "Y-Axis Scaling", 5],
    ['ticks.asp', "Tick Density", 2],
    ['', ""],
    ['', "Polar Charts"],
    ['simpleradar.asp', "Simple Radar Chart", 1],
    ['multiradar.asp', "Multi Radar Chart", 1],
    ['polarline.asp', "Polar Line Chart", 1],
    ['polarspline.asp', "Polar Spline Chart", 1],
    ['polarscatter.asp', "Polar Scatter Chart", 1],
    ['polarbubble.asp', "Polar Bubble Chart", 1],
    ['polarzones.asp', "Polar Zones", 1],
    ['', ""],
    ['', "Clickable Charts"],
    ['clickbar.asp', "Simple Clickable Charts", 0],
    ['jsarea.asp', "Javascript Clickable Charts", 0],
    ['customclick.asp', "Custom Clickable Objects", 0],
    ['', ""],
    ['', "Working With Database"],
    ['dbdemo1.asp', "Database Integration (1)", 0],
    ['dbdemo2.asp', "Database Integration (2)", 0],
    ['dbdemo3.asp', "Database Clickable Charts", 0],
    ];
function setChart(c)
{
    var doc = top.indexright.document;
    doc.open();
    doc.writeln('<body topmargin="5" leftmargin="5" rightmargin="0" marginwidth="5" marginheight="5">');
    doc.writeln('<div style="font-size:18pt; font-family:verdana; font-weight:bold">' + charts[c][1] + '</div><hr color="#000080">');
    doc.writeln('<a href="viewsource.asp?file=' + charts[c][0] + '"><font size="2" face="Verdana">View Chart Source Code</font></a>');
    doc.writeln('<p>');
    for (var i = 0; i < charts[c][2]; ++i)
        doc.writeln('<img src="' + charts[c][0] + '?img=' + i + '">');

    doc.writeln('</p>');
    doc.writeln('</body>');
    doc.close();
}
</script>
<head>
<style type="text/css">
p.demotitle {margin-top:0; margin-bottom:0; padding-left:3; font-family:verdana; font-weight:bold; font-size:9pt; line-height:140%;}
p.demolink {margin-top:0; margin-bottom:0; padding-left:3; padding-top:2; padding-bottom:1; font-family:verdana; font-size:8pt;}
</style>
<body topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family:verdana; font-size:8pt;">
<script language="Javascript">
for (var c in charts)
{
    if (charts[c][1] == "")
        document.writeln('<tr><td><p class="demolink">&nbsp;</p></td></tr>');
    if (charts[c][0] == "")
        document.writeln('<tr><td colspan="2" bgcolor="#9999FF"><p class="demotitle">' + charts[c][1] + '</p></td></tr>');
    else if (charts[c][2] != 0)
        document.writeln('<tr valign="top"><td><p class="demolink">&#8226;</p></td><td><p class="demolink"><a href="javascript:;" onclick="setChart(\'' + c + '\');">' + charts[c][1] + '</a></p></td></tr>');
    else
        document.writeln('<tr valign="top"><td><p class="demolink">&#8226;</p></td><td><p class="demolink"><a href="' + charts[c][0] + '" target="indexright">' + charts[c][1] + '</a></p></td></tr>');
}
</script>
</table>
</body>
</html>
