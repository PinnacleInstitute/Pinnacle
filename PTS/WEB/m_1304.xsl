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
         <xsl:with-param name="pagename" select="'Course Ratings'"/>
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
               <xsl:attribute name="name">Session</xsl:attribute>
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
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">100%</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SelectRating(group, rating){ 
               document.getElementById('Rating' + String(group)).value = rating;
               for(i = 1; i <= 5; i++){
               if( i > rating){
               document.getElementById( "Rating" + String(group) + String(i) ).src = "Images/star_empty.gif";
               }else{
               document.getElementById( "Rating" + String(group) + String(i) ).src = "Images/star_full.gif";
               }
               }
               ComputeTotalRating();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ComputeTotalRating(){ 
               var total = 0;
               var str;
               for(i = 1; i <= 4; i++){
               total += parseInt(document.getElementById( 'Rating' + String(i) ).value);
               }
               total = Math.round( total / 2.0 );
               document.getElementById('TotalRating').value = total;
               //total /= 2.0;
               //str = total.toString();
               //if( str.indexOf(".") == -1 ){
               //   str += ".0"
               //}
               // document.getElementById('TotalRatingImage').src = "Images/Star" + str + ".gif"
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">0</xsl:attribute>
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
                              <xsl:attribute name="name">Rating1</xsl:attribute>
                              <xsl:attribute name="id">Rating1</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSSESSION/@rating1"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Rating2</xsl:attribute>
                              <xsl:attribute name="id">Rating2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSSESSION/@rating2"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Rating3</xsl:attribute>
                              <xsl:attribute name="id">Rating3</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSSESSION/@rating3"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Rating4</xsl:attribute>
                              <xsl:attribute name="id">Rating4</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSSESSION/@rating4"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">TotalRating</xsl:attribute>
                              <xsl:attribute name="id">TotalRating</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSSESSION/@totalrating"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='m_Congradulations']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
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
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSSESSION/@coursename"/>
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
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">Prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RatingInstructions']"/>
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
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">Prompt</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ClickStar']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EvalLegend']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          P
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          F
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          G
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          GR
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          E
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rating1']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating11</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating11</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating12</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating12</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating13</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating13</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating14</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating14</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating15</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating15</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(1, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rating2']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating21</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating21</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating22</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating22</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating23</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating23</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating24</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating24</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating25</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating25</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(2, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rating3']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating31</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating31</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating32</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating32</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating33</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating33</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating34</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating34</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating35</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating35</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(3, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rating4']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating41</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating41</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating42</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating42</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating43</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating43</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating44</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 4)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating44</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 4);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">16%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &lt; 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_empty.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating45</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSSESSION/@rating1 &gt;= 5)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/star_full.gif</xsl:attribute>
                                                   <xsl:attribute name="width">20</xsl:attribute>
                                                   <xsl:attribute name="id">Rating45</xsl:attribute>
                                                   <xsl:attribute name="align">bottom</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[SelectRating(4, 5);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ApplyText']"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">Apply</xsl:attribute>
                                             <xsl:attribute name="id">Apply</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSSESSION/PTSAPPLYS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Recommend']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">Recommend1</xsl:attribute>
                                          <xsl:attribute name="id">Recommend1</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSSESSION/@recommend1 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Recommend1']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">3</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">Recommend2</xsl:attribute>
                                          <xsl:attribute name="id">Recommend2</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSSESSION/@recommend2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Recommend2']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">3</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">Recommend3</xsl:attribute>
                                          <xsl:attribute name="id">Recommend3</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSSESSION/@recommend3 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Recommend3']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feedback']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="TEXTAREA">
                                             <xsl:attribute name="name">Feedback</xsl:attribute>
                                             <xsl:attribute name="id">Feedback</xsl:attribute>
                                             <xsl:attribute name="rows">6</xsl:attribute>
                                             <xsl:attribute name="cols">35</xsl:attribute>
                                             <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>2000) {doMaxLenMsg(2000); value=value.substring(0,2000);}]]></xsl:text></xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSSESSION/@feedback"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

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
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>