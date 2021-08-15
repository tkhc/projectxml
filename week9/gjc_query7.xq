xquery version "1.0";

(:
   New Perspectives on XML, 3rd Edition
   Tutorial 9
   Tutorial Assignment

   Return total revenue grouped by department and store

   Filename:   gjc_query7.xq
   Terrence Chan 3/24/21 
 :)

import module namespace gjc = "http://www.example.com/gjc" at "gjc_functions.xqm";

<results>{

    for $s in $gjc:stores
    let $sID := $s/@storeID
    return
        <store storeID="{$sID}" location="{$s/city}, {$s/state}">
            {
            for $d in distinct-values($gjc:products/department)
            return
                <department name="{$d}">
                    <revenue>
                        {gjc:revenue(gjc:storeDeptOrders($sID, $d))}
                    </revenue>
                </department>
            }
        </store>
}</results>
