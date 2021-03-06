<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
      <xsl:output omit-xml-declaration="yes"/>

      <xsl:template name="PageHeader600">
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">600</xsl:attribute>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">600</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">600</xsl:attribute>
                  <xsl:attribute name="align">center</xsl:attribute>
                  <xsl:attribute name="valign">top</xsl:attribute>
                  <xsl:element name="IMG">
                     <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/SYSTEM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                     <xsl:attribute name="border">0</xsl:attribute>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

         </xsl:element>

      </xsl:template>
   </xsl:stylesheet>