<?php
    //session_start();
    require_once "usuarios.php";

    session_start();

    $baseDatos = new usuarios();

    $usua = $_POST["usuario"];
    $pass = $_POST["clave"];
     
    $ret = $baseDatos->loginUser($usua, $pass);
    if ($ret)
    {
        $_SESSION['usuario'] = $usua;
        echo "OK";
    }
    else
    {
        session_unset();
        session_destroy();
        echo "Usuario no registrado.";
    }
?>