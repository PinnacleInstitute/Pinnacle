<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--	<xsl:include href="wtSystem.xsl"/>-->

	<xsl:template name="DefineTab">
		<xsl:value-of select="$cr"/>
		<xsl:element name="SCRIPT">
			<xsl:attribute name="language">JavaScript</xsl:attribute>
			<xsl:apply-templates select="/DATA/TAB"/>
		</xsl:element>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="TAB">
	<!--==================================================================-->
		<xsl:variable name="ind0" select="''"/>
		<xsl:variable name="ind1" select="$tab"/>

		<xsl:variable name="width">
			<xsl:if test="@width"><xsl:value-of select="@width"/></xsl:if>
			<xsl:if test="not(@width)">600</xsl:if>
		</xsl:variable>

		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind0, 'var ', @name, 'Def = {', $cr)"/>

		<xsl:value-of select="concat($ind1, 'width:' $width, ',', $cr)"/>
		<xsl:value-of select="concat($ind1, 'height:0,', $cr)"/>
		<xsl:value-of select="concat($ind1, 'offset:0,', $cr)"/>
		<xsl:value-of select="concat($ind1, 'spacing:3,', $cr)"/>
		<xsl:value-of select="concat($ind1, 'padding:3,', $cr)"/>
		<xsl:value-of select="concat($ind1, 'layout:&quot;top&quot;,', $cr)"/>
		<xsl:value-of select="concat($ind1, 'border:{width:0,color:&quot;#000000&quot;},', $cr)"/>
		<xsl:value-of select="concat($ind1, 'css:&quot;def&quot;,', $cr)"/>
		<xsl:value-of select="concat($ind1, 'cssover:&quot;over&quot;,', $cr)"/>
		<xsl:value-of select="concat($ind1, 'csscurr:&quot;curr&quot;,', $cr)"/>

		<xsl:value-of select="concat($ind1, 'tabs:[', $cr)"/>

		<xsl:apply-templates select="ITEM">
			<xsl:with-param name="indent" select="$ind1"/>
			<xsl:with-param name="level">0</xsl:with-param> 
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, ']', $cr)"/>
		<xsl:value-of select="concat($ind0, '};', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="TAB/ITEM">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="level"/>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="ind1" select="concat($ind0, $tab)"/>

		<xsl:value-of select="concat($ind0, '{', $cr)"/>
		<xsl:value-of select="concat($ind1, 'text:&quot;')"/>

		<xsl:if test="@label">
			<xsl:variable name="label" select="@label"/>
			<xsl:variable name="tmp"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$label]"/></xsl:variable>
			<xsl:if test="$tmp!=''"><xsl:value-of select="$tmp"/></xsl:if>
			<xsl:if test="$tmp=''"><xsl:value-of select="@label"/></xsl:if>
		</xsl:if>
		<xsl:if test="@value">
			<xsl:value-of select="@value"/>
		</xsl:if>
		<xsl:if test="comment()">
	      <xsl:value-of select="comment()" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:value-of select="concat('&quot;,', $cr)"/>

		<xsl:if test="@width">
			<xsl:value-of select="concat($ind1, 'width:', @width, ',', $cr)"/>
		</xsl:if>

		<!-- define the link -->
		<xsl:apply-templates select="LINK">
			<xsl:with-param name="indent" select="$ind1"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, 'hint:&quot; &quot;', $cr)"/>

		<xsl:value-of select="concat($ind0, '}')"/>
		<xsl:if test="position()!=last()">,</xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--=================================================================-->
	<xsl:template match="TAB/ITEM/LINK">
		<xsl:param name="indent"/>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind0, 'action : {')"/>

		<xsl:choose>
			<xsl:when test="($nametype='JAVA')">
				<xsl:value-of select="concat('js:&quot;', $nametext, '&quot;')"/>
			</xsl:when>
			<xsl:when test="($nametype='CONST')">
				<xsl:value-of select="$nametext"/>
			</xsl:when>
		</xsl:choose>

		<xsl:value-of select="concat('},', $cr)"/>
	</xsl:template>

</xsl:stylesheet>
