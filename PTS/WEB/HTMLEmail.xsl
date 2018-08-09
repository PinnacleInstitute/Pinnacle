<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="CSSEmail.xsl"/>

	<xsl:template name="HTMLEmail">
		<xsl:param name="pagename"/>

		<xsl:element name="HEAD">

			<xsl:element name="TITLE">
				<xsl:value-of select="$pagename"/>
			</xsl:element>

			<xsl:element name="META">
				<xsl:attribute name="HTTP-EQUIV">Pragma</xsl:attribute>
				<xsl:attribute name="CONTENT">no-cache</xsl:attribute>
			</xsl:element>

			<xsl:call-template name="CSSEmail"/>

		</xsl:element>	
	</xsl:template>

</xsl:stylesheet>
