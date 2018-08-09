<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output omit-xml-declaration="yes"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: September 2009
	Desc: Validates Reports Definition for Reporting Engine
	Copyright 2009 Pinnacle Institue
===================================================================================-->

<xsl:template match="/">
	<xsl:apply-templates select="/VALID/REPORTS"/>
</xsl:template>

<xsl:template match="VALID/REPORTS">
	<xsl:variable name="cr" select="'NEWLINE'"/>

	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='source'"/>
			<xsl:when test="name()='language'"/>
			<xsl:when test="name()='path'"/>
			<xsl:otherwise><xsl:value-of select="concat( '...Invalid REPORTS Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>

	<!--TEST each REPORT-->
	<xsl:for-each select="REPORT">
		<xsl:variable name="reportname" select="@name"/>

		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='id'"/>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='secure'"/>
				<xsl:when test="name()='option'"/>
				<xsl:when test="name()='source'"/>
				<xsl:when test="name()='language'"/>
				<xsl:when test="name()='path'"/>
				<xsl:when test="name()='xsl'"/>
				<xsl:when test="name()='desc'"/>
				<xsl:when test="name()='align'"/>
				<xsl:when test="name()='grid'"/>
	 			<xsl:when test="name()='graybar'"/>
				<xsl:when test="name()='header'"/>
				<xsl:when test="name()='chart'"/>
				<xsl:when test="name()='width'"/>
				<xsl:when test="name()='height'"/>
				<xsl:when test="name()='title'"/>
				<xsl:when test="name()='xtitle'"/>
				<xsl:when test="name()='ytitle'"/>
	 			<xsl:when test="name()='transform'"/>
				<xsl:otherwise><xsl:value-of select="concat( '...Invalid REPORT Attribute (', $reportname, ':', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:if test="not(@id)">
			<xsl:value-of select="concat( '...Required id attribute (', $reportname, ')', $cr)"/>
		</xsl:if>
		<xsl:if test="not(@name)">
			<xsl:value-of select="concat( '...Required name attribute (', $reportname, ')', $cr)"/>
		</xsl:if>
		<xsl:if test="not(@type)">
			<xsl:value-of select="concat( '...Required type attribute (', $reportname, ')', $cr)"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="@type='system'"/>
			<xsl:when test="@type='company'"/>
			<xsl:when test="@type='member'"/>
			<xsl:otherwise><xsl:value-of select="concat( '...Invalid type attribute value (', $reportname, ':', @type, ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
		<xsl:if test="@align">
			<xsl:choose>
				<xsl:when test="@align='left'"/>
				<xsl:when test="@align='center'"/>
				<xsl:when test="@align='right'"/>
				<xsl:otherwise><xsl:value-of select="concat( '...Invalid align attribute value (', $reportname, ':', @align, ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="@header">
			<xsl:choose>
				<xsl:when test="@header='false'"/>
				<xsl:otherwise><xsl:value-of select="concat( '...Invalid header attribute value (', $reportname, ':', @header, ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="@chart">
			<xsl:choose>
				<xsl:when test="@chart='pie'"/>
				<xsl:when test="@chart='bar'"/>
				<xsl:when test="@chart='line'"/>
				<xsl:when test="@chart='area'"/>
				<xsl:otherwise><xsl:value-of select="concat( '...Invalid chart attribute value (', $reportname, ':', @chart, ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
			
		<!-- test if there is a label for the report name -->
		<xsl:variable name="rptlabel">
			<xsl:value-of select="/VALID/LANGUAGE/LABEL[@name=$reportname]"/>
		</xsl:variable>
		<xsl:if test="$rptlabel=''">
			<xsl:value-of select="concat( '...Missing Language Label for Report name (', @name, ')', $cr)"/>
		</xsl:if>

		<!-- test if there is a label for the report decription -->
		<xsl:if test="@desc">
			<xsl:variable name="reportdesc" select="@desc"/>
			<xsl:variable name="labeldesc">
				<xsl:value-of select="/VALID/LANGUAGE/LABEL[@name=$reportdesc]"/>
			</xsl:variable>
			<xsl:if test="$labeldesc=''">
				<xsl:value-of select="concat( '...Missing Language Label for Report description (', @desc, ')', $cr)"/>
			</xsl:if>
		</xsl:if>

		<!--TEST PARAM-->
		<xsl:for-each select="PARAM">
			<xsl:variable name="paramname" select="@name"/>
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='type'"/>
					<xsl:when test="name()='init'"/>
					<xsl:when test="name()='required'"/>
					<xsl:otherwise><xsl:value-of select="concat( '...Invalid PARAM Attribute (', $reportname, ':', $paramname, ':', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:if test="not(@name)">
				<xsl:value-of select="concat( '...Required name attribute (', $reportname, ':', $paramname, ')', $cr)"/>
			</xsl:if>
			<xsl:if test="not(@type)">
				<xsl:value-of select="concat( '...Required type attribute (', $reportname, ':', $paramname, ')', $cr)"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@type='system'"/>
				<xsl:when test="@type='date'"/>
				<xsl:when test="@type='text'"/>
				<xsl:when test="@type='list'"/>
				<xsl:otherwise><xsl:value-of select="concat( '...Invalid type attribute value (', $reportname, ':', $paramname, ':', @type, ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
			
			<!-- test if there is a label for the parameter name -->
			<xsl:if test="not(@type='system')">
				<xsl:variable name="label">
					<xsl:value-of select="/VALID/LANGUAGE/LABEL[@name=$paramname]"/>
				</xsl:variable>
				<xsl:if test="$label=''">
					<xsl:value-of select="concat( '...Missing Language Label for Parameter name (', $reportname, ':', @name, ')', $cr)"/>
				</xsl:if>
			</xsl:if>

			<xsl:for-each select="OPTION">
				<xsl:variable name="optionname" select="@name"/>
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='id'"/>
						<xsl:when test="name()='name'"/>
						<xsl:otherwise><xsl:value-of select="concat( '...Invalid OPTION Attribute (', $reportname, ':', $paramname, ':', $optionname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:if test="not(@id)">
					<xsl:value-of select="concat( '...Required id attribute (', $reportname, ':', $paramname, ':', $optionname, ')', $cr)"/>
				</xsl:if>
				<xsl:if test="not(@name)">
					<xsl:value-of select="concat( '...Required name attribute (', $reportname, ':', $paramname, ':', $optionname, ')', $cr)"/>
				</xsl:if>

				<!-- test if there is a label for the option name -->
				<xsl:variable name="label">
					<xsl:value-of select="/VALID/LANGUAGE/LABEL[@name=$optionname]"/>
				</xsl:variable>
				<xsl:if test="$label=''">
					<xsl:value-of select="concat( '...Missing Language Label for Parameter name (', $reportname, ':', $paramname, ':', @name, ')', $cr)"/>
				</xsl:if>
				
			</xsl:for-each>
		</xsl:for-each>
			
		<!--TEST COLUMN-->
		<xsl:for-each select="COLUMN">
			<xsl:variable name="columnname" select="@name"/>
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='width'"/>
					<xsl:when test="name()='align'"/>
					<xsl:when test="name()='format'"/>
					<xsl:when test="name()='decimal'"/>
					<xsl:when test="name()='style'"/>
					<xsl:otherwise><xsl:value-of select="concat( '...Invalid COLUMN Attribute (', $reportname, ':', $columnname, ':', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:if test="not(@name)">
				<xsl:value-of select="concat( '...Required name attribute (', $reportname, ':', $columnname, ')', $cr)"/>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:choose>
					<xsl:when test="@align='left'"/>
					<xsl:when test="@align='center'"/>
					<xsl:when test="@align='right'"/>
					<xsl:otherwise><xsl:value-of select="concat( '...Invalid align attribute value (', $reportname, ':', $columnname, ':', @align, ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="@format">
				<xsl:choose>
					<xsl:when test="@align='number'"/>
					<xsl:when test="@align='currency'"/>
					<xsl:when test="@align='date'"/>
					<xsl:when test="@align='percent'"/>
					<xsl:otherwise><xsl:value-of select="concat( '...Invalid format attribute value (', $reportname, ':', $columnname, ':', @format, ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="@style)">
				<xsl:if test="@style &lt; 0 or @style &gt; 4">
					<xsl:value-of select="concat( '...Invalid Date Format Style 0-4 (', $reportname, ':', $columnname, ':', @style, ')', $cr)"/>
				</xsl:if>
			</xsl:if>

			<!-- test if column name is lower case -->
			<xsl:variable name="test">
				<xsl:value-of select="translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
			</xsl:variable>
			<xsl:if test="not(@name=$test)">
				<xsl:value-of select="concat( '...Invalid Column name must be lowercase (', $reportname, ':', @name, ')', $cr)"/>
			</xsl:if>

			<!-- test if there is a label for the column name -->
			<xsl:variable name="label">
				<xsl:value-of select="/VALID/LANGUAGE/LABEL[@name=$columnname]"/>
			</xsl:variable>
			<xsl:if test="$label=''">
				<xsl:value-of select="concat( '...Missing Language Label for Column name (', $reportname, ':', @name, ')', $cr)"/>
			</xsl:if>
			
		</xsl:for-each>
		
		<!--TEST TOTAL-->
		<xsl:for-each select="TOTAL">
			<xsl:variable name="totalname" select="@name"/>
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='type'"/>
					<xsl:when test="name()='format'"/>
					<xsl:when test="name()='decimal'"/>
					<xsl:otherwise><xsl:value-of select="concat( '...Invalid TOTAL Attribute (', $reportname, ':', $totalname, ':', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:if test="not(@name)">
				<xsl:value-of select="concat( '...Required name attribute (', $reportname, ':', $totalname, ')', $cr)"/>
			</xsl:if>
			<xsl:if test="not(@type)">
				<xsl:value-of select="concat( '...Required type attribute (', $reportname, ':', $totalname, ')', $cr)"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@type='count'"/>
				<xsl:when test="@type='sum'"/>
				<xsl:when test="@type='avg'"/>
				<xsl:otherwise><xsl:value-of select="concat( '...Invalid type attribute value (', $reportname, ':', $totalname, ':', @type, ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@format">
				<xsl:choose>
					<xsl:when test="@align='number'"/>
					<xsl:when test="@align='currency'"/>
					<xsl:otherwise><xsl:value-of select="concat( '...Invalid format attribute value (', $reportname, ':', $totalname, ':', @format, ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:if>

			<!-- test if there is a label for the total name -->
			<xsl:variable name="label">
				<xsl:value-of select="/VALID/LANGUAGE/LABEL[@name=$totalname]"/>
			</xsl:variable>
			<xsl:if test="$label=''">
				<xsl:value-of select="concat( '...Missing Language Label for Total name (', $reportname, ':', @name, ')', $cr)"/>
			</xsl:if>

		</xsl:for-each>
	
	</xsl:for-each>
		
</xsl:template>

</xsl:stylesheet>

