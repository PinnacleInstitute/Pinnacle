<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
      <xsl:output omit-xml-declaration="yes"/>

      <xsl:template name="PageHeaderPublic">
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">750</xsl:attribute>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">750</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:variable name="tmpHeader">Header[<xsl:value-of select="/DATA/SYSTEM/@language"/>].png</xsl:variable>

            <xsl:if test="(/DATA/SYSTEM/@companyid = 0)">
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">750</xsl:attribute>
                     <xsl:attribute name="align">center</xsl:attribute>
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:element name="IMG">
                        <xsl:attribute name="src">Images/<xsl:value-of select="$tmpHeader"/></xsl:attribute>
                        <xsl:attribute name="border">0</xsl:attribute>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>

            </xsl:if>
            <xsl:if test="(/DATA/SYSTEM/@companyid &gt; 0)">
               <xsl:if test="(/DATA/SYSTEM/@headerimage = '')">
                  <xsl:element name="TR">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">750</xsl:attribute>
                        <xsl:attribute name="align">center</xsl:attribute>
                        <xsl:attribute name="valign">top</xsl:attribute>
                        <xsl:element name="IMG">
                           <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/SYSTEM/@companyid"/>/<xsl:value-of select="$tmpHeader"/></xsl:attribute>
                           <xsl:attribute name="border">0</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                  </xsl:element>
               </xsl:if>

               <xsl:if test="(/DATA/SYSTEM/@headerimage != '')">
                  <xsl:if test="(/DATA/SYSTEM/@companyid = 0)">
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">top</xsl:attribute>
                           <xsl:element name="IMG">
                              <xsl:attribute name="src">Images/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                              <xsl:attribute name="border">0</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                  </xsl:if>

                  <xsl:if test="(/DATA/SYSTEM/@companyid &gt; 0)">
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">top</xsl:attribute>
                           <xsl:element name="IMG">
                              <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/SYSTEM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                              <xsl:attribute name="border">0</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                  </xsl:if>

               </xsl:if>
            </xsl:if>
         </xsl:element>

      </xsl:template>
   </xsl:stylesheet>