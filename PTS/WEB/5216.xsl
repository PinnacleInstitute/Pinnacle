<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="ReportHeader.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'Sales Order Receipt'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">10</xsl:attribute>
         <xsl:choose>
            <xsl:when test="(/DATA/ERROR)">
               <xsl:variable name="errnum" select="/DATA/ERROR/@number"/>
               <xsl:variable name="errmsg" select="/DATA/LANGUAGE/LABEL[@name=$errnum]"/>
               <xsl:choose>
                  <xsl:when test="string-length($errmsg)&gt;0">
                     <xsl:variable name="msgval" select="/DATA/ERROR/@msgval"/>
                     <xsl:variable name="msgfld" select="/DATA/ERROR/@msgfld"/>
                     <xsl:variable name="errfld" select="/DATA/LANGUAGE[*]/LABEL[@name=$msgfld]"/>
                     <xsl:variable name="errmsgfld">
                        <xsl:choose>
                           <xsl:when test="string-length($errfld)&gt;0"><xsl:value-of select="$errfld"/></xsl:when>
                           <xsl:otherwise><xsl:value-of select="$msgfld"/></xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="string-length($msgval)&gt;0"><xsl:value-of select="concat(' (', $msgval, ')')"/></xsl:if>
                     </xsl:variable>
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper</xsl:attribute>
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">650</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">SalesOrder</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <!--HEADER ROW-->
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:call-template name="ReportHeader"/>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">12</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:attribute name="class">PageHeading</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesOrderText']"/>
               </xsl:element>
            </xsl:element>

            <xsl:if test="(/DATA/PARAM/@memberid != 0) and (/DATA/PARAM/@prospectid = 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:attribute name="height">6</xsl:attribute>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:attribute name="width">650</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:element name="div">
                        <xsl:attribute name="id">true</xsl:attribute>
                        <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:element name="b">
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                        <xsl:element name="BR"/>
                     <xsl:if test="(/DATA/PARAM/@addressid = 0)">
                        <xsl:for-each select="/DATA/TXN/PTSADDRESSS/PTSADDRESS">
                                 <xsl:value-of select="@street1"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="@street2"/>
                                 ,
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="@city"/>
                                 ,
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="@state"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="@zip"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="@countryname"/>
                                 <xsl:element name="BR"/>
                        </xsl:for-each>
                     </xsl:if>
                     <xsl:if test="(/DATA/PARAM/@addressid != 0)">
                           <xsl:value-of select="/DATA/TXN/PTSADDRESS/@street1"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="/DATA/TXN/PTSADDRESS/@street2"/>
                           ,
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/>
                           ,
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="/DATA/TXN/PTSADDRESS/@countryname"/>
                           <xsl:element name="BR"/>
                     </xsl:if>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/>
                        <xsl:element name="BR"/>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/>
                        <xsl:element name="BR"/>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone2']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone2"/>
                     </xsl:element>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:if test="(/DATA/PARAM/@prospectid != 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:attribute name="height">6</xsl:attribute>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:attribute name="width">650</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:element name="b">
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Customer']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     </xsl:element>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:element name="b">
                        <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectname"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        ,
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="@street1"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="@street2"/>
                        ,
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="@city"/>
                        ,
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="@state"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="@zip"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="@countryname"/>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">6</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesOrderID']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@salesorderid"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrderDate']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@orderdate"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:variable name="tmp1"><xsl:value-of select="/DATA/TXN/PTSSALESORDER/PTSSTATUSS/ENUM[@id=/DATA/TXN/PTSSALESORDER/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">6</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Amount']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@amount"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:if test="(/DATA/TXN/PTSSALESORDER/@bv != '$0.00')">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">125</xsl:attribute>
                     <xsl:attribute name="align">right</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BV']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">525</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:element name="b">
                     <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@bv"/>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:if test="(/DATA/TXN/PTSSALESORDER/@discount != 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">125</xsl:attribute>
                     <xsl:attribute name="align">right</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Discount']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">525</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:element name="b">
                     <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@discount"/>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tax']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@tax"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Shipping']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@shipping"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@total"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="height">18</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ship']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:variable name="tmp1"><xsl:value-of select="/DATA/TXN/PTSSALESORDER/PTSSHIPS/ENUM[@id=/DATA/TXN/PTSSALESORDER/@ship]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track']"/>
                  <xsl:text>:</xsl:text>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
               </xsl:element>
               <xsl:element name="TD">
                  <xsl:attribute name="width">525</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@track"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:if test="(/DATA/TXN/PTSSALESORDER/@notes != '')">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">125</xsl:attribute>
                     <xsl:attribute name="align">right</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Notes']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">525</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@notes"/>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">6</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="TABLE">
                     <xsl:attribute name="border">0</xsl:attribute>
                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                     <xsl:attribute name="width">650</xsl:attribute>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="width">5%</xsl:attribute>
                           <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                           <xsl:attribute name="valign">Bottom</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qty']"/>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="width">65%</xsl:attribute>
                           <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                           <xsl:attribute name="valign">Bottom</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProductName']"/>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="width">15%</xsl:attribute>
                           <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                           <xsl:attribute name="valign">Bottom</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Price']"/>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="width">15%</xsl:attribute>
                           <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                           <xsl:attribute name="valign">Bottom</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Options']"/>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">4</xsl:attribute>
                           <xsl:attribute name="height">2</xsl:attribute>
                           <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

                     <xsl:for-each select="/DATA/TXN/PTSSALESITEMS/PTSSALESITEM">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="@quantity"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@productname"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:if test="(@billdate != '')">
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/recur.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">purple</xsl:attribute>
                                    <xsl:value-of select="@billdate"/>
                                    </xsl:element>
                              </xsl:if>
                                 <xsl:if test="(@inputvalues != '')">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:value-of select="@inputvalues"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="@price"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="@optionprice"/>
                           </xsl:element>
                        </xsl:element>
                     </xsl:for-each>
                     <xsl:choose>
                        <xsl:when test="(count(/DATA/TXN/PTSSALESITEMS/PTSSALESITEM) = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">4</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="class">NoItems</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:when>
                     </xsl:choose>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">4</xsl:attribute>
                           <xsl:attribute name="height">2</xsl:attribute>
                           <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:if test="(/DATA/PARAM/@prospectid = 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:attribute name="height">12</xsl:attribute>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:attribute name="width">650</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">650</xsl:attribute>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="width">15%</xsl:attribute>
                              <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                              <xsl:attribute name="valign">Bottom</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaymentDate']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="width">13%</xsl:attribute>
                              <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                              <xsl:attribute name="valign">Bottom</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Amount']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="width">15%</xsl:attribute>
                              <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                              <xsl:attribute name="valign">Bottom</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayType']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="width">17%</xsl:attribute>
                              <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                              <xsl:attribute name="valign">Bottom</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="width">40%</xsl:attribute>
                              <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                              <xsl:attribute name="valign">Bottom</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reference']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">5</xsl:attribute>
                              <xsl:attribute name="height">2</xsl:attribute>
                              <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:for-each select="/DATA/TXN/PTSPAYMENTS/PTSPAYMENT">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@paydate"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@total"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:variable name="tmp3"><xsl:value-of select="../PTSPAYTYPES/ENUM[@id=current()/@paytype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:variable name="tmp4"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp4]"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@reference"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:for-each>
                        <xsl:choose>
                           <xsl:when test="(count(/DATA/TXN/PTSPAYMENTS/PTSPAYMENT) = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">5</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="class">NoItems</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:when>
                        </xsl:choose>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">5</xsl:attribute>
                              <xsl:attribute name="height">2</xsl:attribute>
                              <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">24</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:attribute name="class">PageHeading</xsl:attribute>
                  <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@companyname"/>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="div">
                     <xsl:attribute name="id">true</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:element name="b">
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@email"/>
                     <xsl:element name="BR"/>
                     <xsl:if test="(/DATA/TXN/PTSCOMPANY/@phone1 != '')">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@phone1"/>
                        <xsl:element name="BR"/>
                     </xsl:if>
                     <xsl:if test="(/DATA/TXN/PTSCOMPANY/@fax != '')">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fax']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@fax"/>
                        <xsl:element name="BR"/>
                     </xsl:if>
                  </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">12</xsl:attribute>
               </xsl:element>
            </xsl:element>

            </xsl:element>
            <!--END FORM-->

         </xsl:element>
         <!--END PAGE-->

<xsl:element name="script">
   <xsl:attribute name="type">text/javascript</xsl:attribute>
   <xsl:text>function googleTranslateElementInit() {</xsl:text>
   <xsl:text>new google.translate.TranslateElement({pageLanguage:'en'}, 'google_translate_element');</xsl:text>
   <xsl:text>}</xsl:text>
</xsl:element>
<xsl:element name="script">
   <xsl:attribute name="type">text/javascript</xsl:attribute>
   <xsl:attribute name="src">//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit</xsl:attribute>
</xsl:element>
      </xsl:element>
      </xsl:element>
      <!--END BODY-->

   </xsl:template>
</xsl:stylesheet>