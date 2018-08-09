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
         <xsl:with-param name="pagename" select="'Try CloudZow'"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowComputers();]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowComputers();]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowComputers();]]></xsl:text></xsl:attribute>
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
               <xsl:attribute name="name">CloudZow</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ValidFirst(id){ 
               var obj, first, last, email;
               obj = document.getElementById('First'+id);
               first = obj.value;
               last = document.getElementById('Last'+id).value;
               email = document.getElementById('Email'+id).value;
               if ( first == "" && ( last != "" || email != "" ) )
                  alert("#" + id + " first name is required");
               if ( first != "" )
                  TitleCase(obj);
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ValidLast(id){ 
               var obj, first, last, email;
               first = document.getElementById('First'+id).value;
               obj = document.getElementById('Last'+id);
               last = obj.value;
               email = document.getElementById('Email'+id).value;
               if ( last == "" && ( first != "" || email != "" ) )
                  alert("#" + id + " last name is required");
               if ( last != "" ) {
                  TitleCase(obj);
                  if ( first == "" )
                     alert("#" + id + " first name is required");
               }   
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ValidEmail(id){ 
               var first, last, email, bad=0;
               first = document.getElementById('First'+id).value;
               last = document.getElementById('Last'+id).value;
               email = document.getElementById('Email'+id).value.toLowerCase();
               if ( email == "" && first != "" )
                  alert("#" + id + " email address is required");
               if ( email != "" ) {
                  var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                  //var filter = [a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)\b;
                  if (! filter.test(email)) {
                     alert("#" + id + " invalid email address");
                     bad = 1;
                  }   
                  var i=1, disp;
                  for (i=1; i<=20; i++)
                  {
                     if( i != id ) {
                        if( email == document.getElementById('Email' + i).value.toLowerCase() )
                           bad=1;
                     }   
                     if( bad == 1 ) i=21;
                  }
                  if( bad == 1 ) { alert("Each computer email address must be unique."); }
                  if ( first == "" ) { alert("#" + id + " first name is required"); }
                  if ( last == "" ) {   alert("#" + id + " last name is required"); }
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ValidPassword(id){ 
               email = document.getElementById('Email'+id).value;
               var pswd = document.getElementById('Password'+id).value;
               if ( email != '' && pswd.length < 6 )
                  alert("#" + id + " password must be at least 6 characters long");
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function TitleCase(obj){    
               var val = obj.value;
               if ( val.length == 2 ) {
                  obj.value = val.charAt(0).toUpperCase() + val.charAt(1).toUpperCase();
               }
               else {               
                  obj.value = val.charAt(0).toUpperCase() + val.slice(1);
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowComputers(){ 
               var computers = document.getElementById('Computers').value;
               var i=1, disp;
               for (i=1; i<=20; i++)
               {
                  if( i <= computers ) { disp = ''; } else { disp = 'none'; }
                  document.getElementById('Computer' + i).style.display = disp;
               }
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">550</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BillingID</xsl:attribute>
                              <xsl:attribute name="id">BillingID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@billingid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Processor</xsl:attribute>
                              <xsl:attribute name="id">Processor</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@processor"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberToken</xsl:attribute>
                              <xsl:attribute name="id">MemberToken</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@membertoken"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Token</xsl:attribute>
                              <xsl:attribute name="id">Token</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@token"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">PayDesc</xsl:attribute>
                              <xsl:attribute name="id">PayDesc</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paydesc"/></xsl:attribute>
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
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">550</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">NameFirst</xsl:attribute>
                              <xsl:attribute name="id">NameFirst</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                              <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                              <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this); document.getElementById('First1').value = this.value;]]></xsl:text></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameLast']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">550</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">NameLast</xsl:attribute>
                              <xsl:attribute name="id">NameLast</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/></xsl:attribute>
                              <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                              <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this); document.getElementById('Last1').value = this.value;]]></xsl:text></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">550</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Email</xsl:attribute>
                              <xsl:attribute name="id">Email</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                              <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                              <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('Email1').value = this.value;]]></xsl:text></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">550</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Phone1</xsl:attribute>
                              <xsl:attribute name="id">Phone1</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/></xsl:attribute>
                              <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
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
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Machine48.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ComputersText1']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">550</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">Computers</xsl:attribute>
                                    <xsl:attribute name="id">Computers</xsl:attribute>
                                    <xsl:attribute name="style">font:12pt;</xsl:attribute>
                                    <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ShowComputers();]]></xsl:text></xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@computers"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='1Computer']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">2</xsl:attribute>
                                       <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">3</xsl:attribute>
                                       <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='3Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">4</xsl:attribute>
                                       <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='4Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">5</xsl:attribute>
                                       <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='5Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">6</xsl:attribute>
                                       <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='6Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">7</xsl:attribute>
                                       <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='7Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">8</xsl:attribute>
                                       <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='8Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">9</xsl:attribute>
                                       <xsl:if test="$tmp='9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='9Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">10</xsl:attribute>
                                       <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='10Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">11</xsl:attribute>
                                       <xsl:if test="$tmp='11'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='11Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">12</xsl:attribute>
                                       <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='12Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">13</xsl:attribute>
                                       <xsl:if test="$tmp='13'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='13Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">14</xsl:attribute>
                                       <xsl:if test="$tmp='14'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='14Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">15</xsl:attribute>
                                       <xsl:if test="$tmp='15'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='15Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">16</xsl:attribute>
                                       <xsl:if test="$tmp='16'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='16Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">17</xsl:attribute>
                                       <xsl:if test="$tmp='17'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='17Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">18</xsl:attribute>
                                       <xsl:if test="$tmp='18'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='18Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">19</xsl:attribute>
                                       <xsl:if test="$tmp='19'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='19Computers']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">20</xsl:attribute>
                                       <xsl:if test="$tmp='20'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='20Computers']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ComputersText2']"/>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddComputers']"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameLast']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Logon']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Password']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer1</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #1
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First1</xsl:attribute>
                                          <xsl:attribute name="id">First1</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first1"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(1);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last1</xsl:attribute>
                                          <xsl:attribute name="id">Last1</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last1"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(1);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email1</xsl:attribute>
                                          <xsl:attribute name="id">Email1</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email1"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(1);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password1</xsl:attribute>
                                          <xsl:attribute name="id">Password1</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password1"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(1);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer2</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #2
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First2</xsl:attribute>
                                          <xsl:attribute name="id">First2</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first2"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(2);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last2</xsl:attribute>
                                          <xsl:attribute name="id">Last2</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last2"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(2);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email2</xsl:attribute>
                                          <xsl:attribute name="id">Email2</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email2"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(2);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password2</xsl:attribute>
                                          <xsl:attribute name="id">Password2</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password2"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(2);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer3</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #3
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First3</xsl:attribute>
                                          <xsl:attribute name="id">First3</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first3"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(3);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last3</xsl:attribute>
                                          <xsl:attribute name="id">Last3</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last3"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(3);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email3</xsl:attribute>
                                          <xsl:attribute name="id">Email3</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email3"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(3);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password3</xsl:attribute>
                                          <xsl:attribute name="id">Password3</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password3"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(3);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer4</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #4
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First4</xsl:attribute>
                                          <xsl:attribute name="id">First4</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first4"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(4);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last4</xsl:attribute>
                                          <xsl:attribute name="id">Last4</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last4"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(4);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email4</xsl:attribute>
                                          <xsl:attribute name="id">Email4</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email4"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(4);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password4</xsl:attribute>
                                          <xsl:attribute name="id">Password4</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password4"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(4);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer5</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #5
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First5</xsl:attribute>
                                          <xsl:attribute name="id">First5</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first5"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(5);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last5</xsl:attribute>
                                          <xsl:attribute name="id">Last5</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last5"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(5);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email5</xsl:attribute>
                                          <xsl:attribute name="id">Email5</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email5"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(5);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password5</xsl:attribute>
                                          <xsl:attribute name="id">Password5</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password5"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(5);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer6</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #6
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First6</xsl:attribute>
                                          <xsl:attribute name="id">First6</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first6"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(6);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last6</xsl:attribute>
                                          <xsl:attribute name="id">Last6</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last6"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(6);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email6</xsl:attribute>
                                          <xsl:attribute name="id">Email6</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email6"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(6);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password6</xsl:attribute>
                                          <xsl:attribute name="id">Password6</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password6"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(6);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer7</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #7
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First7</xsl:attribute>
                                          <xsl:attribute name="id">First7</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first7"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(7);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last7</xsl:attribute>
                                          <xsl:attribute name="id">Last7</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last7"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(7);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email7</xsl:attribute>
                                          <xsl:attribute name="id">Email7</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email7"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(7);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password7</xsl:attribute>
                                          <xsl:attribute name="id">Password7</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password7"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(7);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer8</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #8
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First8</xsl:attribute>
                                          <xsl:attribute name="id">First8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first8"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(8);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last8</xsl:attribute>
                                          <xsl:attribute name="id">Last8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last8"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(8);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email8</xsl:attribute>
                                          <xsl:attribute name="id">Email8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email8"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(8);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password8</xsl:attribute>
                                          <xsl:attribute name="id">Password8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password8"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(8);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer9</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #9
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First9</xsl:attribute>
                                          <xsl:attribute name="id">First9</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first9"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(9);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last9</xsl:attribute>
                                          <xsl:attribute name="id">Last9</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last9"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(9);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email9</xsl:attribute>
                                          <xsl:attribute name="id">Email9</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email9"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(9);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password9</xsl:attribute>
                                          <xsl:attribute name="id">Password9</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password9"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(9);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer10</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #10
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First10</xsl:attribute>
                                          <xsl:attribute name="id">First10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first10"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(10);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last10</xsl:attribute>
                                          <xsl:attribute name="id">Last10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last10"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(10);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email10</xsl:attribute>
                                          <xsl:attribute name="id">Email10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email10"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(10);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password10</xsl:attribute>
                                          <xsl:attribute name="id">Password10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password10"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(10);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer11</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #11
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First11</xsl:attribute>
                                          <xsl:attribute name="id">First11</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first11"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(11);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last11</xsl:attribute>
                                          <xsl:attribute name="id">Last11</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last11"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(11);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email11</xsl:attribute>
                                          <xsl:attribute name="id">Email11</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email11"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(11);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password11</xsl:attribute>
                                          <xsl:attribute name="id">Password11</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password11"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(11);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer12</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #12
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First12</xsl:attribute>
                                          <xsl:attribute name="id">First12</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first12"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(12);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last12</xsl:attribute>
                                          <xsl:attribute name="id">Last12</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last12"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(12);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email12</xsl:attribute>
                                          <xsl:attribute name="id">Email12</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email12"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(12);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password12</xsl:attribute>
                                          <xsl:attribute name="id">Password12</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password12"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(12);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer13</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #13
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First13</xsl:attribute>
                                          <xsl:attribute name="id">First13</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first13"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(13);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last13</xsl:attribute>
                                          <xsl:attribute name="id">Last13</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last13"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(13);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email13</xsl:attribute>
                                          <xsl:attribute name="id">Email13</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email13"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(13);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password13</xsl:attribute>
                                          <xsl:attribute name="id">Password13</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password13"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(13);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer14</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #14
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First14</xsl:attribute>
                                          <xsl:attribute name="id">First14</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first14"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(14);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last14</xsl:attribute>
                                          <xsl:attribute name="id">Last14</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last14"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(14);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email14</xsl:attribute>
                                          <xsl:attribute name="id">Email14</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email14"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(14);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password14</xsl:attribute>
                                          <xsl:attribute name="id">Password14</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password14"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(14);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer15</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #15
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First15</xsl:attribute>
                                          <xsl:attribute name="id">First15</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first15"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(15);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last15</xsl:attribute>
                                          <xsl:attribute name="id">Last15</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last15"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(15);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email15</xsl:attribute>
                                          <xsl:attribute name="id">Email15</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email15"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(15);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password15</xsl:attribute>
                                          <xsl:attribute name="id">Password15</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password15"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(15);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer16</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #16
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First16</xsl:attribute>
                                          <xsl:attribute name="id">First16</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first16"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(16);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last16</xsl:attribute>
                                          <xsl:attribute name="id">Last16</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last16"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(16);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email16</xsl:attribute>
                                          <xsl:attribute name="id">Email16</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email16"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(16);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password16</xsl:attribute>
                                          <xsl:attribute name="id">Password16</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password16"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(16);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer17</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #17
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First17</xsl:attribute>
                                          <xsl:attribute name="id">First17</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first17"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(17);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last17</xsl:attribute>
                                          <xsl:attribute name="id">Last17</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last17"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(17);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email17</xsl:attribute>
                                          <xsl:attribute name="id">Email17</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email17"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(17);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password17</xsl:attribute>
                                          <xsl:attribute name="id">Password17</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password17"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(17);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer18</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #18
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First18</xsl:attribute>
                                          <xsl:attribute name="id">First18</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first18"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(18);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last18</xsl:attribute>
                                          <xsl:attribute name="id">Last18</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last18"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(18);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email18</xsl:attribute>
                                          <xsl:attribute name="id">Email18</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email18"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(18);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password18</xsl:attribute>
                                          <xsl:attribute name="id">Password18</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password18"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(18);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer19</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #19
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First19</xsl:attribute>
                                          <xsl:attribute name="id">First19</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first19"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(19);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last19</xsl:attribute>
                                          <xsl:attribute name="id">Last19</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last19"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(19);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email19</xsl:attribute>
                                          <xsl:attribute name="id">Email19</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email19"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(19);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password19</xsl:attribute>
                                          <xsl:attribute name="id">Password19</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password19"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(19);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">Computer20</xsl:attribute>
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          Computer #20
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">First20</xsl:attribute>
                                          <xsl:attribute name="id">First20</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@first20"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidFirst(20);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Last20</xsl:attribute>
                                          <xsl:attribute name="id">Last20</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@last20"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="size">19</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidLast(20);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email20</xsl:attribute>
                                          <xsl:attribute name="id">Email20</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@email20"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">28</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidEmail(20);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Password20</xsl:attribute>
                                          <xsl:attribute name="id">Password20</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@password20"/></xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="style">height=28px; padding=4px 0</xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPassword(20);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@pay != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:attribute name="id">Pay2</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaymentText']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">PayType</xsl:attribute>
                                 <xsl:attribute name="id">PayType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paytype"/></xsl:attribute>
                              </xsl:element>

                           <xsl:element name="TR">
                              <xsl:attribute name="id">Pay3</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/PayType1.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(1);]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/PayType2.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(2);]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/PayType3.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(3);]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/PayType4.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(4);]]></xsl:text></xsl:attribute>
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
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardNumber']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CardNumber</xsl:attribute>
                                 <xsl:attribute name="id">CardNumber</xsl:attribute>
                                 <xsl:attribute name="size">25</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[var x = this.value; this.value = x.replace(/[^\d]/g, '');]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardDate']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">CardMo</xsl:attribute>
                                    <xsl:attribute name="id">CardMo</xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardmo"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"></xsl:attribute>
                                       <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='January']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">2</xsl:attribute>
                                       <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='February']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">3</xsl:attribute>
                                       <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='March']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">4</xsl:attribute>
                                       <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='April']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">5</xsl:attribute>
                                       <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='May']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">6</xsl:attribute>
                                       <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='June']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">7</xsl:attribute>
                                       <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='July']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">8</xsl:attribute>
                                       <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='August']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">9</xsl:attribute>
                                       <xsl:if test="$tmp='9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='September']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">10</xsl:attribute>
                                       <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='October']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">11</xsl:attribute>
                                       <xsl:if test="$tmp='11'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='November']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">12</xsl:attribute>
                                       <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='December']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">CardYr</xsl:attribute>
                                    <xsl:attribute name="id">CardYr</xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardyr"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"></xsl:attribute>
                                       <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">12</xsl:attribute>
                                       <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2012']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">13</xsl:attribute>
                                       <xsl:if test="$tmp='13'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2013']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">14</xsl:attribute>
                                       <xsl:if test="$tmp='14'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2014']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">15</xsl:attribute>
                                       <xsl:if test="$tmp='15'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2015']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">16</xsl:attribute>
                                       <xsl:if test="$tmp='16'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2016']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">17</xsl:attribute>
                                       <xsl:if test="$tmp='17'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2017']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">18</xsl:attribute>
                                       <xsl:if test="$tmp='18'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2018']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">19</xsl:attribute>
                                       <xsl:if test="$tmp='19'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2019']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">20</xsl:attribute>
                                       <xsl:if test="$tmp='20'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2020']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">21</xsl:attribute>
                                       <xsl:if test="$tmp='21'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2021']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">22</xsl:attribute>
                                       <xsl:if test="$tmp='22'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2022']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">23</xsl:attribute>
                                       <xsl:if test="$tmp='23'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2023']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">24</xsl:attribute>
                                       <xsl:if test="$tmp='24'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2024']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">25</xsl:attribute>
                                       <xsl:if test="$tmp='25'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2025']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardName']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CardName</xsl:attribute>
                                 <xsl:attribute name="id">CardName</xsl:attribute>
                                 <xsl:attribute name="size">25</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardCode']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CardCode</xsl:attribute>
                                 <xsl:attribute name="id">CardCode</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="maxlength">4</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardcode"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[FormatCardCode(this);]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href">#</xsl:attribute>
                                    <xsl:attribute name="class">tooltip</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/SymbolHelp.gif</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="SPAN">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/SecurityCode.png</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillingAddress']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Street1</xsl:attribute>
                                 <xsl:attribute name="id">Street1</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@street1"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Street Required!');}]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">200</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Street2</xsl:attribute>
                                 <xsl:attribute name="id">Street2</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@street2"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">350</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">City</xsl:attribute>
                                          <xsl:attribute name="id">City</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@city"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, City Required!');}else{TitleCase(this);}]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">350</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">State</xsl:attribute>
                                          <xsl:attribute name="id">State</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@state"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, State Required!');}else{TitleCase(this);}]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">450</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CountryID']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Zip</xsl:attribute>
                                          <xsl:attribute name="id">Zip</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@zip"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Postal Code Required!')}]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">450</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">CountryID</xsl:attribute>
                                             <xsl:attribute name="id">CountryID</xsl:attribute>
                                             <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSBILLING/@countryid"/></xsl:variable>
                                             <xsl:for-each select="/DATA/TXN/PTSCOUNTRYS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="@name"/>
                                                </xsl:element>
                                             </xsl:for-each>
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
                              <xsl:attribute name="id">Secure</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/padlock.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SecurePayment']"/>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:attribute name="id">Agree2</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                    <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@isagree2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
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
                              <xsl:element name="b">
                              <xsl:element name="font">
                                 <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@isagree = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree']"/>
                                 </xsl:element>
                              </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="A">
                                 <xsl:attribute name="onclick">w=window.open(this.href,"Terms","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                 <xsl:attribute name="href">Page.asp?page=terms</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgreeText']"/>
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
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@pay = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartTrial']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(2,""); this.disabled = true]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@pay != 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartNow']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(2,""); this.disabled = true]]></xsl:text></xsl:attribute>
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

                        <xsl:if test="(/DATA/PARAM/@referredby != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReferredBy']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@referredby" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:attribute name="height">48</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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