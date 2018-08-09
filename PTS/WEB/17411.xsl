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
         <xsl:with-param name="pagename" select="'Barter Credit'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">5</xsl:attribute>
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
               <xsl:attribute name="name">BarterCredit</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function NewBarterOption(id){ 
          document.getElementById('CreditType').value = id
          doSubmit(1,'Are you completely sure you want to add this feature for the specified credits?');
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
                              <xsl:attribute name="width">60%</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">40%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BarterAdID</xsl:attribute>
                              <xsl:attribute name="id">BarterAdID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@barteradid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CreditType</xsl:attribute>
                              <xsl:attribute name="id">CreditType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@credittype"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@title"/>
                                 <xsl:element name="BR"/>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterCredits']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@negative = 0)">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">green</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Available']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@available" disable-output-escaping="yes"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@negative != 0)">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">red</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Available']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@available" disable-output-escaping="yes"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/PARAM/@total" disable-output-escaping="yes"/>
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
                              <xsl:attribute name="width">60%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeader</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Feature_Title.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                    <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionTitle']"/>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionTitle2']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">40%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'C'))">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">4</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Enabled']"/>
                                    </xsl:element>
                                 </xsl:if>
                              <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'C')))">
                                    <xsl:if test="(/DATA/PARAM/@available &gt;= 1)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFeature']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewBarterOption(2)]]></xsl:text></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@available &lt; 1)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">3</xsl:attribute>
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                       </xsl:element>
                                    </xsl:if>
                              </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'D')))">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">60%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeader</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Feature_Images.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionImages']"/>
                                    </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionImages2']"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">40%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">2</xsl:attribute>
                                       <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'd'))">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">4</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Enabled']"/>
                                          </xsl:element>
                                       </xsl:if>
                                    <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'd')))">
                                          <xsl:if test="(/DATA/PARAM/@available &gt;= 3)">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFeature']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewBarterOption(3)]]></xsl:text></xsl:attribute>
                                             </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@available &lt; 3)">
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">3</xsl:attribute>
                                                <xsl:attribute name="color">red</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                             </xsl:element>
                                          </xsl:if>
                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">60%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeader</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Feature_Images2.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                    <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionImages+']"/>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionImages+2']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">40%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'D'))">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">4</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Enabled']"/>
                                       </xsl:element>
                                    </xsl:if>
                                 <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'D')))">
                                       <xsl:if test="(/DATA/PARAM/@available &gt;= 5)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFeature']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewBarterOption(4)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@available &lt; 5)">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">3</xsl:attribute>
                                             <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                          </xsl:element>
                                       </xsl:if>
                                 </xsl:if>
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
                              <xsl:attribute name="width">60%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeader</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Feature_Editor.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                    <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionEditor']"/>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionEditor2']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">40%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'E'))">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">4</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Enabled']"/>
                                       </xsl:element>
                                    </xsl:if>
                                 <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'E')))">
                                       <xsl:if test="(/DATA/PARAM/@available &gt;= 3)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFeature']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewBarterOption(5)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@available &lt; 3)">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">3</xsl:attribute>
                                             <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                          </xsl:element>
                                       </xsl:if>
                                 </xsl:if>
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
                              <xsl:attribute name="width">60%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeader</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Feature_Long.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                    <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionLong']"/>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionLong2']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">40%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'F'))">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">4</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Enabled']"/>
                                       </xsl:element>
                                    </xsl:if>
                                 <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'F')))">
                                       <xsl:if test="(/DATA/PARAM/@available &gt;= 5)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFeature']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewBarterOption(6)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@available &lt; 5)">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">3</xsl:attribute>
                                             <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                          </xsl:element>
                                       </xsl:if>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'C'))) and (not(contains(/DATA/TXN/PTSBARTERAD/@options, 'd'))) and (not(contains(/DATA/TXN/PTSBARTERAD/@options, 'E')))">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">60%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeader</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionBundle1']"/>
                                    </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionBundle12']"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">40%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@available &gt;= 5)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFeature']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewBarterOption(8)]]></xsl:text></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@available &lt; 5)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">3</xsl:attribute>
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'C'))) and (not(contains(/DATA/TXN/PTSBARTERAD/@options, 'D'))) and (not(contains(/DATA/TXN/PTSBARTERAD/@options, 'E'))) and (not(contains(/DATA/TXN/PTSBARTERAD/@options, 'F')))">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">60%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeader</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionBundle2']"/>
                                    </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionBundle22']"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">40%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@available &gt;= 10)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFeature']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewBarterOption(9)]]></xsl:text></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@available &lt; 10)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">3</xsl:attribute>
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
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
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.opener.UpdateImages();window.close()]]></xsl:text></xsl:attribute>
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

                  </xsl:element>
                  <!--END CONTENT COLUMN-->

               </xsl:element>

            </xsl:element>
            <!--END FORM-->

         </xsl:element>
         <!--END PAGE-->

      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>