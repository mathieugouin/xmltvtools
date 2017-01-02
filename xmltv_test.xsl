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
        <xsl:apply-templates select="programme" />
-->
    </xsl:template>  <!-- end match="tv" -->

    <!-- ******************************************************************************** -->
    <xsl:template match="channel">
        <h3>Template channel :
        <xsl:value-of select="display-name[1]"/>
        </h3>

        <xsl:variable name="chanid" select="@id"/>
        <div><xsl:value-of select="$chanid" /></div>

<!-- TBD MGouin:
-->
        <xsl:for-each select="/tv/programme[@channel=$chanid]">
            <xsl:sort select="@start"/>
            <div><xsl:value-of select="title"/></div>
        </xsl:for-each>
    </xsl:template>

    <!-- ******************************************************************************** -->
    <xsl:template match="programme">
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
    <!-- TBD MGouin: Start old xslt -->
    <xsl:template match="channel_bak" mode="EarlyMorning">
        <xsl:variable name="chanid" select="@id"/>

        <xsl:variable name="start_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>0000</xsl:variable>
        <xsl:variable name="end_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>0600</xsl:variable>

        <xsl:if test="position() mod 15 = 0">
            <xsl:call-template name="header">
                <xsl:with-param name="hour1" select="'12 AM'"/>
                <xsl:with-param name="hour2" select="'1 AM'"/>
                <xsl:with-param name="hour3" select="'2 AM'"/>
                <xsl:with-param name="hour4" select="'3 AM'"/>
                <xsl:with-param name="hour5" select="'4 AM'"/>
                <xsl:with-param name="hour6" select="'5 AM'"/>
            </xsl:call-template>
        </xsl:if>

        <tr>
            <td colspan="3" class="listing header colspan3"><div class="listing colspan3 " ><xsl:value-of select="display-name"/></div></td>
            <xsl:apply-templates select="/tv/programme[@channel=$chanid][substring(@start,1,12) &lt; $end_time]" mode="Listings">
                <xsl:with-param name="timeslice_start" select="$start_time"/>
                <xsl:with-param name="timeslice_end" select="$end_time"/>
            </xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="channel" mode="LateMorning">
        <xsl:variable name="chanid" select="@id"/>
        <xsl:variable name="start_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>0600</xsl:variable>
        <xsl:variable name="end_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>1200</xsl:variable>

        <xsl:if test="position() mod 15 = 0">
            <xsl:call-template name="header">
                <xsl:with-param name="hour1" select="'6 AM'"/>
                <xsl:with-param name="hour2" select="'7 AM'"/>
                <xsl:with-param name="hour3" select="'8 AM'"/>
                <xsl:with-param name="hour4" select="'9 AM'"/>
                <xsl:with-param name="hour5" select="'10 AM'"/>
                <xsl:with-param name="hour6" select="'11 AM'"/>
            </xsl:call-template>
        </xsl:if>
        <tr>
            <td colspan="3" class="listing header colspan3"><div class="listing colspan3 " ><xsl:value-of select="display-name"/></div></td>
            <xsl:apply-templates select="/tv/programme[@channel=$chanid][(substring(@start,1,12) &gt;= $start_time and substring(@start,1,12) &lt; $end_time) or (substring(@stop,1,12) &gt; $start_time and substring(@start,1,12) &lt; $start_time)]" mode="Listings">
            <xsl:with-param name="timeslice_start" select="$start_time"/><xsl:with-param name="timeslice_end" select="$end_time"/></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="channel" mode="Afternoon">
        <xsl:variable name="chanid" select="@id"/>
        <xsl:variable name="start_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>1200</xsl:variable>
        <xsl:variable name="end_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>1800</xsl:variable>

        <xsl:if test="position() mod 15 = 0">
            <xsl:call-template name="header">
                <xsl:with-param name="hour1" select="'12 PM'"/>
                <xsl:with-param name="hour2" select="'1 PM'"/>
                <xsl:with-param name="hour3" select="'2 PM'"/>
                <xsl:with-param name="hour4" select="'3 PM'"/>
                <xsl:with-param name="hour5" select="'4 PM'"/>
                <xsl:with-param name="hour6" select="'5 PM'"/>
            </xsl:call-template>
        </xsl:if>
        <tr>
            <td colspan="3" class="listing header colspan3"><div class="listing colspan3 " ><xsl:value-of select="display-name"/></div></td>
            <xsl:apply-templates select="/tv/programme[@channel=$chanid][(substring(@start,1,12) &gt;= $start_time and substring(@start,1,12) &lt; $end_time) or (substring(@stop,1,12) &gt; $start_time and substring(@start,1,12) &lt; $start_time)]" mode="Listings">
            <xsl:with-param name="timeslice_start" select="$start_time"/><xsl:with-param name="timeslice_end" select="$end_time"/></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="channel" mode="Evening">
        <xsl:variable name="chanid" select="@id"/>
        <xsl:variable name="start_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>1800</xsl:variable>
        <xsl:variable name="end_time"><xsl:value-of select="substring(/tv/programme[1]/@stop,1,8)"/>2400</xsl:variable>
        <xsl:if test="position() mod 15 = 0">
            <xsl:call-template name="header">
                <xsl:with-param name="hour1" select="'6 PM'"/>
                <xsl:with-param name="hour2" select="'7 PM'"/>
                <xsl:with-param name="hour3" select="'8 PM'"/>
                <xsl:with-param name="hour4" select="'9 PM'"/>
                <xsl:with-param name="hour5" select="'10 PM'"/>
                <xsl:with-param name="hour6" select="'11 PM'"/>
            </xsl:call-template>
        </xsl:if>
        <tr>
            <td colspan="3" class="listing header colspan3"><div class="listing colspan3 " ><xsl:value-of select="display-name"/></div></td>
            <xsl:apply-templates select="/tv/programme[@channel=$chanid][(substring(@start,1,12) &gt;= $start_time and substring(@start,1,12) &lt; $end_time) or (substring(@stop,1,12) &gt; $start_time and substring(@start,1,12) &lt; $start_time)]" mode="Listings">
            <xsl:with-param name="timeslice_start" select="$start_time"/><xsl:with-param name="timeslice_end" select="$end_time"/></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template name="time24">
        <xsl:param name="value" select="'00000000000000'"/>
        <xsl:value-of select="substring($value, 9,2)"/>:<xsl:value-of select="substring($value, 11,2)"/>
    </xsl:template>
    <xsl:template name="time100">
        <xsl:param name="value" select="'00000000000000'"/>
        <xsl:value-of select="substring($value, 9,4)"/>
    </xsl:template>
    <xsl:template name="time12">
        <xsl:param name="value" select="'00000000000000'"/>
        <xsl:if test="number(substring($value,9,2)) &lt; 12">
            <xsl:if test="number(substring($value,9,2)) = 0">12</xsl:if>
            <xsl:if test="number(substring($value,9,2)) &gt; 0"><xsl:value-of select="substring($value, 9, 2)"/></xsl:if>
            :<xsl:value-of select="substring($value, 11,2)"/> AM
        </xsl:if>
        <xsl:if test="number(substring($value,9,2)) &gt;= 12">
            <xsl:if test="number(substring($value,9,2)) = 12">12</xsl:if>
            <xsl:if test="number(substring($value,9,2)) &gt; 12"><xsl:value-of select="(substring($value, 9, 2) - 12)"/></xsl:if>
            :<xsl:value-of select="substring($value, 11,2)"/> PM
        </xsl:if>
    </xsl:template>
    <!-- -->


    <!-- This Generates the Pop_Up / Tool Tip -->
    <xsl:template match="/tv/programme" mode="programme_info">
        <div class="popup_window" style="display:none; width:20em;">
            <xsl:attribute name="ID"><xsl:value-of select="episode-num"/><xsl:value-of select="@channel"/><xsl:value-of select="substring(@start,7,6)"/></xsl:attribute>
            <div class="popup_title">
                <xsl:value-of select="title"/>
                <br/>
                <xsl:call-template name="time12">
                    <xsl:with-param name="value" select="@start"/>
                </xsl:call-template>
                        to  <xsl:call-template name="time12"><xsl:with-param name="value" select="@stop"/></xsl:call-template>
            </div>
            <div class="popup_data">
                <xsl:if test="sub-title"><b><xsl:value-of select="sub-title"/></b><br/></xsl:if>
                <xsl:if test="desc"><xsl:value-of select="desc"/><br/></xsl:if>
                <table border="0" cellspacing="0">
                    <tr>
                        <th class="header popup_small">Categories</th>
                    </tr>
                    <tr>
                        <td class="popup_small">
                            <xsl:for-each select="category">
                                <xsl:value-of select="."/>/
                            </xsl:for-each>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </xsl:template>

    <!-- -->
    <xsl:template match="/tv/programme" mode="categories">
        <tr>
            <xsl:for-each select="category">
            <td>
                <xsl:value-of select="."/>
            </td>
            </xsl:for-each>
        </tr>
    </xsl:template>

    <xsl:template match="category" >
        <tr>
            <xsl:for-each select="category">
            <td class="programme">
                <xsl:value-of select="."/>
            </td>
            </xsl:for-each>
        </tr>
    </xsl:template>

</xsl:stylesheet>
