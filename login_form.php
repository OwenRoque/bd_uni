<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/portal.css">
    <script type="text/javascript" src="js/portal.js"></script>
    
</head>
<body>
    <div class="login-page">
        <div class="form">
            <form class="login-form">
                <input id="usuario" name="usuario" type="text" placeholder="Usuario..."/>
                <input id="clave" name="clave" type="password" placeholder="Clave..."/>
                <button id="btnAcceder" type="button">Iniciar Sesión</button>
                <p class="message">¿No registrado? <a href="register_form.php">Registrarse</a></p>
            </form>
            <p class="message_error" id="mensaje" name="mensaje"></p>
        </div>
    </div>
</body>
</html>