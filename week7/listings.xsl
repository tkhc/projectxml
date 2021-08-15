<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML, 3rd Edition
   Tutorial 7
   Tutorial Case

   Real Estate Listings Style Sheet
   Terrence Chan 3/12/2021
   Filename:         listings.xsl
   Supporting Files:
-->


<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

     <xsl:variable name="agentsDoc" select="document('agents.xml')" />
     <xsl:variable name="firmsDoc" select="document('firms.xml')" />

     <xsl:key name="cityNames" match="property" use="city" />
     <xsl:key name="aKey" match="agent" use="@id" />
     <xsl:key name="fKey" match="firm" use="@id" />


   <xsl:output method="html"
      doctype-system="about:legacy-compat"
      encoding="UTF-8"
      indent="yes" />


   <xsl:template match="/">
      <html>
         <head>
            <title>Real Estate Listings</title>
            <link href="brstyles.css" rel="stylesheet" type="text/css" />
         </head>

         <body>
            <div id="wrap">
               <header>
                  <img src="brlogo.png" alt="Bowline Realty" />
               </header>

               <h1>New Listings</h1>

               <section id="city_list">
               |
                   <xsl:apply-templates select="listings/property[not(city=preceding::property/city)]" mode="cityList">
                       <xsl:sort select="city" />
                   </xsl:apply-templates>
               </section>

               <xsl:for-each select="//property[generate-id()=generate-id(key('cityNames', city)[1])]">
                   <xsl:sort select="city" />
                   <h2 id="{generate-id()}"><xsl:value-of select="city" /></h2>

               <xsl:apply-templates select="key('cityNames', city)">
                   <xsl:sort select="price" order="descending" />
               </xsl:apply-templates>

               </xsl:for-each>

             </div>
         </body>
      </html>
   </xsl:template>


   <xsl:template match="property">
      <table class="head" cellpadding="2">
         <tr>
            <th>Price</th>
            <td><xsl:value-of select="format-number(price,'$#,##0')" /></td>
            <th>Sq. Feet</th>
            <td><xsl:value-of select="sqfeet" /></td>
         </tr>
         <tr>
            <th rowspan="2">Address</th>
            <td rowspan="2">
               <xsl:value-of select="street" /><br />
               <xsl:value-of select="city" />, <xsl:value-of select="state" />
               <xsl:text> </xsl:text><xsl:value-of select="zip" />
            </td>
            <th>Baths</th>
            <td><xsl:value-of select="bathrooms" /></td>
         </tr>
         <tr>
            <th>Bedrooms</th>
            <td><xsl:value-of select="bedrooms" /></td>
         </tr>
         <tr>
            <th>Style</th>
            <td><xsl:value-of select="style" /></td>
            <th>Garage</th>
            <td><xsl:value-of select="garage" /></td>
         </tr>
         <tr>
            <th>Age</th>
            <td><xsl:value-of select="age" /></td>
            <th>Listing #</th>
            <td><xsl:value-of select="@rln" /></td>
         </tr>
         <tr>
            <td class="description" colspan="4">
               <xsl:value-of select="description" />
            </td>
         </tr>
         <tr>
             <th colspan="2">Real Estate Agency</th>
             <th colspan="2">Agent</th>
         </tr>
         <tr>
             <td colspan="2">
                 <xsl:variable name="fID" select="@firm" />
                 <xsl:for-each select="$firmsDoc">
                     <xsl:value-of select="key('fKey', $fID)/name" /> <br />
                     <xsl:value-of select="key('fKey', $fID)/street" /> <br />
                     <xsl:value-of select="key('fKey', $fID)/city" />,
                     <xsl:value-of select="key('fKey', $fID)/state" /> &#160;
                     <xsl:value-of select="key('fKey', $fID)/zip" /><br />
                     <xsl:value-of select="key('fKey', $fID)/phone" /><br />
                     <xsl:value-of select="key('fKey', $fID)/web" />
                 </xsl:for-each>
             </td>
             <td colspan="2">
                 <xsl:variable name="aID" select="@agent" />
                 <xsl:for-each select="$agentsDoc">
                     <xsl:value-of select="key('aKey', $aID)/name" /> <br />
                     <xsl:value-of select="key('aKey', $aID)/phone" /> <br />
                     <xsl:value-of select="key('aKey', $aID)/email" />
                 </xsl:for-each>
             </td>
         </tr>
      </table>
   </xsl:template>

   <xsl:template match="property" mode="cityList">
       <a href="#{generate-id()}">
       <xsl:value-of select="city" />
        </a>
       (<xsl:value-of select="count(key('cityNames', city))" />) |
   </xsl:template>


</xsl:stylesheet>
