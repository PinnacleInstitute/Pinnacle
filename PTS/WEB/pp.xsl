<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:value-of select="/DATA/TXN/TOP/comment()" disable-output-escaping="yes"/>

               <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">PageID</xsl:attribute>
                  <xsl:attribute name="id">PageID</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@pageid"/></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">AddPageID</xsl:attribute>
                  <xsl:attribute name="id">AddPageID</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@addpageid"/></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">r</xsl:attribute>
                  <xsl:attribute name="id">r</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@r"/></xsl:attribute>
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