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
         <xsl:with-param name="pagename" select="'Member Options'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
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
               <xsl:attribute name="onload">document.getElementById('A').focus()</xsl:attribute>
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
               <xsl:attribute name="name">Coption</xsl:attribute>
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
                     <xsl:attribute name="width">600</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">600</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PaeHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberOptions']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@opt = 4)">
                                    <xsl:value-of select="/DATA/PARAM/@name" disable-output-escaping="yes"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@opt &lt; 4)">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@opt" disable-output-escaping="yes"/>
                                    </xsl:element>
                                 </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">300</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
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
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">A</xsl:attribute>
                                          <xsl:attribute name="id">A</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='A']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">hh</xsl:attribute>
                                          <xsl:attribute name="id">hh</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@hh = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='hh']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">E</xsl:attribute>
                                          <xsl:attribute name="id">E</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@e = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='E']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a6</xsl:attribute>
                                          <xsl:attribute name="id">a6</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a6 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a6']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">Y</xsl:attribute>
                                          <xsl:attribute name="id">Y</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@y = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Y']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">Z</xsl:attribute>
                                          <xsl:attribute name="id">Z</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@z = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Z']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">zz</xsl:attribute>
                                          <xsl:attribute name="id">zz</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@zz = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='zz']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">lcurly</xsl:attribute>
                                          <xsl:attribute name="id">lcurly</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@lcurly = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='lcurly']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a5</xsl:attribute>
                                          <xsl:attribute name="id">a5</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a5 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a5']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a3</xsl:attribute>
                                          <xsl:attribute name="id">a3</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a3 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a3']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a1</xsl:attribute>
                                          <xsl:attribute name="id">a1</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a1 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a1']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">nn</xsl:attribute>
                                          <xsl:attribute name="id">nn</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@nn = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='nn']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">ll</xsl:attribute>
                                          <xsl:attribute name="id">ll</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@ll = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ll']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">star</xsl:attribute>
                                          <xsl:attribute name="id">star</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@star = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='star']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">pound</xsl:attribute>
                                          <xsl:attribute name="id">pound</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@pound = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pound']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">lbracket</xsl:attribute>
                                          <xsl:attribute name="id">lbracket</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@lbracket = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='lbracket']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">ss</xsl:attribute>
                                          <xsl:attribute name="id">ss</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@ss = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ss']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">H</xsl:attribute>
                                          <xsl:attribute name="id">H</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@h = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='H']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a2</xsl:attribute>
                                          <xsl:attribute name="id">a2</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a2']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a7</xsl:attribute>
                                          <xsl:attribute name="id">a7</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a7 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a7']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">F</xsl:attribute>
                                          <xsl:attribute name="id">F</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@f = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='F']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">ff</xsl:attribute>
                                          <xsl:attribute name="id">ff</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@ff = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ff']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">I</xsl:attribute>
                                          <xsl:attribute name="id">I</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@i = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='I']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">ii</xsl:attribute>
                                          <xsl:attribute name="id">ii</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@ii = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ii']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">G</xsl:attribute>
                                          <xsl:attribute name="id">G</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@g = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='G']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">gg</xsl:attribute>
                                          <xsl:attribute name="id">gg</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@gg = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='gg']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">W</xsl:attribute>
                                          <xsl:attribute name="id">W</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@w = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='W']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">oo</xsl:attribute>
                                          <xsl:attribute name="id">oo</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@oo = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='oo']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">B</xsl:attribute>
                                          <xsl:attribute name="id">B</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@b = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='B']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">K</xsl:attribute>
                                          <xsl:attribute name="id">K</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@k = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='K']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">L</xsl:attribute>
                                          <xsl:attribute name="id">L</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@l = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='L']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a9</xsl:attribute>
                                          <xsl:attribute name="id">a9</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a9 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a9']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">M</xsl:attribute>
                                          <xsl:attribute name="id">M</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@m = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='M']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">ww</xsl:attribute>
                                          <xsl:attribute name="id">ww</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@ww = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ww']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">V</xsl:attribute>
                                          <xsl:attribute name="id">V</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@v = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='V']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">jj</xsl:attribute>
                                          <xsl:attribute name="id">jj</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@jj = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='jj']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">rparen</xsl:attribute>
                                          <xsl:attribute name="id">rparen</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@rparen = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rparen']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">pp</xsl:attribute>
                                          <xsl:attribute name="id">pp</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@pp = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pp']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">xx</xsl:attribute>
                                          <xsl:attribute name="id">xx</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@xx = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='xx']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">N</xsl:attribute>
                                          <xsl:attribute name="id">N</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@n = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='N']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">fslash</xsl:attribute>
                                          <xsl:attribute name="id">fslash</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@fslash = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='fslash']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">semicolon</xsl:attribute>
                                          <xsl:attribute name="id">semicolon</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@semicolon = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='semicolon']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">J</xsl:attribute>
                                          <xsl:attribute name="id">J</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@j = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='J']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a8</xsl:attribute>
                                          <xsl:attribute name="id">a8</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a8 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a8']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">percent</xsl:attribute>
                                          <xsl:attribute name="id">percent</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@percent = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='percent']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">300</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">aa</xsl:attribute>
                                          <xsl:attribute name="id">aa</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@aa = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='aa']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">bb</xsl:attribute>
                                          <xsl:attribute name="id">bb</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@bb = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='bb']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">dd</xsl:attribute>
                                          <xsl:attribute name="id">dd</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@dd = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='dd']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">cc</xsl:attribute>
                                          <xsl:attribute name="id">cc</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@cc = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='cc']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">ee</xsl:attribute>
                                          <xsl:attribute name="id">ee</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@ee = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ee']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">rcurly</xsl:attribute>
                                          <xsl:attribute name="id">rcurly</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@rcurly = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rcurly']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">bar</xsl:attribute>
                                          <xsl:attribute name="id">bar</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@bar = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='bar']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">bslash</xsl:attribute>
                                          <xsl:attribute name="id">bslash</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@bslash = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='bslash']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">underscore</xsl:attribute>
                                          <xsl:attribute name="id">underscore</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@underscore = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='underscore']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">plus</xsl:attribute>
                                          <xsl:attribute name="id">plus</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@plus = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='plus']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">equal</xsl:attribute>
                                          <xsl:attribute name="id">equal</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@equal = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='equal']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a4</xsl:attribute>
                                          <xsl:attribute name="id">a4</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a4 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a4']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">a0</xsl:attribute>
                                          <xsl:attribute name="id">a0</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@a0 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='a0']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">D</xsl:attribute>
                                          <xsl:attribute name="id">D</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@d = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='D']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">U</xsl:attribute>
                                          <xsl:attribute name="id">U</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@u = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='U']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">S</xsl:attribute>
                                          <xsl:attribute name="id">S</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@s = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='S']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">R</xsl:attribute>
                                          <xsl:attribute name="id">R</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@r = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='R']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">T</xsl:attribute>
                                          <xsl:attribute name="id">T</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@t = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='T']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">mm</xsl:attribute>
                                          <xsl:attribute name="id">mm</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@mm = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='mm']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">C</xsl:attribute>
                                          <xsl:attribute name="id">C</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@c = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='C']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">O</xsl:attribute>
                                          <xsl:attribute name="id">O</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@o = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='O']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">P</xsl:attribute>
                                          <xsl:attribute name="id">P</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@p = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='P']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">Q</xsl:attribute>
                                          <xsl:attribute name="id">Q</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@q = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Q']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">X</xsl:attribute>
                                          <xsl:attribute name="id">X</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@x = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='X']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">kk</xsl:attribute>
                                          <xsl:attribute name="id">kk</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@kk = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='kk']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">qq</xsl:attribute>
                                          <xsl:attribute name="id">qq</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@qq = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='qq']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">rr</xsl:attribute>
                                          <xsl:attribute name="id">rr</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@rr = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rr']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">tt</xsl:attribute>
                                          <xsl:attribute name="id">tt</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@tt = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='tt']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">uu</xsl:attribute>
                                          <xsl:attribute name="id">uu</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@uu = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='uu']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">vv</xsl:attribute>
                                          <xsl:attribute name="id">vv</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@vv = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='vv']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">at</xsl:attribute>
                                          <xsl:attribute name="id">at</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@at = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='at']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">lparen</xsl:attribute>
                                          <xsl:attribute name="id">lparen</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@lparen = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='lparen']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">period</xsl:attribute>
                                          <xsl:attribute name="id">period</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@period = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='period']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">comma</xsl:attribute>
                                          <xsl:attribute name="id">comma</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@comma = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='comma']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">rbracket</xsl:attribute>
                                          <xsl:attribute name="id">rbracket</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@rbracket = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rbracket']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">yy</xsl:attribute>
                                          <xsl:attribute name="id">yy</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@yy = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='yy']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">exclaim</xsl:attribute>
                                          <xsl:attribute name="id">exclaim</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@exclaim = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='exclaim']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">dollar</xsl:attribute>
                                          <xsl:attribute name="id">dollar</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@dollar = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='dollar']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">colon</xsl:attribute>
                                          <xsl:attribute name="id">colon</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@colon = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='colon']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">caret</xsl:attribute>
                                          <xsl:attribute name="id">caret</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@caret = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='caret']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">18</xsl:attribute>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">18</xsl:attribute>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">18</xsl:attribute>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">18</xsl:attribute>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">18</xsl:attribute>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">18</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
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

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>