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
        Template programme :

        <xsl:variable name="category_class">
            <xsl:call-template name="convert_category">
                <xsl:with-param name="value" select="category/text()"/>
            </xsl:call-template>
        </xsl:variable>

        <div class="{$category_class}">
            <h3>
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
                Category: <xsl:value-of select="category" />
            </div>
            <div>
                Ep: <xsl:value-of select="episode-num" />
            </div>
        </div>

    </xsl:template>

    <!-- ******************************************************************************** -->
    <xsl:template match="programme" mode="simple">
        <xsl:variable name="start_time" select="concat(substring(@start,9,2), ':', substring(@start,11,2))" />
        <xsl:variable name="stop_time"  select="concat(substring(@stop,9,2), ':', substring(@stop,11,2))" />
        <xsl:variable name="start_date" select="substring(@start,1,8)" />

        <xsl:variable name="category_class">
            <xsl:call-template name="convert_category">
                <xsl:with-param name="value" select="category/text()"/>
            </xsl:call-template>
        </xsl:variable>

        <div class="{$category_class}">
            <xsl:value-of select="$start_date" />
            [<xsl:value-of select="$start_time" />-<xsl:value-of select="$stop_time" />]
            <xsl:value-of select="title" />
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
        <xsl:param name="value" />
        <xsl:variable name="apos" select='"&apos;"'/>
        <xsl:choose>
            <xsl:when test="$value = concat('Children', $apos, 's / Youth programmes')">
                child
            </xsl:when>
            <xsl:when test="$value = 'Movie / Drama'">
                drama
            </xsl:when>
            <xsl:when test="$value = 'News / Current affairs'">
                news
            </xsl:when>
            <xsl:when test="$value = 'Show / Game show'">
                serie
            </xsl:when>
            <xsl:when test="$value = 'Sports'">
                sport
            </xsl:when>
            <xsl:otherwise>
                unknown
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
