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
         <xsl:with-param name="pagename" select="'Machine'"/>
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
            <xsl:attribute name="width">600</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">600</xsl:attribute>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">6</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">600</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Welcome']"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">6</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">3</xsl:attribute>
                  <xsl:attribute name="width">600</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">6</xsl:attribute>
               </xsl:element>
            </xsl:element>
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">2</xsl:attribute>
                  <xsl:attribute name="width">600</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="TABLE">
                     <xsl:attribute name="border">0</xsl:attribute>
                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                     <xsl:attribute name="width">600</xsl:attribute>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="width">30%</xsl:attribute>
                           <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                           <xsl:attribute name="valign">Bottom</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UserName']"/>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="width">35%</xsl:attribute>
                           <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                           <xsl:attribute name="valign">Bottom</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="width">35%</xsl:attribute>
                           <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                           <xsl:attribute name="valign">Bottom</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Password']"/>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">3</xsl:attribute>
                           <xsl:attribute name="height">2</xsl:attribute>
                           <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

                     <xsl:for-each select="/DATA/TXN/PTSMACHINES/PTSMACHINE">
                        <xsl:element name="TR">
                           <xsl:attribute name="height">18</xsl:attribute>
                           <xsl:if test="(position() mod 2)=1">
                              <xsl:attribute name="class">GrayBar</xsl:attribute>
                           </xsl:if>
                           <xsl:if test="(position() mod 2)=0">
                              <xsl:attribute name="class">WhiteBar</xsl:attribute>
                           </xsl:if>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="@namelast"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="@email"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="@password"/>
                           </xsl:element>
                        </xsl:element>
                     </xsl:for-each>
                     <xsl:choose>
                        <xsl:when test="(count(/DATA/TXN/PTSMACHINES/PTSMACHINE) = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="class">NoItems</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:when>
                     </xsl:choose>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">3</xsl:attribute>
                           <xsl:attribute name="height">2</xsl:attribute>
                           <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

                  </xsl:element>
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
                  <xsl:attribute name="width">600</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:attribute name="class">PageHeading</xsl:attribute>
                     <xsl:value-of select="/DATA/TXN/PTSCOMPANY/@companyname"/>
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