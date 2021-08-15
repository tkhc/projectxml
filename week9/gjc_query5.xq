xquery version "1.0";

(:
   New Perspectives on XML, 3rd Edition
   Tutorial 9
   Tutorial Assignment

   Return total revenue grouped by department

   Filename:   gjc_query5.xq
   Terrence Chan 3/24/21 
 :)


<results>{

    let $products := doc('gjc_products.xml')//product
    for $d in distinct-values($products/department)
    let $deptProducts := $products[department=$d]

    let $orders := doc('gjc_orders.xml')//product
    let $deptOrders := $orders[@productID=$deptProducts/@productID]

    let $deptTotal := sum($deptOrders/(@qty*@salesPrice))

    return
    <department name="{$d}">{
        <revenue>{
        concat("$",round-half-to-even($deptTotal,2))
        }</revenue>
    }</department>

}</results>
