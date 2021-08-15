<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML, 3rd Edition
   Tutorial 6
   Tutorial Case
   Terrence Chan
   3/4/2021 
   Harpe Gaming Library of Templates Style Sheet

   Filename:         hglibrary.xsl
   Supporting Files:
-->
<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:r="http://example.com/reviews"
     xmlns:df="http://example.com/dateformats">
    <df:months>
        <m>January</m>
        <m>February</m>
        <m>March</m>
        <m>April</m>
        <m>May</m>
        <m>June</m>
        <m>July</m>
        <m>August</m>
        <m>September</m>
        <m>October</m>
        <m>November</m>
        <m>December</m>
    </df:months>
    <xsl:variable name="monthNames"
  select="document('')/xsl:stylesheet/df:months/m"/>
    <xsl:template match="releaseDate | r:reviewDate">
        <xsl:variable name="yearValue"
   select="substring-before(., '-')" />
        <xsl:variable name="monthValue"
   select="substring-before(substring-after(., '-'), '-')" />
        <xsl:variable name="dayValue"
   select="substring-after(substring-after(., '-'), '-')" />
        <xsl:value-of
   select="concat($monthNames[number($monthValue)], ' ',
   number($dayValue), ', ', $yearValue)" />
    </xsl:template>
    <xsl:template name="drawImages">
        <xsl:param name="imgFile" />
        <xsl:param name="imgCount" />
        <xsl:if test="$imgCount > 0">
            <img src="{$imgFile}" alt="" />
            <xsl:call-template name="drawImages">
                <xsl:with-param name="imgFile" select="$imgFile" />
                <xsl:with-param name="imgCount" select="$imgCount - 1" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>