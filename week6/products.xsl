<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML, 3rd Edition
   Tutorial 6
   Tutorial Case
   Terrence Chan
   3/4/2021 
   Harpe Gaming Products Style Sheet

   Filename:         products.xsl
   Supporting Files:
-->
<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:r="http://example.com/reviews">
    <xsl:include href="hglibrary.xsl" />
    <xsl:include href="reviews.xsl" />
    <xsl:param name="productID" select="'vg10551'" />
    <xsl:variable name="reviewList"
        select="document('reviews.xml')/r:reviews/r:review[@pid=$productID]" />
    <xsl:output method="html"
      doctype-system="about:legacy-compat"
      encoding="UTF-8"
      indent="yes" />
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="products/product[@pid=$productID]/title" />
                </title>
                <link href="harpe.css" rel="stylesheet" type="text/css" />
            </head>
            <body>
                <div id="wrap">
                    <header>
                        <h1>Harpe Gaming</h1>
                    </header>
                    <section id="productSummary">
                        <xsl:apply-templates select="products/product[@pid=$productID]" />
                    </section>
                    <section id="reviews">
                        <h1>Customer Reviews</h1>
                        <p>
                            <xsl:variable name="avgRating"
                        select="sum($reviewList/r:rating) div count($reviewList/r:rating)" />
                            <xsl:call-template name="drawImages">
                                <xsl:with-param name="imgFile" select="'solidstar.png'" />
                                <xsl:with-param name="imgCount" select="round($avgRating)" />
                            </xsl:call-template>
                            <xsl:call-template name="drawImages">
                                <xsl:with-param name="imgFile" select="'emptystar.png'" />
                                <xsl:with-param name="imgCount" select="5 - round($avgRating)" />
                            </xsl:call-template>
                            <br />
                            <xsl:value-of select="format-number($avgRating, '0.00')" />
                    out of 5 stars

                    (
                            <xsl:value-of select="count($reviewList)" /> reviews)
                            <xsl:call-template name="makeBarChart">
                    </xsl:call-template>
                        </p>
                        <xsl:apply-templates select="$reviewList[position() &lt;= 5]"/>
                    </section>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="product">
        <img src="{image}" alt="" />
        <h1>
            <xsl:value-of select="title" />
        </h1>
        <h2>By:
            <em>
                <xsl:value-of select="manufacturer" />
            </em>
        </h2>
        <table id="summaryTable">
            <tr>
                <th>Product ID: </th>
                <td>
                    <xsl:value-of select="@pid" />
                </td>
            </tr>
            <tr>
                <th>List Price: </th>
                <td>
                    <xsl:value-of select="format-number(price,'$#,#0.00')" />
                </td>
            </tr>
            <tr>
                <th>Media: </th>
                <td>
                    <xsl:value-of select="media" />
                </td>
            </tr>
            <tr>
                <th>Release Date: </th>
                <td>
                    <xsl:apply-templates select="releaseDate" />
                </td>
            </tr>
        </table>
        <xsl:copy-of select="summary/*" />
    </xsl:template>

    <xsl:template name="makeBarChart">
        <table id="barChart">
            <xsl:call-template name="drawBars">
                <xsl:with-param name="stars" select="5" />
            </xsl:call-template>
        </table>
    </xsl:template>
    <xsl:template name="drawBars">
        <xsl:param name="stars" />
        <xsl:if test="$stars > 0">
            <xsl:variable name="dataCount" select="count($reviewList[r:rating=$stars])" />
            <tr>
                <th>
                    <xsl:value-of select="$stars" /> star
                   (
                    <xsl:value-of select="$dataCount" />)
                </th>
                <td>
                    <xsl:variable name="percent"
                       select="100*($dataCount div count($reviewList))" />
                    <img src="solidbar.png" alt="" height="18px" width="{concat($percent, 'px')}" />
                </td>
            </tr>
            <xsl:call-template name="drawBars">
                <xsl:with-param name="stars" select="$stars - 1" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>