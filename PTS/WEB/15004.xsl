<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="HTML">

      <xsl:variable name="usergroup" select="/DATA/SYSTEM/@usergroup"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='MerchantStoreSetup']"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor">editor</xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/jscolor.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">10</xsl:attribute>
         <xsl:choose>
            <xsl:when test="(/DATA/ERROR)">
               <xsl:variable name="errnum" select="/DATA/ERROR/@number"/>
               <xsl:variable name="errmsg" select="/DATA/LANGUAGE/LABEL[@name=$errnum]"/>
               <xsl:choose>
                  <xsl:when test="string-length($errmsg)&gt;0">
                     <xsl:variable name="msgval" select="/DATA/ERROR/@msgval"/>
                     <xsl:variable name="msgfld" select="/DATA/ERROR/@msgfld"/>
                     <xsl:variable name="errfld" select="/DATA/LANGUAGE[*]/LABEL[@name=$msgfld]"/>
                     <xsl:variable name="errmsgfld">
                        <xsl:choose>
                           <xsl:when test="string-length($errfld)&gt;0"><xsl:value-of select="$errfld"/></xsl:when>
                           <xsl:otherwise><xsl:value-of select="$msgfld"/></xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="string-length($msgval)&gt;0"><xsl:value-of select="concat(' (', $msgval, ')')"/></xsl:if>
                     </xsl:variable>
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onload">document.getElementById('Description').focus()</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper1000</xsl:attribute>
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">750</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Merchant</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">Bookmark</xsl:attribute>
                  <xsl:attribute name="id">Bookmark</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@nextbookmark"/></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">740</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ImageManager(){ 
               var url, win;
               url = "15021.asp?merchantid=" + document.getElementById('MerchantID').value
            win = window.open(url,"ImageManager");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function Preview(){ 
               var url, win;
               url = "15050.asp?preview=1&merchantid=" + document.getElementById('MerchantID').value
            win = window.open(url,"StorePreview");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">1000</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">1000</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MerchantID</xsl:attribute>
                              <xsl:attribute name="id">MerchantID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@merchantid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">650</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeader</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Merchant48.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">650</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MerchantStoreSetup']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@merchantname"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/PARAM/@txn = 1)">
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">red</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Updated']"/>
                                             </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeader</xsl:attribute>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[Preview()]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">4</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DescriptionText']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">Description</xsl:attribute>
                                 <xsl:attribute name="id">Description</xsl:attribute>
                                 <xsl:attribute name="rows">10</xsl:attribute>
                                 <xsl:attribute name="cols">100</xsl:attribute>
                                 <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>2000) {doMaxLenMsg(2000); value=value.substring(0,2000);}]]></xsl:text></xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                              <xsl:element name="SCRIPT">
                                 <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                 <![CDATA[   CKEDITOR.replace('Description', { wordcount:{showParagraphs:false,showCharCount:true,countSpacesAsChars:true,countHTML:true,maxCharCount:2000}, height:200 } );  ]]>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Image']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Image</xsl:attribute>
                              <xsl:attribute name="id">Image</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="maxlength">40</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMERCHANT/@image"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Upload']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImageText']"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">B</xsl:attribute>
                              <xsl:attribute name="id">B</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@b = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RightImage']"/>
                              </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email2']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Email2</xsl:attribute>
                              <xsl:attribute name="id">Email2</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="maxlength">80</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMERCHANT/@email2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">D</xsl:attribute>
                              <xsl:attribute name="id">D</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@d = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowEmail']"/>
                              </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone2']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Phone2</xsl:attribute>
                              <xsl:attribute name="id">Phone2</xsl:attribute>
                              <xsl:attribute name="size">30</xsl:attribute>
                              <xsl:attribute name="maxlength">30</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMERCHANT/@phone2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">E</xsl:attribute>
                              <xsl:attribute name="id">E</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@e = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowPhone']"/>
                              </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">F</xsl:attribute>
                              <xsl:attribute name="id">F</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@f = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowContact']"/>
                              </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="font">
                                 <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@namelast"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">C</xsl:attribute>
                              <xsl:attribute name="id">C</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@c = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowAddress']"/>
                              </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="font">
                                 <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@street1"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@street2"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@city"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@state"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@zip"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMERCHANT/@countryname"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">H</xsl:attribute>
                              <xsl:attribute name="id">H</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@h = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowMap']"/>
                              </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">18</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StoreTextColor']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="class">color</xsl:attribute>
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">TextColor</xsl:attribute>
                              <xsl:attribute name="id">TextColor</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@textcolor"/></xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StoreBackColor']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="class">color</xsl:attribute>
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">BackColor</xsl:attribute>
                              <xsl:attribute name="id">BackColor</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@backcolor"/></xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StoreBackImage']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">BackImage</xsl:attribute>
                                 <xsl:attribute name="id">BackImage</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@backimage"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value"></xsl:attribute>
                                    <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                    
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">circles.png</xsl:attribute>
                                    <xsl:if test="$tmp='circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    Circles.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">crossed_stripes.png</xsl:attribute>
                                    <xsl:if test="$tmp='crossed_stripes.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    crossed_stripes.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">crosses.png</xsl:attribute>
                                    <xsl:if test="$tmp='crosses.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    crosses.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">dark_circles.png</xsl:attribute>
                                    <xsl:if test="$tmp='dark_circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    dark_circles.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">dark_matter.png</xsl:attribute>
                                    <xsl:if test="$tmp='dark_matter.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    dark_matter.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">diamonds.png</xsl:attribute>
                                    <xsl:if test="$tmp='diamonds.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    diamonds.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">foil.png</xsl:attribute>
                                    <xsl:if test="$tmp='foil.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    foil.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">gun_metal.png</xsl:attribute>
                                    <xsl:if test="$tmp='gun_metal.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    gun_metal.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">knitted-netting.png</xsl:attribute>
                                    <xsl:if test="$tmp='knitted-netting.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    knitted_netting.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">littleknobs.png</xsl:attribute>
                                    <xsl:if test="$tmp='littleknobs.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    littleknobs.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">merely_cubed.png</xsl:attribute>
                                    <xsl:if test="$tmp='merely_cubed.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    merely_cubed.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">micro_carbon.png</xsl:attribute>
                                    <xsl:if test="$tmp='micro_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    micro_carbon.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">small-crackle.png</xsl:attribute>
                                    <xsl:if test="$tmp='small-crackle.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    small_crackle.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">soft_pad.png</xsl:attribute>
                                    <xsl:if test="$tmp='soft_pad.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    soft_pad.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">white_carbon.png</xsl:attribute>
                                    <xsl:if test="$tmp='white_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    white_carbon.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">zigzag.png</xsl:attribute>
                                    <xsl:if test="$tmp='zigzag.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    zigzag.png
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">G</xsl:attribute>
                              <xsl:attribute name="id">G</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@g = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoStoreBack']"/>
                              </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">A</xsl:attribute>
                              <xsl:attribute name="id">A</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@a = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Store3DBox']"/>
                              </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StorePageColor']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="class">color</xsl:attribute>
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">PageColor</xsl:attribute>
                              <xsl:attribute name="id">PageColor</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@pagecolor"/></xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StorePageImage']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">PageImage</xsl:attribute>
                                 <xsl:attribute name="id">PageImage</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@pageimage"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value"></xsl:attribute>
                                    <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                    
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">circles.png</xsl:attribute>
                                    <xsl:if test="$tmp='circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    Circles.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">crossed_stripes.png</xsl:attribute>
                                    <xsl:if test="$tmp='crossed_stripes.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    crossed_stripes.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">crosses.png</xsl:attribute>
                                    <xsl:if test="$tmp='crosses.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    crosses.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">dark_circles.png</xsl:attribute>
                                    <xsl:if test="$tmp='dark_circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    dark_circles.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">dark_matter.png</xsl:attribute>
                                    <xsl:if test="$tmp='dark_matter.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    dark_matter.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">diamonds.png</xsl:attribute>
                                    <xsl:if test="$tmp='diamonds.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    diamonds.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">foil.png</xsl:attribute>
                                    <xsl:if test="$tmp='foil.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    foil.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">gun_metal.png</xsl:attribute>
                                    <xsl:if test="$tmp='gun_metal.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    gun_metal.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">knitted-netting.png</xsl:attribute>
                                    <xsl:if test="$tmp='knitted-netting.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    knitted_netting.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">littleknobs.png</xsl:attribute>
                                    <xsl:if test="$tmp='littleknobs.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    littleknobs.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">merely_cubed.png</xsl:attribute>
                                    <xsl:if test="$tmp='merely_cubed.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    merely_cubed.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">micro_carbon.png</xsl:attribute>
                                    <xsl:if test="$tmp='micro_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    micro_carbon.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">small-crackle.png</xsl:attribute>
                                    <xsl:if test="$tmp='small-crackle.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    small_crackle.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">soft_pad.png</xsl:attribute>
                                    <xsl:if test="$tmp='soft_pad.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    soft_pad.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">white_carbon.png</xsl:attribute>
                                    <xsl:if test="$tmp='white_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    white_carbon.png
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">zigzag.png</xsl:attribute>
                                    <xsl:if test="$tmp='zigzag.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    zigzag.png
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">4</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Details']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DetailsText']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">Data</xsl:attribute>
                                 <xsl:attribute name="id">Data</xsl:attribute>
                                 <xsl:attribute name="rows">80</xsl:attribute>
                                 <xsl:attribute name="cols">100</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                              <xsl:element name="SCRIPT">
                                 <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                 <![CDATA[   CKEDITOR.replace('Data', { toolbar:'editor2', wordcount:{showCharCount:true}, templates_files:['CKEditor/templates_store.js'], height:1600 } );  ]]>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StoreImageManager']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ImageManager()]]></xsl:text></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                     </xsl:element>

                  </xsl:element>
                  <!--END CONTENT COLUMN-->

               </xsl:element>

            </xsl:element>
            <!--END FORM-->

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

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>