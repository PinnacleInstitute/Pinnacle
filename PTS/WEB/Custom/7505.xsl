<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
   <xsl:include href="PageFooter.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:variable name="usergroup" select="/DATA/SYSTEM/@usergroup"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'Copy Project'"/>
         <xsl:with-param name="includecalendar" select="false()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
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
               <xsl:attribute name="onload"></xsl:attribute>
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
               <xsl:attribute name="name">Project</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">140</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">600</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">3</xsl:attribute>
                     <xsl:call-template name="PageHeader"/>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="align">right</xsl:attribute>
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">140</xsl:attribute>
                  </xsl:element>

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
                              <xsl:attribute name="width">600</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">5</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProjectCopy']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/TXN/PTSPROJECT/@projectname"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">2</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSPROJECT/@description"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">2</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProjectCopyText']"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copy']"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">ProjectName</xsl:attribute>
                              <xsl:attribute name="id">ProjectName</xsl:attribute>
                              <xsl:attribute name="size">60</xsl:attribute>
                              <xsl:attribute name="maxlength">60</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROJECT/@projectname"/></xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludeMembers']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:for-each select="/DATA/TXN/PTSPROJECTMEMBERS/PTSPROJECTMEMBER">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">checkbox</xsl:attribute>
                                       <xsl:attribute name="name">M<xsl:value-of select="@projectmemberid"/></xsl:attribute>
                                       <xsl:attribute name="id">M<xsl:value-of select="@projectmemberid"/></xsl:attribute>
                                       <xsl:attribute name="CHECKED"/>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="@membername"/>
                                 </xsl:element>
                              </xsl:element>
                        </xsl:for-each>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludeTasks']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
								<xsl:call-template name="Tasks">
									<xsl:with-param name="ProjectID" select="/DATA/PARAM/@projectid"/>			
									<xsl:with-param name="Indent">0</xsl:with-param>			
								</xsl:call-template>

                        <xsl:for-each select="/DATA/TXN/PTSPROJECTS/PTSPROJECT[(@parentid = /DATA/PARAM/@projectid)]">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">checkbox</xsl:attribute>
                                       <xsl:attribute name="name">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                       <xsl:attribute name="id">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                       <xsl:attribute name="CHECKED"/>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="@projectname"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

										<xsl:call-template name="Tasks">
											<xsl:with-param name="ProjectID" select="@projectid"/>			
											<xsl:with-param name="Indent">1</xsl:with-param>			
										</xsl:call-template>

                              <xsl:for-each select="/DATA/TXN/PTSPROJECTS/PTSPROJECT[(@parentid = current()/@projectid)]">
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
														<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent">1</xsl:with-param></xsl:call-template>
                                          <xsl:element name="b">
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">checkbox</xsl:attribute>
                                             <xsl:attribute name="name">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                             <xsl:attribute name="id">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                             <xsl:attribute name="CHECKED"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="@projectname"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

												<xsl:call-template name="Tasks">
													<xsl:with-param name="ProjectID" select="@projectid"/>			
													<xsl:with-param name="Indent">2</xsl:with-param>			
												</xsl:call-template>

                                    <xsl:for-each select="/DATA/TXN/PTSPROJECTS/PTSPROJECT[(@parentid = current()/@projectid)]">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">600</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
																<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent">2</xsl:with-param></xsl:call-template>
                                                <xsl:element name="b">
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">checkbox</xsl:attribute>
                                                   <xsl:attribute name="name">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                                   <xsl:attribute name="id">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                                   <xsl:attribute name="CHECKED"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@projectname"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

										<xsl:call-template name="Tasks">
											<xsl:with-param name="ProjectID" select="@projectid"/>			
											<xsl:with-param name="Indent">3</xsl:with-param>			
										</xsl:call-template>

                                          <xsl:for-each select="/DATA/TXN/PTSPROJECTS/PTSPROJECT[(@parentid = current()/@projectid)]">
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">600</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
																		<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent">3</xsl:with-param></xsl:call-template>
                                                      <xsl:element name="b">
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">checkbox</xsl:attribute>
                                                         <xsl:attribute name="name">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                                         <xsl:attribute name="id">P<xsl:value-of select="@projectid"/></xsl:attribute>
                                                         <xsl:attribute name="CHECKED"/>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="@projectname"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

												<xsl:call-template name="Tasks">
													<xsl:with-param name="ProjectID" select="@projectid"/>			
													<xsl:with-param name="Indent">4</xsl:with-param>			
												</xsl:call-template>

                                          </xsl:for-each>
                                    </xsl:for-each>
                              </xsl:for-each>
                        </xsl:for-each>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copy']"/>
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

                     </xsl:element>

                  </xsl:element>
                  <!--END CONTENT COLUMN-->

               </xsl:element>

               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">3</xsl:attribute>
                     <xsl:call-template name="PageFooter"/>
                  </xsl:element>
               </xsl:element>

            </xsl:element>
            <!--END FORM-->

         </xsl:element>
         <!--END PAGE-->

      </xsl:element>
      <!--END BODY-->

   </xsl:template>

   <xsl:template name="Tasks">
		<xsl:param name="ProjectID"/>
		<xsl:param name="Indent"/>
   
		<xsl:for-each select="/DATA/TXN/PTSTASKS/PTSTASK[(@projectid = $ProjectID) and (@parentid = 0)]">
				<xsl:element name="TR">
					<xsl:element name="TD">
						<xsl:attribute name="width">600</xsl:attribute>
						<xsl:attribute name="align">left</xsl:attribute>
						<xsl:attribute name="valign">center</xsl:attribute>
						<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent" select="$Indent"/></xsl:call-template>
						<xsl:element name="INPUT">
						<xsl:attribute name="type">checkbox</xsl:attribute>
						<xsl:attribute name="name">T<xsl:value-of select="@taskid"/></xsl:attribute>
						<xsl:attribute name="id">T<xsl:value-of select="@taskid"/></xsl:attribute>
						<xsl:attribute name="CHECKED"/>
						</xsl:element>
						<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
						<xsl:value-of select="@taskname"/>
					</xsl:element>
				</xsl:element>

				<xsl:for-each select="/DATA/TXN/PTSTASKS/PTSTASK[(@parentid = current()/@taskid)]">
						<xsl:element name="TR">
							<xsl:element name="TD">
								<xsl:attribute name="width">600</xsl:attribute>
								<xsl:attribute name="align">left</xsl:attribute>
								<xsl:attribute name="valign">center</xsl:attribute>
								<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent" select="$Indent"/></xsl:call-template>
								<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent">1</xsl:with-param></xsl:call-template>
								<xsl:element name="INPUT">
								<xsl:attribute name="type">checkbox</xsl:attribute>
								<xsl:attribute name="name">T<xsl:value-of select="@taskid"/></xsl:attribute>
								<xsl:attribute name="id">T<xsl:value-of select="@taskid"/></xsl:attribute>
								<xsl:attribute name="CHECKED"/>
								</xsl:element>
								<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
								<xsl:value-of select="@taskname"/>
							</xsl:element>
						</xsl:element>

						<xsl:for-each select="/DATA/TXN/PTSTASKS/PTSTASK[(@parentid = current()/@taskid)]">
								<xsl:element name="TR">
									<xsl:element name="TD">
										<xsl:attribute name="width">600</xsl:attribute>
										<xsl:attribute name="align">left</xsl:attribute>
										<xsl:attribute name="valign">center</xsl:attribute>
										<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent" select="$Indent"/></xsl:call-template>
											<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent">2</xsl:with-param></xsl:call-template>
										<xsl:element name="INPUT">
										<xsl:attribute name="type">checkbox</xsl:attribute>
										<xsl:attribute name="name">T<xsl:value-of select="@taskid"/></xsl:attribute>
										<xsl:attribute name="id">T<xsl:value-of select="@taskid"/></xsl:attribute>
										<xsl:attribute name="CHECKED"/>
										</xsl:element>
										<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
										<xsl:value-of select="@taskname"/>
									</xsl:element>
								</xsl:element>

								<xsl:for-each select="/DATA/TXN/PTSTASKS/PTSTASK[(@parentid = current()/@taskid)]">
										<xsl:element name="TR">
											<xsl:element name="TD">
												<xsl:attribute name="width">600</xsl:attribute>
												<xsl:attribute name="align">left</xsl:attribute>
												<xsl:attribute name="valign">center</xsl:attribute>
												<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent" select="$Indent"/></xsl:call-template>
												<xsl:call-template name="TaskIndent"><xsl:with-param name="Indent">3</xsl:with-param></xsl:call-template>
												<xsl:element name="INPUT">
												<xsl:attribute name="type">checkbox</xsl:attribute>
												<xsl:attribute name="name">T<xsl:value-of select="@taskid"/></xsl:attribute>
												<xsl:attribute name="id">T<xsl:value-of select="@taskid"/></xsl:attribute>
												<xsl:attribute name="CHECKED"/>
												</xsl:element>
												<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
												<xsl:value-of select="@taskname"/>
											</xsl:element>
										</xsl:element>

								</xsl:for-each>
						</xsl:for-each>
				</xsl:for-each>
		</xsl:for-each>
   </xsl:template>

	<xsl:template name="TaskIndent">
		<xsl:param name="Indent"/>
		<xsl:choose>
			<xsl:when test="$Indent='1'">
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$Indent='2'">
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$Indent='3'">
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$Indent='4'">
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>