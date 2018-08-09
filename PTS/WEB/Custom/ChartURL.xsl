<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output omit-xml-declaration="yes"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: 1/21/2005
	Desc: Creates a URL to the Chart Page 
	Copyright 2005 WinTech, Inc.
===================================================================================-->
	<xsl:template match="CHART">
		<xsl:value-of select="concat('Chart.asp?type=', @type)"/>
		
		<xsl:if test="@width > 0 "><xsl:value-of select="concat('&amp;width=', @width)"/></xsl:if>	
		<xsl:if test="@height > 0 "><xsl:value-of select="concat('&amp;height=', @height)"/></xsl:if>	
		<xsl:if test="@startdate != ''"><xsl:value-of select="concat('&amp;startdate=', @startdate)"/></xsl:if>	
		<xsl:if test="@enddate != ''"><xsl:value-of select="concat('&amp;endate=', @endate)"/></xsl:if>	
		<xsl:if test="@unit != ''"><xsl:value-of select="concat('&amp;unit=', @unit)"/></xsl:if>	

		<xsl:variable name="title">
			<xsl:if test="@title"><xsl:value-of select="@title"/></xsl:if>
			<xsl:if test="not(@title)">Title</xsl:if>
		</xsl:variable>
		<xsl:variable name="xtitle">
			<xsl:if test="@xtitle"><xsl:value-of select="@xtitle"/></xsl:if>
			<xsl:if test="not(@xtitle)">XTitle</xsl:if>
		</xsl:variable>
		<xsl:variable name="ytitle">
			<xsl:if test="@ytitle"><xsl:value-of select="@ytitle"/></xsl:if>
			<xsl:if test="not(@ytitle)">YTitle</xsl:if>
		</xsl:variable>

		<xsl:if test="$title != ''"><xsl:value-of select="concat('&amp;title=', /CHART/LABEL[@name=$title])"/></xsl:if>	
		<xsl:if test="$xtitle != ''"><xsl:value-of select="concat('&amp;xtitle=', /CHART/LABEL[@name=$xtitle])"/></xsl:if>	
		<xsl:if test="$ytitle != ''"><xsl:value-of select="concat('&amp;ytitle=', /CHART/LABEL[@name=$ytitle])"/></xsl:if>	
		<xsl:apply-templates select="DATA" mode="data"/>
		<xsl:apply-templates select="DATA" mode="labels"/>
	</xsl:template>

	<xsl:template match="DATA" mode="data">
		<xsl:if test="position()=1"><xsl:value-of select="'&amp;data='"/></xsl:if>	
		<xsl:value-of select="."/>
		<xsl:if test="position()!=last()"><xsl:value-of select="'|'"/></xsl:if>	
	</xsl:template>
	
	<xsl:template match="DATA" mode="labels">
		<xsl:if test="position()=1"><xsl:value-of select="'&amp;labels='"/></xsl:if>	
		<xsl:variable name="label"><xsl:value-of select="/CHART/LABEL[@name=current()/@label]"/></xsl:variable>
		<xsl:if test="$label=''"><xsl:value-of select="@label"/></xsl:if>
		<xsl:if test="$label!=''"><xsl:value-of select="$label"/></xsl:if>
		<xsl:if test="position()!=last()"><xsl:value-of select="'|'"/></xsl:if>	
	</xsl:template>
	
</xsl:stylesheet>
