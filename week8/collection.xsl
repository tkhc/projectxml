<?xml version="1.0" encoding="UTF-8"?>
<!--
New Perspectives on XML, 3rd Edition
Tutorial 8
Tutorial Case

Style Sheet to Collate Shipping Documents

Filename:         collection.xsl
Supporting Files:
Terrence Chan
-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="list">
        <orders>
            <xsl:for-each select="collection('.?select=shipdoc*.xml')">

                <order orderID="{shipment/@shipID}">
                    <orderDate>
                        <xsl:value-of select="shipment/shipDateTime" />
                    </orderDate>
                    <xsl:copy-of select="shipment/shipType" />
                    <xsl:copy-of select="shipment/items" />
                    <xsl:copy-of select="shipment/custID" />
                </order>

            </xsl:for-each>
        </orders>
    </xsl:template>

</xsl:stylesheet>
