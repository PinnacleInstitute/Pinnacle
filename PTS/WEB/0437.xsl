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
         <xsl:with-param name="pagename" select="'Member'"/>
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
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Hi']"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/PARAM/@sponsorname" disable-output-escaping="yes"/>
                     ,
                     <xsl:element name="BR"/><xsl:element name="BR"/>
                  <xsl:if test="(/DATA/PARAM/@customer != 0)">
                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@status = 1)">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewCustomer']"/>
                        </xsl:if>
                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@status = 2)">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewTrial']"/>
                        </xsl:if>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@customer = 0) and (/DATA/PARAM/@msg = 0)">
                        <xsl:if test="(/DATA/PARAM/@type = 0)">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewEnrolledMember']"/>
                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@type = 1) or (/DATA/PARAM/@type = 2)">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewSponsoredMember']"/>
                        </xsl:if>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@msg = 1)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpgradeMember']"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@msg = 12)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpgradeLevel12']"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@msg = 13)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpgradeLevel13']"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@msg = 14)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpgradeLevel14']"/>
                  </xsl:if>
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
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/PARAM/@newmembername" disable-output-escaping="yes"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:element name="b">
                  <xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone2"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>

            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:attribute name="height">18</xsl:attribute>
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