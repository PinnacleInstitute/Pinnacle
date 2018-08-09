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
         <xsl:with-param name="pagename" select="'Nexxus Support'"/>
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
         <xsl:attribute name="id">wrapper800</xsl:attribute>
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
                     <xsl:attribute name="width">800</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">800</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">267</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">267</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">266</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Performance32.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NexxusSupportStatistics']"/>
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
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="width">800</xsl:attribute>
                                                      <xsl:attribute name="height">24</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">3</xsl:attribute>
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                         <xsl:if test="(/DATA/PARAM/@orgid = 0)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AllSupportTickets']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/PARAM/@orgid != 0)">
                                                               <xsl:value-of select="/DATA/TXN/PTSORG/@namefirst"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:value-of select="/DATA/TXN/PTSORG/@namelast"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SupportTickets']"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">800</xsl:attribute>
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">1</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">6</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='1hr']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='4hr']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='12hr']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='1day']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2day']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='3day']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='7day']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='14day']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='14+day']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">6</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Submitted']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1a"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1b"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">orange</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1c"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">orange</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1d"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1e"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1f"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1g"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1h"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1i"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z1t"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">6</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Assigned']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2a"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2b"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">orange</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2c"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">orange</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2d"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2e"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2f"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2g"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2h"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2i"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z2t"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">6</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='InProcess']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3a"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3b"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">orange</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3c"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">orange</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3d"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3e"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3f"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3g"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3h"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3i"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z3t"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">6</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">800</xsl:attribute>
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">1</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
                                                      <xsl:attribute name="height">6</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Unresolved']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7a"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7b"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7c"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7d"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7e"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7f"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7g"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7h"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7i"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">72</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@z7t"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">11</xsl:attribute>
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
                              <xsl:attribute name="width">800</xsl:attribute>
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
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrgID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">OrgID</xsl:attribute>
                              <xsl:attribute name="id">OrgID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@orgid"/></xsl:attribute>
                              <xsl:attribute name="size">4</xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">200</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
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
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="width">200</xsl:attribute>
                                                      <xsl:attribute name="height">24</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DailyResolvedTickets']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">200</xsl:attribute>
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd1"/>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Yesterday']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd2"/>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2DaysAgo']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd3"/>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='3DaysAgo']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd4"/>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='4DaysAgo']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd5"/>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='5DaysAgo']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd6"/>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='6DaysAgo']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd7"/>
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
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='7DaysAgo']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">100</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zd8"/>
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
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">200</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">White</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="width">200</xsl:attribute>
                                                      <xsl:attribute name="height">24</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">darkblue</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResolvedTicketDays']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">200</xsl:attribute>
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">1</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SameDay']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr1"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp1"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextDay']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr2"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp2"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2Days']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr3"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp3"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='3Days']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr4"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp4"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='4Days']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr5"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp5"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='5Days']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr6"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp6"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='6Days']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr7"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp7"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">80</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='6+Days']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zr8"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">60</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSTATS/@zp8"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">200</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">267</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="width">40%</xsl:attribute>
                                                   <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                   <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrgID']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="width">60%</xsl:attribute>
                                                   <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                   <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StaffName']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">2</xsl:attribute>
                                                   <xsl:attribute name="height">2</xsl:attribute>
                                                   <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>

                                             <xsl:for-each select="/DATA/TXN/PTSORGS/PTSORG">
                                                <xsl:element name="TR">
                                                   <xsl:if test="(position() mod 2)=1">
                                                      <xsl:attribute name="class">GrayBar</xsl:attribute>
                                                   </xsl:if>
                                                   <xsl:if test="(position() mod 2)=0">
                                                      <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                                   </xsl:if>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="@orgid"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="@namefirst"/>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:for-each>
                                             <xsl:choose>
                                                <xsl:when test="(count(/DATA/TXN/PTSORGS/PTSORG) = 0)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="class">NoItems</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:when>
                                             </xsl:choose>

                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">2</xsl:attribute>
                                                   <xsl:attribute name="height">2</xsl:attribute>
                                                   <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
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