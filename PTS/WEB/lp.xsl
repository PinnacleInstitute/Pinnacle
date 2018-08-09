<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="InputOptions.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:value-of select="/DATA/TXN/TOP/comment()" disable-output-escaping="yes"/>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">0</xsl:attribute>

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
                     <xsl:attribute name="onLoad">location.hash='#top';doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad">location.hash='#top';doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onload">location.hash='#top';</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">LeadCampaign</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

            <xsl:if test="(/DATA/PARAM/@preview = 1)">
                  <xsl:element name="font">
                     <xsl:attribute name="size">3</xsl:attribute>
                     <xsl:attribute name="color">red</xsl:attribute>
                     <xsl:attribute name="face">arial</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PreviewWarning']"/>
                  </xsl:element>
                  <xsl:element name="BR"/>
            </xsl:if>
               <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">LeadPageID</xsl:attribute>
                  <xsl:attribute name="id">LeadPageID</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@leadpageid"/></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">AddLeadPageID</xsl:attribute>
                  <xsl:attribute name="id">AddLeadPageID</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@addleadpageid"/></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">Preview</xsl:attribute>
                  <xsl:attribute name="id">Preview</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@preview"/></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">r</xsl:attribute>
                  <xsl:attribute name="id">r</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@r"/></xsl:attribute>
               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@preview != 2)">
               <xsl:if test="(/DATA/TXN/PTSLEADPAGE/@isinput != 0) and (/DATA/TXN/PTSLEADPAGE/@inputs != '')">
                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">750</xsl:attribute>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:for-each select="/DATA/TXN/PTSLEADPAGE/INPUTSS/INPUTS">
                              <xsl:call-template name="InputOptions">
                                 <xsl:with-param name="margin" select="0"/>
                                 <xsl:with-param name="secure" select="0"/>
                              </xsl:call-template>
                           </xsl:for-each>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Submit']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                     </xsl:element>
               </xsl:if>
               <xsl:if test="(/DATA/PARAM/@leadpageid != 0) and (/DATA/TXN/PTSLEADPAGE/@isnext != 0)">
                     <xsl:if test="(not(/DATA/TXN/PTSLEADPAGE/@nextcaption))">
                     <xsl:element name="CENTER">
                        <xsl:element name="INPUT">
                           <xsl:attribute name="type">button</xsl:attribute>
                           <xsl:attribute name="value">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Next']"/>
                           </xsl:attribute>
                           <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     </xsl:if>
                     <xsl:if test="(/DATA/TXN/PTSLEADPAGE/@nextcaption != '')">
                     <xsl:element name="CENTER">
                        <xsl:element name="INPUT">
                           <xsl:attribute name="type">button</xsl:attribute>
                           <xsl:attribute name="value">
                              <xsl:value-of select="/DATA/TXN/PTSLEADPAGE/@nextcaption"/>
                           </xsl:attribute>
                           <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     </xsl:if>
               </xsl:if>
               <xsl:if test="(/DATA/PARAM/@preview != 0)">
                     <xsl:element name="BR"/><xsl:element name="BR"/>
                  <xsl:element name="CENTER">
                     <xsl:element name="INPUT">
                        <xsl:attribute name="type">button</xsl:attribute>
                        <xsl:attribute name="value">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                        </xsl:attribute>
                        <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                     </xsl:element>
                  </xsl:element>
               </xsl:if>
            </xsl:if>
            <xsl:if test="(/DATA/PARAM/@preview = 2)">
                  <xsl:element name="BR"/><xsl:element name="BR"/>
               <xsl:element name="CENTER">
                  <xsl:element name="INPUT">
                     <xsl:attribute name="type">button</xsl:attribute>
                     <xsl:attribute name="value">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Thankyou']"/>
                     </xsl:attribute>
                     <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                  </xsl:element>
               </xsl:element>
            </xsl:if>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
            </xsl:element>
            <!--END FORM-->

      </xsl:element>
      <!--END BODY-->

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <![CDATA[function doSubmit(iAction, sMsg){document.LeadCampaign.elements['ActionCode'].value=iAction;document.LeadCampaign.submit();}]]>
         <![CDATA[function doErrorMsg(sError){alert(sError);}]]>
      </xsl:element>

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
   </xsl:template>
</xsl:stylesheet>