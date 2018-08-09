<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
   <xsl:include href="PageFooter.xsl"/>
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
         <xsl:with-param name="pagename" select="'Managing Buddy'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:if test="/DATA/PARAM/@contentpage=1 or /DATA/PARAM/@contentpage=3">
            <xsl:attribute name="topmargin">0</xsl:attribute>
            <xsl:attribute name="leftmargin">0</xsl:attribute>
         </xsl:if>
         <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
            <xsl:attribute name="topmargin">0</xsl:attribute>
            <xsl:attribute name="leftmargin">10</xsl:attribute>
         </xsl:if>
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
            <xsl:if test="/DATA/PARAM/@contentpage=0">
               <xsl:attribute name="width">750</xsl:attribute>
            </xsl:if>
            <xsl:if test="/DATA/PARAM/@contentpage=1">
               <xsl:attribute name="width">600</xsl:attribute>
            </xsl:if>
            <xsl:if test="/DATA/PARAM/@contentpage=2 or /DATA/PARAM/@contentpage=3">
               <xsl:attribute name="width">610</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Company</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ContentPage</xsl:attribute>
                  <xsl:attribute name="id">ContentPage</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@contentpage"/></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">740</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
                        <xsl:call-template name="PageHeader"/>
                     </xsl:if>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">600</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">600</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">middle</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/tbimage.gif</xsl:attribute>
                                 <xsl:attribute name="width">72</xsl:attribute>
                                 <xsl:attribute name="height">72</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Good']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/PARAM/@time = 1)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EarlyMorning']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@time = 2)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Morning']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@time = 3)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Afternoon']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@time = 4)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Evening']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@namefirst"/>
                                    <xsl:element name="BR"/>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomerSupport']"/>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:if test="(/DATA/TXN/PTSBUSINESS/@customeremail != '')">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@customeremail"/>
                                    <xsl:element name="BR"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSBUSINESS/@phone != '')">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@phone"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSBUSINESS/@fax != '')">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fax']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@fax"/>
                                    <xsl:element name="BR"/>
                                 </xsl:if>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ManagingBuddyText']"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Green</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberExpectations']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">palegreen</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@expectation1"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Expectation1']"/>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">palegreen</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@expectation0"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Expectation0']"/>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Green</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberStatus']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Green</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberVisit']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">palegreen</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMBM/@total"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalMembers']"/>
                                             <xsl:element name="BR"/>
                                          <xsl:if test="(/DATA/TXN/PTSMBM/@status1 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBM/@status1"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status1']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBM/@status2 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBM/@status2"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status2']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBM/@status3 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBM/@status3"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status3']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBM/@status4 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBM/@status4"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status4']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">palegreen</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSMBV/@visit1 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBV/@visit1"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit1']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBV/@visit3 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBV/@visit3"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit3']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBV/@visit7 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBV/@visit7"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit7']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBV/@visit14 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBV/@visit14"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit14']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBV/@visit30 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBV/@visit30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit30']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBV/@visit31 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBV/@visit31"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit31']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMBV/@visit32 != '')">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMBV/@visit32"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit32']"/>
                                                <xsl:element name="BR"/>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">18</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Navy</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Folders']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Navy</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Courses']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">PaleTurquoise</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@orgtotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrgTotal']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@orgpublic"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrgPublic']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@orgprivate"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrgPrivate']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@orgsemiprivate"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrgSemiPrivate']"/>
                                             <xsl:element name="BR"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">PaleTurquoise</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@coursetotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseTotal']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@coursepublic"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CoursePublic']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@courseused"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseUsed']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@courseunused"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseUnused']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@coursetrainer"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseTrainer']"/>
                                             <xsl:element name="BR"/>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">18</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Purple</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Suggestions']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Purple</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Assessments']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Purple</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Surveys']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="bgcolor">plum</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@suggesttotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestTotal']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@suggestnew"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestNew']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@suggestreplied"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestReplied']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@suggestaccepted"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestAccepted']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@suggestrewarded"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestRewarded']"/>
                                             <xsl:element name="BR"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="bgcolor">plum</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@assesstotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessTotal']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@assessactive"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessActive']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@assessinactive"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessInactive']"/>
                                             <xsl:element name="BR"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">190</xsl:attribute>
                                          <xsl:attribute name="bgcolor">plum</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@surveytotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyTotal']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@surveycompleted"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyCompleted']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@surveypending"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyPending']"/>
                                             <xsl:element name="BR"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMB/@surveyinactive"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyInactive']"/>
                                             <xsl:element name="BR"/>
                                       </xsl:element>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@contentpage = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@contentpage != 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
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

               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
                        <xsl:call-template name="PageFooter"/>
                     </xsl:if>
                  </xsl:element>
               </xsl:element>

            </xsl:element>
            <!--END FORM-->

         </xsl:element>
         <!--END PAGE-->

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>