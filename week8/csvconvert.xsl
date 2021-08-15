<?xml version="1.0" encoding="UTF-8"?>
<!--
New Perspectives on XML, 3rd Edition
Tutorial 8
Tutorial Case

Style Sheet to convert CSV to XML
Filename:         csvconvert.xsl
Supporting Files:
Terrence Chan
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" />
    <xsl:param name="csvFile" as="xs:string" />
    <xsl:param name="root" as="xs:string" />
    <xsl:param name="record" as="xs:string" />
    <xsl:variable name="dataText" select="unparsed-text($csvFile)" as="xs:string" />
    <xsl:template name="csvConvert">
        <xsl:variable name="rows" select="tokenize($dataText, '\r?\n')" as="xs:string*" />
        <xsl:variable name="elemNames" select="tokenize($rows[1], ',\s*')" as="xs:string+" />
        <xsl:element name="{$root}">
            <xsl:for-each select="$rows[position()>1]">
                <xsl:element name="{$record}">
                    <xsl:variable name="dataValues" select="tokenize(., ',\s*')" as="xs:string+" />
                    <xsl:for-each select="$elemNames">
                        <xsl:variable name="elemName" select="." />
                        <xsl:element name="{replace($elemName, '\s', '_')}">
                            <xsl:value-of select="$dataValues[index-of($elemNames, $elemName)]" />
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>