<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
      <xsl:output omit-xml-declaration="yes"/>

      <xsl:template name="ReportFooter">
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">650</xsl:attribute>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:if test="(/DATA/SYSTEM/@companyid = 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">1</xsl:attribute>
                     <xsl:attribute name="height">6</xsl:attribute>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">650</xsl:attribute>
                     <xsl:attribute name="height">1</xsl:attribute>
                     <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">1</xsl:attribute>
                     <xsl:attribute name="height">2</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">650</xsl:attribute>
                     <xsl:attribute name="align">center</xsl:attribute>
                     <xsl:attribute name="valign">center</xsl:attribute>
                     <xsl:attribute name="class">Copyright</xsl:attribute>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copyright']"/>
                  </xsl:element>
               </xsl:element>

            </xsl:if>
         </xsl:element>

      </xsl:template>
   </xsl:stylesheet>