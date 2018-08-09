<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLEmail.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleMail.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLEmail">
         <xsl:with-param name="pagename" select="'SalesOrder'"/>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">10</xsl:attribute>
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
                  <xsl:element name="div">
                     <xsl:attribute name="id">true</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:element name="b">
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                     <xsl:element name="BR"/>
                  <xsl:for-each select="/DATA/TXN/PTSADDRESSS/PTSADDRESS">
                           <xsl:value-of select="@street1"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           <xsl:value-of select="@street2"/>
                           <xsl:element name="BR"/>
                           <xsl:value-of select="@city"/>
                           ,
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="@state"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           <xsl:value-of select="@zip"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           <xsl:value-of select="@countryname"/>
                           <xsl:element name="BR"/><xsl:element name="BR"/>
                  </xsl:for-each>
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

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">12</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="height">18</xsl:attribute>
                  <xsl:attribute name="align">right</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrderID']"/>
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
                  <xsl:attribute name="height">18</xsl:attribute>
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
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">12</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">125</xsl:attribute>
                  <xsl:attribute name="height">18</xsl:attribute>
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

            <xsl:if test="(/DATA/TXN/PTSSALESORDER/@discount != 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">125</xsl:attribute>
                     <xsl:attribute name="height">18</xsl:attribute>
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
                  <xsl:attribute name="height">18</xsl:attribute>
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
                  <xsl:attribute name="height">18</xsl:attribute>
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
                  <xsl:attribute name="height">18</xsl:attribute>
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
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="height">12</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:for-each select="/DATA/TXN/PTSPAYMENTS/PTSPAYMENT">
                  <xsl:element name="TR">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">125</xsl:attribute>
                        <xsl:attribute name="height">18</xsl:attribute>
                        <xsl:attribute name="align">right</xsl:attribute>
                        <xsl:attribute name="valign">center</xsl:attribute>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payee']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     </xsl:element>
                     <xsl:element name="TD">
                        <xsl:attribute name="width">525</xsl:attribute>
                        <xsl:attribute name="align">left</xsl:attribute>
                        <xsl:attribute name="valign">center</xsl:attribute>
                        <xsl:element name="b">
                        <xsl:value-of select="@payee"/>
                        </xsl:element>
                     </xsl:element>
                  </xsl:element>

                  <xsl:element name="TR">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">125</xsl:attribute>
                        <xsl:attribute name="height">18</xsl:attribute>
                        <xsl:attribute name="align">right</xsl:attribute>
                        <xsl:attribute name="valign">center</xsl:attribute>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayType']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     </xsl:element>
                     <xsl:element name="TD">
                        <xsl:attribute name="width">525</xsl:attribute>
                        <xsl:attribute name="align">left</xsl:attribute>
                        <xsl:attribute name="valign">center</xsl:attribute>
                        <xsl:element name="b">
                        <xsl:variable name="tmp1"><xsl:value-of select="../PTSPAYTYPES/ENUM[@id=current()/@paytype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                        </xsl:element>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="@cardnumber"/>
                     </xsl:element>
                  </xsl:element>

                  <xsl:element name="TR">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">125</xsl:attribute>
                        <xsl:attribute name="height">18</xsl:attribute>
                        <xsl:attribute name="align">right</xsl:attribute>
                        <xsl:attribute name="valign">center</xsl:attribute>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reference']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     </xsl:element>
                     <xsl:element name="TD">
                        <xsl:attribute name="width">525</xsl:attribute>
                        <xsl:attribute name="align">left</xsl:attribute>
                        <xsl:attribute name="valign">center</xsl:attribute>
                        <xsl:element name="b">
                        <xsl:value-of select="@reference"/>
                        </xsl:element>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="@notes"/>
                     </xsl:element>
                  </xsl:element>

            </xsl:for-each>
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
                  <xsl:attribute name="align">right</xsl:attribute>
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
                                 <xsl:element name="BR"/>
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
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@phone1"/>
                     <xsl:element name="BR"/>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fax']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@fax"/>
                     <xsl:element name="BR"/>
                  </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

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