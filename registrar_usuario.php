<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/portal.css">    
</head>
<body>
    <div class="login-page">
        <div class="form">
            <?php
            include ("base_datos.php");
            
            $usua = $_POST["usuario"];
            $clave = $_POST["clave"];
            $dir = "img/";
            $file = $_FILES["foto"];
            $path = $_FILES['foto']['name'];
            
            $ext = pathinfo($path, PATHINFO_EXTENSION);
            if (empty($usua) || empty($clave)){
                echo "<p class='message'><a href='register_form.php'>Regresar a Register</a></p>";
                echo "<h1>Campos incompletos.</h1>";
                return;
            }
            
            $temporary_file = $file['tmp_name']; 
            $finfo 	    = finfo_open(FILEINFO_MIME_TYPE);
            $file_type  = finfo_file($finfo, $temporary_file);

            if(($file_type != "image/jpeg") && ($file_type != "image/png") && ($file_type != "image/jpg")){
                echo "<p class='message'><a href='register_form.php'>Regresar a Register</a></p>";
                echo "<h1>Formato de imagen no aceptado.</h1>";
                echo $file['name'];
                return;
            }

            else if (!move_uploaded_file($file["tmp_name"], "$dir/" . $usua . "." . $ext)) {
                echo "<p class='message'><a href='register_form.php'>Regresar a Register</a></p>";
                echo "<h1>No se pudo subir la foto del usuario.</h1>";
                return;
            }
            $baseDatos = new base_datos("localhost","root","","dbp_2022a_base");
            $baseDatos->conectar();
            if ($baseDatos->insUsuario($usua, $clave)){
                echo "<h1>El usuario se registró correctamente.</h1>";
            } else {
                echo "<h1>Hubo un error al registrar al usuario.</h1>";
            }
            echo "<p class='message'><a href='login_form.php'>Regresar a Login</a></p>";
            $baseDatos->cerrar();
            ?>
        </div>
    </div>
</body>
</html>