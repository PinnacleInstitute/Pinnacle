<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="HTML">

      <xsl:variable name="usergroup" select="/DATA/SYSTEM/@usergroup"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Store']"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">3</xsl:attribute>
         <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@pagecolor"/></xsl:attribute>
         <xsl:variable name="background">
            <xsl:choose>
               <xsl:when test="string-length(/DATA/PARAM/@pageimage)!=0">
                  <xsl:value-of select="/DATA/PARAM/@pageimage"/>
               </xsl:when>
               <xsl:otherwise><xsl:value-of select="/DATA/PARAM/@pageimage"/></xsl:otherwise>
            </xsl:choose>
         </xsl:variable>
         <xsl:attribute name="background">Images/<xsl:value-of select="$background"/></xsl:attribute>
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
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">100%</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Merchant</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">0%</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">100%</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewMap(address){ 
          var url, win;
          url = "http://maps.google.com/?q=" + address
          win = window.open(url,"Map");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewAwards(){ 
          var mid = document.getElementById('MerchantID').value;
          var  url = "m_15312.asp?merchantid=" + mid
          var win = window.open(url);
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">0%</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">100%</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MerchantID</xsl:attribute>
                              <xsl:attribute name="id">MerchantID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@merchantid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(not(contains(/DATA/PARAM/@storeoptions, 'B')))">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="style"><xsl:value-of select="/DATA/PARAM/@textstyle"/></xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">70%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSMERCHANT/@image != '')">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Store/<xsl:value-of select="/DATA/TXN/PTSMERCHANT/@merchantid"/>/<xsl:value-of select="/DATA/TXN/PTSMERCHANT/@image"/></xsl:attribute>
                                                   <xsl:attribute name="width">300</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">70%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:attribute name="style"><xsl:value-of select="/DATA/PARAM/@textstyle"/></xsl:attribute>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@merchantname"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star<xsl:value-of select="/DATA/TXN/PTSMERCHANT/@rating"/>.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'D')) or (contains(/DATA/PARAM/@storeoptions, 'E')) or (contains(/DATA/PARAM/@storeoptions, 'F'))">
                                                   <xsl:element name="BR"/>
                                                <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'F'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">3</xsl:attribute>
                                                         <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@namefirst"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@namelast"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'D'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">3</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@email2"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'E'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">3</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@phone2"/>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                             <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'C'))">
                                                   <xsl:element name="BR"/>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="size">3</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@street1"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@street2"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@city"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@state"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@zip"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@countryname"/>
                                                   <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'H'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">ViewMap("<xsl:value-of select="concat(/DATA/TXN/PTSMERCHANT/@street1, ' ', /DATA/TXN/PTSMERCHANT/@street2, ' ', /DATA/TXN/PTSMERCHANT/@city, ' ', /DATA/TXN/PTSMERCHANT/@state, ' ', /DATA/TXN/PTSMERCHANT/@zip, ' ', /DATA/TXN/PTSMERCHANT/@countryname)"/>")</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/GoogleMaps.png</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMap']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMap']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:for-each select="/DATA/TXN/PTSAWARDS/PTSAWARD">
                                                      <xsl:element name="BR"/>
                                                      <xsl:value-of select="@amount"/>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='%']"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@description"/>
                                                      <xsl:if test="(@cap != '$0.00')">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='upto']"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="@cap"/>
                                                      </xsl:if>
                                             </xsl:for-each>
                                             <xsl:if test="(/DATA/TXN/PTSMERCHANT/@isawards != 0)">
                                                   <xsl:element name="BR"/>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="size">3</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAwards']"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewAwards()</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/gift24.png</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSMERCHANT/@terms != '')">
                                                   <xsl:element name="BR"/>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="size">3</xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@terms"/>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@acceptedcoins != '')">
                                                   <xsl:element name="BR"/>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',1,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',2,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin2.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',3,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin3.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',4,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin4.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',5,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin5.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',6,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin6.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',7,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin7.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',8,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin8.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',9,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin9.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',10,'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/coin10.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'B'))">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="style"><xsl:value-of select="/DATA/PARAM/@textstyle"/></xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">70%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">70%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:attribute name="style"><xsl:value-of select="/DATA/PARAM/@textstyle"/></xsl:attribute>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@merchantname"/>
                                             <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'D')) or (contains(/DATA/PARAM/@storeoptions, 'E')) or (contains(/DATA/PARAM/@storeoptions, 'F'))">
                                                   <xsl:element name="BR"/>
                                                <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'D'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">3</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@email2"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'E'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">3</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@phone2"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'F'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">3</xsl:attribute>
                                                         <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@namefirst"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@namelast"/>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                             <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'C'))">
                                                   <xsl:element name="BR"/>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="size">3</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@street1"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@street2"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@city"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@state"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@zip"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@countryname"/>
                                                   <xsl:if test="(contains(/DATA/PARAM/@storeoptions, 'H'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">ViewMap("<xsl:value-of select="concat(/DATA/TXN/PTSMERCHANT/@street1, ' ', /DATA/TXN/PTSMERCHANT/@street2, ' ', /DATA/TXN/PTSMERCHANT/@city, ' ', /DATA/TXN/PTSMERCHANT/@state, ' ', /DATA/TXN/PTSMERCHANT/@zip, ' ', /DATA/TXN/PTSMERCHANT/@countryname)"/>")</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/GoogleMaps.png</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMap']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMap']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:for-each select="/DATA/TXN/PTSAWARDS/PTSAWARD">
                                                      <xsl:element name="BR"/>
                                                      <xsl:value-of select="@amount"/>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='%']"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@description"/>
                                                      <xsl:if test="(@cap != '$0.00')">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='upto']"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="@cap"/>
                                                      </xsl:if>
                                             </xsl:for-each>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSMERCHANT/@image != '')">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Store/<xsl:value-of select="/DATA/TXN/PTSMERCHANT/@merchantid"/>/<xsl:value-of select="/DATA/TXN/PTSMERCHANT/@image"/></xsl:attribute>
                                                   <xsl:attribute name="width">300</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSMERCHANT/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                     </xsl:element>

                  </xsl:element>
                  <!--END CONTENT COLUMN-->

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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>