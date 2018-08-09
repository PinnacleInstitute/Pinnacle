<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="CustomReportParam">

		<xsl:if test="@type!='system'">
			<xsl:element name="TR">
				<xsl:element name="TD">
					<xsl:attribute name="align">right</xsl:attribute>
					<xsl:variable name="fld" select="@name"/>
					<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$fld]"/>
					<xsl:text disable-output-escaping="yes">:&#160;&#160;</xsl:text>
				</xsl:element>
				<xsl:element name="TD">
					<xsl:attribute name="align">left</xsl:attribute>

					<xsl:if test="@type='list'">
						<xsl:element name="SELECT">
							<xsl:attribute name="name">P<xsl:value-of select="position()"/></xsl:attribute>
							<xsl:attribute name="id">P<xsl:value-of select="position()"/></xsl:attribute>
                            <xsl:variable name="tmp">
								<xsl:choose>
									<xsl:when test="position()=1"><xsl:value-of select="/DATA/PARAM/@p1"/></xsl:when>
									<xsl:when test="position()=2"><xsl:value-of select="/DATA/PARAM/@p2"/></xsl:when>
									<xsl:when test="position()=3"><xsl:value-of select="/DATA/PARAM/@p3"/></xsl:when>
									<xsl:when test="position()=4"><xsl:value-of select="/DATA/PARAM/@p4"/></xsl:when>
									<xsl:when test="position()=5"><xsl:value-of select="/DATA/PARAM/@p5"/></xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:for-each select="OPTION">
								<xsl:element name="OPTION">
									<xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
									<xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
									<xsl:variable name="ofld" select="@name"/>
									<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$ofld]"/>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:if>
					
					<xsl:if test="@type!='list'">
						<xsl:element name="INPUT">
							<xsl:attribute name="type">text</xsl:attribute>
							<xsl:attribute name="name">P<xsl:value-of select="position()"/></xsl:attribute>
							<xsl:attribute name="id">P<xsl:value-of select="position()"/></xsl:attribute>
							<xsl:if test="@type='date'">
								<xsl:attribute name="size">8</xsl:attribute>
							</xsl:if>
							
							<xsl:choose>
								<xsl:when test="position()=1"><xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@p1"/></xsl:attribute></xsl:when>
								<xsl:when test="position()=2"><xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@p2"/></xsl:attribute></xsl:when>
								<xsl:when test="position()=3"><xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@p3"/></xsl:attribute></xsl:when>
								<xsl:when test="position()=4"><xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@p4"/></xsl:attribute></xsl:when>
								<xsl:when test="position()=5"><xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@p5"/></xsl:attribute></xsl:when>
							</xsl:choose>
						</xsl:element>
						<xsl:if test="@type='date'">
							<xsl:text disable-output-escaping="yes">&#160;&#160;</xsl:text>
							<xsl:element name="IMG">
								<xsl:attribute name="name">Calendar</xsl:attribute>
								<xsl:attribute name="src">Images\Calendar.gif</xsl:attribute>
								<xsl:attribute name="width">16</xsl:attribute>
								<xsl:attribute name="height">16</xsl:attribute>
								<xsl:attribute name="border">0</xsl:attribute>
								<xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.forms[0].P<xsl:value-of select="position()"/>)</xsl:attribute>
							</xsl:element>
						</xsl:if>
					</xsl:if>
					<xsl:if test="@required">
						<xsl:text disable-output-escaping="yes">&#160;&#160;</xsl:text>
						<xsl:element name="IMG">
							<xsl:attribute name="src">Images\Required.gif</xsl:attribute>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
		</xsl:if>

	</xsl:template>

	<xsl:template name="CustomReportData">
		<xsl:param name="report"/>
		<xsl:param name="data"/>

		<xsl:variable name="colwidth" select="sum($report/COLUMN/@width)"/>
		<xsl:variable name="colcount" select="count($report/COLUMN)"/>
		<xsl:variable name="rptwidth">
			<xsl:choose>
				<xsl:when test="$colwidth&gt;0"><xsl:value-of select="$colwidth"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="count($report/COLUMN)*100"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="border">
			<xsl:choose>
				<xsl:when test="$report/@grid">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

        <xsl:element name="TABLE">
			<xsl:attribute name="border"><xsl:value-of select="$border"/></xsl:attribute>
			<xsl:attribute name="cellpadding">0</xsl:attribute>
			<xsl:attribute name="cellspacing">0</xsl:attribute>
			<xsl:if test="$report/@align">
				<xsl:attribute name="align"><xsl:value-of select="$report/@align"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="width"><xsl:value-of select="$rptwidth"/></xsl:attribute>
			<xsl:attribute name="class">Calendar</xsl:attribute>

			<!-- Create Column Headers -->
			<xsl:if test="not($report/@header='false')">
				<xsl:element name="TR">
					<xsl:for-each select="$report/COLUMN">
						<xsl:element name="TD">
							<xsl:if test="@width">
								<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
							</xsl:if>
							<xsl:if test="@align">
								<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
							</xsl:if>
							<xsl:attribute name="bgcolor">lightblue</xsl:attribute>
							<xsl:variable name="fld" select="@name"/>
							<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$fld]"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>

			<!-- Create Row Data -->
			<xsl:for-each select="$data">
				<xsl:element name="TR">
					<xsl:if test="$report/@graybar">
                        <xsl:if test="(position() mod 2)">
                            <xsl:attribute name="class">GrayBar</xsl:attribute>
                        </xsl:if>
					</xsl:if>
					<xsl:variable name="row" select="."/>
					<xsl:for-each select="$report/COLUMN">
						<xsl:element name="TD">
							<xsl:if test="@width">
								<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
							</xsl:if>
							<xsl:if test="@align">
								<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
							</xsl:if>

							<xsl:variable name="fld" select="@name"/>
							<xsl:for-each select="$row/@*">
		  						<xsl:if test="name()=$fld">
									<xsl:value-of select="."/>
								</xsl:if>
							</xsl:for-each>

						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>

		<!-- Create Totals -->
		<xsl:if test="$report/TOTAL">
			<xsl:element name="TABLE">
				<xsl:attribute name="border">0</xsl:attribute>
				<xsl:attribute name="cellpadding">0</xsl:attribute>
				<xsl:attribute name="cellspacing">0</xsl:attribute>
				<xsl:if test="$report/@align">
					<xsl:attribute name="align"><xsl:value-of select="$report/@align"/></xsl:attribute>
				</xsl:if>
				<xsl:attribute name="width"><xsl:value-of select="$rptwidth"/></xsl:attribute>
				<xsl:element name="TR">
					<xsl:for-each select="$report/COLUMN">
						<xsl:variable name="fld" select="@name"/>
						<xsl:element name="TD">
							<xsl:attribute name="height">18</xsl:attribute>
							<xsl:if test="@width">
								<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
							</xsl:if>
							<xsl:if test="@align">
								<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
							</xsl:if>

							<xsl:if test="position() = 1">
								<xsl:for-each select="$report/TOTAL[@type='count']">
									<xsl:variable name="cfld" select="@name"/>
									<xsl:element name="B">
										<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$cfld]"/>
										<xsl:text disable-output-escaping="yes">:&#160;&#160;</xsl:text>
										<xsl:value-of select="@value"/>
									</xsl:element>
								</xsl:for-each>
							</xsl:if>
							<xsl:for-each select="$report/TOTAL[@name=$fld]">
								<xsl:element name="B">
									<xsl:value-of select="@value"/>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:element>
		</xsl:if>

	</xsl:template>
		
	<xsl:template name="CustomReportChart">
		<xsl:param name="report"/>
		<xsl:param name="chart"/>

		<xsl:variable name="chartwidth">
			<xsl:choose>
				<xsl:when test="$report/@width"><xsl:value-of select="$report/@width"/></xsl:when>
				<xsl:otherwise>750</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

        <xsl:element name="TABLE">
			<xsl:attribute name="border">0</xsl:attribute>
			<xsl:attribute name="cellpadding">0</xsl:attribute>
			<xsl:attribute name="cellspacing">0</xsl:attribute>
			<xsl:if test="$report/@align">
				<xsl:attribute name="align"><xsl:value-of select="$report/@align"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="width"><xsl:value-of select="$chartwidth"/></xsl:attribute>

			<xsl:element name="TR">
				<xsl:element name="TD">
					<xsl:attribute name="width"><xsl:value-of select="$chartwidth"/></xsl:attribute>
					<xsl:if test="$report/@align">
						<xsl:attribute name="align"><xsl:value-of select="$report/@align"/></xsl:attribute>
					</xsl:if>
				
					<xsl:element name="IMG">
						<xsl:attribute name="src">Images\./..\<xsl:value-of select="$chart"/></xsl:attribute>
						<xsl:attribute name="border">0</xsl:attribute>
					</xsl:element>
				</xsl:element>
	          
			</xsl:element>

			<xsl:if test="$report/TOTAL">
				<xsl:for-each select="$report/TOTAL">
					<xsl:element name="TR">
						<xsl:element name="TD">
							<xsl:attribute name="height">18</xsl:attribute>
							<xsl:attribute name="align">center</xsl:attribute>
							<xsl:attribute name="class">PageHeading</xsl:attribute>
							<xsl:variable name="fld" select="@name"/>
							<xsl:element name="B">
								<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$fld]"/>
								<xsl:text disable-output-escaping="yes">:&#160;&#160;</xsl:text>
								<xsl:value-of select="@value"/>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:for-each>
			</xsl:if>
		</xsl:element>

	</xsl:template>
		
</xsl:stylesheet>
