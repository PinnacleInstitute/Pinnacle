<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet5.css</xsl:attribute>
      </xsl:element>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">GCR</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
            <xsl:element name="CENTER">
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">button</xsl:attribute>
                  <xsl:attribute name="value">
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CloseWindow']"/>
                  </xsl:attribute>
                  <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
               </xsl:element>
            </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
            </xsl:element>
            <!--END FORM-->

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <![CDATA[function doSubmit(iAction, sMsg){document.GCR.elements['ActionCode'].value=iAction;document.GCR.submit();}]]>
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