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
         <xsl:with-param name="pagename" select="'Debt Manager'"/>
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
               <xsl:attribute name="name">Debt</xsl:attribute>
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

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function AnalyzeDebt(id){ 
               var url, win;
               url = "10210.asp?memberid=" + id
                  win = window.open(url,"AnalyzeDebt");
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
                              <xsl:attribute name="width">750</xsl:attribute>
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
                              <xsl:attribute name="width">750</xsl:attribute>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@expired &gt;= 0) and (count(/DATA/TXN/PTSDEBTS/PTSDEBT) = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewDebt']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(count(/DATA/TXN/PTSDEBTS/PTSDEBT) != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Process']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/TXN/PTSFINANCE/@payoff = 1)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payoff1']"/>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSFINANCE/@payoff = 2)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payoff2']"/>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSFINANCE/@payoff = 3)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payoff3']"/>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSFINANCE/@payoff = 4)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payoff4']"/>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSFINANCE/@payoff = 5)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payoff5']"/>
                                    </xsl:if>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='First']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@extrapayment != '$0.00')">
                                       |
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/PARAM/@extrapayment" disable-output-escaping="yes"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExtraPayment']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSFINANCE/@isminpayment != 0)">
                                       |
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Min$']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSFINANCE/@savings != 0)">
                                       |
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/TXN/PTSFINANCE/@savings"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='%']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Savings']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='@']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/TXN/PTSFINANCE/@savingsrate"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='%']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 </xsl:if>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AdvancedOptions']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                 </xsl:element>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
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

                           <xsl:element name="TR">
                              <xsl:element name="TD">
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
                                             <xsl:attribute name="width">25</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">700</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">25</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
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
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/debticon.jpg</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">3</xsl:attribute>
                                                   <xsl:attribute name="color">#000070</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourDebts']"/>
                                                </xsl:element>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewDebt']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">#004080</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditDebts']"/>
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">25</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">700</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                                             <xsl:attribute name="colspan">3</xsl:attribute>
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
                                                               <xsl:attribute name="width">16%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DebtType']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="width">25%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DebtName']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="width">12%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Balance']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="width">10%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payment']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="width">10%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Minimum']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="width">10%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Margin']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="width">8%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rate']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="width">6%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsActive']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="align">right</xsl:attribute>
                                                               <xsl:attribute name="width">5%</xsl:attribute>
                                                               <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                               <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">9</xsl:attribute>
                                                               <xsl:attribute name="height">2</xsl:attribute>
                                                               <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:for-each select="/DATA/TXN/PTSDEBTS/PTSDEBT">
                                                            <xsl:if test="(@isactive != 0)">
                                                               <xsl:element name="TR">
                                                                  <xsl:attribute name="height">24</xsl:attribute>
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
                                                                           <xsl:attribute name="src">Images/debttype<xsl:value-of select="@debttype"/>.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:variable name="tmp3"><xsl:value-of select="../PTSDEBTTYPES/ENUM[@id=current()/@debttype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:value-of select="@debtname"/>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="href">10203.asp?DebtID=<xsl:value-of select="@debtid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditDebt']"/></xsl:attribute>
                                                                              <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditDebt']"/></xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:value-of select="@balance"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:value-of select="@payment"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:value-of select="@minpayment"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:value-of select="@margin"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:value-of select="@intrate"/>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='%']"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:if test="(@isactive = 0)">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">10201.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ActiveID=<xsl:value-of select="@debtid"/></xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/uncheckedbox.gif</xsl:attribute>
                                                                                 <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                                 <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@isactive != 0)">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">10201.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ActiveID=<xsl:value-of select="@debtid"/></xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/checkedbox.gif</xsl:attribute>
                                                                                 <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                                 <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">right</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="href">10201.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RemoveID=<xsl:value-of select="@debtid"/></xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Trash.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DeleteDebt']"/></xsl:attribute>
                                                                              <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DeleteDebt']"/></xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:if>
                                                            <xsl:if test="(@isactive = 0)">
                                                               <xsl:element name="TR">
                                                                  <xsl:attribute name="height">24</xsl:attribute>
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
                                                                           <xsl:attribute name="src">Images/debttype<xsl:value-of select="@debttype"/>.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">gray</xsl:attribute>
                                                                        <xsl:variable name="tmp3"><xsl:value-of select="../PTSDEBTTYPES/ENUM[@id=current()/@debttype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                                        </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">gray</xsl:attribute>
                                                                        <xsl:value-of select="@debtname"/>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="href">10203.asp?DebtID=<xsl:value-of select="@debtid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditDebt']"/></xsl:attribute>
                                                                              <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditDebt']"/></xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="color">gray</xsl:attribute>
                                                                     <xsl:value-of select="@balance"/>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="color">gray</xsl:attribute>
                                                                     <xsl:value-of select="@payment"/>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="color">gray</xsl:attribute>
                                                                     <xsl:value-of select="@minpayment"/>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="color">gray</xsl:attribute>
                                                                     <xsl:value-of select="@margin"/>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">gray</xsl:attribute>
                                                                        <xsl:value-of select="@intrate"/>
                                                                        </xsl:element>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='%']"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:if test="(@isactive = 0)">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">10201.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ActiveID=<xsl:value-of select="@debtid"/></xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/uncheckedbox.gif</xsl:attribute>
                                                                                 <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                                 <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@isactive != 0)">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">10201.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ActiveID=<xsl:value-of select="@debtid"/></xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/checkedbox.gif</xsl:attribute>
                                                                                 <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                                 <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivateDebt']"/></xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="align">right</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="href">10201.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RemoveID=<xsl:value-of select="@debtid"/></xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Trash.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DeleteDebt']"/></xsl:attribute>
                                                                              <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DeleteDebt']"/></xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:if>
                                                         </xsl:for-each>
                                                         <xsl:choose>
                                                            <xsl:when test="(count(/DATA/TXN/PTSDEBTS/PTSDEBT) = 0)">
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">9</xsl:attribute>
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="class">NoItems</xsl:attribute>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:when>
                                                         </xsl:choose>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">9</xsl:attribute>
                                                               <xsl:attribute name="height">2</xsl:attribute>
                                                               <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>

                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">25</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@expired &gt;= 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                       <xsl:element name="A">
                                          <xsl:attribute name="href">#_</xsl:attribute>
                                          <xsl:attribute name="onclick">AnalyzeDebt(<xsl:value-of select="/DATA/PARAM/@memberid"/>)</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/calculator.jpg</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AnalyzeDebt']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AnalyzeDebt']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AnalyzeDebt']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@expired &gt; 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@expired" disable-output-escaping="yes"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DaysLeft']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@expired &lt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">4</xsl:attribute>
                                    <xsl:attribute name="color">red</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Expired']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>