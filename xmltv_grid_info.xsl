<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.1">
<!--
    '===========================================================
    ' xmltv_grid_info:
    ' Author: Timothy Alosi (timalosi.com)
    ' Revision 0.1.B
    ' Revision Date: November 20, 2004
    '
    ' Copyright (c) 2004 Timothy Alosi
    '
    ' This opensource project is hosted at http://xmltvtools.sourceforge.net
    ' Please contribute any improvements back to the project.
    '
    ' Permission is hereby granted, free of charge, to any person obtaining a copy
    ' of this software and associated documentation files (the "Software"), to deal
    ' in the Software without restriction, including without limitation the rights
    ' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    ' copies of the Software, and to permit persons to whom the Software is
    ' furnished to do so, subject to the following conditions:
    '
    ' The above copyright notice and this permission notice shall be included in
    ' all copies or substantial portions of the Software.
    '
    ' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    ' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    ' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    ' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    ' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    ' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    ' THE SOFTWARE.
    '
    '===========================================================
-->
    <xsl:output method="html" />
    <!-- Main Template: Build the Framework of the Page -->

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="xmltv.css" type="text/css" />
                <link rel="stylesheet" href="programme_categories.css" type="text/css" />
                <title>TV Listings</title>
                <script type="text/javascript" language="JScript" src="xmltv.js"></script>
            </head>
            <body bgcolor="#FFFFFF" onload="SetUpPage()" >
                <xsl:apply-templates select="/tv"/>
            </body>
        </html>
    </xsl:template>

    <!-- Grab the Root Element and Build the Menu and Call the various page templates -->
    <xsl:template match="tv">
        <div ID="MenuDiv" class="menu popup_window">
            <div ID="MenuTitle" class="popup_title">Listings for: <xsl:value-of select="substring(programme[1]/@stop, 5,2)"/>/<xsl:value-of select="substring(programme[1]/@stop,7,2)"/>/07</div>
            <div ID="MenuData" class="popup_data">
                <span id="CurrentTime">Processing XML ...</span>
                <p>
                    Click to Display<br/>
                    <input type="checkbox" class="small_checkbox" ID="chkEarlyMorning" value="ON" onpropertychange="showListings()"/>Early Morning<br/>
                    <input type="checkbox" class="small_checkbox" ID="chkLateMorning" value="ON" onpropertychange="showListings()"/>Late Morning<br/>
                    <input type="checkbox" class="small_checkbox" ID="chkAfternoon" value="ON" onpropertychange="showListings()"/>Afternoon<br/>
                    <input type="checkbox" class="small_checkbox" ID="chkEvening" value="ON" onpropertychange="showListings()"/>Evening
                </p>
                <p>Color Codings
                    <div class="mv">Movies</div>
                    <div class="sitco">SitComs, Series</div>
                    <div class="reali">Reality Shows</div>
                    <div class="cooki">How-To, Cooking</div>
                    <div class="child">Childrens, Educational</div>
                    <div class="sport">Sports</div>
                    <div class="news">News, Specials</div>
                    <div class="talk">Talk Shows</div>
                    <div class="drama">Drama, Action, etc</div>
                </p>

                    <!--<input type="submit" onclick="Test()" value="Run Test Script"/><br/>-->

                    <center><a onclick="About()">About this Page</a></center>
            </div>
        </div>

            <div ID="AboutDiv" class="menu popup_window" style="display:none">
            <div ID="AboutTitle" class="popup_title" ><span ID="AboutClose" class="popup_close" onclick="About()">x</span>About Tim's TV Listings</div>
                <div ID="AboutData" class="popup_data" >
                    <p>Web page design and stylesheet construction by <a href="http://timalosi.com">TimAlosi.com</a></p>
                    <p>Listing data from <a><xsl:attribute name="href"><xsl:value-of select="@source-info-url"/></xsl:attribute><xsl:value-of select="@source-info-url"/></a><br/>
                    This data is copyrighted and provided for personal use only.</p>
                    <p>The listing data was gathered using <a href="http://www.xmltv.org">XMLTV.org</a> Listing grabber and parser.</p>
                    <p><font style="text-size:8pt; text-align:center;">Style Sheet Version 0.1b</font></p>
                    <p>This open source project hosted by <a href="http://sourceforge.net"><img src="http://sflogo.sourceforge.net/sflogo.php?group_id=206983&amp;type=2" width="125" height="37" border="0" alt="SourceForge.net Logo" /></a></p>
                    <center><a onclick="About()">Close Window</a></center>
                </div>
            </div>


            <div ID="message1"><center><h2>Processing Program Information ...</h2></center></div>
            <xsl:apply-templates select="/tv/programme" mode="programme_info"/>
            <div ID="message2" ><center><h2>Processing Early Morning Listings ...</h2></center></div>
            <xsl:call-template name="EarlyMorning"/>
            <div ID="message3" ><center><h2>Processing Late Morning Listings ...</h2></center></div>
            <xsl:call-template name="LateMorning"/>
            <div ID="message4"><center><h2>Processing Afternoon Listings ...</h2></center></div>
            <xsl:call-template name="Afternoon"/>
            <div ID="message5" ><center><h2>Processing Evening Listings ...</h2></center></div>
            <xsl:call-template name="Evening"/>
            <xsl:call-template name="Channel_Col"/>


        <!--<p>Categories</p>
        <table>
            <xsl:apply-templates select="/tv/programme" mode="categories">
            </xsl:apply-templates>
        </table>
        <p>End of the listing</p>-->
    </xsl:template>


    <xsl:template name="header">
        <xsl:param name="hour1"/>
        <xsl:param name="hour2"/>
        <xsl:param name="hour3"/>
        <xsl:param name="hour4"/>
        <xsl:param name="hour5"/>
        <xsl:param name="hour6"/>

            <tr>
                <th colspan="3" class="listing header colspan3" style="background-color: #eee"><div class="listing colspan3" >Channel</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc"><xsl:value-of select="$hour1"/></div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:15</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:30</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:45</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee"><xsl:value-of select="$hour2"/></div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:15</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:30</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:45</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc"><xsl:value-of select="$hour3"/></div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:15</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:30</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:45</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee"><xsl:value-of select="$hour4"/></div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:15</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:30</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:45</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc"><xsl:value-of select="$hour5"/></div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:15</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:30</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #ccc">:45</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee"><xsl:value-of select="$hour6"/></div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:15</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:30</div></th>
                <th class="listing header colspan1"><div class="listing colspan1" style="background-color: #eee">:45</div></th>
            </tr>
    </xsl:template>


    <xsl:template name="EarlyMorning">
        <div ID="EarlyMorning" class="time_slice" style="display:none">
            <table border="0" cellspacing="0" cellpadding="0"  class="listing">
                <xsl:call-template name="header">
                    <xsl:with-param name="hour1" select="'12 AM'"/>
                    <xsl:with-param name="hour2" select="'1 AM'"/>
                    <xsl:with-param name="hour3" select="'2 AM'"/>
                    <xsl:with-param name="hour4" select="'3 AM'"/>
                    <xsl:with-param name="hour5" select="'4 AM'"/>
                    <xsl:with-param name="hour6" select="'5 AM'"/>
                </xsl:call-template>
                <xsl:apply-templates select="channel" mode="EarlyMorning"/></table>
        </div>
    </xsl:template>


    <xsl:template name="LateMorning" >
        <div ID="LateMorning" class="time_slice" style="display:none">
            <table border="0" cellspacing="0" cellpadding="0"   class="listing">
                <xsl:call-template name="header">
                    <xsl:with-param name="hour1" select="'6 AM'"/>
                    <xsl:with-param name="hour2" select="'7 AM'"/>
                    <xsl:with-param name="hour3" select="'8 AM'"/>
                    <xsl:with-param name="hour4" select="'9 AM'"/>
                    <xsl:with-param name="hour5" select="'10 AM'"/>
                    <xsl:with-param name="hour6" select="'11 AM'"/>
                </xsl:call-template>
            <xsl:apply-templates select="channel" mode="LateMorning"/></table>
        </div>
    </xsl:template>


    <xsl:template name="Afternoon">
        <div ID="Afternoon" class="time_slice" style="display:none" >
            <table border="0" cellspacing="0" cellpadding="0" class="listing">
                <xsl:call-template name="header">
                    <xsl:with-param name="hour1" select="'12 PM'"/>
                    <xsl:with-param name="hour2" select="'1 PM'"/>
                    <xsl:with-param name="hour3" select="'2 PM'"/>
                    <xsl:with-param name="hour4" select="'3 PM'"/>
                    <xsl:with-param name="hour5" select="'4 PM'"/>
                    <xsl:with-param name="hour6" select="'5 PM'"/>
                </xsl:call-template>
            <xsl:apply-templates select="channel" mode="Afternoon"/></table>
        </div>
    </xsl:template>

    <xsl:template name="Evening">
        <div ID="Evening" class="time_slice" style="display:none">
            <table border="0" cellspacing="0" cellpadding="0"  class="listing">
                <xsl:call-template name="header">
                    <xsl:with-param name="hour1" select="'6 PM'"/>
                    <xsl:with-param name="hour2" select="'7 PM'"/>
                    <xsl:with-param name="hour3" select="'8 PM'"/>
                    <xsl:with-param name="hour4" select="'9 PM'"/>
                    <xsl:with-param name="hour5" select="'10 PM'"/>
                    <xsl:with-param name="hour6" select="'11 PM'"/>
                </xsl:call-template>
            <xsl:apply-templates select="channel" mode="Evening"/></table>
        </div>
    </xsl:template>


    <xsl:template name="Channel_Col">
        <div ID="Channel_Col" class="time_slice" style="display:none" >
            <table border="0" cellspacing="0" cellpadding="0"  class="listing" >
                    <tr>
                        <th colspan="3" class="listing header colspan3" style="background-color: #eee"><div class="listing colspan3" >Channel</div></th>
                    </tr>
                    <xsl:apply-templates select="channel" mode="Channel_Col"/>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="channel" mode="Channel_Col">
        <xsl:if test="position() mod 15 = 0">
            <tr>
                <th colspan="3" class="listing header colspan3" style="background-color: #eee"><div class="listing colspan3" >Channel</div></th>
            </tr>
        </xsl:if>
        <tr>
            <td colspan="3" class="listing header colspan3"><div class="listing colspan3 " ><xsl:value-of select="display-name"/></div></td>
        </tr>
    </xsl:template>

    <xsl:template match="channel" mode="EarlyMorning">
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
            <xsl:with-param name="timeslice_start" select="$start_time"/><xsl:with-param name="timeslice_end" select="$end_time"/></xsl:apply-templates>
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

    <xsl:template match="/tv/programme" mode="Listings">
        <xsl:param name="timeslice_start" select="'yyyymmddhhmm'"/>
        <xsl:param name="timeslice_end" select="'yyyymmddhhmm'"/>

        <!-- Scale the Minutes from 0 - 60 to 0 - 100 -->

        <xsl:variable name="start_time"><xsl:value-of select="substring(@start,1,10)"/><xsl:value-of select="format-number(round(number(substring(@start,11,2))* 100 div 60),'00')"/></xsl:variable>
        <xsl:variable name="stop_time"><xsl:value-of select="substring(@stop,1,10)"/><xsl:value-of select="format-number(round(number(substring(@stop,11,2))* 100 div 60),'00')"/></xsl:variable>
        <xsl:variable name="time_duration" select="$stop_time - $start_time"/>


        <xsl:if test="position() = 1 ">
            <xsl:variable name="timeleftinshow" select="$stop_time - $timeslice_start"/>
            <xsl:variable name="columns" select="round($timeleftinshow div 25)"/>
            <xsl:if test ="$columns != 0">
                <td>
                    <xsl:attribute name="colspan" ><xsl:value-of select="$columns"/></xsl:attribute>
                    <xsl:attribute name="class">listing colspan<xsl:value-of select="$columns"/>
                        <xsl:value-of select="concat(' ',substring(episode-num,1,2))"/>
                        <xsl:for-each select="category">
                            <xsl:value-of select="concat(' ', substring(.,1,5), ' ')"/>
                        </xsl:for-each>
                    </xsl:attribute>
                    <div><xsl:attribute name="class">listing colspan<xsl:value-of select="$columns"/></xsl:attribute>
                    <span style="cursor:hand">
                        <xsl:attribute name="onmouseover">ToolTip('<xsl:value-of select="episode-num"/><xsl:value-of select="@channel"/><xsl:value-of select="substring(@start,7,6)"/>')</xsl:attribute>
                        <xsl:attribute name="onmouseout">ToolTip('<xsl:value-of select="episode-num"/><xsl:value-of select="@channel"/><xsl:value-of select="substring(@start,7,6)"/>')</xsl:attribute>
                        <xsl:value-of select="title"/>
                        <!--<xsl:call-template name="programme_info"><xsl:with-param name="prog_id" select="episode-num"/><xsl:with-param name="chan" select="$chan"/></xsl:call-template>-->
                    </span></div>
                </td>
            </xsl:if>
        </xsl:if>
        <xsl:if test="position() != 1 ">
            <xsl:if test ="$stop_time &lt;= $timeslice_end">
                <!-- This not the last show of the Section -->
                <xsl:variable name="columns" select="round($time_duration div 25)"/>
                <xsl:if test ="$columns != 0">
                    <td>
                        <xsl:attribute name="colspan" ><xsl:value-of select="$columns"/></xsl:attribute>
                        <xsl:attribute name="class">listing colspan<xsl:value-of select="$columns"/>
                            <xsl:value-of select="concat(' ',substring(episode-num,1,2))"/>
                            <xsl:for-each select="category">
                                <xsl:value-of select="concat(' ', substring(.,1,5), ' ')"/>
                            </xsl:for-each>
                        </xsl:attribute>

                        <div><xsl:attribute name="class">listing colspan<xsl:value-of select="$columns"/></xsl:attribute>
                        <span style="cursor:hand">
                            <xsl:attribute name="onmouseover">ToolTip('<xsl:value-of select="episode-num"/><xsl:value-of select="@channel"/><xsl:value-of select="substring(@start,7,6)"/>')</xsl:attribute>
                            <xsl:attribute name="onmouseout">ToolTip('<xsl:value-of select="episode-num"/><xsl:value-of select="@channel"/><xsl:value-of select="substring(@start,7,6)"/>')</xsl:attribute>
                            <xsl:value-of select="title"/>
                            <!--<xsl:call-template name="programme_info"><xsl:with-param name="prog_id" select="episode-num"/><xsl:with-param name="chan" select="$chan"/></xsl:call-template>-->
                        </span></div>
                    </td>
                </xsl:if>
            </xsl:if>
            <xsl:if test ="$stop_time &gt; $timeslice_end">
                <!-- This IS the last show of the Section -->
                <xsl:variable name="timeleftinslice" select="$timeslice_end - $start_time"/>
                <xsl:variable name="columns" select="round($timeleftinslice div 25)"/>
                <xsl:if test ="$columns != 0">
                    <td>
                        <xsl:attribute name="colspan" ><xsl:value-of select="$columns"/></xsl:attribute>
                        <xsl:attribute name="class">listing colspan<xsl:value-of select="$columns"/>
                            <xsl:value-of select="concat(' ',substring(episode-num,1,2))"/>
                            <xsl:for-each select="category">
                                <xsl:value-of select="concat(' ', substring(.,1,5), ' ')"/>
                            </xsl:for-each>
                        </xsl:attribute>
                        <div><xsl:attribute name="class">listing colspan<xsl:value-of select="$columns"/></xsl:attribute>
                        <span style="cursor:hand">
                            <xsl:attribute name="onmouseover">ToolTip('<xsl:value-of select="episode-num"/><xsl:value-of select="@channel"/><xsl:value-of select="substring(@start,7,6)"/>')</xsl:attribute>
                            <xsl:attribute name="onmouseout">ToolTip('<xsl:value-of select="episode-num"/><xsl:value-of select="@channel"/><xsl:value-of select="substring(@start,7,6)"/>')</xsl:attribute>
                            <xsl:value-of select="title"/>
                            <!--<xsl:call-template name="programme_info"><xsl:with-param name="prog_id" select="episode-num"/><xsl:with-param name="chan" select="$chan"/></xsl:call-template>-->
                        </span></div>
                    </td>
                </xsl:if>
            </xsl:if>
        </xsl:if>
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
                <xsl:value-of select = "title"/>
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
