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
         <xsl:with-param name="pagename" select="'Leader Board'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">0</xsl:attribute>
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
               <xsl:attribute name="onload">document.getElementById('FromDate').focus()</xsl:attribute>
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
            <xsl:attribute name="width">100%</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Metric</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="5"/></xsl:attribute>
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
                     <xsl:attribute name="width">0%</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">100%</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                  var tmpID = '<xsl:value-of select="/DATA/SYSTEM/@ga_acctid"/>'
                  var tmpDomain = '<xsl:value-of select="/DATA/SYSTEM/@ga_domain"/>'
                  var tmpAction = '<xsl:value-of select="/DATA/SYSTEM/@actioncode"/>'
                  <xsl:text disable-output-escaping="yes">if( tmpID.length != 0 &amp;&amp; tmpDomain.length != 0 &amp;&amp; (tmpAction = '0') ) {</xsl:text>
                     ga('create', tmpID, tmpDomain);
                     ga('send', 'pageview');
                  }
               </xsl:element>
               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">0%</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">100%</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
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
                              <xsl:attribute name="name">GroupID</xsl:attribute>
                              <xsl:attribute name="id">GroupID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@groupid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Pos</xsl:attribute>
                              <xsl:attribute name="id">Pos</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@pos"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">EnrollDate</xsl:attribute>
                              <xsl:attribute name="id">EnrollDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@enrolldate"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Custom1</xsl:attribute>
                              <xsl:attribute name="id">Custom1</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@custom1"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Custom2</xsl:attribute>
                              <xsl:attribute name="id">Custom2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@custom2"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Custom3</xsl:attribute>
                              <xsl:attribute name="id">Custom3</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@custom3"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Custom4</xsl:attribute>
                              <xsl:attribute name="id">Custom4</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@custom4"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Custom5</xsl:attribute>
                              <xsl:attribute name="id">Custom5</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@custom5"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@contestid != 0)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Scope</xsl:attribute>
                              <xsl:attribute name="id">Scope</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@scope"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Rpt</xsl:attribute>
                              <xsl:attribute name="id">Rpt</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@rpt"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:attribute name="color">#000070</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeaderBoard']"/>
                                 </xsl:element>
                                 </xsl:element>
                              <xsl:if test="(/DATA/PARAM/@contestid = 0)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="SELECT">
                                       <xsl:attribute name="name">Scope</xsl:attribute>
                                       <xsl:attribute name="id">Scope</xsl:attribute>
                                       <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@scope"/></xsl:variable>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyID']"/>
                                       </xsl:element>
                                       <xsl:if test="(/DATA/PARAM/@groupid != 0)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">2</xsl:attribute>
                                             <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GroupID']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/SYSTEM/@memberid != 0)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">3</xsl:attribute>
                                             <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mentor']"/>
                                          </xsl:element>
                                       </xsl:if>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="SELECT">
                                       <xsl:attribute name="name">Rpt</xsl:attribute>
                                       <xsl:attribute name="id">Rpt</xsl:attribute>
                                       <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@rpt"/></xsl:variable>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Results']"/>
                                       </xsl:element>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">2</xsl:attribute>
                                          <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Activities']"/>
                                       </xsl:element>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">3</xsl:attribute>
                                          <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='All']"/>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(count(/DATA/TXN/PTSCONTESTS/ENUM) &gt; 1) or (/DATA/PARAM/@ownercontestid != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@ownercontestid = 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/contest.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">ContestID</xsl:attribute>
                                          <xsl:attribute name="id">ContestID</xsl:attribute>
                                          <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(5,"")]]></xsl:text></xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@contestid"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/PTSCONTESTS/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@ownercontestid != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/contest.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="b">
                                       <xsl:value-of select="/DATA/PARAM/@contestname" disable-output-escaping="yes"/>
                                       </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@nodates != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='from']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@fromdate" disable-output-escaping="yes"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='to']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@todate" disable-output-escaping="yes"/>
                                    </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@nodates != 0)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Term</xsl:attribute>
                              <xsl:attribute name="id">Term</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@term"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">FromDate</xsl:attribute>
                              <xsl:attribute name="id">FromDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@fromdate"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ToDate</xsl:attribute>
                              <xsl:attribute name="id">ToDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@todate"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@nodates = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadersFor']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">Term</xsl:attribute>
                                    <xsl:attribute name="id">Term</xsl:attribute>
                                    <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[
                     var ONE_DAY = 1000 * 60 * 60 * 24;
                     var fromdate = new Date();
                     var todate = new Date();
                     term = document.getElementById('Term').value;
                     switch(term) {
                     case "1":
                     document.getElementById('FromDate').value = document.getElementById('EnrollDate').value
                     break;
                     case "2":
                     break;
                     case "3":
                     fromdate.setTime(fromdate.getTime() - ONE_DAY );
                     todate = fromdate;
                     break;
                     case "4":
                     var d = fromdate.getDay()
                     if( d == 0 ) { d = 7 }
                     fromdate.setTime(fromdate.getTime() - ( (d-1) * ONE_DAY ) );
                     break;
                     case "5":
                     fromdate.setDate(1);
                     break;
                     case "6":
                     fromdate.setMonth(0);
                     fromdate.setDate(1);
                     break;
                     case "7":
                     var d = todate.getDay()
                     if( d == 0 ) { d = 7 }
                     todate.setTime(todate.getTime() - ( d * ONE_DAY ) );
                     fromdate.setTime(todate.getTime() - ( 6 * ONE_DAY ) );
                     break;
                     case "8":
                     todate.setDate(1);
                     todate.setTime(todate.getTime() - ONE_DAY );
                     fromdate.setTime(todate.getTime());
                     fromdate.setDate(1);
                     break;
                     case "9":
                     fromdate.setTime(fromdate.getTime() - ( 6 * ONE_DAY) );
                     break;
                     case "10":
                     fromdate.setTime(fromdate.getTime() - ( 30 * ONE_DAY) );
                     break;
                     }
                     if(term!=1){document.getElementById('FromDate').value = fromdate.getMonth()+1 + "/" + fromdate.getDate() + "/" + fromdate.getFullYear();}
                     document.getElementById('ToDate').value = todate.getMonth()+1 + "/" + todate.getDate() + "/" + todate.getFullYear();
                  ]]></xsl:text></xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@term"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">2</xsl:attribute>
                                       <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">3</xsl:attribute>
                                       <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Yesterday']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">9</xsl:attribute>
                                       <xsl:if test="$tmp='9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev7']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">10</xsl:attribute>
                                       <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev30']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">4</xsl:attribute>
                                       <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisWeek']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">5</xsl:attribute>
                                       <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisMonth']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">6</xsl:attribute>
                                       <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisYear']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">7</xsl:attribute>
                                       <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LastWeek']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">8</xsl:attribute>
                                       <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LastMonth']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='from']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">FromDate</xsl:attribute>
                              <xsl:attribute name="id">FromDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@fromdate"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('FromDate'))</xsl:attribute>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='to']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">ToDate</xsl:attribute>
                              <xsl:attribute name="id">ToDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@todate"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('ToDate'))</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">submit</xsl:attribute>
                                 <xsl:attribute name="class">bigbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">15%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='#']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">55%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">15%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Points']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">15%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">4</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSMETRICS/PTSMETRIC">
                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">30</xsl:attribute>
                                       <xsl:if test="(position() mod 2)=1">
                                          <xsl:attribute name="class">GrayBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:if test="(position() mod 2)=0">
                                          <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="position()+/DATA/PARAM/@pos"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@membername"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@points"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">m_11714.asp?MemberID=<xsl:value-of select="@metricid"/>&amp;FromDate=<xsl:value-of select="/DATA/PARAM/@fromdate"/>&amp;ToDate=<xsl:value-of select="/DATA/PARAM/@todate"/>&amp;Rpt=<xsl:value-of select="/DATA/PARAM/@rpt"/>&amp;OwnerContestID=<xsl:value-of select="/DATA/PARAM/@ownercontestid"/>&amp;Custom1=<xsl:value-of select="/DATA/PARAM/@custom1"/>&amp;Custom2=<xsl:value-of select="/DATA/PARAM/@custom2"/>&amp;Custom3=<xsl:value-of select="/DATA/PARAM/@custom3"/>&amp;Custom4=<xsl:value-of select="/DATA/PARAM/@custom4"/>&amp;Custom5=<xsl:value-of select="/DATA/PARAM/@custom5"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Preview24.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:for-each>
                                 <xsl:choose>
                                    <xsl:when test="(count(/DATA/TXN/PTSMETRICS/PTSMETRIC) = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="class">NoItems</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:when>
                                 </xsl:choose>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">4</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="height">2</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">25%</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="class">PrevNext</xsl:attribute>
                                       <xsl:if test="/DATA/BOOKMARK/@next='False'">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndOfList']"/>
                                       </xsl:if>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">75%</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:call-template name="PreviousNext"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="height">4</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchMember']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">SearchMember</xsl:attribute>
                              <xsl:attribute name="id">SearchMember</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@searchmember"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">bigbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Search']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">bigbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='All']"/>
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