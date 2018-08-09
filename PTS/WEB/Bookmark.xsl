<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="FindBy">

	</xsl:template>

	<xsl:template name="PreviousNext">
		<xsl:if test="/DATA/BOOKMARK/@prev='False'">	
			<xsl:attribute name="class">PrevNextDisable</xsl:attribute>
		</xsl:if>
		<xsl:if test="/DATA/BOOKMARK/@next='False'">	
			<xsl:attribute name="class">PrevNextDisable</xsl:attribute>
		</xsl:if>

		<xsl:if test="/DATA/BOOKMARK/@prev='True'">	
			<xsl:element name="A">
				<xsl:attribute name="class">PrevNext</xsl:attribute>
				<xsl:attribute name="href">javascript: doSubmit(6, "")</xsl:attribute>
				<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PreviousPage']"/>
			</xsl:element>	
		</xsl:if>

		<xsl:if test="/DATA/BOOKMARK/@prev='False'">	
			<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PreviousPage']"/>
		</xsl:if>	
		<xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160</xsl:text>

		<xsl:if test="/DATA/BOOKMARK/@next='True'">	
			<xsl:element name="A">
				<xsl:attribute name="class">PrevNext</xsl:attribute>
				<xsl:attribute name="href">javascript: doSubmit(7, "")</xsl:attribute>
				<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextPage']"/>
			</xsl:element>	
		</xsl:if>

		<xsl:if test="/DATA/BOOKMARK/@next='False'">	
			<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextPage']"/>
		</xsl:if>	
	</xsl:template>

</xsl:stylesheet>
