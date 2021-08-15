<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML, 3rd Edition
   Tutorial 6
   Tutorial Case
   Terrence Chan
   3/4/2021 
   Harpe Gaming Review Style Sheet

   Filename:         reviews.xsl
   Supporting Files:
-->


<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:r="http://example.com/reviews"
     xmlns:c="http://example.com/customers">

     <xsl:variable name="customerList"
         select="document('customers.xml')/c:customers/c:customer" />

   <xsl:template match="r:review">
      <h2>
          <xsl:call-template name="drawImages">
              <xsl:with-param name="imgFile" select="'solidstar.png'" />
              <xsl:with-param name="imgCount" select="r:rating" />
          </xsl:call-template>
          <xsl:call-template name="drawImages">
              <xsl:with-param name="imgFile" select="'emptystar.png'" />
              <xsl:with-param name="imgCount" select="5 - r:rating" />
          </xsl:call-template>
          <xsl:text> </xsl:text>
         <xsl:value-of select="r:title" />
      </h2>
      <table id="reviewTable">
          <tr>
              <th>By:</th>
              <td>
                  <xsl:variable name="customerID" select="current()/@cid" />
                  <xsl:value-of select="$customerList[@cid=$customerID]/c:nickname" />
                  (<xsl:value-of select="$customerList[@cid=$customerID]/c:city" />,
                  <xsl:value-of select="$customerList[@cid=$customerID]/c:state" />)
              </td>
          </tr>
         <tr>
            <th>Review Date:</th>
            <td>
               <xsl:apply-templates select="r:reviewDate" />
            </td>
         </tr>
      </table>

      <xsl:copy-of select="r:description/*" />

   </xsl:template>


</xsl:stylesheet>
