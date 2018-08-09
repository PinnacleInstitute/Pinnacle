<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:value-of select="/DATA/TXN/TOP/comment()" disable-output-escaping="yes"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Profile</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">48</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:value-of select="/DATA/TXN/PTSCOVER/DATA/comment()" disable-output-escaping="yes"/>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@print != 0)">
               <xsl:element name="DIV">
                  <xsl:attribute name="id">1</xsl:attribute>
                  <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
               </xsl:element>
            </xsl:if>
            <xsl:if test="(/DATA/PARAM/@detail != 0)">
                  <xsl:element name="TABLE">
                     <xsl:attribute name="border">0</xsl:attribute>
                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSCONGRATS/DATA/comment()" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@print = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                  </xsl:element>
               <xsl:if test="(/DATA/PARAM/@print != 0)">
                  <xsl:element name="DIV">
                     <xsl:attribute name="id">1</xsl:attribute>
                     <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                  </xsl:element>
               </xsl:if>
            </xsl:if>
               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:value-of select="/DATA/TXN/PTSCONTENTS/DATA/comment()" disable-output-escaping="yes"/>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@print != 0)">
               <xsl:element name="DIV">
                  <xsl:attribute name="id">1</xsl:attribute>
                  <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
               </xsl:element>
            </xsl:if>
               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:value-of select="/DATA/TXN/PTSTHINKING/DATA/comment()" disable-output-escaping="yes"/>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@print != 0)">
               <xsl:element name="DIV">
                  <xsl:attribute name="id">1</xsl:attribute>
                  <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
               </xsl:element>
            </xsl:if>
               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="IMG">
                              <xsl:attribute name="src"><xsl:value-of select="/DATA/PARAM/@samplegraphpath"/><xsl:value-of select="/DATA/PARAM/@samplegraphname"/></xsl:attribute>
                              <xsl:attribute name="border">0</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@print != 0)">
               <xsl:element name="DIV">
                  <xsl:attribute name="id">1</xsl:attribute>
                  <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
               </xsl:element>
            </xsl:if>
               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
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
                              <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              -
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThinkingGraph']"/>
                        </xsl:element>
                     </xsl:element>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:element name="b">
                           <xsl:element name="font">
                              <xsl:attribute name="size">2</xsl:attribute>
                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourPerspective']"/>
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

                     <xsl:variable name="MiniVQI"><xsl:value-of select="concat('Mini-VQ-I-', /DATA/TXN/PTSPROFILE/@vqclarity_i, '-', /DATA/TXN/PTSPROFILE/@vqbias_i)"/></xsl:variable>

                     <xsl:variable name="MiniVQE"><xsl:value-of select="concat('Mini-VQ-E-', /DATA/TXN/PTSPROFILE/@vqclarity_e, '-', /DATA/TXN/PTSPROFILE/@vqbias_e)"/></xsl:variable>

                     <xsl:variable name="MiniVQS"><xsl:value-of select="concat('Mini-VQ-S-', /DATA/TXN/PTSPROFILE/@vqclarity_s, '-', /DATA/TXN/PTSPROFILE/@vqbias_s)"/></xsl:variable>

                     <xsl:variable name="MiniSQI"><xsl:value-of select="concat('Mini-SQ-I-', /DATA/TXN/PTSPROFILE/@sqclarity_i, '-', /DATA/TXN/PTSPROFILE/@sqbias_i)"/></xsl:variable>

                     <xsl:variable name="MiniSQE"><xsl:value-of select="concat('Mini-SQ-E-', /DATA/TXN/PTSPROFILE/@sqclarity_e, '-', /DATA/TXN/PTSPROFILE/@sqbias_e)"/></xsl:variable>

                     <xsl:variable name="MiniSQS"><xsl:value-of select="concat('Mini-SQ-S-', /DATA/TXN/PTSPROFILE/@sqclarity_s, '-', /DATA/TXN/PTSPROFILE/@sqbias_s)"/></xsl:variable>

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
                                       <xsl:attribute name="width">600</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">12</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">138</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">600</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                       <xsl:element name="TABLE">
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="cellpadding">0</xsl:attribute>
                                          <xsl:attribute name="cellspacing">0</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">600</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">600</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="TABLE">
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="cellpadding">5</xsl:attribute>
                                                      <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                      <xsl:attribute name="width">600</xsl:attribute>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">24</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="b">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Empathy']"/>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="b">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Practical']"/>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="b">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Structured']"/>
                                                               </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">24</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 8pt</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$MiniVQI]"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 8pt</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$MiniVQE]"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 8pt</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$MiniVQS]"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="id">vqclarity</xsl:attribute>
                                                                  <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@vqileft"/>px; top:<xsl:value-of select="/DATA/PARAM/@vqitop"/>px; z-index:1;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqclarity_i"/>.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="id">vqclarity</xsl:attribute>
                                                                  <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@vqeleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@vqetop"/>px; z-index:1;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqclarity_e"/>.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="id">vqclarity</xsl:attribute>
                                                                  <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@vqsleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@vqstop"/>px; z-index:1;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqclarity_s"/>.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">10</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">3</xsl:attribute>
                                                               <xsl:attribute name="width">600</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size:10pt; color:white; background:#085d8d;</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='WorldView']"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">36</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 9pt; background: #89c8ec; font-weight:bold;</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Relator']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 9pt; background: #89c8ec; font-weight:bold;</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Doer']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 9pt; background: #89c8ec; font-weight:bold;</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Thinker']"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">10</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">3</xsl:attribute>
                                                               <xsl:attribute name="width">600</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size:10pt; color:white; background:#085d8d;</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelfView']"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="id">sqclarity</xsl:attribute>
                                                                  <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@sqileft"/>px; top:<xsl:value-of select="/DATA/PARAM/@sqitop"/>px; z-index:1;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqclarity_i"/>.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="id">sqclarity</xsl:attribute>
                                                                  <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@sqeleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@sqetop"/>px; z-index:1;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqclarity_e"/>.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               <xsl:element name="DIV">
                                                                  <xsl:attribute name="id">sqclarity</xsl:attribute>
                                                                  <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@sqsleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@sqstop"/>px; z-index:1;</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqclarity_s"/>.png</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">24</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="b">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelfEmpathy']"/>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="b">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RoleAwareness']"/>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="b">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelfDirection']"/>
                                                               </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">24</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 8pt</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$MiniSQI]"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 8pt</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$MiniSQE]"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">200</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:attribute name="style">font-size: 8pt</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$MiniSQS]"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>

                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">12</xsl:attribute>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">138</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="TABLE">
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="cellpadding">0</xsl:attribute>
                                          <xsl:attribute name="cellspacing">0</xsl:attribute>
                                          <xsl:attribute name="width">138</xsl:attribute>

                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">138</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
                                                   <xsl:element name="TABLE">
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                      <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                      <xsl:attribute name="width">138</xsl:attribute>
                                                      <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">138</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="TABLE">
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                  <xsl:attribute name="width">138</xsl:attribute>

                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">50</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">88</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
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
                                                                           <xsl:attribute name="width">50</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity5.png</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">88</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Outstanding']"/>
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
                                                                           <xsl:attribute name="width">50</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity4.png</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">88</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Excellent']"/>
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
                                                                           <xsl:attribute name="width">50</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity3.png</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">88</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='VeryGood']"/>
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
                                                                           <xsl:attribute name="width">50</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity2.png</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">88</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Good']"/>
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
                                                                           <xsl:attribute name="width">50</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity1.png</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">88</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fair']"/>
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
                                                                           <xsl:attribute name="width">50</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity0.png</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">88</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Unclear']"/>
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
                                                         </xsl:element>

                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">1</xsl:attribute>
                                                   <xsl:attribute name="height">24</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>

                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">138</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="TABLE">
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="cellpadding">3</xsl:attribute>
                                                      <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                      <xsl:attribute name="width">138</xsl:attribute>
                                                      <xsl:attribute name="style">font-size: 8pt; text-align: center; border: 1px #5084A2 solid; border-collapse:collapse</xsl:attribute>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">middle</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Part1']"/>
                                                                  </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">middle</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Part2']"/>
                                                                  </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Dif']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Dim%']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Int-I']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Int-E']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Int-S']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Int']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Int%']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DI']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Dis']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqdiff"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="concat(/DATA/TXN/PTSPROFILE/@vqdimperc, '%')"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqintcate_i"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqintcate_e"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqintcate_s"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqint"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="concat(/DATA/TXN/PTSPROFILE/@vqintperc, '%')"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqdi"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqdis"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqdiff"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="concat(/DATA/TXN/PTSPROFILE/@sqdimperc, '%')"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqintcate_i"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqintcate_e"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqintcate_s"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqint"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="concat(/DATA/TXN/PTSPROFILE/@sqintperc, '%')"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqdi"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqdis"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='VQ']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SQ']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BQr']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BQa']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CQ']"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RQ']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">2</xsl:attribute>
                                                               <xsl:attribute name="width">92</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqleft"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  -
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqright"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqleft"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  -
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqright"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@bqrleft"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  -
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@bqrright"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@bqaleft"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  -
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@bqaright"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@cqleft"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  -
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@cqright"/>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@rqleft"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  -
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROFILE/@rqright"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AI%']"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="concat(/DATA/TXN/PTSPROFILE/@vqai, '%')"/>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">46</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                                                                  <xsl:value-of select="concat(/DATA/TXN/PTSPROFILE/@sqai, '%')"/>
                                                            </xsl:element>
                                                         </xsl:element>

                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>

                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:element>
                        </xsl:element>
                     </xsl:element>

               </xsl:element>
               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
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
                              <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>
                           <xsl:value-of select="/DATA/TXN/PTSDEFINITIONS/DATA/comment()" disable-output-escaping="yes"/>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@print != 0)">
               <xsl:element name="DIV">
                  <xsl:attribute name="id">1</xsl:attribute>
                  <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
               </xsl:element>
            </xsl:if>
            <xsl:variable name="BiasVQI"><xsl:value-of select="concat('Bias-VQ-I-', /DATA/TXN/PTSPROFILE/@vqclarity_i, '-', /DATA/TXN/PTSPROFILE/@vqbias_i)"/></xsl:variable>

            <xsl:variable name="BiasVQE"><xsl:value-of select="concat('Bias-VQ-E-', /DATA/TXN/PTSPROFILE/@vqclarity_e, '-', /DATA/TXN/PTSPROFILE/@vqbias_e)"/></xsl:variable>

            <xsl:variable name="BiasVQS"><xsl:value-of select="concat('Bias-VQ-S-', /DATA/TXN/PTSPROFILE/@vqclarity_s, '-', /DATA/TXN/PTSPROFILE/@vqbias_s)"/></xsl:variable>

            <xsl:variable name="BiasSQI"><xsl:value-of select="concat('Bias-SQ-I-', /DATA/TXN/PTSPROFILE/@sqclarity_i, '-', /DATA/TXN/PTSPROFILE/@sqbias_i)"/></xsl:variable>

            <xsl:variable name="BiasSQE"><xsl:value-of select="concat('Bias-SQ-E-', /DATA/TXN/PTSPROFILE/@sqclarity_e, '-', /DATA/TXN/PTSPROFILE/@sqbias_e)"/></xsl:variable>

            <xsl:variable name="BiasSQS"><xsl:value-of select="concat('Bias-SQ-S-', /DATA/TXN/PTSPROFILE/@sqclarity_s, '-', /DATA/TXN/PTSPROFILE/@sqbias_s)"/></xsl:variable>

               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
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
                              <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                              <xsl:element name="BR"/>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='WorldThinkingDescription']"/>
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
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Empathy']"/>
                                          </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="BR"/><xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$BiasVQI]"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="id">vqclarity</xsl:attribute>
                                          <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@vqileft"/>px; top:<xsl:value-of select="/DATA/PARAM/@vqitop"/>px; z-index:1;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqclarity_i"/>.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
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
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Practical']"/>
                                          </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="BR"/><xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$BiasVQE]"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="id">vqclarity</xsl:attribute>
                                          <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@vqeleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@vqetop"/>px; z-index:1;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqclarity_e"/>.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
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
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Structured']"/>
                                          </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="BR"/><xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$BiasVQS]"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="id">vqclarity</xsl:attribute>
                                          <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@vqsleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@vqstop"/>px; z-index:1;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@vqclarity_s"/>.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@print != 0)">
               <xsl:element name="DIV">
                  <xsl:attribute name="id">1</xsl:attribute>
                  <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
               </xsl:element>
            </xsl:if>
               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
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
                              <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                              <xsl:element name="BR"/>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelfThinkingDescription']"/>
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
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelfEmpathy']"/>
                                          </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="BR"/><xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$BiasSQI]"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="id">sqclarity</xsl:attribute>
                                          <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@sqileft"/>px; top:<xsl:value-of select="/DATA/PARAM/@sqitop"/>px; z-index:1;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqclarity_i"/>.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
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
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RoleAwareness']"/>
                                          </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="BR"/><xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$BiasSQE]"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="id">sqclarity</xsl:attribute>
                                          <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@sqeleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@sqetop"/>px; z-index:1;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqclarity_e"/>.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
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
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">670</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelfDirection']"/>
                                          </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="BR"/><xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$BiasSQS]"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">80</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">position:relative; width:77px;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/GraphLine.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="id">sqclarity</xsl:attribute>
                                          <xsl:attribute name="style">position:absolute; left:<xsl:value-of select="/DATA/PARAM/@sqsleft"/>px; top:<xsl:value-of select="/DATA/PARAM/@sqstop"/>px; z-index:1;</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/Clarity<xsl:value-of select="/DATA/TXN/PTSPROFILE/@sqclarity_s"/>.png</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:element>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                     </xsl:if>

               </xsl:element>
            <xsl:if test="(/DATA/PARAM/@print != 0)">
               <xsl:element name="DIV">
                  <xsl:attribute name="id">1</xsl:attribute>
                  <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
               </xsl:element>
            </xsl:if>
            <xsl:if test="(/DATA/PARAM/@detail != 0)">
                  <xsl:element name="TABLE">
                     <xsl:attribute name="border">0</xsl:attribute>
                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSSTRENGTH/DATA/comment()" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@print = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                  </xsl:element>
               <xsl:if test="(/DATA/PARAM/@print != 0)">
                  <xsl:element name="DIV">
                     <xsl:attribute name="id">1</xsl:attribute>
                     <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                  </xsl:element>
               </xsl:if>
               <xsl:variable name="StrgVQI"><xsl:value-of select="concat('Strg-VQ-I-', /DATA/TXN/PTSPROFILE/@vqclarity_i, '-', /DATA/TXN/PTSPROFILE/@vqbias_i)"/></xsl:variable>

               <xsl:variable name="StrgVQE"><xsl:value-of select="concat('Strg-VQ-E-', /DATA/TXN/PTSPROFILE/@vqclarity_e, '-', /DATA/TXN/PTSPROFILE/@vqbias_e)"/></xsl:variable>

               <xsl:variable name="StrgVQS"><xsl:value-of select="concat('Strg-VQ-S-', /DATA/TXN/PTSPROFILE/@vqclarity_s, '-', /DATA/TXN/PTSPROFILE/@vqbias_s)"/></xsl:variable>

               <xsl:variable name="StrgSQI"><xsl:value-of select="concat('Strg-SQ-I-', /DATA/TXN/PTSPROFILE/@sqclarity_i, '-', /DATA/TXN/PTSPROFILE/@sqbias_i)"/></xsl:variable>

               <xsl:variable name="StrgSQE"><xsl:value-of select="concat('Strg-SQ-E-', /DATA/TXN/PTSPROFILE/@sqclarity_e, '-', /DATA/TXN/PTSPROFILE/@sqbias_e)"/></xsl:variable>

               <xsl:variable name="StrgSQS"><xsl:value-of select="concat('Strg-SQ-S-', /DATA/TXN/PTSPROFILE/@sqclarity_s, '-', /DATA/TXN/PTSPROFILE/@sqbias_s)"/></xsl:variable>

               <xsl:variable name="TextStrgVQI"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$StrgVQI]"/></xsl:variable>

               <xsl:variable name="TextStrgVQE"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$StrgVQE]"/></xsl:variable>

               <xsl:variable name="TextStrgVQS"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$StrgVQS]"/></xsl:variable>

               <xsl:variable name="TextStrgSQI"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$StrgSQI]"/></xsl:variable>

               <xsl:variable name="TextStrgSQE"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$StrgSQE]"/></xsl:variable>

               <xsl:variable name="TextStrgSQS"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$StrgSQS]"/></xsl:variable>

                  <xsl:element name="TABLE">
                     <xsl:attribute name="border">0</xsl:attribute>
                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
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
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NaturalSources']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="($TextStrgVQI != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextStrgVQI" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextStrgVQE != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextStrgVQE" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextStrgVQS != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextStrgVQS" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextStrgSQI != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextStrgSQI" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextStrgSQE != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextStrgSQE" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextStrgSQS != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextStrgSQS" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@print = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                  </xsl:element>
               <xsl:if test="(/DATA/PARAM/@print != 0)">
                  <xsl:element name="DIV">
                     <xsl:attribute name="id">1</xsl:attribute>
                     <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                  </xsl:element>
               </xsl:if>
                  <xsl:element name="TABLE">
                     <xsl:attribute name="border">0</xsl:attribute>
                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSWEAKNESS/DATA/comment()" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@print = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                  </xsl:element>
               <xsl:if test="(/DATA/PARAM/@print != 0)">
                  <xsl:element name="DIV">
                     <xsl:attribute name="id">1</xsl:attribute>
                     <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                  </xsl:element>
               </xsl:if>
               <xsl:variable name="WeakVQI"><xsl:value-of select="concat('Weak-VQ-I-', /DATA/TXN/PTSPROFILE/@vqclarity_i, '-', /DATA/TXN/PTSPROFILE/@vqbias_i)"/></xsl:variable>

               <xsl:variable name="WeakVQE"><xsl:value-of select="concat('Weak-VQ-E-', /DATA/TXN/PTSPROFILE/@vqclarity_e, '-', /DATA/TXN/PTSPROFILE/@vqbias_e)"/></xsl:variable>

               <xsl:variable name="WeakVQS"><xsl:value-of select="concat('Weak-VQ-S-', /DATA/TXN/PTSPROFILE/@vqclarity_s, '-', /DATA/TXN/PTSPROFILE/@vqbias_s)"/></xsl:variable>

               <xsl:variable name="WeakSQI"><xsl:value-of select="concat('Weak-SQ-I-', /DATA/TXN/PTSPROFILE/@sqclarity_i, '-', /DATA/TXN/PTSPROFILE/@sqbias_i)"/></xsl:variable>

               <xsl:variable name="WeakSQE"><xsl:value-of select="concat('Weak-SQ-E-', /DATA/TXN/PTSPROFILE/@sqclarity_e, '-', /DATA/TXN/PTSPROFILE/@sqbias_e)"/></xsl:variable>

               <xsl:variable name="WeakSQS"><xsl:value-of select="concat('Weak-SQ-S-', /DATA/TXN/PTSPROFILE/@sqclarity_s, '-', /DATA/TXN/PTSPROFILE/@sqbias_s)"/></xsl:variable>

               <xsl:variable name="TextWeakVQI"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$WeakVQI]"/></xsl:variable>

               <xsl:variable name="TextWeakVQE"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$WeakVQE]"/></xsl:variable>

               <xsl:variable name="TextWeakVQS"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$WeakVQS]"/></xsl:variable>

               <xsl:variable name="TextWeakSQI"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$WeakSQI]"/></xsl:variable>

               <xsl:variable name="TextWeakSQE"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$WeakSQE]"/></xsl:variable>

               <xsl:variable name="TextWeakSQS"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$WeakSQS]"/></xsl:variable>

                  <xsl:element name="TABLE">
                     <xsl:attribute name="border">0</xsl:attribute>
                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
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
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PotentialInterferers']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="($TextWeakVQI != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextWeakVQI" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextWeakVQE != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextWeakVQE" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextWeakVQS != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextWeakVQS" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextWeakSQI != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextWeakSQI" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextWeakSQE != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextWeakSQE" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="($TextWeakSQS != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="$TextWeakSQS" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@print = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                  </xsl:element>
               <xsl:if test="(/DATA/PARAM/@print != 0)">
                  <xsl:element name="DIV">
                     <xsl:attribute name="id">1</xsl:attribute>
                     <xsl:attribute name="style">page-break-after:always</xsl:attribute>
                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                  </xsl:element>
               </xsl:if>
            </xsl:if>
               <xsl:element name="TABLE">
                  <xsl:attribute name="border">0</xsl:attribute>
                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                  <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="colspan">1</xsl:attribute>
                           <xsl:attribute name="height">24</xsl:attribute>
                        </xsl:element>
                     </xsl:element>
                     <xsl:element name="TR">
                        <xsl:element name="TD">
                           <xsl:attribute name="width">750</xsl:attribute>
                           <xsl:attribute name="align">left</xsl:attribute>
                           <xsl:attribute name="valign">center</xsl:attribute>
                           <xsl:value-of select="/DATA/TXN/PTSACTIONPLAN/DATA/comment()" disable-output-escaping="yes"/>
                        </xsl:element>
                     </xsl:element>

                     <xsl:if test="(/DATA/PARAM/@print = 0)">
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
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
                     </xsl:if>

               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
            </xsl:element>
            <!--END FORM-->

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
      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <![CDATA[function doSubmit(iAction, sMsg){document.Profile.elements['ActionCode'].value=iAction;document.Profile.submit();}]]>
         <![CDATA[function doErrorMsg(sError){alert(sError);}]]>
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