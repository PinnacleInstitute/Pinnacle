<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="appprefix">PTS</xsl:variable>
	<xsl:variable name="apos"><xsl:text>&apos;</xsl:text></xsl:variable>
	<xsl:variable name="cr" select="'&#010;'"/>
	<xsl:variable name="tab" select="'&#009;'"/>
<!--
	<xsl:variable name="cr" select="''"/>
	<xsl:variable name="tab" select="''"/>
-->
	<!--==========QualifiedType=======-->
	<xsl:template name="QualifiedType">
		<xsl:param name="value"/>
		<xsl:variable name="text">
			<xsl:choose>
				<xsl:when test="(substring($value, 1, 4) = 'JAVA')">JAVA</xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'CONST')">CONST</xsl:when>
				<xsl:otherwise>NONE</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$text"/>
	</xsl:template>

	<!--==========QualifiedValue=========-->
	<xsl:template name="QualifiedValue">
		<xsl:param name="value"/>
		<xsl:variable name="text">
			<xsl:choose>
				<xsl:when test="(substring($value, 1, 4) = 'JAVA')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'CONST')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="(substring($value, 1, 5) = 'CONST')"><xsl:value-of select="($text)"/></xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'JAVA')"><xsl:value-of select="($text)"/></xsl:when>
			<xsl:when test="contains($text, '.')"><xsl:value-of select="substring-after($text,'.')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="($text)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==========QualifiedPrefix=========-->
	<xsl:template name="QualifiedPrefix">
		<xsl:param name="value"/>
		<xsl:variable name="text">
			<xsl:choose>
				<xsl:when test="(substring($value, 1, 4) = 'JAVA')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'CONST')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="(substring($value, 1, 5) = 'CONST')"></xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'JAVA')"></xsl:when>
			<xsl:when test="contains($text, '.')"><xsl:value-of select="substring-before($text,'.')"/></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
