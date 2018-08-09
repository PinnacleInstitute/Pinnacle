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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Assessment']"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ToggleType();
               ToggleResult();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ToggleType();
               ToggleResult();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ToggleType();
               ToggleResult();
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper600</xsl:attribute>
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
               <xsl:attribute name="name">Assessment</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ToggleType(){    
               var shwExternal = 'none'; var shwInternal = 'none'; var shwCourse = 'none'; var shwMaster = 'none';  var shwProgram = 'none'; 
               var type = document.getElementById('AssessmentType').value;
               if (type == 1){ shwInternal = ''; shwCourse = ''; }
               if (type == 2){ shwExternal = ''; shwCourse = ''; }
               if (type == 3){ shwMaster = ''; }
               if (type == 4){ shwProgram = ''; }
               document.getElementById('ShowInternal').style.display = shwInternal;
               document.getElementById('ShowExternal').style.display = shwExternal;
               document.getElementById('ShowCourse').style.display = shwCourse;
               document.getElementById('ShowMaster').style.display = shwMaster;
               document.getElementById('ShowProgram').style.display = shwProgram;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ToggleResult(){ 
               var type = document.getElementById('ResultType').value;
               if (type == 1) 
               {
                  document.getElementById('FormulaRow').style.display = '';
                  document.getElementById('CustomCodeRow').style.display = 'none';
               }   
               if (type == 2)
               {
                  document.getElementById('FormulaRow').style.display = 'none';
                  document.getElementById('CustomCodeRow').style.display = '';
               }   
               if (type == 3 || type == 4)
               {
                  document.getElementById('FormulaRow').style.display = 'none';
                  document.getElementById('CustomCodeRow').style.display = 'none';
                  document.getElementById('EditResultRow1').style.display = 'none';
                  document.getElementById('EditResultRow2').style.display = 'none';
                  document.getElementById('EditResultRow3').style.display = 'none';
               }   
               if (type != 3)
               {
                  document.getElementById('EditResultRow1').style.display = '';
                  document.getElementById('EditResultRow2').style.display = '';
                  document.getElementById('EditResultRow3').style.display = '';
               }   
              }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewCourse(){ 
               if (document.getElementById('Courses'))
                  {
                    var URL = "3219.asp?" + "courses=" + document.getElementById('Courses').value;
                    window.open( URL);
                  }
              }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewMaster(){ 
               if (document.getElementById('Assessments'))
                  {
                    var URL = "3119.asp?" + "assessments=" + document.getElementById('Assessments').value;
                    window.open( URL);
                  }
              }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">600</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">600</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Assessment']"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 's'))">
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">9202.asp?EntityID=31&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmentid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSASSESSMENT/@assessmentname,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">bottom</xsl:attribute>
                              <xsl:attribute name="class">PrevNext</xsl:attribute>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="href">3211.asp?AssessmentID=<xsl:value-of select="/DATA/PARAM/@assessmentid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessQuestions']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              <xsl:element name="A">
                                 <xsl:attribute name="onclick">w=window.open(this.href,"Certificate","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                 <xsl:attribute name="href">3106.asp?AssessmentID=<xsl:value-of select="/DATA/PARAM/@assessmentid"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certificate']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">smbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Validate']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@validate != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/PARAM/@validate" disable-output-escaping="yes"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessmentHelpText']"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessmentName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">AssessmentName</xsl:attribute>
                              <xsl:attribute name="id">AssessmentName</xsl:attribute>
                              <xsl:attribute name="size">60</xsl:attribute>
                              <xsl:attribute name="maxlength">60</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmentname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessType']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">AssessType</xsl:attribute>
                                    <xsl:attribute name="id">AssessType</xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSASSESSMENT/PTSASSESSTYPES/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
                              </xsl:element>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">AssessLevel</xsl:attribute>
                                    <xsl:attribute name="id">AssessLevel</xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSASSESSMENT/PTSASSESSLEVELS/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
                              </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessLength']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">AssessLength</xsl:attribute>
                                 <xsl:attribute name="id">AssessLength</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assesslength"/></xsl:attribute>
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
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rating']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Rating</xsl:attribute>
                                 <xsl:attribute name="id">Rating</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@rating"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 (1-10)
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AssessType</xsl:attribute>
                              <xsl:attribute name="id">AssessType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assesstype"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AssessLevel</xsl:attribute>
                              <xsl:attribute name="id">AssessLevel</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assesslevel"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AssessLength</xsl:attribute>
                              <xsl:attribute name="id">AssessLength</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assesslength"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Rating</xsl:attribute>
                              <xsl:attribute name="id">Rating</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@rating"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessDate']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">AssessDate</xsl:attribute>
                              <xsl:attribute name="id">AssessDate</xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessdate"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('AssessDate'))</xsl:attribute>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Status</xsl:attribute>
                                 <xsl:attribute name="id">Status</xsl:attribute>
                                 <xsl:for-each select="/DATA/TXN/PTSASSESSMENT/PTSSTATUSS/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           <xsl:element name="IMG">
                              <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                              <xsl:attribute name="alt">Required Field</xsl:attribute>
                           </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup != 51) and (/DATA/SYSTEM/@usergroup != 52)">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrivateAssessment']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup != 51) and (/DATA/SYSTEM/@usergroup != 52)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CompanyID</xsl:attribute>
                                 <xsl:attribute name="id">CompanyID</xsl:attribute>
                                 <xsl:attribute name="size">4</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@companyid"/></xsl:attribute>
                              </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Status</xsl:attribute>
                              <xsl:attribute name="id">Status</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@status"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@companyid"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 21)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrainerID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">TrainerID</xsl:attribute>
                                 <xsl:attribute name="id">TrainerID</xsl:attribute>
                                 <xsl:attribute name="size">4</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@trainerid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">IsPaid</xsl:attribute>
                                 <xsl:attribute name="id">IsPaid</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@ispaid = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsPaid']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                  - 
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ScoreFactor']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">ScoreFactor</xsl:attribute>
                                 <xsl:attribute name="id">ScoreFactor</xsl:attribute>
                                 <xsl:attribute name="size">4</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@scorefactor"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 21)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">TrainerID</xsl:attribute>
                              <xsl:attribute name="id">TrainerID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@trainerid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsPaid</xsl:attribute>
                              <xsl:attribute name="id">IsPaid</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@ispaid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ScoreFactor</xsl:attribute>
                              <xsl:attribute name="id">ScoreFactor</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@scorefactor"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">IsTrial</xsl:attribute>
                              <xsl:attribute name="id">IsTrial</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@istrial = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsTrial']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">IsCertify</xsl:attribute>
                              <xsl:attribute name="id">IsCertify</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@iscertify = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsCertify']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                               - 
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Grade']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Grade</xsl:attribute>
                              <xsl:attribute name="id">Grade</xsl:attribute>
                              <xsl:attribute name="size">2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@grade"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Points']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Points</xsl:attribute>
                              <xsl:attribute name="id">Points</xsl:attribute>
                              <xsl:attribute name="size">2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@points"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">IsCustomCertificate</xsl:attribute>
                              <xsl:attribute name="id">IsCustomCertificate</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@iscustomcertificate = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsCustomCertificate']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">NoCertificate</xsl:attribute>
                              <xsl:attribute name="id">NoCertificate</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@nocertificate = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoCertificate']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TimeLimit']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">TimeLimit</xsl:attribute>
                              <xsl:attribute name="id">TimeLimit</xsl:attribute>
                              <xsl:attribute name="size">2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@timelimit"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='minutes']"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
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
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">Description</xsl:attribute>
                                 <xsl:attribute name="id">Description</xsl:attribute>
                                 <xsl:attribute name="rows">10</xsl:attribute>
                                 <xsl:attribute name="cols">72</xsl:attribute>
                                 <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>500) {doMaxLenMsg(500); value=value.substring(0,500);}]]></xsl:text></xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@description"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusTypeText']"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessmentType']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">AssessmentType</xsl:attribute>
                                    <xsl:attribute name="id">AssessmentType</xsl:attribute>
                                    <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSASSESSMENT/PTSASSESSMENTTYPES/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                       </xsl:element>
                                    </xsl:for-each>
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

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AssessmentType</xsl:attribute>
                              <xsl:attribute name="id">AssessmentType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmenttype"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="id">ShowInternal</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FirstQuestionText']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FirstQuestionCode']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">FirstQuestionCode</xsl:attribute>
                                          <xsl:attribute name="id">FirstQuestionCode</xsl:attribute>
                                          <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@firstquestioncode"/></xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResultText']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResultType']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">ResultType</xsl:attribute>
                                             <xsl:attribute name="id">ResultType</xsl:attribute>
                                             <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleResult();]]></xsl:text></xsl:attribute>
                                             <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@resulttype"/></xsl:variable>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sum']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">2</xsl:attribute>
                                                <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Custom']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">3</xsl:attribute>
                                                <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Decision']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">4</xsl:attribute>
                                                <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Self']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">FormulaRow</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Formula']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="TEXTAREA">
                                             <xsl:attribute name="name">Formula</xsl:attribute>
                                             <xsl:attribute name="id">Formula</xsl:attribute>
                                             <xsl:attribute name="rows">2</xsl:attribute>
                                             <xsl:attribute name="cols">50</xsl:attribute>
                                             <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>100) {doMaxLenMsg(100); value=value.substring(0,100);}]]></xsl:text></xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@formula"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">CustomCodeRow</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomCode']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">CustomCode</xsl:attribute>
                                          <xsl:attribute name="id">CustomCode</xsl:attribute>
                                          <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@customcode"/></xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditInstruction']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(4,"")</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
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
                                       <xsl:attribute name="id">EditResultRow1</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">EditResultRow2</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditResult']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
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
                                       <xsl:attribute name="id">EditResultRow3</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/TXN/PTSRESULT/DATA/comment()" disable-output-escaping="yes"/>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="id">ShowExternal</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExternalText']"/>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewURL']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="TEXTAREA">
                                             <xsl:attribute name="name">NewURL</xsl:attribute>
                                             <xsl:attribute name="id">NewURL</xsl:attribute>
                                             <xsl:attribute name="rows">3</xsl:attribute>
                                             <xsl:attribute name="cols">70</xsl:attribute>
                                             <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>200) {doMaxLenMsg(200); value=value.substring(0,200);}]]></xsl:text></xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@newurl"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditURL']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="TEXTAREA">
                                             <xsl:attribute name="name">EditURL</xsl:attribute>
                                             <xsl:attribute name="id">EditURL</xsl:attribute>
                                             <xsl:attribute name="rows">2</xsl:attribute>
                                             <xsl:attribute name="cols">70</xsl:attribute>
                                             <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>200) {doMaxLenMsg(200); value=value.substring(0,200);}]]></xsl:text></xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@editurl"/>
                                          </xsl:element>
                                       </xsl:element>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TakesText']"/>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Takes']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Takes</xsl:attribute>
                              <xsl:attribute name="id">Takes</xsl:attribute>
                              <xsl:attribute name="size">2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@takes"/></xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DelayText']"/>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delay']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Delay</xsl:attribute>
                              <xsl:attribute name="id">Delay</xsl:attribute>
                              <xsl:attribute name="size">2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@delay"/></xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="id">ShowCourse</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessCoursesText']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessCourses']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Courses</xsl:attribute>
                                          <xsl:attribute name="id">Courses</xsl:attribute>
                                          <xsl:attribute name="size">50</xsl:attribute>
                                          <xsl:attribute name="maxlength">50</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@courses"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ViewCourse();]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="id">ShowMaster</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessMasterText']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessMaster']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Assessments</xsl:attribute>
                                          <xsl:attribute name="id">Assessments</xsl:attribute>
                                          <xsl:attribute name="size">50</xsl:attribute>
                                          <xsl:attribute name="maxlength">50</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessments"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ViewMaster();]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="id">ShowProgram</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessProgramText']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessProgram']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Program</xsl:attribute>
                                          <xsl:attribute name="id">Program</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@program"/></xsl:attribute>
                                          <xsl:attribute name="size">20</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
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
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(2,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmDelete']"/>')</xsl:attribute>
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