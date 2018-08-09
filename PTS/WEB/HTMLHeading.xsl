<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="HTMLHeading">
		<xsl:param name="pagename"/>
		<xsl:param name="includecalendar" select="false()"/>
		<xsl:param name="htmleditor"/>
		<xsl:param name="pageenter"/>
		<xsl:param name="description"/>
		<xsl:param name="content"/>
		<xsl:param name="keywords"/>
		<xsl:param name="viewport"/>
		<xsl:param name="ogtitle"/>
		<xsl:param name="ogimage"/>
		<xsl:param name="translate"/>

		<xsl:element name="HEAD">

			<xsl:if test="/DATA/PARAM/@printurl">
				<xsl:element name="link">
					<xsl:attribute name="rel">alternate</xsl:attribute>
					<xsl:attribute name="media">print</xsl:attribute>
					<xsl:attribute name="href"><xsl:value-of select="/DATA/PARAM/@printurl"/></xsl:attribute>
				</xsl:element>
			</xsl:if>

			<xsl:element name="TITLE">
				<xsl:value-of select="$pagename"/>
			</xsl:element>

			<xsl:if test="$pageenter!=''">
				<xsl:element name="meta">
				   <xsl:attribute name="http-equiv">Page-Enter</xsl:attribute>
				   <xsl:attribute name="content"><xsl:value-of select="$pageenter"/></xsl:attribute>
				</xsl:element>
			</xsl:if>

			<xsl:element name="META">
				<xsl:attribute name="HTTP-EQUIV">Pragma</xsl:attribute>
				<xsl:attribute name="CONTENT">no-cache</xsl:attribute>
			</xsl:element>

			<xsl:if test="$description!=''">
				<xsl:element name="meta">
				   <xsl:attribute name="name">description</xsl:attribute>
				   <xsl:attribute name="content"><xsl:value-of select="$description"/></xsl:attribute>
				</xsl:element>
			</xsl:if>

			<xsl:if test="$content!=''">
				<xsl:element name="meta">
				   <xsl:attribute name="name">content</xsl:attribute>
				   <xsl:attribute name="content"><xsl:value-of select="$content"/></xsl:attribute>
				</xsl:element>
			</xsl:if>

			<xsl:if test="$keywords!=''">
				<xsl:element name="meta">
					<xsl:attribute name="name">keywords</xsl:attribute>
					<xsl:attribute name="content">
						<xsl:value-of select="$keywords"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:if>
			
			<xsl:if test="$viewport!=''">
				<xsl:element name="meta">
					<xsl:attribute name="name">viewport</xsl:attribute>
					<xsl:attribute name="content"><xsl:value-of select="$viewport"/></xsl:attribute>
				</xsl:element>
			</xsl:if>

			<xsl:if test="$ogtitle!=''">
				<xsl:element name="meta">
				   <xsl:attribute name="name">og:title</xsl:attribute>
				   <xsl:attribute name="content"><xsl:value-of select="$ogtitle"/></xsl:attribute>
				</xsl:element>
			</xsl:if>
			<xsl:if test="$ogimage!=''">
				<xsl:element name="meta">
				   <xsl:attribute name="name">og:image</xsl:attribute>
				   <xsl:attribute name="content"><xsl:value-of select="$ogimage"/></xsl:attribute>
				</xsl:element>
			</xsl:if>

			<xsl:if test="$translate='google'">
				<xsl:element name="meta">
					<xsl:attribute name="name">google-translate-customization</xsl:attribute>
					<xsl:attribute name="content">49724c083f22a4e1-ef1170ddd0729a4f-g9b9bb561cd5e683d-11</xsl:attribute>
				</xsl:element>
			</xsl:if>

			<xsl:if test="$includecalendar">
				<xsl:element name="SCRIPT">
					<xsl:attribute name="language">JavaScript</xsl:attribute>
					<xsl:attribute name="src">Include/wtcalendar.js</xsl:attribute>
					<xsl:text> </xsl:text>
				</xsl:element>
			</xsl:if>

			<xsl:element name="SCRIPT">
				<xsl:attribute name="language">JavaScript</xsl:attribute>
					<![CDATA[   function doSubmit (iAction, sMsg) { document.forms[0].ActionCode.value = iAction; if( sMsg.length != 0 ) { if( ! confirm( sMsg ) ) { return; } } document.forms[0].submit();} ]]>
					<![CDATA[   function doErrorMsg (sError) { alert(sError); }  ]]>
					<![CDATA[   function doMaxLenMsg (iLength){alert("]]><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MaxLength']"/><![CDATA[" + iLength);}]]>
					<xsl:if test="$includecalendar">
            <![CDATA[   function CalendarPopup(frm, fld) {  displayDatePicker(fld.name, fld);} ]]>
            <![CDATA[   parent.window.scroll(0,0); ]]>
          </xsl:if>
			</xsl:element>

			<xsl:if test="$htmleditor!=''">
				<xsl:element name="SCRIPT">
					<xsl:attribute name="language">JavaScript</xsl:attribute>
					<xsl:attribute name="src">CKEditor4/CKEditor.js</xsl:attribute>
					<xsl:text> </xsl:text>
				</xsl:element>
			</xsl:if>

		</xsl:element>
	</xsl:template>

	<xsl:template name="FormatTime">
		<xsl:param name="tmp"/>
		<xsl:param name="timezone" select="'PST'"/>
		<xsl:choose>
		<xsl:when test="$tmp = 0">
		    <xsl:value-of select="concat('12:00 am ', $timezone)"/>
		</xsl:when>
		<xsl:when test="$tmp &lt; 100">
		    <xsl:value-of select="concat('12:', format-number($tmp,'#0'), ' am ', $timezone)"/>
		</xsl:when>
		<xsl:when test="$tmp &lt; 1000">
		    <xsl:value-of select="concat(format-number($tmp div 100,'#0'), ':', substring($tmp,2,2), ' am ', $timezone)"/>
		</xsl:when>
		<xsl:when test="$tmp &lt; 1200">
		    <xsl:value-of select="concat(format-number($tmp div 100,'#0'), ':', substring($tmp,3,2), ' am ', $timezone)"/>
		</xsl:when>
		<xsl:when test="$tmp &lt; 1300">
		    <xsl:value-of select="concat('12:', substring($tmp,3,2), ' pm ', $timezone)"/>
		</xsl:when>
		<xsl:otherwise>
		    <xsl:value-of select="concat(format-number($tmp div 100-12,'#0'), ':', substring($tmp,3,2), ' pm ', $timezone)"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
