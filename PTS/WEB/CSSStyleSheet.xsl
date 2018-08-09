<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="CSSStyleSheet">
			<xsl:element name="STYLE">
				BODY {FONT-SIZE: 9pt; FONT-FAMILY: Verdana}
				A:link {COLOR: #000000; TEXT-DECORATION: none}
				A {COLOR: #000000}
				A:visited {TEXT-DECORATION: none}
				A:hover {COLOR: #0066FF}
				A.NavBar {COLOR: #0033CC; TEXT-DECORATION: none; FONT-WEIGHT: bold}
				.PageLink A, .PageLink A:visited, .PageLink A:hover {!important; COLOR: #0066FF; FONT-WEIGHT: bold; FONT-SIZE: 9pt; !important; TEXT-DECORATION: none;}
				.PageLink A:hover {!important; COLOR: #0066FF; FONT-WEIGHT: bold; FONT-SIZE: 9pt; !important; TEXT-DECORATION: underline; }
				.PageLinkNormal A, .PageLink A:visited, .PageLink A:hover {!important; COLOR: #0033CC; FONT-WEIGHT: bold; FONT-SIZE: 9pt; !important; TEXT-DECORATION: none;}
				.SelectLink A, .SelectLink A:visited {!important; COLOR: #0033CC; !important; TEXT-DECORATION: underline; }
				.SelectLink A:hover {!important; COLOR: #0066FF; !important; TEXT-DECORATION: underline; }
				.CustNavGroup, .CustNavGroup TD {!important; COLOR: #000000; FONT-WEIGHT: bold; FONT-SIZE: 10 pt}
				.CustNavItem A:hover {!important; FONT-WEIGHT:bold;}
				TD {FONT-SIZE: 9pt; FONT-FAMILY: Arial, Helvetica, Sans-Serif}
				.NavBar {!important; COLOR: #0033CC; FONT-WEIGHT: bold; FONT-SIZE: 9pt; TEXT-DECORATION: none; }
				.PageHeading {COLOR: #000000; FONT-SIZE: 13pt; FONT-WEIGHT: bold}
				.PageHeadingUnderline {COLOR: #000000; FONT-SIZE: 13pt; FONT-WEIGHT: bold; TEXT-DECORATION: underline;}
				.ReverseHeading {COLOR: #FFFFFF; FONT-SIZE: 9pt; FONT-WEIGHT: bold}
				.Copyright {COLOR: #000000; FONT-SIZE: 8pt; FONT-STYLE: Italic}
				.Button {FONT-SIZE: 9pt; FONT-WEIGHT: bolder; MARGIN-LEFT: 0px; MARGIN-RIGHT: 0px; TEXT-ALIGN: center;}
				.AccentTitle {COLOR: white; FONT-SIZE: 12pt; FONT-WEIGHT: bolder; TEXT-DECORATION: none}
				.ColumnHeader {COLOR: #000000; FONT-WEIGHT: bold}
				.FindByColumn {COLOR: #FFFFFF !important; FONT-WEIGHT: bold; BACKGROUND-COLOR: #0033CC}
				.InputHeading {COLOR: #000000; FONT-SIZE: 7pt}
				.DisplayText {COLOR: #000000; FONT-WEIGHT: bold; FONT-SIZE: 11pt}
				.ParentLink {COLOR: #000000; FONT-WEIGHT: bold; FONT-SIZE: 11pt}
				.PrevNext {COLOR: #000000; FONT-WEIGHT: bold; FONT-SIZE: 8pt}
				.PrevNextDisable {COLOR: #808080; FONT-WEIGHT: bold; FONT-SIZE: 8pt}
				.EndList {COLOR: #000000; FONT-WEIGHT: bold}
				.NoItems {BACKGROUND-COLOR: #E9E9FF; COLOR: #000000; FONT-STYLE: Italic}
				.NoItemsSys {FONT-STYLE: Italic}
				.ItemCount {COLOR: #000000; FONT-STYLE: Italic}
				.GrayBar {BACKGROUND-COLOR: #E9E9FF}
				.BoldText {FONT-WEIGHT: bold}
				.BoldMedium {FONT-SIZE: 11pt; COLOR: #000000; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff; FONT-WEIGHT: bold;}
				.BoldLarge {FONT-SIZE: 15pt; COLOR: #000000; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff; FONT-WEIGHT: bold;}
				.BodyMedium {FONT-SIZE: 11pt; COLOR: #000000; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff}
				.BodySmall {FONT-SIZE: 7pt; COLOR: #000000; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff}
				.DarkHeader, .DarkHeader TD {BACKGROUND-COLOR: #800080; COLOR: #FFFFFF; FONT-WEIGHT: bold;  FONT-SIZE: 11pt}
				.DarkHeader A, .DarkHeader A:visited, .DarkHeader A:hover {!important; COLOR: #FFFFFF; !important; TEXT-DECORATION: none; !important; FONT-WEIGHT: normal; FONT-SIZE: 9pt}
				.ScriptSmall {COLOR: #2B4994; FONT-FAMILY: 'Georgia'; FONT-SIZE: 9 pt; FONT-WEIGHT: normal; FONT-STYLE: Italic}
				.WarningSmall {COLOR: #FF0000; FONT-SIZE: 9 pt; FONT-WEIGHT: normal}
				.TableBorder {border-collapse: collapse; border: 1px solid #C0C0C0; padding-left: 4; padding-right: 4; padding-top: 1; padding-bottom: 1;}
				.Prompt {COLOR: #2B4994; FONT-FAMILY: 'Georgia'; FONT-SIZE: 9 pt; FONT-WEIGHT: normal}
				.PromptSys {FONT-FAMILY: 'Georgia'; FONT-SIZE: 9 pt; FONT-WEIGHT: normal}
			</xsl:element>
	</xsl:template>
</xsl:stylesheet>
