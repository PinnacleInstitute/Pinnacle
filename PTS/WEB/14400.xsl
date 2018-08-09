<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Broadcast</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">600</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">600</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">600</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="A">
                              <xsl:attribute name="onclick">w=window.open(this.href,"Right180","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                              <xsl:attribute name="href">http://www.right180.com</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">http://www.right180.com/images/company/12/breakingnews.gif</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">600</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="A">
                              <xsl:attribute name="onclick">w=window.open(this.href,"Right180","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                              <xsl:attribute name="href">http://www.right180.com</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:element name="font">
                              <xsl:attribute name="size">4</xsl:attribute>
                              <xsl:attribute name="color">darkblue</xsl:attribute>
                           Right180.com
                           </xsl:element>
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
                           <xsl:attribute name="width">600</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">top</xsl:attribute>
                           <xsl:element name="TABLE">
                              <xsl:attribute name="border">0</xsl:attribute>
                              <xsl:attribute name="cellpadding">0</xsl:attribute>
                              <xsl:attribute name="cellspacing">0</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="style">border: 1px #000000 solid; padding:5px</xsl:attribute>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">600</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:for-each select="/DATA/TXN/PTSBROADCASTS/PTSBROADCAST">
                                       <xsl:if test="(position() != 1)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">600</xsl:attribute>
                                                <xsl:attribute name="height">1</xsl:attribute>
                                                <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                       <xsl:if test="(@title != '')">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">600</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Story","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">http://www.right180.com/13210.asp?s=<xsl:value-of select="@broadcastid"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">http://www.right180.com/images\News\12\thumb\<xsl:value-of select="@image"/></xsl:attribute>
                                                         <xsl:attribute name="width">75</xsl:attribute>
                                                         <xsl:attribute name="height">75</xsl:attribute>
                                                         <xsl:attribute name="hspace">10</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Story","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">http://www.right180.com/13210.asp?s=<xsl:value-of select="@broadcastid"/></xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="@title"/>
                                                   </xsl:element>
                                                   <xsl:element name="BR"/>
                                                   </xsl:element>
                                                   <xsl:value-of select="SUMMARY/comment()" disable-output-escaping="yes"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Story","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">http://www.right180.com/13210.asp?s=<xsl:value-of select="@broadcastid"/></xsl:attribute>
                                                   <xsl:element name="b">
                                                   Read More...
                                                   </xsl:element>
                                                   </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                       <xsl:if test="(@title = '')">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">600</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="SUMMARY/comment()" disable-output-escaping="yes"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                 </xsl:for-each>
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
                           <xsl:attribute name="width">600</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="i">
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LegalText']"/>
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
                           <xsl:element name="A">
                              <xsl:attribute name="onclick">w=window.open(this.href,"Unsubscribe","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                              <xsl:attribute name="href">14107.asp?f=<xsl:value-of select="/DATA/PARAM/@friend"/></xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Unsubscribe']"/>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">6</xsl:attribute>
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
         <![CDATA[function doSubmit(iAction, sMsg){document.Broadcast.elements['ActionCode'].value=iAction;document.Broadcast.submit();}]]>
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