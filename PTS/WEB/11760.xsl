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
         <xsl:with-param name="pagename" select="'Activity Reports'"/>
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
               <xsl:attribute name="onload">document.getElementById('FromDate').focus()</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper750b</xsl:attribute>
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
               <xsl:attribute name="name">Report</xsl:attribute>
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

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">EnrollDate</xsl:attribute>
                              <xsl:attribute name="id">EnrollDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@enrolldate"/></xsl:attribute>
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
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:element name="font">
                                 <xsl:attribute name="size">4</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrackerReports']"/>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Report']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Report</xsl:attribute>
                                 <xsl:attribute name="id">Report</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@report"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">20</xsl:attribute>
                                    <xsl:if test="$tmp='20'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrackMeter']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivitySummary']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">2</xsl:attribute>
                                    <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalSummary']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">3</xsl:attribute>
                                    <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipSummary']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">4</xsl:attribute>
                                    <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalProgress']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">5</xsl:attribute>
                                    <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipProgress']"/>
                                 </xsl:element>
                                 <xsl:if test="(contains(/DATA/PARAM/@goal, '41'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">41</xsl:attribute>
                                       <xsl:if test="$tmp='41'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalResults']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/PARAM/@goal, '42'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">42</xsl:attribute>
                                       <xsl:if test="$tmp='42'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalActivities']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/PARAM/@goal, '43'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">43</xsl:attribute>
                                       <xsl:if test="$tmp='43'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipResults']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/PARAM/@goal, '44'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">44</xsl:attribute>
                                       <xsl:if test="$tmp='44'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipActivities']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/PARAM/@goal, '45'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">45</xsl:attribute>
                                       <xsl:if test="$tmp='45'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalTotalPoints']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '0'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">30</xsl:attribute>
                                       <xsl:if test="$tmp='30'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamTracks']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '0'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">31</xsl:attribute>
                                       <xsl:if test="$tmp='31'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamActivitySummary']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '0'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">32</xsl:attribute>
                                       <xsl:if test="$tmp='32'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalSummary']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '0'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">33</xsl:attribute>
                                       <xsl:if test="$tmp='33'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipSummary']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '0'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">34</xsl:attribute>
                                       <xsl:if test="$tmp='34'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalProgress']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '0'))">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">35</xsl:attribute>
                                       <xsl:if test="$tmp='35'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipProgress']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@memberid = /DATA/PARAM/@groupid)">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">10</xsl:attribute>
                                       <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemTracks']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@memberid = /DATA/PARAM/@groupid)">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">11</xsl:attribute>
                                       <xsl:if test="$tmp='11'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemActivitySummary']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@memberid = /DATA/PARAM/@groupid)">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">12</xsl:attribute>
                                       <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalSummary']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@memberid = /DATA/PARAM/@groupid)">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">13</xsl:attribute>
                                       <xsl:if test="$tmp='13'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipSummary']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@memberid = /DATA/PARAM/@groupid)">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">14</xsl:attribute>
                                       <xsl:if test="$tmp='14'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalProgress']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@memberid = /DATA/PARAM/@groupid)">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">15</xsl:attribute>
                                       <xsl:if test="$tmp='15'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipProgress']"/>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
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
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='For']"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Term</xsl:attribute>
                                 <xsl:attribute name="id">Term</xsl:attribute>
                                 <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[
                     var ONE_DAY = 1000 * 60 * 60 * 24;
                     var fromdate = new Date();
                     var todate = new Date();
                     var term = document.getElementById('Term').value;
                     switch(term) {
                     case "0":
                     document.getElementById('FromDate').value = document.getElementById('EnrollDate').value
                     break;
                     case "1":
                     fromdate.setTime(fromdate.getTime() - ONE_DAY );
                     todate = fromdate;
                     break;
                     case "2":
                     break;
                     case "3":
                     todate.setTime(todate.getTime() - ( todate.getDay() * ONE_DAY ) );
                     fromdate.setTime(todate.getTime() - ( 6 * ONE_DAY ) );
                     break;
                     case "4":
                     todate.setDate(1);
                     todate.setTime(todate.getTime() - ONE_DAY );
                     fromdate.setTime(todate.getTime());
                     fromdate.setDate(1);
                     break;
                     case "5":
                     todate.setMonth(0);
                     todate.setDate(1);
                     todate.setTime(todate.getTime() - ONE_DAY );
                     fromdate.setTime(todate.getTime());
                     fromdate.setMonth(0);
                     fromdate.setDate(1);
                     break;
                     case "6":
                     fromdate.setTime(fromdate.getTime() - ( (fromdate.getDay()-1) * ONE_DAY ) );
                     break;
                     case "7":
                     fromdate.setDate(1);
                     break;
                     case "8":
                     fromdate.setMonth(0);
                     fromdate.setDate(1);
                     break;
                     case "9":
                     fromdate.setTime(fromdate.getTime() - ( 6 * ONE_DAY) );
                     break;
                     case "10":
                     fromdate.setTime(fromdate.getTime() - ( 30 * ONE_DAY) );
                     break;
                     }
                     if(term!=0){document.getElementById('FromDate').value = fromdate.getMonth()+1 + "/" + fromdate.getDate() + "/" + fromdate.getFullYear();}
                     document.getElementById('ToDate').value = todate.getMonth()+1 + "/" + todate.getDate() + "/" + todate.getFullYear();
                  ]]></xsl:text></xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@term"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">0</xsl:attribute>
                                    <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership']"/>
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
                                    <xsl:attribute name="value">6</xsl:attribute>
                                    <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='WeekToDate']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">7</xsl:attribute>
                                    <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MonthToDate']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8</xsl:attribute>
                                    <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YearToDate']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">3</xsl:attribute>
                                    <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevWeek']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">4</xsl:attribute>
                                    <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevMonth']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">5</xsl:attribute>
                                    <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevYear']"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='From']"/>
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
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='To']"/>
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
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@count &lt; 0)">
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
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoReportData']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@count &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">5</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@report = 20)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrackMeter']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 1)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivitySummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 2)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalSummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 3)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipSummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 4)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalProgress']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 5)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipProgress']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 10)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemTracks']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 11)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemActivitySummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 12)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalSummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 13)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipSummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 14)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalProgress']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 15)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipProgress']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 30)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamTracks']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 31)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamActivitySummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 32)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalSummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 33)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipSummary']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 34)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalProgress']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 35)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipProgress']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 41)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalResults']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 42)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalActivities']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 43)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipResults']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 44)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipActivities']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 45)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalTotalPoints']"/>
                                       </xsl:if>
                                    </xsl:element>
                                    <xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/PARAM/@fromdate" disable-output-escaping="yes"/>
                                     - 
                                    <xsl:value-of select="/DATA/PARAM/@todate" disable-output-escaping="yes"/>
                                 <xsl:if test="(/DATA/PARAM/@report = 1) or (/DATA/PARAM/@report = 11) or (/DATA/PARAM/@report = 31)">
                                       <xsl:element name="BR"/>
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@total1" disable-output-escaping="yes"/>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResultsText']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@total2" disable-output-escaping="yes"/>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivitiesText']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RatioText']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@total3" disable-output-escaping="yes"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@report = 2) or (/DATA/PARAM/@report = 3) or (/DATA/PARAM/@report = 12) or (/DATA/PARAM/@report = 13) or (/DATA/PARAM/@report = 32) or (/DATA/PARAM/@report = 33)">
                                       <xsl:element name="BR"/>
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@total1" disable-output-escaping="yes"/>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResultsText']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@total2" disable-output-escaping="yes"/>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivitiesText']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RatioText']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@total3" disable-output-escaping="yes"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@report = 4) or (/DATA/PARAM/@report = 5) or (/DATA/PARAM/@report = 14) or (/DATA/PARAM/@report = 15) or (/DATA/PARAM/@report = 34) or (/DATA/PARAM/@report = 35) or (/DATA/PARAM/@report = 41) or (/DATA/PARAM/@report = 42) or (/DATA/PARAM/@report = 43) or (/DATA/PARAM/@report = 44) or (/DATA/PARAM/@report = 45)">
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/PARAM/@unit = 'day')">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Daily']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@unit = 'week')">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Weekly']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@unit = 'month')">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Monthly']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@unit = 'quarter')">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Quarterly']"/>
                                       </xsl:if>
                                 </xsl:if>
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
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/./../<xsl:value-of select="/DATA/PARAM/@chartsource"/></xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@mobile = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">prompt</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@report = 20)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrackMeterText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 1)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivitySummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 2)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalSummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 3)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipSummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 4)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalProgressText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 5)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipProgressText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 10)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemTracksText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 11)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemActivitySummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 12)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalSummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 13)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipSummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 14)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalProgressText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 15)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipProgressText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 30)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamTracksText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 31)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamActivitySummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 32)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalSummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 33)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipSummaryText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 34)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalProgressText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 35)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipProgressText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 41)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalResultsText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 42)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalActivitiesText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 43)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipResultsText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 44)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipActivitiesText']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@report = 45)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalTotalPointsText']"/>
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

                           <xsl:if test="(/DATA/PARAM/@mobile != 0)">
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
                                                <xsl:attribute name="width">200</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">350</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">200</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">200</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">350</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">prompt</xsl:attribute>
                                                   <xsl:if test="(/DATA/PARAM/@report = 20)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrackMeterText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 1)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActivitySummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 2)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalSummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 3)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipSummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 4)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PersonalProgressText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 5)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadershipProgressText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 10)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemTracksText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 11)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemActivitySummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 12)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalSummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 13)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipSummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 14)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemPersonalProgressText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 15)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SystemLeadershipProgressText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 30)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamTracksText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 31)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamActivitySummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 32)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalSummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 33)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipSummaryText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 34)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamPersonalProgressText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 35)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamLeadershipProgressText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 41)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalResultsText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 42)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalPersonalActivitiesText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 43)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipResultsText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 44)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLeadershipActivitiesText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@report = 45)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalTotalPointsText']"/>
                                                   </xsl:if>
                                             </xsl:element>
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

                        </xsl:if>
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
                              <xsl:attribute name="colspan">1</xsl:attribute>
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