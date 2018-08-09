<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Prospect</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">2295</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">20</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='#']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">200</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProspectName']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">100</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">100</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameLast']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">125</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesCampaignName']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">125</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProspectTypeName']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">100</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Category']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">100</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusName']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">50</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextEvent']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">50</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextDate']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">50</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextTime']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">50</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Priority']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">50</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Source']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">125</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">200</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">125</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">125</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone2']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">200</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Street']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">50</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Unit']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">100</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">100</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">50</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">100</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Country']"/>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>

                     <xsl:for-each select="/DATA/TXN/PTSPROSPECTS/PTSPROSPECT">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">20</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@prospectid"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@prospectname"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@namefirst"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@namelast"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">125</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@salescampaignname"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">125</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@prospecttypename"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@representing"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@statusname"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:variable name="tmp1"><xsl:value-of select="../PTSNEXTEVENTS/ENUM[@id=current()/@nextevent]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@nextdate"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@nexttime"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@priority"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@source"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">125</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@title"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@email"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">125</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@phone1"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">125</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@phone2"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@street"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@unit"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@city"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@state"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@zip"/>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="@country"/>
                              </xsl:element>
                           </xsl:element>

                     </xsl:for-each>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">23</xsl:attribute>
                           <xsl:attribute name="height">12</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">20</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                           <xsl:text>:</xsl:text>
                           <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">200</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/PARAM/@count" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">23</xsl:attribute>
                           <xsl:attribute name="height">12</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
            </xsl:element>
            <!--END FORM-->

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <![CDATA[function doSubmit(iAction, sMsg){document.Prospect.elements['ActionCode'].value=iAction;document.Prospect.submit();}]]>
         <![CDATA[function doErrorMsg(sError){alert(sError);}]]>
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