<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="css/portal.css">    
</head>
<body>
    <div class="login-page">
        <div class="form">
            <form action="registrar_usuario.php" method="POST" enctype="multipart/form-data" class="login-form">    
                <input id="usuario" name="usuario" type="text" placeholder="Usuario..."/>
                <input id="clave" name="clave" type="password" placeholder="Clave..."/>
                <label>Seleccione una foto: </label>
                <input id="foto" name="foto" type="file" accept=".png, .jpeg, .jpg">
                <button id="btnRegistrar" type="submit">Registrar</button>
                <p class="message">¿Ya tienes una cuenta? <a href="login_form.php">Inicia Sesión</a></p>
            </form>
        </div>
    </div>
</body>
</html>