<?php

#codded by mohammad reza ashouri 
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'http://www.google.com/');
curl_setopt($ch, CURLOPT_RANGE, '0-100');
curl_setopt($ch, CURLOPT_BINARYTRANSFER, 1);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$result = curl_exec($ch);
curl_close($ch);
echo $result;
?>