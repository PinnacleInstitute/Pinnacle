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
         <xsl:attribute name="href">include/StyleSheet5.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'Customer Portal'"/>
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
               <xsl:attribute name="name">Machine</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function CustomerBilling(){ 
               var url, win, member;
               member = document.getElementById('MemberID').value
               url = "Trialp.asp?memberid=" + member
                  win = window.open(url,"CustomerBilling","");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function GetWebName(WName){ 
               var url1, win, webnm;
               webnm = WName;
               url1 = "http://" + webnm + ".cloudzow.net"
               win = window.open(url1,"","");
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
                              <xsl:attribute name="width">75</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">675</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BillingID</xsl:attribute>
                              <xsl:attribute name="id">BillingID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@billingid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">75</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Machine48.gif</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">675</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:attribute name="color">#000070</xsl:attribute>
                                 <xsl:element name="b">
                                    <xsl:if test="(/DATA/PARAM/@customer = 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Affiliate']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@customer != 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Customer']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/>
                                 </xsl:element>
                              <xsl:if test="(/DATA/PARAM/@isedit != 0) and (/DATA/PARAM/@billingid != 0)">
                                    <xsl:element name="BR"/>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">2</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillTo']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/PARAM/@billingid != 0)">
                                       <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 1)">
                                             <xsl:variable name="tmp2"><xsl:value-of select="/DATA/TXN/PTSBILLING/PTSCARDTYPES/ENUM[@id=/DATA/TXN/PTSBILLING/@cardtype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="concat(/DATA/TXN/PTSBILLING/@cardmo,'/',/DATA/TXN/PTSBILLING/@cardyr)"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 2)">
                                             <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkbank"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkname"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkroute"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccount"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       </xsl:if>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="class">smbutton</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                          </xsl:element>
                                    </xsl:if>
                                    </xsl:element>
                              </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@machineid = 0) and (/DATA/PARAM/@billingid = 0)">
                           <xsl:if test="(/DATA/PARAM/@customer != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                       <xsl:attribute name="color">#000070</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@trialdays = 0)">
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrialExpired1']"/>
                                          </xsl:element>
                                          <xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrialExpired2']"/>
                                    </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@trialdays != 0)">
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/PARAM/@trialdays" disable-output-escaping="yes"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrialRemaining']"/>
                                          </xsl:element>
                                       </xsl:if>
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
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@isedit != 0)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomerAddBilling']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CustomerBilling();]]></xsl:text></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@customer = 0) and (/DATA/PARAM/@isedit != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddBilling']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(9,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@machineid != 0)">
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
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">18</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UserName']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMACHINE/@namefirst"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSMACHINE/@namelast"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">18</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMACHINE/@email"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">18</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OnlineData']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">400</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">GetWebName('<xsl:value-of select="@webname"/>')</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSMACHINE/@webname"/>
                                             </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@machineid = 0) and (count(/DATA/TXN/PTSMACHINES/PTSMACHINE) &gt; 0)">
                           <xsl:if test="(/DATA/PARAM/@isedit != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">75</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">675</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">prompt</xsl:attribute>
                                       <xsl:if test="(count(/DATA/TXN/PTSMACHINES/PTSMACHINE) = 0)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewMachineListText']"/>
                                       </xsl:if>
                                       <xsl:if test="(count(/DATA/TXN/PTSMACHINES/PTSMACHINE) &gt; 0)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MachineListText']"/>
                                       </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">25%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UserName']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">30%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">25%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OnlineData']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Service']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="width">3%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:for-each select="/DATA/TXN/PTSMACHINES/PTSMACHINE">
                                       <xsl:if test="(@status = 1)">
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
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/MachineStatus<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="@namefirst"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@namelast"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                <xsl:if test="(/DATA/PARAM/@isedit != 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">10703.asp?MachineID=<xsl:value-of select="@machineid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/edit.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditComputer']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditComputer']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">green</xsl:attribute>
                                                <xsl:value-of select="@email"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">GetWebName('<xsl:value-of select="@webname"/>')</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">green</xsl:attribute>
                                                <xsl:value-of select="@webname"/>
                                                </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">green</xsl:attribute>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">purple</xsl:attribute>
                                                   <xsl:value-of select="@qty"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:variable name="tmp2"><xsl:value-of select="../PTSSERVICES/ENUM[@id=current()/@service]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@backupused"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 2)">
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
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/MachineStatus<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@namefirst"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@namelast"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:if test="(/DATA/PARAM/@isedit != 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">10703.asp?MachineID=<xsl:value-of select="@machineid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/edit.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditComputer']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditComputer']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="@email"/>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">GetWebName('<xsl:value-of select="@webname"/>')</xsl:attribute>
                                                <xsl:value-of select="@webname"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">purple</xsl:attribute>
                                                   <xsl:value-of select="@qty"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:variable name="tmp2"><xsl:value-of select="../PTSSERVICES/ENUM[@id=current()/@service]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@backupused"/>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@customer = 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">https://www.cloudzow.com/10712.asp?MachineID=<xsl:value-of select="@machineid"/>&amp;E=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/NewCustomer16.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConvertCustomer']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConvertCustomer']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status &gt; 2)">
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
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/MachineStatus<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="@namefirst"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@namelast"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                <xsl:if test="(/DATA/PARAM/@isedit != 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">10703.asp?MachineID=<xsl:value-of select="@machineid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/edit.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditComputer']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditComputer']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                <xsl:value-of select="@email"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">GetWebName('<xsl:value-of select="@webname"/>')</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                <xsl:value-of select="@webname"/>
                                                </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">purple</xsl:attribute>
                                                   <xsl:value-of select="@qty"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:variable name="tmp2"><xsl:value-of select="../PTSSERVICES/ENUM[@id=current()/@service]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@backupused"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 0)">
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
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/MachineStatus0.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UnusedComputer']"/>
                                                   <xsl:value-of select="position()"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@isedit != 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">10702.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/addnew.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfigureNewComputer']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfigureNewComputer']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status &gt; 1)">
                                          <xsl:element name="TR">
                                             <xsl:attribute name="height">18</xsl:attribute>
                                             <xsl:if test="(position() mod 2)=1">
                                                <xsl:attribute name="class">GrayBar</xsl:attribute>
                                             </xsl:if>
                                             <xsl:if test="(position() mod 2)=0">
                                                <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                             </xsl:if>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">5</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">gray</xsl:attribute>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:if test="(@status = 2)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActiveDate']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@activedate"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:if>
                                                   <xsl:if test="(@status = 3)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CancelDate']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@canceldate"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:if>
                                                   <xsl:if test="(@status = 4)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RemoveDate']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@removedate"/>
                                                   </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                    </xsl:for-each>
                                    <xsl:choose>
                                       <xsl:when test="(count(/DATA/TXN/PTSMACHINES/PTSMACHINE) = 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">5</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="class">NoItems</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:when>
                                    </xsl:choose>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">170</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">487</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">75</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">18</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
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
                                             <xsl:attribute name="width">170</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActiveMachines']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/PARAM/@count" disable-output-escaping="yes"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">487</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@customer != 0) or (/DATA/PARAM/@prepaidmachines &lt;= /DATA/PARAM/@count)">
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">75</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@customer != 0) or (/DATA/PARAM/@prepaidmachines &lt;= /DATA/PARAM/@count)">
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/PARAM/@total" disable-output-escaping="yes"/>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:if test="(/DATA/TXN/PTSMEMBER/@level = 0) and (/DATA/TXN/PTSMEMBER/@price != /DATA/PARAM/@total)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="height">6</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">170</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">487</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomerTotal']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">75</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@price"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                       <xsl:if test="(/DATA/PARAM/@prepaidmachines &gt; /DATA/PARAM/@count)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="height">6</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">170</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrePaidMachines']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/PARAM/@prepaidmachines" disable-output-escaping="yes"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">487</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GrandTotal']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">75</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/PARAM/@grandtotal" disable-output-escaping="yes"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@isedit != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewMachine']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@customer = 0) and (/DATA/PARAM/@count &lt; 8)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ChangeMachine']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(10,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@ismoney != 0) or (/DATA/PARAM/@isuniversity != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@ismoney != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Money","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">Money.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/ZowMoney.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@isuniversity != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"University","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">University.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/ZowUniversity.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ZowMoney']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ZowUniversity']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
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
                              <xsl:attribute name="height">6</xsl:attribute>
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