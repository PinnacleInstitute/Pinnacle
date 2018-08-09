<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="CustomReport.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/wtcalendar.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">10</xsl:attribute>
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
               <xsl:attribute name="onload">document.getElementById('Rpt').focus()</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Business</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">400</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">150</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                        </xsl:element>
                        <xsl:element name="TD">
                           <xsl:attribute name="width">250</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="SCRIPT">
                        <xsl:attribute name="language">JavaScript</xsl:attribute>
                        <xsl:text disable-output-escaping="yes"><![CDATA[ function NewReport(){ 
                  document.getElementById('NewRpt').value = 1;
                }]]></xsl:text>
                     </xsl:element>

                     <xsl:element name="SCRIPT">
                        <xsl:attribute name="language">JavaScript</xsl:attribute>
                        <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewReport(){ 
                  var val = document.getElementById('Mode').value;
                  document.getElementById('Mode').value = Number(val) + 1;
                  doSubmit(0,"");
                }]]></xsl:text>
                     </xsl:element>

                     <xsl:element name="SCRIPT">
                        <xsl:attribute name="language">JavaScript</xsl:attribute>
                        <xsl:text disable-output-escaping="yes"><![CDATA[ function LoadFile(url){ 
                  var win;
                  win = window.open(url);
                  win.focus();
                }]]></xsl:text>
                     </xsl:element>

                        <xsl:element name="INPUT">
                           <xsl:attribute name="type">hidden</xsl:attribute>
                           <xsl:attribute name="name">C</xsl:attribute>
                           <xsl:attribute name="id">C</xsl:attribute>
                           <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@c"/></xsl:attribute>
                        </xsl:element>
                        <xsl:element name="INPUT">
                           <xsl:attribute name="type">hidden</xsl:attribute>
                           <xsl:attribute name="name">M</xsl:attribute>
                           <xsl:attribute name="id">M</xsl:attribute>
                           <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@m"/></xsl:attribute>
                        </xsl:element>
                        <xsl:element name="INPUT">
                           <xsl:attribute name="type">hidden</xsl:attribute>
                           <xsl:attribute name="name">MR</xsl:attribute>
                           <xsl:attribute name="id">MR</xsl:attribute>
                           <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@mr"/></xsl:attribute>
                        </xsl:element>
                        <xsl:element name="INPUT">
                           <xsl:attribute name="type">hidden</xsl:attribute>
                           <xsl:attribute name="name">NewRpt</xsl:attribute>
                           <xsl:attribute name="id">NewRpt</xsl:attribute>
                           <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@newrpt"/></xsl:attribute>
                        </xsl:element>
                        <xsl:element name="INPUT">
                           <xsl:attribute name="type">hidden</xsl:attribute>
                           <xsl:attribute name="name">Mode</xsl:attribute>
                           <xsl:attribute name="id">Mode</xsl:attribute>
                           <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@mode"/></xsl:attribute>
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
                           <xsl:attribute name="width">400</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rpttype = 'system')">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemReports']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@rpttype = 'company')">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyReports']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@rpttype = 'member')">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberReports']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:value-of select="/DATA/PARAM/@username" disable-output-escaping="yes"/>
                        </xsl:element>
                     </xsl:element>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">2</xsl:attribute>
                           <xsl:attribute name="width">400</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:value-of select="/DATA/PARAM/@date" disable-output-escaping="yes"/>
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
                           <xsl:attribute name="width">400</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                           <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Rpt</xsl:attribute>
                                 <xsl:attribute name="id">Rpt</xsl:attribute>
                                 <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[NewReport()]]></xsl:text></xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@rpt"/></xsl:variable>
                                 <xsl:for-each select="/DATA/TXN/REPORTS/REPORT">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                           <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">submit</xsl:attribute>
                              <xsl:attribute name="value">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
                              </xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ViewReport()]]></xsl:text></xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">2</xsl:attribute>
                           <xsl:attribute name="height">6</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@mode &gt; 0)">
                        <xsl:variable name="desc"><xsl:value-of select="/DATA/TXN/REPORTS/REPORT[@id=/DATA/PARAM/@rpt]/@desc"/></xsl:variable>

                        <xsl:if test="($desc != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">400</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$desc]"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                     </xsl:if>
                     <xsl:if test="(/DATA/PARAM/@mode &gt; 0)">
                        <xsl:for-each select="/DATA/TXN/REPORTS/REPORT[@id=/DATA/PARAM/@rpt]/PARAM">
                           <xsl:call-template name="CustomReportParam"/>
                        </xsl:for-each>

                     </xsl:if>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">2</xsl:attribute>
                           <xsl:attribute name="height">6</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@file != '')">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="A">
                                 <xsl:attribute name="href">#_</xsl:attribute>
                                 <xsl:attribute name="onclick">LoadFile('<xsl:value-of select="/DATA/PARAM/@file"/>')</xsl:attribute>
                              <xsl:value-of select="/DATA/PARAM/@file" disable-output-escaping="yes"/>
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

                     <xsl:if test="(/DATA/PARAM/@mode &gt; 1) and (/DATA/PARAM/@count = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoData']"/>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@mode &gt; 1) and (/DATA/PARAM/@count &gt; 0)">
               <xsl:if test="(/DATA/PARAM/@chartsource = '')">
                  <xsl:call-template name="CustomReportData">
                     <xsl:with-param name="report" select="/DATA/TXN/REPORTS/REPORT[@id=/DATA/PARAM/@rpt]"/>
                     <xsl:with-param name="data" select="/DATA/TXN/REPORT/DATA"/>
                  </xsl:call-template>

               </xsl:if>
               <xsl:if test="(/DATA/PARAM/@chartsource != '')">
                  <xsl:call-template name="CustomReportChart">
                     <xsl:with-param name="report" select="/DATA/TXN/REPORTS/REPORT[@id=/DATA/PARAM/@rpt]"/>
                     <xsl:with-param name="chart" select="/DATA/PARAM/@chartsource"/>
                  </xsl:call-template>

               </xsl:if>
            </xsl:if>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
            </xsl:element>
            <!--END FORM-->

      </xsl:element>
      <!--END BODY-->

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <![CDATA[function doSubmit(iAction, sMsg){document.Business.elements['ActionCode'].value=iAction;document.Business.submit();}]]>
         <![CDATA[function doErrorMsg(sError){alert(sError);}]]>
         <![CDATA[function CalendarPopup(frm, fld) {  displayDatePicker(fld.name, fld);}]]>
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