<?php

    // Author: Sean Sosik-Hamor <sean@hamor.com>
    // License: GPLv3
    //
    // Description:
    // Proof-of-concept snippet to create an embeddable SmugMug photo gallery on sites
    // like Squarespace.com. Currently hardcoded for HamorHollow.com.
    //
    // Usage:
    // View-source on your SmugMug gallery and look for the application/rss+xml link
    // pointing at /hack/feed.mg. Copy the Data= value, for example: 16616021_NvK5Xw
    //
    // Copy this script to your Web server running PHP and then embed this script on
    // your Squarespace.com site by calling:
    //
    // https://www.example.com/embed-smugmug-gallery.php?gallery=16616021_NvK5Xw

    $galleryid = $_GET['galleryid'];

    if (empty($galleryid)) {
        echo "<a href=\"https://www.hamorhollow.com/chippoke/\">Chippoke</a> broke something important.";
        exit;
    }

    $xmlFileData = file_get_contents
        ("https://photos.hamorhollow.com/hack/feed.mg?Type=gallery&ImageCount=9999&Data=$galleryid&Size=XL&format=rss200");
    $xmlData = new SimpleXMLElement($xmlFileData);

    foreach($xmlData->channel->item as $item) {
        // Define variables.
        $title = $item->title;
        $link = $item->link;
        $description = $item->description;
        $imagethumbnail = $item->guid;

        // Convert URL from Thumbnail to Small.
        $imagesmall = str_replace("/Th/","/S/","$imagethumbnail");
        $imagesmall = str_replace("-Th.jpg","-S.jpg","$imagesmall");

        // Display images.
        echo "<a href=\"$link\" target=\"_top\"><img src=\"$imagesmall\"></a> ";
    }

?>
