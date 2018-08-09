<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="wtSystem.xsl"/>

  <xsl:template name="DefineMenu">
    <xsl:value-of select="$cr"/>
    <xsl:element name="SCRIPT">
      <xsl:attribute name="language">JavaScript</xsl:attribute>
      <xsl:apply-templates select="/DATA/MENU"/>
    </xsl:element>
    <xsl:value-of select="$cr"/>
  </xsl:template>

  <!--==================================================================-->
  <xsl:template match="MENU">
    <!--==================================================================-->
    <xsl:variable name="ind0" select="''"/>
    <xsl:variable name="ind1" select="$tab"/>
    <xsl:variable name="ind2" select="concat($ind1, $tab)"/>
    <xsl:variable name="ind3" select="concat($ind2, $tab)"/>

    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="@color"><xsl:value-of select="@color"/></xsl:when>
        <xsl:when test="@type='bar'">black</xsl:when>
        <xsl:otherwise>black</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bgcolor">
      <xsl:choose>
        <xsl:when test="@bgcolor and @bgcolor!=''"><xsl:value-of select="@bgcolor"/></xsl:when>
        <xsl:when test="@type='bar'">#E3E6FC</xsl:when>
        <xsl:otherwise>#6C86DC</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="top-bgcolor">
      <xsl:choose>
        <xsl:when test="@top-bgcolor"><xsl:value-of select="@top-bgcolor"/></xsl:when>
        <xsl:when test="@type='bar'">#265BCC</xsl:when>
        <xsl:otherwise>#265BCC</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="shadow-color">
      <xsl:choose>
        <xsl:when test="@shadow-color"><xsl:value-of select="@shadow-color"/></xsl:when>
        <xsl:when test="@type='bar'">silver</xsl:when>
        <xsl:otherwise>silver</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="shadow">
      <xsl:choose>
        <xsl:when test="@shadow"><xsl:value-of select="@shadow"/></xsl:when>
        <xsl:when test="@type='bar'">2</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bdcolor">
      <xsl:choose>
        <xsl:when test="@bdcolor"><xsl:value-of select="@bdcolor"/></xsl:when>
        <xsl:when test="@type='bar'">#ACA899</xsl:when>
        <xsl:otherwise>#ACA899</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="over-color">
      <xsl:choose>
        <xsl:when test="@over-color"><xsl:value-of select="@over-color"/></xsl:when>
        <xsl:when test="@type='bar'">black</xsl:when>
        <xsl:otherwise>black</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="over-bgcolor">
      <xsl:choose>
        <xsl:when test="@over-bgcolor"><xsl:value-of select="@over-bgcolor"/></xsl:when>
        <xsl:when test="@type='bar'">#B0BBD4</xsl:when>
        <xsl:otherwise>#B0BBD4</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="divider-color">
      <xsl:choose>
        <xsl:when test="@divider-color"><xsl:value-of select="@divider-color"/></xsl:when>
        <xsl:when test="@type='bar'">silver</xsl:when>
        <xsl:otherwise>silver</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="imgendon">
      <xsl:choose>
        <xsl:when test="@imgendon"><xsl:value-of select="@imgendon"/></xsl:when>
        <xsl:when test="@type='bar'"></xsl:when>
        <xsl:otherwise>arr_down2.gif</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="imgendoff">
      <xsl:choose>
        <xsl:when test="@imgendoff"><xsl:value-of select="@imgendoff"/></xsl:when>
        <xsl:when test="@type='bar'"></xsl:when>
        <xsl:otherwise>ar.gif</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="width">
      <xsl:if test="@width"><xsl:value-of select="@width"/></xsl:if>
      <xsl:if test="not(@width)">100</xsl:if>
    </xsl:variable>
    <xsl:variable name="height">
      <xsl:if test="@height"><xsl:value-of select="@height"/></xsl:if>
      <xsl:if test="not(@height)">20</xsl:if>
    </xsl:variable>
    <xsl:variable name="separatorwidth">
      <xsl:choose>
        <xsl:when test="@menuwidth"><xsl:value-of select="@menuwidth"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$width"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat($ind0, 'var ', @name, 'Def = {', $cr)"/>

    <xsl:if test="@type='bar'">
      <xsl:value-of select="concat($ind1, 'type:&quot;bar&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind1, 'style:{', $cr)"/>
      <xsl:value-of select="concat($ind2, 'css:&quot;top&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'bgcolor:&quot;', $top-bgcolor, '&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'size:[', $width, ',', $height, '],', $cr)"/>
      <xsl:value-of select="concat($ind2, 'imgspace:5,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'direction:&quot;h&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'itemoffset:{x:2,y:2},', $cr)"/>
      <!--
			<xsl:value-of select="concat($ind2, 'imgendoff:{src:&quot;img/top_arr_right.gif&quot;, width:16, 
height:16},', $cr)"/>
			<xsl:value-of select="concat($ind2, 'imgendon:{src:&quot;img/top_arr_down.gif&quot;, width:16, 
height:16},', $cr)"/>
-->
      <xsl:value-of select="concat($ind2, 'shadow:{color:&quot;', $shadow-color, '&quot;,width:', $shadow, 
'},', $cr)"/>
      <xsl:value-of select="concat($ind2, 'border:{color:&quot;', $bdcolor, '&quot;,width:1}', $cr)"/>
      <xsl:value-of select="concat($ind1, '},', $cr)"/>

      <xsl:value-of select="concat($ind1, 'itemover:{color:&quot;', $over-color, '&quot;,bgcolor:&quot;', 
$over-bgcolor, '&quot;},', $cr)"/>
      <xsl:value-of select="concat($ind1, 'separator:{style:{size:[', $separatorwidth, ',1],bgcolor:&quot;', 
$divider-color, '&quot;}},', $cr)"/>
      <xsl:value-of select="concat($ind1, 'position:{absolute:false},', $cr)"/>
    </xsl:if>

    <xsl:if test="@type='xpbar'">
      <xsl:value-of select="concat($ind1, 'style:{', $cr)"/>
      <xsl:value-of select="concat($ind2, 'css:&quot;bartitle&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'size:[140,25],', $cr)"/>
      <xsl:value-of select="concat($ind2, 'imgendoff:{src:&quot;img/arr_up.gif&quot;, width:24, height:24},', 
$cr)"/>
      <xsl:value-of select="concat($ind2, 'imgendon:{src:&quot;img/arr_down.gif&quot;, width:24, height:24},', 
$cr)"/>
      <xsl:value-of select="concat($ind2, 'imgspace:5,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'itemoffset:{x:2,y:5},', $cr)"/>
      <xsl:value-of select="concat($ind2, 'fixheight:700,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'bgcolor:&quot;', $bgcolor, '&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'shadow:{color:&quot;#C0C0C0&quot;,width:1}', $cr)"/>
      <!--			<xsl:value-of select="concat($ind2, 'border:{color:&quot;black&quot;,width:1}', $cr)"/>-->
      <xsl:value-of select="concat($ind1, '},', $cr)"/>
      <xsl:value-of select="concat($ind1, 'imgblank:&quot;img/1x1.gif&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind1, 'itemover:{', $cr)"/>
      <xsl:value-of select="concat($ind2, 'css:&quot;bartitle&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'size:[140,25],', $cr)"/>
      <xsl:value-of select="concat($ind2, 'imgendoff:{src:&quot;img/arr_up_over.gif&quot;, width:24, height:24},', $cr)"/>
      <xsl:value-of select="concat($ind2, 'imgendon:{src:&quot;img/arr_down_over.gif&quot;, width:24, height:24},', $cr)"/>
      <xsl:value-of select="concat($ind2, 'bgimg:&quot;img/title_bg_140.gif&quot;', $cr)"/>
      <xsl:value-of select="concat($ind1, '},', $cr)"/>
      <xsl:value-of select="concat($ind1, 'itemon:{color:&quot;white&quot;,bgcolor:&quot;#265BCC&quot;},', $cr)"/>
      <xsl:value-of select="concat($ind1, 'scroller:{', $cr)"/>
      <xsl:value-of select="concat($ind2, 'style:{', $cr)"/>
      <xsl:value-of select="concat($ind3, 'css:&quot;bartitlecenter&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind3, 'align:&quot;center&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind3, 'size:[140,18],', $cr)"/>
      <xsl:value-of select="concat($ind3, 'bgcolor:&quot;white&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind3, 'opacity:60', $cr)"/>
      <xsl:value-of select="concat($ind2, '},', $cr)"/>
      <xsl:value-of select="concat($ind2, 'styleover:{', $cr)"/>
      <xsl:value-of select="concat($ind3, 'css:&quot;bartitlecenter&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind3, 'align:&quot;center&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind3, 'size:[140,80],', $cr)"/>
      <xsl:value-of select="concat($ind3, 'bgcolor:&quot;white&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind3, 'opacity:60', $cr)"/>
      <xsl:value-of select="concat($ind2, '},', $cr)"/>
      <xsl:value-of select="concat($ind2, 'up:&quot;img/scroller_up.gif&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'down:&quot;img/scroller_down.gif&quot;,', $cr)"/>
      <xsl:value-of select="concat($ind2, 'len:60, step:5, time:30', $cr)"/>
      <xsl:value-of select="concat($ind1, '},', $cr)"/>
      <xsl:value-of select="concat($ind1, 'position:{pos:[0,0],absolute:false},', $cr)"/>
    </xsl:if>

    <xsl:value-of select="concat($ind1, 'items:[', $cr)"/>

    <xsl:apply-templates select="ITEM">
      <xsl:with-param name="indent" select="$ind1"/>
      <xsl:with-param name="level">0</xsl:with-param>
      <xsl:with-param name="type" select="@type"/>
      <xsl:with-param name="menu" select="."/>
    </xsl:apply-templates>

    <xsl:value-of select="concat($ind1, ']', $cr)"/>
    <xsl:value-of select="concat($ind0, '};', $cr)"/>
  </xsl:template>

  <!--==================================================================-->
  <xsl:template match="ITEM">
    <!--==================================================================-->
    <xsl:param name="indent"/>
    <xsl:param name="level"/>
    <xsl:param name="menu"/>

    <xsl:variable name="ind0" select="$indent"/>
    <xsl:variable name="ind1" select="concat($ind0, $tab)"/>
    <xsl:variable name="ind2" select="concat($ind1, $tab)"/>
    <xsl:variable name="ind3" select="concat($ind2, $tab)"/>

    <xsl:variable name="imgwidth">
      <xsl:if test="IMAGE/@width"><xsl:value-of select="IMAGE/@width"/></xsl:if>
      <xsl:if test="not(IMAGE/@width)">16</xsl:if>
    </xsl:variable>
    <xsl:variable name="imgheight">
      <xsl:if test="IMAGE/@height"><xsl:value-of select="IMAGE/@height"/></xsl:if>
      <xsl:if test="not(IMAGE/@height)">16</xsl:if>
    </xsl:variable>

    <xsl:variable name="top-color">
      <xsl:choose>
        <xsl:when test="$menu/@top-color"><xsl:value-of select="$menu/@top-color"/></xsl:when>
        <xsl:when test="$menu/@type='bar'">white</xsl:when>
        <xsl:otherwise>white</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="top-bgcolor">
      <xsl:choose>
        <xsl:when test="$menu/@top-bgcolor"><xsl:value-of select="$menu/@top-bgcolor"/></xsl:when>
        <xsl:when test="$menu/@type='bar'">#265BCC</xsl:when>
        <xsl:otherwise>#265BCC</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="$menu/@color"><xsl:value-of select="$menu/@color"/></xsl:when>
        <xsl:when test="$menu/@type='bar'">black</xsl:when>
        <xsl:otherwise>black</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bgcolor">
      <xsl:choose>
        <xsl:when test="$menu/@bgcolor"><xsl:value-of select="$menu/@bgcolor"/></xsl:when>
        <xsl:when test="$menu/@type='bar'">#E3E6FC</xsl:when>
        <xsl:otherwise>#265BCC</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="itemheight">
      <xsl:choose>
        <xsl:when test="@height"><xsl:value-of select="@height"/></xsl:when>
        <xsl:when test="$level=0">30</xsl:when>
        <xsl:when test="$level=1">25</xsl:when>
        <xsl:otherwise>30</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="concat($ind0, '{', $cr)"/>
    <xsl:value-of select="concat($ind1, 'text:&quot;')"/>

    <xsl:if test="$menu/@type='bar' and $level!=0 and not(IMAGE)">
      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
    </xsl:if>

    <xsl:if test="@label">
      <xsl:variable name="label" select="@label"/>
      <xsl:variable name="tmp"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$label]"/></xsl:variable>
      <xsl:if test="$tmp!=''"><xsl:value-of select="$tmp"/></xsl:if>
      <xsl:if test="$tmp=''"><xsl:value-of select="@label"/></xsl:if>
    </xsl:if>
    <xsl:if test="@value"><xsl:value-of select="@value"/></xsl:if>
    <xsl:if test="comment()">
      <xsl:value-of select="comment()" disable-output-escaping="yes"/>
    </xsl:if>

    <xsl:value-of select="'&quot;'"/>

    <xsl:if test="ITEM or LINK or $level=0">,</xsl:if>
    <xsl:value-of select="$cr"/>

    <xsl:if test="$menu/@type='xpbar'">
      <xsl:if test="$level=0">
        <xsl:value-of select="concat($ind1, 'style:{imgspace:1,align:&quot;center&quot;,bgimg:&quot;img/title_bg_140.gif&quot;},', $cr)"/>
      </xsl:if>
      <xsl:if test="$level!=0">
        <xsl:if test="IMAGE">
          <xsl:value-of select="concat($ind1, 'style:{imgitem:{src:&quot;img/', IMAGE/@name, '&quot;, width:', $imgwidth, ', height:', $imgheight, '}}')"/>
          <xsl:if test="LINK"><xsl:value-of select="','"/></xsl:if>
          <xsl:value-of select="$cr"/>
        </xsl:if>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$menu/@type='bar'">
      <xsl:if test="$level=0 or IMAGE">
        <xsl:value-of select="concat($ind1, 'style:{', $cr)"/>
        <xsl:if test="$level=0">
          <xsl:value-of select="concat($ind2, 'color:&quot;', $top-color, '&quot;,bgcolor:&quot;', $top-bgcolor, '&quot;,', $cr)"/>
          <xsl:if test="$menu/@top-bgimg!=''">
            <xsl:value-of select="concat($ind2, 'bgimg:&quot;imagesb/', $menu/@top-bgimg, '&quot;,', $cr)"/>
          </xsl:if>
        </xsl:if>
        <xsl:if test="IMAGE">
          <xsl:variable name="width">
            <xsl:if test="IMAGE/@width"><xsl:value-of select="IMAGE/@width"/></xsl:if>
            <xsl:if test="not(IMAGE/@width)">16</xsl:if>
          </xsl:variable>
          <xsl:variable name="height">
            <xsl:if test="IMAGE/@height"><xsl:value-of select="IMAGE/@height"/></xsl:if>
            <xsl:if test="not(IMAGE/@height)">16</xsl:if>
          </xsl:variable>
          <xsl:if test="ITEM">
            <xsl:value-of select="concat($ind2, 'imgdir:{src:&quot;img/', IMAGE/@name, '&quot;, width:', $imgwidth, ', height:', $imgheight, '},', $cr)"/>
          </xsl:if>
          <xsl:if test="not(ITEM)">
            <xsl:value-of select="concat($ind2, 'imgitem:{src:&quot;img/', IMAGE/@name, '&quot;, width:', $imgwidth, ', height:', $imgheight, '},', $cr)"/>
          </xsl:if>
        </xsl:if>
        <xsl:if test="@width">
            <xsl:value-of select="concat($ind2, 'size:[', @width, ',', $itemheight, '],', $cr)"/>
        </xsl:if>
        <xsl:if test="@align">
          <xsl:value-of select="concat($ind2, 'align:&quot;', @align, '&quot;,', $cr)"/>
        </xsl:if>
        <xsl:if test="not(@align) and $menu/@top-align and $level=0">
          <xsl:value-of select="concat($ind2, 'align:&quot;', $menu/@top-align, '&quot;,', $cr)"/>
        </xsl:if>

        <xsl:value-of select="concat($ind2, 'itemoffset:{x:2,y:2}', $cr)"/>
        <xsl:value-of select="concat($ind1, '}')"/>
        <xsl:if test="ITEM or LINK">,</xsl:if>
        <xsl:value-of select="$cr"/>
      </xsl:if>
    </xsl:if>

    <!-- if we have child menu items, define the submenu -->
    <xsl:if test="ITEM">
      <xsl:variable name="menuwidth">
        <xsl:choose>
          <xsl:when test="@menuwidth"><xsl:value-of select="@menuwidth"/></xsl:when>
          <xsl:when test="$menu/@menuwidth"><xsl:value-of select="$menu/@menuwidth"/></xsl:when>
          <xsl:when test="@type='bar'">100</xsl:when>
          <xsl:otherwise>100</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="menuheight">
        <xsl:choose>
          <xsl:when test="@menuheight"><xsl:value-of select="@menuheight"/></xsl:when>
          <xsl:otherwise>25</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="opacity">
        <xsl:choose>
          <xsl:when test="$menu/@opacity"><xsl:value-of select="$menu/@opacity"/></xsl:when>
          <xsl:when test="@type='bar'">100</xsl:when>
          <xsl:otherwise>100</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:value-of select="concat($ind1, 'menu:', $cr)"/>
      <xsl:value-of select="concat($ind1, '{', $cr)"/>

      <xsl:if test="$menu/@type='xpbar'">
        <xsl:value-of select="concat($ind2, 'style:{size:[130,20],bgcolor:&quot;#D6DFF7&quot;,', $cr)"/>
        <xsl:value-of select="concat($ind3, 'itemoffset:{x:5,y:2},', $cr)"/>
        <xsl:value-of select="concat($ind3, 'border:{color:&quot;white&quot;,width:1}', $cr)"/>
        <xsl:value-of select="concat($ind2, '},', $cr)"/>
        <xsl:value-of select="concat($ind2, 'itemover:{size:[130,20]},', $cr)"/>
      </xsl:if>
      <xsl:if test="$menu/@type='bar'">
        <!-- if we are not a the top level set the top style -->
        <xsl:if test="$level=0 or $level=1">
          <xsl:value-of select="concat($ind2, 'style:{size:[', $menuwidth, ',', $menuheight, '],color:&quot;', $color, '&quot;,bgcolor:&quot;', $bgcolor, '&quot;,', $cr)"/>
          <xsl:if test="$menu/@bgimg!=''">
            <xsl:value-of select="concat($ind3, 'bgimg:&quot;imagesb/', $menu/@bgimg, '&quot;,', $cr)"/>
          </xsl:if>
          <xsl:value-of select="concat($ind3, 'imgendoff:{src:&quot;img/arr_off.gif&quot;,width:7,height:7},', $cr)"/>
          <xsl:value-of select="concat($ind3, 'imgendon:{src:&quot;img/arr_on.gif&quot;,width:7,height:7},', $cr)"/>
          <xsl:value-of select="concat($ind3, 'direction:&quot;v&quot;,', $cr)"/>
          <xsl:value-of select="concat($ind3, 'itemoffset:{x:2,y:2},', $cr)"/>
          <xsl:value-of select="concat($ind3, 'opacity:', $opacity, $cr)"/>
          <xsl:value-of select="concat($ind2, '},', $cr)"/>
          <xsl:if test="$level=0">
            <xsl:value-of select="concat($ind2, 'position:{anchor:&quot;sw&quot;,anchor_side:&quot;nw&quot;},', $cr)"/>
          </xsl:if>
          <xsl:if test="$level=1">
            <xsl:value-of select="concat($ind2, 'position:{anchor:&quot;ne&quot;,anchor_side:&quot;nw&quot;},', $cr)"/>
          </xsl:if>
        </xsl:if>
      </xsl:if>

      <xsl:value-of select="concat($ind2, 'items:[', $cr)"/>
      <xsl:apply-templates>
        <xsl:with-param name="indent" select="$ind2"/>
        <xsl:with-param name="level" select="$level+1"/>
        <xsl:with-param name="menu" select="$menu"/>
      </xsl:apply-templates>
      <xsl:value-of select="concat($ind2, ']', $cr)"/>
      <xsl:value-of select="concat($ind1, '}', $cr)"/>
    </xsl:if>

    <!-- define the link -->
    <xsl:apply-templates select="LINK">
      <xsl:with-param name="indent" select="$ind1"/>
    </xsl:apply-templates>

    <xsl:value-of select="concat($ind0, '}')"/>
    <xsl:if test="position()!=last()">,</xsl:if>
    <xsl:value-of select="$cr"/>
  </xsl:template>

  <!--==================================================================-->
  <xsl:template match="DIVIDER">
    <!--==================================================================-->
    <xsl:param name="indent"/>
    <xsl:variable name="ind0" select="$indent"/>
    <xsl:value-of select="concat($ind0, '{type:&quot;separator&quot;}')"/>
    <xsl:if test="position()!=last()">,</xsl:if>
    <xsl:value-of select="$cr"/>
  </xsl:template>

  <!--=================================================================-->
  <xsl:template match="LINK">
    <xsl:param name="indent"/>

    <xsl:variable name="ind0" select="$indent"/>
    <xsl:variable name="nametype">
      <xsl:call-template name="QualifiedType">
        <xsl:with-param name="value" select="@name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="nametext">
      <xsl:call-template name="QualifiedValue">
        <xsl:with-param name="value" select="@name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="nameentity">
      <xsl:call-template name="QualifiedPrefix">
        <xsl:with-param name="value" select="@name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat($ind0, 'action : {')"/>

    <xsl:choose>
      <xsl:when test="($nametype='JAVA')">
        <xsl:value-of select="concat('js:&quot;', $nametext, '&quot;')"/>
      </xsl:when>
      <xsl:when test="($nametype='CONST')">
        <xsl:value-of select="$nametext"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'url:&quot;'"/>
        <xsl:value-of select="concat(@name, '.asp')"/>

        <xsl:for-each select="PARAM">
          <xsl:if test="(position() = '1')">?</xsl:if>
          <xsl:if test="(position() != '1')">
            <xsl:value-of select="'&amp;'" disable-output-escaping="yes"/>
          </xsl:if>
          <xsl:value-of select="concat(@name, '=', @value)"/>
        </xsl:for-each>

        <xsl:if test="not(@return='false') and not(@target)">
          <xsl:if test="(count(PARAM)=0)">?</xsl:if>
          <xsl:if test="(count(PARAM)!=0)">
            <xsl:value-of select="'&amp;'" disable-output-escaping="yes"/>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="@skipreturn">
              <xsl:value-of select="concat('ReturnURL=', /DATA/SYSTEM/@returnurl)" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="@nodata">
              <xsl:value-of select="concat('ReturnURL=', /DATA/SYSTEM/@pageURL)" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="not(@nodata)">
              <xsl:value-of select="concat('ReturnURL=', /DATA/SYSTEM/@pageURL, '&amp;ReturnData=', /DATA/SYSTEM/@pageData)" disable-output-escaping="yes"/>
            </xsl:when>
          </xsl:choose>
        </xsl:if>
        <xsl:value-of select="'&quot;'"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="@target">
      <xsl:value-of select="concat(',target:&quot;', @target, '&quot;')"/>
    </xsl:if>

    <xsl:value-of select="concat('}', $cr)"/>
  </xsl:template>

</xsl:stylesheet>
