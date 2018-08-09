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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Dashboard']"/>
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
         <xsl:attribute name="id">wrapper400s</xsl:attribute>
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">750</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Legacy</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="0"/></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">740</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">400</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">400</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Performance32.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Dashboard']"/>
                                  - 
                                 <xsl:value-of select="/DATA/PARAM/@today" disable-output-escaping="yes"/>
                                 <xsl:element name="BR"/>
                                 <xsl:element name="b">
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    (#<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Joined']"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@enrolldate"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">400</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Advancement']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="colspan">5</xsl:attribute>
                                                      <xsl:attribute name="height">1</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
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
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>/Title<xsl:value-of select="/DATA/TXN/PTSMEMBER/@title"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 1)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title1']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 2)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title2']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 3)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title3']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 4)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title4']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 5)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title5']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 6)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title6']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 7)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title7']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 8)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title8']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 9)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title9']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 10)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title10']"/>
                                                         </xsl:if>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &lt; 10)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">150</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextTitle']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">250</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>/Title<xsl:value-of select="/DATA/TXN/PTSMEMBER/@title+1"/>.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 1)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title2']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 2)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title3']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 3)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title4']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 4)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title5']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 5)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title6']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 6)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title7']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 7)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title8']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 8)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title9']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 9)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title10']"/>
                                                            </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &lt; 10)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">150</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NeedNext']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">250</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@a1"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &gt;= 4) and (/DATA/TXN/PTSMEMBER/@title &lt;= 10)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Personal']"/>
                                                            </xsl:if>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 1)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need2']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 2)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need3']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 3)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need4']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 4)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need5']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 5)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need6']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 6)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need7']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 7)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need8']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 8)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need9']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 9)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Need10']"/>
                                                            </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalsTeam']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/TXN/PTSMEMBER/@bv"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         /
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/TXN/PTSMEMBER/@qv"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="height">2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LastRecruit']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@r1 = '')">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='None']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@r1 != '')">
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@r1"/>
                                                         </xsl:if>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         /
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@r2 = '')">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='None']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@r2 != '')">
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@r2"/>
                                                         </xsl:if>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="height">2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">1</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">400</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualifications']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="colspan">5</xsl:attribute>
                                                      <xsl:attribute name="height">1</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
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
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BonusQualified']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q1 = 0)">
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Yes']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q1 = 1)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify1_1']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q1 = 2)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify1_2']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q1 = 3)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify1_3']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q1 = 4)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify1_4']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q1 = 5)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify1_5']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q1 = 6)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify1_6']"/>
                                                            </xsl:element>
                                                         </xsl:if>
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
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayoutQualified']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 0)">
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Yes']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 1)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_1']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 2)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_2']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 3)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_3']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 4)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_4']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 5)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_5']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 6)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_6']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 7)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_7']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q2 = 8)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify2_8']"/>
                                                            </xsl:element>
                                                         </xsl:if>
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
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BinaryQualified']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q3 &gt;= 2)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Yes']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q3 = 0)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify3_1']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q3 = 1)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify3_2']"/>
                                                            </xsl:element>
                                                         </xsl:if>
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
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MatchQualified']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &lt; 5)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='None']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 5) or (/DATA/TXN/PTSMEMBER/@title = 6)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level1']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 7)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level2']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 8)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level3']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &gt;= 9)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level4']"/>
                                                         </xsl:if>
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
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MatrixQualified']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q4 = 0)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level0']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q4 = 1)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level1']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q4 = 2)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level2']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q4 = 3)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level3']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q4 = 4)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level4']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@q4 = 5)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level5']"/>
                                                         </xsl:if>
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
                                                      <xsl:attribute name="width">150</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipQualified']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">250</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &lt; 6)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='None']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 6)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team6']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 7)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team7']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 8)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team8']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title = 9)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team9']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &gt;= 10)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team10']"/>
                                                         </xsl:if>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">1</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">400</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Finances']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="colspan">5</xsl:attribute>
                                                      <xsl:attribute name="height">1</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:if test="(/DATA/PARAM/@show != 0)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Recent']"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Quarter']"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">4</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/PARAM/@show != 0)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="colspan">5</xsl:attribute>
                                                         <xsl:attribute name="height">1</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">4</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/PARAM/@show != 0)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payouts']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/TXN/PTSDASH/@p1"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/TXN/PTSDASH/@p3"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/TXN/PTSDASH/@p99"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">4</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LastOrder']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@b1 = '')">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='None']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@b1 != '')">
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@b1"/>
                                                         </xsl:if>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSDASH/@b2 != '')">
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@b2"/>
                                                         </xsl:if>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextOrder']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@billing = 3) or (/DATA/TXN/PTSMEMBER/@billing = 5)">
                                                            <xsl:value-of select="/DATA/TXN/PTSMEMBER/@price"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@billing != 3) and (/DATA/TXN/PTSMEMBER/@billing != 5)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='None']"/>
                                                         </xsl:if>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSMEMBER/@billing = 3) or (/DATA/TXN/PTSMEMBER/@billing = 5)">
                                                            <xsl:value-of select="/DATA/TXN/PTSMEMBER/@paiddate"/>
                                                         </xsl:if>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@retail != '$0.00')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">red</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LostBonuses']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">red</xsl:attribute>
                                                         <xsl:value-of select="/DATA/TXN/PTSMEMBER/@retail"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="width">200</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='since']"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@lostbonusdate"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">4</xsl:attribute>
                                                         <xsl:attribute name="height">2</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">1</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">400</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leadership']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="colspan">5</xsl:attribute>
                                                      <xsl:attribute name="height">1</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">1</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l11 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Enroller']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l11"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l12"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l13"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l21 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mentor']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l21"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l22"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l23"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l31 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MarketMaker']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l31"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l32"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l33"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l41 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leader1']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l41"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l42"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l43"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l51 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leader2']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l51"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l52"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l53"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l61 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leader3']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l61"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l62"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l63"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l71 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leader4']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l71"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l72"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l73"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/TXN/PTSDASH/@l81 != '')">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leader5']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l81"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l82"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            /
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSDASH/@l83"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">1</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
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
                              <xsl:attribute name="height">6</xsl:attribute>
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
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>