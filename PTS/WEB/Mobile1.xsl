<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

               <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
               <xsl:if test="(/DATA/PARAM/@m = 6591)">
               <xsl:element name="CENTER">
                  <xsl:element name="INPUT">
                     <xsl:attribute name="type">button</xsl:attribute>
                     <xsl:attribute name="value">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reports']"/>
                     </xsl:attribute>
                     <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[var win = window.open('Reports.asp?c=7');win.focus();]]></xsl:text></xsl:attribute>
                  </xsl:element>
               </xsl:element>
               </xsl:if>
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