<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--==================================================================-->
<xsl:template name="CustomFields">
  <xsl:param name="margin" select="0"/>
  <xsl:param name="secure" select="0"/>
  <xsl:param name="display" select="0"/>

  <!-- Regular Field processing -->  
  <xsl:if test="@id">
    <xsl:if test="$secure!=0 and /DATA/SYSTEM/@usergroup&gt;$secure and @secure=2">
      <xsl:element name="TR">
        <xsl:if test="$margin=1"><xsl:element name="TD"/></xsl:if>
        <xsl:if test="$margin=2"><xsl:element name="TD"/><xsl:element name="TD"/></xsl:if>
        <xsl:element name="TD">
          <xsl:attribute name="align">right</xsl:attribute>
          <xsl:value-of select="@name"/>
          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
        </xsl:element>
        <xsl:element name="TD">
          <xsl:attribute name="align">left</xsl:attribute>
          <xsl:value-of select="@value"/>
        </xsl:element>
      </xsl:element>
    </xsl:if>

    <xsl:if test="$secure=0 or /DATA/SYSTEM/@usergroup&lt;=$secure or not(@secure)">
      <xsl:if test="@prompt">
        <xsl:if test="$display=0">
          <xsl:element name="TR">
            <xsl:if test="$margin=1"><xsl:element name="TD"/></xsl:if>
            <xsl:if test="$margin=2"><xsl:element name="TD"/><xsl:element name="TD"/></xsl:if>
            <xsl:element name="TD"/>
            <xsl:element name="TD">
              <xsl:attribute name="class">Prompt</xsl:attribute>
              <xsl:value-of select="@prompt"/>
            </xsl:element>
          </xsl:element>
        </xsl:if>
      </xsl:if>
      <xsl:element name="TR">
        <xsl:if test="$margin=1"><xsl:element name="TD"/></xsl:if>
        <xsl:if test="$margin=2"><xsl:element name="TD"/><xsl:element name="TD"/></xsl:if>

        <xsl:if test="$display=0">
          <!-- regular unaligned fields get displayed in 2 columns -->
          <xsl:if test="not(@align)">
            <xsl:element name="TD">
              <xsl:attribute name="align">right</xsl:attribute>
              <xsl:if test="@datatype=3"><xsl:attribute name="valign">top</xsl:attribute></xsl:if>
              <xsl:if test="@datatype!=6">
                <xsl:value-of select="@name"/>
                <xsl:text disable-output-escaping="yes">:&amp;#160;</xsl:text>
              </xsl:if>
            </xsl:element>
            <xsl:element name="TD">
              <xsl:attribute name="align">left</xsl:attribute>

              <!--Define the custom field-->
              <xsl:call-template name="XSLCustomField">
                <xsl:with-param name="fld" select="."/>
                <xsl:with-param name="display" select="$display"/>
              </xsl:call-template>
            </xsl:element>
          </xsl:if>

          <!-- aligned fields get combined into a single merged column -->
          <xsl:if test="@align">
            <xsl:element name="TD">
              <xsl:attribute name="colspan">2</xsl:attribute>
              <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
              <xsl:attribute name="valign">top</xsl:attribute>
              <!--Define the custom field-->
              <xsl:call-template name="XSLCustomField">
                <xsl:with-param name="fld" select="."/>
                <xsl:with-param name="fldname" select="true()"/>
                <xsl:with-param name="display" select="$display"/>
              </xsl:call-template>
            </xsl:element>
          </xsl:if>
        </xsl:if>

        <xsl:if test="$display!=0">
          <xsl:element name="TD">
            <xsl:attribute name="colspan">2</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>
            <xsl:attribute name="valign">top</xsl:attribute>
            <!--Define the custom field-->
            <xsl:call-template name="XSLCustomField">
              <xsl:with-param name="fld" select="."/>
              <xsl:with-param name="fldname" select="true()"/>
              <xsl:with-param name="display" select="$display"/>
            </xsl:call-template>
          </xsl:element>
        </xsl:if>

      </xsl:element>
      <xsl:element name="TR">
        <xsl:element name="TD">
          <xsl:attribute name="colspan">2</xsl:attribute>
          <xsl:attribute name="height">6</xsl:attribute>
        </xsl:element>
      </xsl:element>

    </xsl:if>
  </xsl:if>

  <!-- Combined Field processing -->
  <xsl:if test="not(@id)">
    <xsl:if test="FIELD/@prompt">
      <xsl:if test="$display=0">
        <xsl:element name="TR">
          <xsl:element name="TD">
            <xsl:attribute name="colspan">2</xsl:attribute>
            <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
            <xsl:attribute name="class">Prompt</xsl:attribute>
            <xsl:value-of select="FIELD/@prompt"/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$display=0">
      <xsl:element name="TR">
        <xsl:element name="TD">
          <xsl:attribute name="colspan">2</xsl:attribute>
          <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
          <xsl:attribute name="valign">top</xsl:attribute>
          <xsl:for-each select="FIELD">
            <xsl:call-template name="XSLCustomField">
              <xsl:with-param name="fld" select="."/>
              <xsl:with-param name="fldname" select="true()"/>
              <xsl:with-param name="display" select="$display"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:element>
      </xsl:element>
      <xsl:element name="TR">
        <xsl:element name="TD">
          <xsl:attribute name="colspan">2</xsl:attribute>
          <xsl:attribute name="height">6</xsl:attribute>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    
    <xsl:if test="$display!=0">
      <xsl:for-each select="FIELD">
        <xsl:element name="TR">
          <xsl:element name="TD">
            <xsl:attribute name="colspan">2</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>
            <xsl:attribute name="valign">top</xsl:attribute>
            <xsl:attribute name="style">font-size:12pt;</xsl:attribute>
            <!--Define the custom field-->
            <xsl:call-template name="XSLCustomField">
              <xsl:with-param name="fld" select="."/>
              <xsl:with-param name="fldname" select="true()"/>
              <xsl:with-param name="display" select="$display"/>
            </xsl:call-template>
          </xsl:element>
        </xsl:element>
        <xsl:element name="TR">
          <xsl:element name="TD">
            <xsl:attribute name="colspan">2</xsl:attribute>
            <xsl:attribute name="height">6</xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:for-each>
    </xsl:if>
  </xsl:if>
  
</xsl:template>

<!--==================================================================-->
<xsl:template name="XSLCustomField">
  <xsl:param name="fld"/>
  <xsl:param name="fldname" select="false()"/>
  <xsl:param name="display" select="0"/>

  <xsl:if test="$fldname">
    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
    <xsl:if test="$fld/@datatype!=6">
      <xsl:value-of select="$fld/@name"/>
      <xsl:text disable-output-escaping="yes">:&amp;#160;</xsl:text>
    </xsl:if>
  </xsl:if>
  <!-- Process Lists -->
  <xsl:if test="$fld/@datatype=1">
    <xsl:if test="$display=0">
      <xsl:element name="SELECT">
        <xsl:attribute name="id"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:attribute name="name"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:variable name="val"><xsl:value-of select="$fld/@value"/></xsl:variable>
        <xsl:element name="OPTION"/>
        <xsl:for-each select="$fld/CHOICES/CHOICE">
          <xsl:element name="OPTION">
            <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:if test="$val=@id"><xsl:attribute name="SELECTED"/></xsl:if>
            <xsl:value-of select="@name"/>
            <xsl:if test="@price"><xsl:value-of select="concat(' (', @price, ')')"/></xsl:if>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:if>
    <xsl:if test="$display!=0">
      <xsl:variable name="val"><xsl:value-of select="$fld/@value"/></xsl:variable>
      <xsl:for-each select="$fld/CHOICES/CHOICE">
        <xsl:if test="$val=@id">
          <xsl:element name="B"><xsl:value-of select="@name"/></xsl:element>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:if>
  <!-- Process Text, numbers and dates -->
  <xsl:if test="$fld/@datatype=2 or $fld/@datatype=4 or $fld/@datatype=5">
    <xsl:if test="$display=0">
      <xsl:element name="INPUT">
        <xsl:attribute name="type">text</xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:attribute name="name"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:if test="$fld/@datatype=2 and $fld/@max">
          <xsl:attribute name="maxlength"><xsl:value-of select="$fld/@max"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="$fld/@datatype=5"><xsl:attribute name="size">8</xsl:attribute></xsl:if>
        <xsl:if test="$fld/@size">
          <xsl:attribute name="size"><xsl:value-of select="$fld/@size"/></xsl:attribute>
        </xsl:if>
        <xsl:attribute name="value"><xsl:value-of select="$fld/@value"/></xsl:attribute>
      </xsl:element>
    </xsl:if>
    <xsl:if test="$display!=0">
      <xsl:element name="B">
        <xsl:value-of select="$fld/@value"/>
      </xsl:element>
    </xsl:if>
  </xsl:if>
  <!-- Process Memo fields -->
  <xsl:if test="$fld/@datatype=3">
    <xsl:if test="$display=0">
      <xsl:element name="TEXTAREA">
        <xsl:attribute name="id"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:attribute name="name"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:attribute name="cols">50</xsl:attribute>
        <xsl:if test="$fld/@size">
          <xsl:attribute name="rows"><xsl:value-of select="$fld/@size"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="not($fld/@size)"><xsl:attribute name="rows">4</xsl:attribute></xsl:if>
        <xsl:if test="$fld/@max">
          <xsl:attribute name="onkeyup">
            <xsl:text disable-output-escaping="yes"><![CDATA[if (value.length><xsl:value-of select="$fld/@max"/>) {doMaxLenMsg(<xsl:value-of select="$fld/@max"/>); value=value.substring(0,<xsl:value-of select="$fld/@max"/>);}]]></xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="$fld/@value"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="$display!=0">
      <xsl:element name="B">
        <xsl:value-of select="$fld/@value"/>
      </xsl:element>
    </xsl:if>
  </xsl:if>
  <!-- Process YesNo checkbox field -->
  <xsl:if test="$fld/@datatype=6">
    <xsl:if test="$display=0">
      <xsl:element name="INPUT">
        <xsl:attribute name="type">checkbox</xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:attribute name="name"><xsl:value-of select="$fld/@id"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="$fld/@value"/></xsl:attribute>
        <xsl:if test="($fld/@value = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
      </xsl:element>
      <xsl:value-of select="$fld/@name"/>
    </xsl:if>
    <xsl:if test="$display!=0">
      <xsl:value-of select="$fld/@name"/>
      <xsl:text disable-output-escaping="yes">:&amp;#160;</xsl:text>
      <xsl:element name="B">
        <xsl:if test="($fld/@value = 1)">Yes</xsl:if>
        <xsl:if test="($fld/@value != 1)">No</xsl:if>
        <xsl:if test="(not($fld/@value))">No</xsl:if>
      </xsl:element>
    </xsl:if>
  </xsl:if>
  <xsl:if test="$display=0">
    <!-- Display Calendar for date fields -->
    <xsl:if test="$fld/@datatype=5">
      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
      <xsl:element name="IMG">
        <xsl:attribute name="name">Calendar</xsl:attribute>
        <xsl:attribute name="src">Images\Calendar.gif</xsl:attribute>
        <xsl:attribute name="width">16</xsl:attribute>
        <xsl:attribute name="height">16</xsl:attribute>
        <xsl:attribute name="border">0</xsl:attribute>
        <xsl:attribute name="onclick">
          CalendarPopup(document.forms[0], document.forms[0].<xsl:value-of select="$fld/@id"/>)
        </xsl:attribute>
      </xsl:element>
    </xsl:if>
    <!-- Display required icon for required fields -->
    <xsl:if test="$fld/@required">
      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
      <xsl:element name="IMG">
        <xsl:attribute name="src">Images\Required.gif</xsl:attribute>
        <xsl:attribute name="alt">Required Field</xsl:attribute>
      </xsl:element>
    </xsl:if>
  </xsl:if>

</xsl:template>

</xsl:stylesheet>
