<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
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
         <xsl:with-param name="pagename" select="'Shopping Cart'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

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
            </xsl:otherwise>
         </xsl:choose>

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
            <xsl:attribute name="width">750</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">SalesOrder</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
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

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:call-template name="PageHeader"/>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function GoProductType(){ 
               var ptype = document.getElementById('ProductType').value;
               var company = document.getElementById('CompanyID').value;
               var member = document.getElementById('MemberID').value;
               var sponsor = document.getElementById('SponsorID').value;
               var public = document.getElementById('Public').value;
               var level = document.getElementById('Level').value;
               if ( ptype != 0 )
               document.location='5252.asp?producttypeid=' + ptype + '&companyid=' + company +  '&memberid=' + member + '&sponsorid=' + sponsor + '&public=' + public + '&level=' + level
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewPromo(id){ 
               var url, win;
               url = "0704.asp?promotionid=" + id
                  win = window.open(url,"Promo","top=100,left=100,height=300,width=650,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function CloseAutoShip(){ 
               var parent = window.opener;
               if( parent != null ) 
                  parent.doSubmit(0,"");
               window.close();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewImage(id){ 
               var url, win;
               url = "5006.asp?productid=" + id
                  win = window.open(url,"ProductImage","top=50,left=50,height=500,width=500,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">25</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">700</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">25</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">SponsorID</xsl:attribute>
                              <xsl:attribute name="id">SponsorID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@sponsorid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Dirty</xsl:attribute>
                              <xsl:attribute name="id">Dirty</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@dirty"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Public</xsl:attribute>
                              <xsl:attribute name="id">Public</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@public"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Level</xsl:attribute>
                              <xsl:attribute name="id">Level</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@level"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">RemovePromo</xsl:attribute>
                              <xsl:attribute name="id">RemovePromo</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@removepromo"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@noadd = 0) and (count(/DATA/TXN/PTSPRODUCTTYPES/ENUM) != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">gray</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">725</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                    <xsl:if test="(count(/DATA/TXN/PTSSALESITEMS/PTSSALESITEM) != 0)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">3</xsl:attribute>
                                          <xsl:attribute name="color">dimgray</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContinueShopping']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship != 2)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelectProductType']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship = 2)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelectAutoShipProductType']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                 </xsl:element>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">ProductType</xsl:attribute>
                                    <xsl:attribute name="id">ProductType</xsl:attribute>
                                    <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[GoProductType();]]></xsl:text></xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSPRODUCTTYPES/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="@name"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">gray</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@shoppingcartid = '') or (count(/DATA/TXN/PTSSALESITEMS/PTSSALESITEM) = 0)">
                           <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship != 2)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">725</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CloseShoppingCart']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship = 2)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">725</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CloseAutoShipment']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CloseAutoShip()]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@shoppingcartid != '') and (count(/DATA/TXN/PTSSALESITEMS/PTSSALESITEM) != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">25</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">500</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">500</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">PageHeading</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@memberid = 0)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShoppingCart']"/>
                                                <xsl:if test="(/DATA/PARAM/@sponsorid != 0)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">2</xsl:attribute>
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReferredBy']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/PARAM/@referredby" disable-output-escaping="yes"/>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@memberid != 0)">
                                                   <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship != 2)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShoppingCart']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship = 2)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AutoShip']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:if>
                                                <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/PARAM/@shoppingcartid" disable-output-escaping="yes"/>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                                <xsl:if test="(/DATA/PARAM/@credit != '')">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">2</xsl:attribute>
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Credit']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/PARAM/@credit" disable-output-escaping="yes"/>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship != 2)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CloseShoppingCart']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@edititems != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">25</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">700</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">prompt</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@invalid = 0)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShoppingCartText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@invalid != 0)">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShoppingCartInvalid']"/>
                                          </xsl:element>
                                       </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">25</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">10%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="width">4%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qty']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">62%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="width">10%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Price']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="width">10%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="width">4%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:for-each select="/DATA/TXN/PTSSALESITEMS/PTSSALESITEM">
                                       <xsl:element name="TR">
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:if test="(@image != '')">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewImage(<xsl:value-of select="@productid"/>)</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images\Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>\<xsl:value-of select="@image"/></xsl:attribute>
                                                         <xsl:attribute name="width">60</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:value-of select="@quantity"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:if test="(@locks = 1)">
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="@productname"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                             <xsl:if test="(@locks != 1)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">5303.asp?SalesItemID=<xsl:value-of select="@salesitemid"/>&amp;contentpage=3&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="@productname"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                <xsl:if test="(@invalid = 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">5303.asp?SalesItemID=<xsl:value-of select="@salesitemid"/>&amp;contentpage=3&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditProduct']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditProduct']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@invalid != 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">5303.asp?SalesItemID=<xsl:value-of select="@salesitemid"/>&amp;contentpage=3&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Edit1.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditProduct1']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditProduct1']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                                <xsl:element name="BR"/>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">blue</xsl:attribute>
                                                <xsl:value-of select="@inputvalues"/>
                                                </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:value-of select="@price"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:value-of select="@optionprice"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:if test="(@locks = 0)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">5303.asp?DeleteID=<xsl:value-of select="@salesitemid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Trash.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:if test="(@valid != 0)">
                                          <xsl:element name="TR">
                                             <xsl:if test="(position() mod 2)=1">
                                                <xsl:attribute name="class">GrayBar</xsl:attribute>
                                             </xsl:if>
                                             <xsl:if test="(position() mod 2)=0">
                                                <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                             </xsl:if>
                                             <xsl:element name="TD">
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">5</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:if test="(@valid = 1)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesItemValid1']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(@valid = 2)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesItemValid2']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(@valid = 3)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesItemValid3']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(@valid = 4)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesItemValid4']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(@valid = 12)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesItemValid12']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(@valid = 13)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesItemValid13']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(@valid = 14)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesItemValid14']"/>
                                                   </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                    </xsl:for-each>
                                    <xsl:choose>
                                       <xsl:when test="(count(/DATA/TXN/PTSSALESITEMS/PTSSALESITEM) = 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">6</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="class">NoItems</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:when>
                                    </xsl:choose>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">25</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">120</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">460</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">580</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60</xsl:attribute>
                                             <xsl:attribute name="height">18</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Amount']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@amount"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:if test="(/DATA/TXN/PTSSALESORDER/@discount != '$0.00') or (/DATA/TXN/PTSSALESORDER/@promotionid != 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">580</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:if test="(/DATA/TXN/PTSSALESORDER/@promotionid != 0)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@promotionname"/>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">ViewPromo(<xsl:value-of select="/DATA/TXN/PTSSALESORDER/@promotionid"/>)</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">document.getElementById('RemovePromo').value=1;doSubmit(4,'')</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Trash.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:if test="(/DATA/TXN/PTSSALESORDER/@discount != '$0.00')">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Discount']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:if test="(/DATA/TXN/PTSSALESORDER/@discount != '$0.00')">
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@discount"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                       <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship != 2)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">120</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/TXN/PTSSALESORDER/@promotionid = 0)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PromotionID']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">460</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/TXN/PTSSALESORDER/@promotionid = 0)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Code</xsl:attribute>
                                                   <xsl:attribute name="id">Code</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@code"/></xsl:attribute>
                                                   <xsl:attribute name="size">5</xsl:attribute>
                                                </xsl:element>
                                                </xsl:if>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/TXN/PTSSALESORDER/@promotionid = 0)">
                                                   <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">button</xsl:attribute>
                                                      <xsl:attribute name="class">smbutton</xsl:attribute>
                                                      <xsl:attribute name="value">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                                      </xsl:attribute>
                                                      <xsl:attribute name="onclick">doSubmit(4,"")</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="height">18</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tax']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@tax"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                       <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship = 2)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">580</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="height">18</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tax']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@tax"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                       <xsl:if test="(/DATA/PARAM/@shipping != 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">120</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ship']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">460</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                   <xsl:attribute name="name">Ship</xsl:attribute>
                                                   <xsl:attribute name="id">Ship</xsl:attribute>
                                                   <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('Dirty').value = 1]]></xsl:text></xsl:attribute>
                                                   <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSSALESORDER/@ship"/></xsl:variable>
                                                   <xsl:if test="(/DATA/PARAM/@shipoption = '') or (contains(/DATA/PARAM/@shipoption, '1'))">
                                                      <xsl:element name="OPTION">
                                                         <xsl:attribute name="value">1</xsl:attribute>
                                                         <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ship1']"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@shipoption = '') or (contains(/DATA/PARAM/@shipoption, '2'))">
                                                      <xsl:element name="OPTION">
                                                         <xsl:attribute name="value">2</xsl:attribute>
                                                         <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ship2']"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@shipoption = '') or (contains(/DATA/PARAM/@shipoption, '3'))">
                                                      <xsl:element name="OPTION">
                                                         <xsl:attribute name="value">3</xsl:attribute>
                                                         <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ship3']"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@shipoption = '') or (contains(/DATA/PARAM/@shipoption, '4'))">
                                                      <xsl:element name="OPTION">
                                                         <xsl:attribute name="value">4</xsl:attribute>
                                                         <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ship4']"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(contains(/DATA/PARAM/@shipoption, '5'))">
                                                      <xsl:element name="OPTION">
                                                         <xsl:attribute name="value">5</xsl:attribute>
                                                         <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ship5']"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="height">18</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Shipping']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@shipping"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">580</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@total"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="width">700</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Instructions']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship != 2)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="width">700</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="TEXTAREA">
                                                   <xsl:attribute name="name">Notes</xsl:attribute>
                                                   <xsl:attribute name="id">Notes</xsl:attribute>
                                                   <xsl:attribute name="rows">4</xsl:attribute>
                                                   <xsl:attribute name="cols">50</xsl:attribute>
                                                   <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>1000) {doMaxLenMsg(1000); value=value.substring(0,1000);}]]></xsl:text></xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@notes"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="height">6</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">580</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(4,"")</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                       <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship = 2)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="width">700</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="TEXTAREA">
                                                   <xsl:attribute name="name">Notes</xsl:attribute>
                                                   <xsl:attribute name="id">Notes</xsl:attribute>
                                                   <xsl:attribute name="rows">2</xsl:attribute>
                                                   <xsl:attribute name="cols">50</xsl:attribute>
                                                   <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>1000) {doMaxLenMsg(1000); value=value.substring(0,1000);}]]></xsl:text></xsl:attribute>
                                                   <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('Dirty').value = 1]]></xsl:text></xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSSALESORDER/@notes"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="height">6</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">580</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Save']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(4,"")</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">700</xsl:attribute>
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#8080FF</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/TXN/PTSSALESORDER/@valid = 0)">
                              <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship != 2)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="width">725</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">prompt</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckoutText']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Checkout']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
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
                              </xsl:if>

                              <xsl:if test="(/DATA/TXN/PTSSALESORDER/@autoship = 2)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="width">725</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CloseAutoShipment']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[
                           var dirty = document.getElementById('Dirty').value;
                           var good = 1;
                           if( dirty != 0 ) {
                              alert('Click the "Save" button to save your changes.');
                              good = 0;
                           }   
                           if( good == 1 ) {
                              CloseAutoShip();
                           }   
                        ]]></xsl:text></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                           </xsl:if>
                        </xsl:if>
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