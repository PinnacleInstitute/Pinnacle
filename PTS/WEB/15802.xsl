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
         <xsl:with-param name="pagename" select="'Nexxus Stats'"/>
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
               <xsl:attribute name="onload">document.getElementById('Day').focus()</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper600</xsl:attribute>
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
               <xsl:attribute name="name">Nexxus</xsl:attribute>
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
                     <xsl:attribute name="width">606</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">606</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">6</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">606</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Performance32.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Statistics']"/>
                                  - 
                                 <xsl:value-of select="/DATA/PARAM/@today" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">300</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Customers']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Week']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Member']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m11"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m17"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m199"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="width">230</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomerRatio']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@ac"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Members']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Week']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Affiliate']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m21"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m27"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m299"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Bronze']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m31"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m37"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m399"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Silver']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m41"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m47"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m499"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Gold']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m51"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m57"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m599"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Diamond']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m61"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m67"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m699"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Platinum']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m71"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m77"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m799"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ambassador']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m81"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m87"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@m899"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Active']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@t1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@t7"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@t99"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="width">230</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Paid90']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@aa"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="width">230</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit90']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@av"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="width">230</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Engaged90']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@ae"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Suspended']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@a1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@a7"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@a99"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancelled']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@c1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@c7"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">70</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@c99"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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
                           <xsl:element name="TD">
                              <xsl:attribute name="width">6</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">300</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sales']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Days7']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Days30']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@s1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@s7"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@s30"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@s99"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@s100"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Bonuses']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Days7']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Days30']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@b1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@b7"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@b30"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@b99"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">75</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@b100"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Wallet']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Available']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Requested']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@w1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@w2"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@w3"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualified']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@w4"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@w5"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QualifiedAffiliates']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Days7']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Days30']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
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

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CCS']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@ccs1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@ccs2"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@ccs3"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">63</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QA']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@qa1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@qa2"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">79</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@qa3"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
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
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">606</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DaysBack']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Day</xsl:attribute>
                              <xsl:attribute name="id">Day</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@day"/></xsl:attribute>
                              <xsl:attribute name="size">1</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">smbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Refresh']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(0,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">smbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
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
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>