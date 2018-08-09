<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
      <xsl:output omit-xml-declaration="yes"/>

      <xsl:template name="PageFooter">
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">750</xsl:attribute>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">750</xsl:attribute>
                  <xsl:attribute name="height">1</xsl:attribute>
                  <xsl:attribute name="bgcolor">#000000</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:if test="(/DATA/SYSTEM/@companyid = 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">750</xsl:attribute>
                     <xsl:attribute name="height">36</xsl:attribute>
                     <xsl:attribute name="align">center</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:attribute name="class">Copyright</xsl:attribute>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copyright']"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:element name="IMG">
                        <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                        <xsl:attribute name="border">0</xsl:attribute>
                     </xsl:element>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RequiredField']"/>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:if test="(/DATA/SYSTEM/@companyid = 6) or (/DATA/SYSTEM/@companyid = 7)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">750</xsl:attribute>
                     <xsl:attribute name="align">center</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:element name="b">
                     <xsl:element name="i">
                        <xsl:element name="A">
                           <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                           <xsl:attribute name="href">http://www.pinnaclep.com/Sections/PrivacyStatement.pdf</xsl:attribute>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrivacyStatement']"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                        </xsl:element>
                        <xsl:element name="A">
                           <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                           <xsl:attribute name="href">http://www.pinnaclep.com/Sections/TermsOfUse.pdf</xsl:attribute>
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TermsOfUse']"/>
                        </xsl:element>
                     </xsl:element>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

         </xsl:element>

      </xsl:template>
   </xsl:stylesheet>