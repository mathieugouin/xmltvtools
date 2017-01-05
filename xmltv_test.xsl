<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.1">
    <xsl:output method="html" />
    <!-- Main Template: Build the Framework of the Page -->
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="xmltv.css" type="text/css" />
                <link rel="stylesheet" href="programme_categories.css" type="text/css" />
                <title>TV Listings (TEST)</title>
            </head>
            <body>
                <h1>TV Listing</h1>
                <xsl:apply-templates select="/tv"/>
            </body>
        </html>
    </xsl:template>

    <!-- ******************************************************************************** -->
    <!-- tv template (root element) -->
    <xsl:template match="tv">
        <h2>Template tv</h2>
        <xsl:apply-templates select="channel" />
<!-- TBD MGouin:
        <xsl:apply-templates select="programme" mode="full" />
-->
    </xsl:template>  <!-- end match="tv" -->

    <!-- ******************************************************************************** -->
    <xsl:template match="channel">
        <h3>Template channel :
        <xsl:value-of select="display-name[1]"/>
        </h3>

        <xsl:variable name="chanid" select="@id" />
<!-- TBD MGouin:
        <div><xsl:value-of select="$chanid" /></div>
-->
        <xsl:for-each select="/tv/programme[@channel=$chanid]">
            <xsl:sort select="@start" />
<!-- TBD MGouin:
            <div><xsl:value-of select="title" /></div>
-->
            <xsl:apply-templates select="." mode="simple" />
        </xsl:for-each>
    </xsl:template>

    <!-- ******************************************************************************** -->
    <xsl:template match="programme" mode="full">
        <h3>Template programme :
        <xsl:value-of select="title" />
        </h3>
        <div>
        Ch: <xsl:value-of select="@channel" />
        </div>
        <div>
        [<xsl:value-of select="@start" />] to [<xsl:value-of select="@stop" />]
        </div>
        <div>
        Description: <xsl:value-of select="desc" />
        </div>
        <div>
        Ep: <xsl:value-of select="episode-num" />
        </div>

<!-- TBD MGouin: Buggy for multiple days overlap
        <xsl:variable name="start_time"><xsl:value-of select="substring(@start,1,10)"/><xsl:value-of select="format-number(round(number(substring(@start,11,2))* 100 div 60),'00')"/></xsl:variable>
        <xsl:variable name="stop_time"><xsl:value-of select="substring(@stop,1,10)"/><xsl:value-of select="format-number(round(number(substring(@stop,11,2))* 100 div 60),'00')"/></xsl:variable>
        <xsl:variable name="time_duration" select="($stop_time - $start_time) * 60 div 100"/>
        <div><xsl:copy-of select="$start_time" /></div>
        <div><xsl:copy-of select="$stop_time" /></div>
        <div><xsl:copy-of select="$time_duration" /></div>
-->
    </xsl:template>

    <!-- ******************************************************************************** -->
    <xsl:template match="programme" mode="simple">
        <div>
        <xsl:value-of select="title" />
         | [<xsl:value-of select="@start" />] to [<xsl:value-of select="@stop" />]
        </div>
<!-- TBD MGouin: 
        <div>
        [<xsl:value-of select="@start" />] to [<xsl:value-of select="@stop" />]
        </div>
        <div>
        Description: <xsl:value-of select="desc" />
        </div>
        <div>
        Ep: <xsl:value-of select="episode-num" />
        </div>
-->
    </xsl:template>

    <!-- ******************************************************************************** -->
    <xsl:template name="convert_category">
       <xsl:choose>
        <xsl:when test="price &gt; 10">
          <td bgcolor="#ff00ff"><xsl:value-of select="artist"/></td>
        </xsl:when>
        <xsl:when test="price &gt; 9">
          <td bgcolor="#cccccc"><xsl:value-of select="artist"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><xsl:value-of select="artist"/></td>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
