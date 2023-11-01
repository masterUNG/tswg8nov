<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$nameAndSur = $_GET['nameAndSur'];
		$phone = $_GET['phone'];
		$carId = $_GET['carId'];
		$province = $_GET['province'];
		$objective = $_GET['objective'];
		$urlImage1 = $_GET['urlImage1'];
		$urlImage2 = $_GET['urlImage2'];
		$urlImage3 = $_GET['urlImage3'];
		
		
							
		$sql = "INSERT INTO `checkOfficerGuestUng`(`id`, `nameAndSur`, `phone`, `carId`, `province`, `objective`, `urlImage1`, `urlImage2`, `urlImage3`) VALUES (Null,'$nameAndSur','$phone','$carId','$province','$objective','$urlImage1','$urlImage2','$urlImage3')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>