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
         <xsl:with-param name="pagename" select="'SalesOrder'"/>
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
            <xsl:attribute name="width">650</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">12</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:attribute name="class">PageHeading</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DownloadText']"/>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">12</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="div">
                     <xsl:attribute name="id">true</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:element name="b">
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                     <xsl:element name="BR"/>
                  <xsl:for-each select="/DATA/TXN/PTSADDRESSS/PTSADDRESS">
                           <xsl:value-of select="@street1"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="@street2"/>
                           <xsl:element name="BR"/>
                           <xsl:value-of select="@city"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           ,
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="@state"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="@zip"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:value-of select="@countryname"/>
                  </xsl:for-each>
                  </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">24</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:attribute name="class">PageHeading</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DownloadFiles']"/>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">6</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:for-each select="/DATA/TXN/PTSDOWNLOADS/PTSDOWNLOAD">
                  <xsl:element name="TR">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">650</xsl:attribute>
                        <xsl:attribute name="align">left</xsl:attribute>
                        <xsl:attribute name="valign">center</xsl:attribute>
                        <xsl:element name="A">
                           <xsl:attribute name="href"><xsl:value-of select="@name"/></xsl:attribute>
                        <xsl:value-of select="@name"/>
                        </xsl:element>
                     </xsl:element>
                  </xsl:element>

            </xsl:for-each>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">24</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:attribute name="class">PageHeading</xsl:attribute>
                  <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@companyname"/>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="div">
                     <xsl:attribute name="id">true</xsl:attribute>
                     <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:element name="b">
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@email"/>
                     <xsl:element name="BR"/>
                     <xsl:if test="(/DATA/TXN/PTSCOMPANY/@phone1 != '')">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@phone1"/>
                        <xsl:element name="BR"/>
                     </xsl:if>
                     <xsl:if test="(/DATA/TXN/PTSCOMPANY/@fax != '')">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fax']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@fax"/>
                        <xsl:element name="BR"/>
                     </xsl:if>
                  </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

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