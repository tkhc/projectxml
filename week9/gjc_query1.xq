xquery version "1.0";

(:
   New Perspectives on XML, 3rd Edition
   Tutorial 9
   Tutorial Assignment

   General query on stores and cities

   Filename:   gjc_query1.xq
   Terrence Chan 3/24/21 
 :)

declare variable $state as xs:string :='OR';
declare variable $storeList
:= doc('gjc_stores.xml')//store[state=$state];

<stateStores state="{$state}"
storeCount="{
    count($storeList)
    }">
    {
    $storeList
    }
</stateStores>
