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
         <xsl:with-param name="pagename" select="'AuthUser'"/>
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
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Greeting']"/>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                  <xsl:value-of select="/DATA/TXN/PTSAUTHUSER/@authusername"/>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                  <xsl:if test="(/DATA/TXN/PTSAUTHUSER/@usergroup != 41)">
                     (<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=/DATA/TXN/PTSAUTHUSER/@usergroup]"/>)
                  </xsl:if>
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
                  <xsl:attribute name="class">BoldText</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogonIssued']"/>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                  <xsl:value-of select="/DATA/TXN/PTSAUTHUSER/@logon"/>
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
                  <xsl:attribute name="class">BoldText</xsl:attribute>
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PasswordIssued']"/>
                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                  <xsl:value-of select="/DATA/TXN/PTSAUTHUSER/@password"/>
               </xsl:element>
            </xsl:element>

            <xsl:if test="(/DATA/PARAM/@companyid &gt; 0)">
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
                     <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                  </xsl:element>
               </xsl:element>
            </xsl:if>

            <xsl:if test="(/DATA/PARAM/@companyid = 0)">
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
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Closing1']"/>
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
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Closing2']"/>
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
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Footer']"/>
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
                     <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@businessname"/>
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
                     <xsl:attribute name="class">BoldText</xsl:attribute>
                     <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@systememail"/>
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
                     <xsl:attribute name="class">BoldText</xsl:attribute>
                     <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@phone"/>
                  </xsl:element>
               </xsl:element>

            </xsl:if>
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