<?php
/*
* import checksum generation utility
* You can get this utility from https://developer.paytm.com/docs/checksum/
*/
require_once("PaytmChecksum.php");

$paytmParams = array();

$merchandId = "";
$merchandKey = "";
$amount = $_POST("amout"); // amout is comming from frontend
$orderId = "ORDERID_".mt_rand(); // generate order id


$paytmParams["body"] = array(
 "requestType"  => "Payment",
"mid"  => $merchandId,
 "websiteName"  => "YOUR_WEBSITE_NAME",
 "orderId"    => $orderId,
 "callbackUrl" => "https://<callback URL to be used by merchant>",
 "txnAmount" => array(
 "value"  => $amount,
 "currency"=> "INR",
 ),
 "userInfo"=> array(
 "custId" => "CUST_".mt_rand(),
 ),
);

/*
* Generate checksum by parameters we have in body
* Find your Merchant Key in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys 
*/
$checksum = PaytmChecksum::generateSignature(json_encode($paytmParams["body"], JSON_UNESCAPED_SLASHES), $merchandKey);

$paytmParams["head"] = array(
"signature"=> $checksum
);

$post_data = json_encode($paytmParams, JSON_UNESCAPED_SLASHES);

/* for Staging */
$url = "https://securegw-stage.paytm.in/theia/api/v1/initiateTransaction?mid=$merchandId&orderId=$orderId";

/* for Production */
// $url = "https://securegw.paytm.in/theia/api/v1/initiateTransaction?mid=YOUR_MID_HERE&orderId=ORDERID_98765";

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json")); 
$response = curl_exec($ch);
$res_json = json_decode($res, true); // json decode
if($res_json["body"]['resultInfo']["resultCode"] == "0000"){ //0000 means success
    // on txtoken generation return mid, txtoken, orderid

    $final_response = array();
    $final_response["mid"] = $merchandId;
    $final_response["txToken"] = $res_json["body"]["txToken"];
    $final_response["orderId"] = $orderId;
    echo json_encode($final_response);
}else{
    http_response_code($res_json["body"]["resultInfo"]["resultCode"]);
    echo $res_json["body"]["resultInfo"]["resultMsg"];
}
// print_r($response);
?>
