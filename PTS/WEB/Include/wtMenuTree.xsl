<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="wtSystem.xsl"/>

	<xsl:template name="DefineMenu">
		<xsl:value-of select="$cr"/>
		<xsl:element name="SCRIPT">
			<xsl:attribute name="language">JavaScript</xsl:attribute>
			<xsl:apply-templates select="/DATA/MENU"/>
		</xsl:element>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="MENU">
	<!--==================================================================-->
		<xsl:variable name="ind0" select="''"/>
		<xsl:variable name="ind1" select="$tab"/>
		<xsl:variable name="ind2" select="concat($ind1, $tab)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab)"/>

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise>200</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="height">
			<xsl:choose>
				<xsl:when test="@height"><xsl:value-of select="@height"/></xsl:when>
				<xsl:otherwise>20</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="offset_x">
			<xsl:choose>
				<xsl:when test="@offset_x"><xsl:value-of select="@offset_x"/></xsl:when>
				<xsl:otherwise>20</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="offset_y">
			<xsl:choose>
				<xsl:when test="@offset_y"><xsl:value-of select="@offset_y"/></xsl:when>
				<xsl:otherwise>2</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="position_abs">
			<xsl:choose>
				<xsl:when test="@position_abs"><xsl:value-of select="@position_abs"/></xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="position_x">
			<xsl:choose>
				<xsl:when test="@position_x"><xsl:value-of select="@position_x"/></xsl:when>
				<xsl:otherwise>10</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="position_y">
			<xsl:choose>
				<xsl:when test="@position_y"><xsl:value-of select="@position_y"/></xsl:when>
				<xsl:otherwise>10</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind0, 'var ', @name, 'Def = {', $cr)"/>
		<xsl:value-of select="concat($ind1, 'style:{', $cr)"/>
		<xsl:if test="@css">
			<xsl:value-of select="concat($ind2, 'css:&quot;', @css, '&quot;,', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, 'size:[', $width, ',', $height, '],', $cr)"/>
		<xsl:if test="@color">
			<xsl:value-of select="concat($ind2, 'color:&quot;', @color, '&quot;,', $cr)"/>
		</xsl:if>
		<xsl:if test="@bgcolor">
			<xsl:value-of select="concat($ind2, 'bgcolor:&quot;', @bgcolor, '&quot;,', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, 'itemoffset:{x:', $offset_x, ',y:', $offset_y, '}', $cr)"/>
		<xsl:value-of select="concat($ind1, '},', $cr)"/>

		<xsl:if test="@over_css or @over_color or @over_bgcolor">
			<xsl:value-of select="concat($ind1, 'styleover:{', $cr)"/>
			<xsl:if test="@over_css">
				<xsl:value-of select="concat($ind2, 'css:&quot;', @over_css, '&quot;,', $cr)"/>
			</xsl:if>
			<xsl:if test="@over_color">
				<xsl:value-of select="concat($ind2, 'bgcolor:&quot;', @over_color, '&quot;,', $cr)"/>
			</xsl:if>
			<xsl:if test="@over_bgcolor">
				<xsl:value-of select="concat($ind2, 'bgcolor:&quot;', @over_bgcolor, '&quot;,', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($ind1, '},', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind1, 'position:{absolute:', $position_abs, ', pos:[', $position_x, ',', $position_y, ']},', $cr )"/>
		<xsl:value-of select="concat($ind1, 'items:[', $cr)"/>

		<xsl:apply-templates select="ITEM">
			<xsl:with-param name="indent" select="$ind1"/>
			<xsl:with-param name="level">0</xsl:with-param> 
			<xsl:with-param name="type" select="@type"/>
			<xsl:with-param name="menu" select="."/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, ']', $cr)"/>
		<xsl:value-of select="concat($ind0, '};', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="ITEM">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="level"/>
		<xsl:param name="menu"/>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="ind1" select="concat($ind0, $tab)"/>
		<xsl:variable name="ind2" select="concat($ind1, $tab)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab)"/>

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

		<xsl:value-of select="'&quot;'"/>
		<xsl:if test="ITEM or LINK">,</xsl:if>
		<xsl:value-of select="$cr"/>

		<xsl:if test="IMAGE">
			<xsl:if test="ITEM">
				<xsl:value-of select="concat($ind1, 'style:{', $cr)"/>
				<xsl:value-of select="concat($ind2, 'imgitem:&quot;img/', IMAGE/@name, '&quot;,', $cr)"/>
				<xsl:value-of select="concat($ind2, 'imgdir:&quot;img/', IMAGE/@name, '&quot;,', $cr)"/>
				<xsl:value-of select="concat($ind2, 'imgdiropen:&quot;img/', IMAGE/@name, '&quot;', $cr)"/>
				<xsl:value-of select="concat($ind1, '}')"/>
			</xsl:if>
			<xsl:if test="not(ITEM)">
				<xsl:value-of select="concat($ind1, 'style:{imgitem:&quot;img/', IMAGE/@name, '&quot;}')"/>
			</xsl:if>
			<xsl:if test="ITEM or LINK">,</xsl:if>
			<xsl:value-of select="$cr"/>
		</xsl:if>

		<!-- if we have child menu items -->
		<xsl:if test="ITEM">
			<xsl:value-of select="concat($ind1, 'menu:{', $cr)"/>
			<xsl:value-of select="concat($ind2, 'position:{anchor:&quot;ne&quot;,anchor_side:&quot;nw&quot;},', $cr )"/>
			<xsl:value-of select="concat($ind2, 'items:[', $cr)"/>

			<xsl:apply-templates>
				<xsl:with-param name="indent" select="$ind2"/>
				<xsl:with-param name="level" select="$level+1"/>
				<xsl:with-param name="menu" select="$menu"/>
			</xsl:apply-templates>
			<xsl:value-of select="concat($ind2, ']', $cr)"/>
			<xsl:value-of select="concat($ind1, '}', $cr)"/>
		</xsl:if>

		<!-- define the link -->
		<xsl:apply-templates select="LINK">
			<xsl:with-param name="indent" select="$ind1"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind0, '}')"/>
		<xsl:if test="position()!=last()">,</xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="DIVIDER">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind0" select="$indent"/>
<!--
		<xsl:value-of select="concat($ind0, '{type:&quot;separator&quot;}')"/>
		<xsl:if test="position()!=last()">,</xsl:if>
		<xsl:value-of select="$cr"/>
-->		
	</xsl:template>

	<!--=================================================================-->
	<xsl:template match="LINK">
		<xsl:param name="indent"/>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind0, 'action:{')"/>

		<xsl:choose>
			<xsl:when test="($nametype='JAVA')">
				<xsl:value-of select="concat('js:&quot;', $nametext, '&quot;')"/>
			</xsl:when>
			<xsl:when test="($nametype='CONST')">
				<xsl:value-of select="$nametext"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'url:&quot;'"/>
				<xsl:value-of select="concat(@name, '.asp')"/>

				<xsl:for-each select="PARAM">
					<xsl:if test="(position() = '1')">?</xsl:if>
					<xsl:if test="(position() != '1')"><xsl:value-of select="'&amp;'" disable-output-escaping="yes"/></xsl:if>
					<xsl:value-of select="concat(@name, '=', @value)"/>
				</xsl:for-each>

				<xsl:if test="not(@return='false') and not(@target)">
					<xsl:if test="(count(PARAM)=0)">?</xsl:if>
					<xsl:if test="(count(PARAM)!=0)"><xsl:value-of select="'&amp;'" disable-output-escaping="yes"/></xsl:if>
					<xsl:choose>
						<xsl:when test="@skipreturn">
							<xsl:value-of select="concat('ReturnURL=', /DATA/SYSTEM/@returnurl)" disable-output-escaping="yes"/>
						</xsl:when>
						<xsl:when test="@nodata">
							<xsl:value-of select="concat('ReturnURL=', /DATA/SYSTEM/@pageURL)" disable-output-escaping="yes"/>
						</xsl:when>
						<xsl:when test="not(@nodata)">
							<xsl:value-of select="concat('ReturnURL=', /DATA/SYSTEM/@pageURL, '&amp;ReturnData=', /DATA/SYSTEM/@pageData)" disable-output-escaping="yes"/>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:value-of select="'&quot;'"/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="@target">
			<xsl:value-of select="concat(',target:&quot;', @target, '&quot;')"/>
		</xsl:if>

		<xsl:value-of select="concat('}', $cr)"/>
	</xsl:template>

</xsl:stylesheet>
