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
         <xsl:with-param name="pagename" select="'Email'"/>
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
            <xsl:attribute name="width">750</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">750</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">750</xsl:attribute>
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

            <xsl:if test="(/DATA/TXN/PTSEMAILLIST/@unsubscribe = 1)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">750</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:attribute name="class">Prompt</xsl:attribute>
                     <xsl:element name="A">
                        <xsl:attribute name="href"><xsl:value-of select="concat('http://', /DATA/SYSTEM/@servername, /DATA/SYSTEM/@serverpath)"/>8707.asp?EmaileeID={emaileeid}&amp;EmailListID=<xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@emaillistid"/>&amp;Source=<xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@sourcetype"/></xsl:attribute>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UnsubscribeLink']"/>
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