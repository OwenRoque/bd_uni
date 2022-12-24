<?php
	require 'base_datos.php'
	$imagen='';
	if (isset($_FILES["foto"])){
		$file = $_FILES["foto"];
		$nombre = $file["name"];
		$tipo = $file["type"];
		$ruta_provisional = $file["tmp_name"];
		$size = $file["size"];
		$dimensiones = getimagesize($ruta_provisional);
		$width = $dimensiones[0]:
		$height = $dimensiones[1]:
		$carpeta = "fotos/";
		if ($tipo != 'image/jpg' && $tipo != 'image/JPG' && $tipo != 'image/jpeg' && $tipo != 'image/png')
		{
			echo "Error, el archivo no es una imagen";
		}
		else if ($size > 3*1024*1024){
			echo "Error, el tamaño máximo permitido es un 3MB"
		}
		else{
			$src = $carpeta.$nombre;
			move_uploaded_file($ruta_provisional, $src);
			$imagen = "fotos/".$nombre;
		}	
	}
	$query=mysqli_query($conexion, "INSERT INTO categorias (categoria, foto ,activo) VALUES ('$categoria', '$imagen', '$activo')");
	header('location: register.php')
?>