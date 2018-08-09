<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="InputOptions">
		<xsl:param name="margin" select="0"/>
		<xsl:param name="secure" select="0"/>

        <xsl:if test="$secure!=0 and /DATA/SYSTEM/@usergroup&gt;$secure and @secure=2">
			<xsl:element name="TR">
				<xsl:if test="$margin=1"><xsl:element name="TD"/></xsl:if>
				<xsl:if test="$margin=2"><xsl:element name="TD"/><xsl:element name="TD"/></xsl:if>
				<xsl:element name="TD">
					<xsl:attribute name="align">right</xsl:attribute>
					<xsl:value-of select="@name"/>
					<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
				</xsl:element>
				<xsl:element name="TD">
					<xsl:attribute name="align">left</xsl:attribute>
					<xsl:value-of select="@value"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>

        <xsl:if test="$secure=0 or /DATA/SYSTEM/@usergroup&lt;=$secure or not(@secure)">
			<xsl:if test="@prompt">
				<xsl:element name="TR">
					<xsl:if test="$margin=1"><xsl:element name="TD"/></xsl:if>
					<xsl:if test="$margin=2"><xsl:element name="TD"/><xsl:element name="TD"/></xsl:if>
					<xsl:element name="TD">
					<xsl:attribute name="colspan">2</xsl:attribute>
					<xsl:attribute name="class">Prompt</xsl:attribute>
					<xsl:value-of select="@prompt"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<xsl:element name="TR">
				<xsl:if test="$margin=1"><xsl:element name="TD"/></xsl:if>
				<xsl:if test="$margin=2"><xsl:element name="TD"/><xsl:element name="TD"/></xsl:if>
				<xsl:element name="TD">
					<xsl:attribute name="align">right</xsl:attribute>
					<xsl:if test="@datatype=3">
					<xsl:attribute name="valign">top</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="@name"/>
					<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
				</xsl:element>
				<xsl:element name="TD">
					<xsl:attribute name="align">left</xsl:attribute>
					<xsl:if test="@datatype=1">
					<xsl:element name="SELECT">
						<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
						<xsl:variable name="val"><xsl:value-of select="@value"/></xsl:variable>
						<xsl:element name="OPTION"/>
						<xsl:for-each select="INPUTCHOICES/INPUTCHOICE">
							<xsl:element name="OPTION">
								<xsl:attribute name="value"><xsl:value-of select="@name"/></xsl:attribute>
								<xsl:if test="$val=@name"><xsl:attribute name="SELECTED"/></xsl:if>
								<xsl:value-of select="@name"/>
								<xsl:if test="@price">
								<xsl:value-of select="concat(' (', @price, ')')"/>
								</xsl:if>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
					</xsl:if>
					<xsl:if test="@datatype=2 or @datatype=4 or @datatype=5">
					<xsl:element name="INPUT">
						<xsl:attribute name="type">text</xsl:attribute>
						<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
						<xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
						<xsl:if test="@datatype=2 and @max">
							<xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="@datatype=5">
							<xsl:attribute name="size">8</xsl:attribute>
						</xsl:if>
						<xsl:if test="@size">
							<xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute>
						</xsl:if>
						<xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
					</xsl:element>
					</xsl:if>
					<xsl:if test="@datatype=3">
					<xsl:element name="TEXTAREA">
						<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
						<xsl:attribute name="cols">50</xsl:attribute>
						<xsl:if test="@size">
							<xsl:attribute name="rows"><xsl:value-of select="@size"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="not(@size)">
							<xsl:attribute name="rows">4</xsl:attribute>
						</xsl:if>
						<xsl:if test="@max">
							<xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length><xsl:value-of select="@max"/>) {doMaxLenMsg(<xsl:value-of select="@max"/>); value=value.substring(0,<xsl:value-of select="@max"/>);}]]></xsl:text></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="@value"/>
					</xsl:element>
					</xsl:if>
					<xsl:if test="@datatype=5">
						<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
						<xsl:element name="IMG">
						<xsl:attribute name="name">Calendar</xsl:attribute>
						<xsl:attribute name="src">Images\Calendar.gif</xsl:attribute>
						<xsl:attribute name="width">16</xsl:attribute>
						<xsl:attribute name="height">16</xsl:attribute>
						<xsl:attribute name="border">0</xsl:attribute>
						<xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.forms[0].<xsl:value-of select="@name"/>)</xsl:attribute>
					</xsl:element>
					</xsl:if>
					<xsl:if test="@required">
						<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
						<xsl:element name="IMG">
						<xsl:attribute name="src">Images\Required.gif</xsl:attribute>
						<xsl:attribute name="alt">Required Field</xsl:attribute>
					</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>

		</xsl:if>

	</xsl:template>

</xsl:stylesheet>
