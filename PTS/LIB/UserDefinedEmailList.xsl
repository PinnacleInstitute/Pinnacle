<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--===============================================================================
	Auth: Bob Wood
	Date: August 2003
	Desc: Transforms a User Defined Email List to a SQL statment 
	Copyright 2003 WinTech, Inc.
===================================================================================-->

	<xsl:template match="/">
		<SQL><xsl:apply-templates/></SQL>
	</xsl:template>

	<xsl:template match="DATA">

		<xsl:variable name="apos"><xsl:text>&apos;</xsl:text></xsl:variable>

		<!-- Start the SELECT Clause -->
		<xsl:value-of select="'SELECT '"/>

		<!-- Add the optional TOP element -->
		<xsl:if test="/DATA/WTSELECT/@qty &gt; 0">
			<xsl:value-of select="concat( 'TOP ', /DATA/WTSELECT/@qty, ' ')"/>
		</xsl:if>

		<!-- Build the column list -->
		<xsl:for-each select="/DATA/ENUM[@id=1]">
			<xsl:value-of select="concat( @src, ' AS ', $apos, 'EmaileeID', $apos, ', ')"/>
		</xsl:for-each>
		<xsl:for-each select="/DATA/ENUM[@id=2]">
			<xsl:value-of select="concat( @src, ' AS ', $apos, 'Email', $apos, ', ')"/>
		</xsl:for-each>
		<xsl:for-each select="/DATA/ENUM[@id=3]">
			<xsl:value-of select="concat( @src, ' AS ', $apos, 'FirstName', $apos, ', ')"/>
		</xsl:for-each>
		<xsl:for-each select="/DATA/ENUM[@id=4]">
			<xsl:value-of select="concat( @src, ' AS ', $apos, 'LastName', $apos, ', ')"/>
		</xsl:for-each>
		
		<xsl:variable name="data1" select="/DATA/WTATTRIBUTE[@name='data1']/@src"/>
		<xsl:if test="$data1 = 0">
			<xsl:value-of select="concat( $apos, $apos, ' AS ', $apos, 'Data1', $apos, ', ')"/>
		</xsl:if>
		<xsl:if test="$data1 &gt; 0">
			<xsl:for-each select="/DATA/ENUM[@id=$data1]">
				<xsl:value-of select="concat( @src, ' AS ', $apos, 'Data1', $apos, ', ')"/>
			</xsl:for-each>
		</xsl:if>
		
		<xsl:variable name="data2" select="/DATA/WTATTRIBUTE[@name='data2']/@src"/>
		<xsl:if test="$data2 = 0">
			<xsl:value-of select="concat( $apos, $apos, ' AS ', $apos, 'Data2', $apos, ', ')"/>
		</xsl:if>
		<xsl:if test="$data2 &gt; 0">
			<xsl:for-each select="/DATA/ENUM[@id=$data2]">
				<xsl:value-of select="concat( @src, ' AS ', $apos, 'Data2', $apos, ', ')"/>
			</xsl:for-each>
		</xsl:if>
		
		<xsl:variable name="data3" select="/DATA/WTATTRIBUTE[@name='data3']/@src"/>
		<xsl:if test="$data3 = 0">
			<xsl:value-of select="concat( $apos, $apos, ' AS ', $apos, 'Data3', $apos, ', ')"/>
		</xsl:if>
		<xsl:if test=" $data3 &gt; 0">
			<xsl:for-each select="/DATA/ENUM[@id=$data3]">
				<xsl:value-of select="concat( @src, ' AS ', $apos, 'Data3', $apos, ', ')"/>
			</xsl:for-each>
		</xsl:if>

		<xsl:variable name="data4" select="/DATA/WTATTRIBUTE[@name='data4']/@src"/>
		<xsl:if test="$data4 = 0">
			<xsl:value-of select="concat( $apos, $apos, ' AS ', $apos, 'data4', $apos, ', ')"/>
		</xsl:if>
		<xsl:if test=" $data4 &gt; 0">
			<xsl:for-each select="/DATA/ENUM[@id=$data4]">
				<xsl:value-of select="concat( @src, ' AS ', $apos, 'data4', $apos, ', ')"/>
			</xsl:for-each>
		</xsl:if>

		<xsl:variable name="data5" select="/DATA/WTATTRIBUTE[@name='data5']/@src"/>
		<xsl:if test="$data5 = 0">
			<xsl:value-of select="concat( $apos, $apos, ' AS ', $apos, 'data5', $apos, ' ')"/>
		</xsl:if>
		<xsl:if test=" $data5 &gt; 0">
			<xsl:for-each select="/DATA/ENUM[@id=$data5]">
				<xsl:value-of select="concat( @src, ' AS ', $apos, 'data5', $apos, ' ')"/>
			</xsl:for-each>
		</xsl:if>

		<!-- Add the FROM Clause -->
		<xsl:value-of select="concat( /DATA/WTFROM, ' ')"/>

		<!-- Build the WHERE Clause -->

		<!-- Only get emailees that have '@' in the email address -->
		<xsl:variable name="Email" select="/DATA/ENUM[@id=2]/@src"/>

		<xsl:if test="/DATA/WTFROM/@where">
			<xsl:value-of select="concat('AND ', $Email, ' LIKE ', $apos, '%@%', $apos, ' ')"/>
		</xsl:if>
		<xsl:if test="not(/DATA/WTFROM/@where)">
			<xsl:value-of select="concat('WHERE ', $Email, ' LIKE ', $apos, '%@%', $apos, ' ')"/>
		</xsl:if>

		<xsl:if test="count(/DATA/WTCONDITION[@expr>0])&gt;0">

			<xsl:value-of select="'AND '"/>

			<xsl:for-each select="/DATA/WTCONDITION">
				<xsl:variable name="fld" select="/DATA/ENUM[@id=current()/@expr]/@src"/>
				<xsl:if test="string-length($fld)&gt;0">
					<xsl:if test="@connector">
						<xsl:value-of select="concat( @connector, ' ')"/>
					</xsl:if>
					<xsl:value-of select="$fld"/>
					<xsl:call-template name="GetOperator"><xsl:with-param name="oper" select="@oper"/></xsl:call-template>
					
					<xsl:if test="not(@oper='starts' or @oper='contains' or @oper='not-contains')">
						<xsl:if test="@value='now'">
							<xsl:value-of select="concat( $apos, /DATA/SYSTEM/@date)"/>
						</xsl:if>
						<xsl:if test="not(@value='now')">
							<xsl:value-of select="concat( $apos, @value)"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="@oper='starts' or @oper='contains' or @oper='not-contains'">
						<xsl:value-of select="concat(@value, '%')"/>
					</xsl:if>
					<xsl:value-of select="concat( $apos, ' ')"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>

		<!-- Build the ORDER BY Clause -->
		<xsl:if test="count(/DATA/WTORDERBY[@name>0])&gt;0">
			<xsl:value-of select="'ORDER BY '"/>
			<xsl:for-each select="/DATA/WTORDERBY">
				<xsl:variable name="fld" select="/DATA/ENUM[@id=current()/@name]/@src"/>
				<xsl:if test="string-length($fld)&gt;0">
					<xsl:value-of select="concat( $fld, ' ')"/>
					<xsl:if test="@order='desc'">
						<xsl:value-of select="'DESC '"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: Get Expression Operator -->
	<!--==================================================================-->
	 <xsl:template name="GetOperator">
		  <xsl:param name="oper"/>
		  <xsl:choose>
				<xsl:when test="$oper='equal'"> = </xsl:when>
				<xsl:when test="$oper='greater'"> &gt; </xsl:when>
				<xsl:when test="$oper='greater-equal'"> &gt;= </xsl:when>
				<xsl:when test="$oper='less'"> &lt; </xsl:when>
				<xsl:when test="$oper='less-equal'"> &lt;= </xsl:when>
				<xsl:when test="$oper='not-equal'"> &lt;&gt; </xsl:when>
				<xsl:when test="$oper='plus'"> + </xsl:when>
				<xsl:when test="$oper='minus'"> - </xsl:when>
				<xsl:when test="$oper='divide'"> / </xsl:when>
				<xsl:when test="$oper='multiply'"> * </xsl:when>
				<xsl:when test="$oper='starts'"> LIKE '</xsl:when>
				<xsl:when test="$oper='contains'"> LIKE '%</xsl:when>
				<xsl:when test="$oper='not-contains'"> NOT LIKE '%</xsl:when>
				<xsl:when test="$oper='IS'"> IS </xsl:when>
		  </xsl:choose>
	</xsl:template>
</xsl:stylesheet>
