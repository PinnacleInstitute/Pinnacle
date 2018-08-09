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
                  <xsl:attribute name="width">650</xsl:attribute>
                  <xsl:attribute name="align">left</xsl:attribute>
                  <xsl:attribute name="valign">center</xsl:attribute>
                  <xsl:attribute name="class">PageHeading</xsl:attribute>
                  <xsl:if test="(/DATA/PARAM/@notify = 1)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ClassComplete']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSSESSION/@coursename"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@notify = 2)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessComplete']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmentname"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@notify = 3)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CertifyComplete']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmentname"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@notify = 4)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalComplete']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSGOAL/@goalname"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@notify = 5)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProjectComplete']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSPROJECT/@projectname"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@notify = 6)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SaleComplete']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectname"/>
                  </xsl:if>
                  <xsl:if test="(/DATA/PARAM/@notify = 7)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SignedIn']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                  </xsl:if>
                     <xsl:element name="BR"/>
                  <xsl:if test="(/DATA/PARAM/@notify != 7)">
                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompletedBy']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                        <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                        <xsl:element name="BR"/>
                  </xsl:if>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Date']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/SYSTEM/@currdate"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/SYSTEM/@currtime"/>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                     CST
                     <xsl:element name="BR"/>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/>
                     <xsl:element name="BR"/>
                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                     <xsl:text>:</xsl:text>
                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                     <xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/>
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