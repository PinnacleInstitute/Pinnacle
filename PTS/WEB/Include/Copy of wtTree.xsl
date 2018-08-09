<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="tree_tab" select="'&#009;'"/>
	<xsl:variable name="tree_cr" select="'&#010;'"/>
	<xsl:variable name="tree_apos">'</xsl:variable>

	<xsl:template name="StartTree">
		<xsl:param name="name"/>
		<xsl:param name="color">#000000</xsl:param>
		<xsl:param name="imgline">img/line.gif</xsl:param>
		<xsl:param name="imgdir">img/t-folder.gif</xsl:param>
		<xsl:param name="imgdiropen">img/t-folder-open.gif</xsl:param>
		<xsl:param name="imgdir_l">img/folder.gif</xsl:param>
		<xsl:param name="imgdiropen_l">img/folder-open.gif</xsl:param>
		<xsl:param name="itemoffset_x">22</xsl:param>
		<xsl:param name="itemoffset_y">1</xsl:param>
		<xsl:param name="fixwidth">0</xsl:param>
		<xsl:param name="fixheight">0</xsl:param>
		<xsl:param name="css"></xsl:param>
		<xsl:param name="lined">true</xsl:param>
		<xsl:param name="imgitem">img/t-item-folder.gif</xsl:param>
		<xsl:param name="imgitem_l">img/l-item-folder.gif</xsl:param>
		<xsl:param name="styleover_css"></xsl:param>
		<xsl:param name="styleover_color">#1B77BC</xsl:param>
		<xsl:param name="styleover_bgcolor">#E5EFFA</xsl:param>
		<xsl:param name="target"></xsl:param>
		<xsl:param name="position_abs">false</xsl:param>
		<xsl:param name="position_x">10</xsl:param>
		<xsl:param name="position_y">10</xsl:param>
		<xsl:param name="size_x">0</xsl:param>
		<xsl:param name="size_y">0</xsl:param>
		<xsl:param name="bgimg"></xsl:param>

		<xsl:variable name="ind0" select="''"/>
		<xsl:variable name="ind1" select="concat($ind0, $tree_tab)"/>
		<xsl:variable name="ind2" select="concat($ind1, $tree_tab)"/>

		<xsl:text disable-output-escaping="yes"><![CDATA[<script language="javascript1.2">]]></xsl:text>
		<xsl:value-of select="$tree_cr"/>

		<xsl:value-of select="concat($ind0, 'var TreeDef', $name, ' = {', $tree_cr )"/>
		<xsl:value-of select="concat($ind1, '&quot;type&quot; : &quot;tree&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind1, '&quot;style&quot; : {', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;color&quot; : &quot;', $color, '&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;imgline&quot; : &quot;', $imgline, '&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;imgdir&quot; : &quot;', $imgdir, '&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;imgdiropen&quot; : &quot;', $imgdiropen, '&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;imgdir_l&quot; : &quot;', $imgdir_l, '&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;imgdiropen_l&quot; : &quot;', $imgdiropen_l, '&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;itemoffset&quot; : {&quot;x&quot; : ', $itemoffset_x, ', &quot;y&quot; : ', $itemoffset_y, '},', $tree_cr )"/>
		<xsl:if test="$fixwidth!=0">
			<xsl:value-of select="concat($ind2, '&quot;fixwidth&quot; : ', $fixwidth, ',', $tree_cr )"/>
		</xsl:if>
		<xsl:if test="$fixheight!=0">
			<xsl:value-of select="concat($ind2, '&quot;fixheight&quot; : ', $fixheight, ',', $tree_cr )"/>
		</xsl:if>
		<xsl:if test="$size_x!=0">
			<xsl:value-of select="concat($ind2, '&quot;size&quot; : [', $size_x, ',', $size_y, '],', $tree_cr )"/>
		</xsl:if>
		<xsl:if test="$bgimg!=''">
			<xsl:value-of select="concat($ind2, '&quot;bgimg&quot; : &quot;', $bgimg, '&quot;,', $tree_cr )"/>
		</xsl:if>
		<xsl:if test="$css!=''">
			<xsl:value-of select="concat($ind2, '&quot;css&quot; : &quot;', $css, '&quot;,', $tree_cr )"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, '&quot;lined&quot; : ', $lined, ',', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;imgitem&quot; : &quot;', $imgitem, '&quot;,', $tree_cr )"/>
		<xsl:value-of select="concat($ind2, '&quot;imgitem_l&quot; : &quot;', $imgitem_l, '&quot;', $tree_cr )"/>
		<xsl:value-of select="concat($ind1, '},', $tree_cr )"/>
		<xsl:value-of select="concat($ind1, '&quot;styleover&quot; : {&quot;color&quot; : &quot;', $styleover_color, '&quot;, &quot;bgcolor&quot; : &quot;', $styleover_bgcolor, '&quot;' )"/>
		<xsl:if test="$styleover_css!=''">
			<xsl:value-of select="concat(', &quot;css&quot; : &quot;', $styleover_css, '&quot;' )"/>
		</xsl:if>
		<xsl:value-of select="concat('},', $tree_cr )"/>
		<xsl:if test="$target!=''">
			<xsl:value-of select="concat($ind2, '&quot;target&quot; : &quot;', $target, '&quot;,', $tree_cr )"/>
		</xsl:if>
		<xsl:value-of select="concat($ind1, '&quot;position&quot; : {&quot;absolute&quot; : ', $position_abs, ', &quot;pos&quot; : [', $position_x, ',', $position_y, ']},', $tree_cr )"/>
		<xsl:value-of select="concat($ind1, '&quot;items&quot; : [', $tree_cr )"/>

	</xsl:template>

	<xsl:template name="StartTreeNode">
		<xsl:param name="indent"/>
		<xsl:param name="level"/>
		<xsl:param name="name"/>
		<xsl:param name="children"/>
		<xsl:param name="link"/>
		<xsl:param name="imgdir_l">img/l-folder.gif</xsl:param>
		<xsl:param name="imgdiropen_l">img/l-folder-open.gif</xsl:param>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="ind1" select="concat($ind0, $tree_tab)"/>
		<xsl:variable name="ind2" select="concat($ind1, $tree_tab)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tree_tab)"/>

		<xsl:value-of select="concat($ind0, '{', $tree_tab, '&quot;text&quot; : &quot;', $name, '&quot;')"/>

		<xsl:if test="$children=0 and $link=''">
			<xsl:value-of select="'}'"/>
		</xsl:if>

		<xsl:if test="$link!=''">
			<xsl:value-of select="concat( ',', $tree_cr)"/>
			<xsl:value-of select="concat($ind1, '&quot;action&quot; : {')"/>
			<xsl:value-of select="concat('&quot;js&quot; : &quot;', $link, '&quot; }')"/>
			<xsl:if test="$children=0">
				<xsl:value-of select="$tree_cr"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$children!=0">
			<xsl:value-of select="concat( ',', $tree_cr)"/>
			<xsl:value-of select="concat($ind1, '&quot;menu&quot; : {', $tree_cr)"/>

			<xsl:if test="$level=0">
				<xsl:value-of select="concat($ind2, '&quot;style&quot; : {', $tree_cr)"/>
				<xsl:value-of select="concat($ind3, '&quot;imgdir_l&quot; : &quot;', $imgdir_l, '&quot;,', $tree_cr)"/>
				<xsl:value-of select="concat($ind3, '&quot;imgdiropen_l&quot; : &quot;', $imgdiropen_l, '&quot;', $tree_cr)"/>
				<xsl:value-of select="concat($ind2, '},', $tree_cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($ind2, '&quot;items&quot; : [', $tree_cr)"/>
		</xsl:if>

	</xsl:template>

	<xsl:template name="StartTreeNode1">
		<xsl:param name="indent"/>
		<xsl:value-of select="concat($indent, '{', $tree_tab, '&quot;text&quot; : ', $tree_apos)"/>
	</xsl:template>

	<xsl:template name="StartTreeNode2">
		<xsl:param name="indent"/>
		<xsl:param name="level"/>
		<xsl:param name="children"/>
		<xsl:param name="link"/>
		<xsl:param name="imgdir_l">img/l-folder.gif</xsl:param>
		<xsl:param name="imgdiropen_l">img/l-folder-open.gif</xsl:param>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="ind1" select="concat($ind0, $tree_tab)"/>
		<xsl:variable name="ind2" select="concat($ind1, $tree_tab)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tree_tab)"/>

		<xsl:value-of select="$tree_apos"/>

		<xsl:if test="$children=0 and $link=''">
			<xsl:value-of select="'}'"/>
		</xsl:if>

		<xsl:if test="$link!=''">
			<xsl:value-of select="concat( ',', $tree_cr)"/>
			<xsl:value-of select="concat($ind1, '&quot;action&quot; : {')"/>
			<xsl:value-of select="concat('&quot;js&quot; : &quot;', $link, '&quot; }')"/>
			<xsl:if test="$children=0">
				<xsl:value-of select="$tree_cr"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$children!=0">
			<xsl:value-of select="concat( ',', $tree_cr)"/>
			<xsl:value-of select="concat($ind1, '&quot;menu&quot; : {', $tree_cr)"/>

			<xsl:if test="$level=0">
				<xsl:value-of select="concat($ind2, '&quot;style&quot; : {', $tree_cr)"/>
				<xsl:value-of select="concat($ind3, '&quot;imgdir_l&quot; : &quot;', $imgdir_l, '&quot;,', $tree_cr)"/>
				<xsl:value-of select="concat($ind3, '&quot;imgdiropen_l&quot; : &quot;', $imgdiropen_l, '&quot;', $tree_cr)"/>
				<xsl:value-of select="concat($ind2, '},', $tree_cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($ind2, '&quot;items&quot; : [', $tree_cr)"/>
		</xsl:if>

	</xsl:template>


	<xsl:template name="EndTreeNode">
		<xsl:param name="indent"/>
		<xsl:param name="children"/>
		<xsl:param name="link"/>

		<xsl:variable name="ind1" select="concat($indent, $tree_tab)"/>
		<xsl:variable name="ind2" select="concat($ind1, $tree_tab)"/>

		<xsl:if test="$children!=0">
			<xsl:value-of select="concat($ind2, ']', $tree_cr)"/>
			<xsl:value-of select="concat($ind1, '}', $tree_cr)"/>
		</xsl:if>

		<xsl:if test="$link!='' or $children!=0">
			<xsl:value-of select="concat($indent, '}')"/>
		</xsl:if>

		<xsl:if test="position()!=last()">,</xsl:if>
		<xsl:value-of select="$tree_cr"/>
	</xsl:template>

	<xsl:template name="EndTree">
		<xsl:value-of select="concat($tree_tab, ']', $tree_cr, '};', $tree_cr )"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[</script>]]></xsl:text>
		<xsl:value-of select="$tree_cr"/>
	</xsl:template>


</xsl:stylesheet>
