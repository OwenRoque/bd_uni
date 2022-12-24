<?php 
include ("base_datos.php");
class usuarios{

    public function __construct(){
        setlocale(LC_ALL, 'es_PE', 'es');
        date_default_timezone_set('America/Lima');
    }

    public function registroUsuario($datos)
    {
        $c= new conectar();
        $db=$c->conexionPDO();
        $fecha=date('Y-m-d h:i');

        $sql="INSERT into usuarios (nombre, apellido, email, password, fechaCaptura, activo, isadministrador,isjefeventas)
            VALUES (:nombre, :apellido, :email, :password, :fechaCaptura, :activo, :isadministrador, :isjefeventas)";
        $datosInsertar=array(
            ":nombre" =>$datos['nombre'],
            ":apellido" =>$datos['apellido'],
            ":email" => $datos['email'],
            ":password" => $datos['password'],
            ":fechaCaptura" => $fecha,
            ":activo" => '1',
            ":isadministrador" => $datos['isadministrador'],
            ":isjefeventas" => $datos['isjefeventas']
        );
        try {
            $stmt = $db->prepare($sql);
            $res = $stmt->execute($datosInsertar); //true o false
            if($res)
                return $db->lastInsertId();
            else
                return -1;
        }
        catch(PDOException $e)
        {
            //var_dump($e);
            return "Error: " . $e->getMessage();
        }
    }

    public function Usuarioviewmodel(){
        $c=new conectar();
        $db=$c->conexionPDO();
        $sql="SELECT concat(SUBSTRING_INDEX(nombre, ' ', 1), ',', SUBSTRING_INDEX(apellido, ' ', 1)) as nombre
                FROM usuarios WHERE id_usuario='" . $_SESSION['iduser'] . "' and activo=1";
        $regUsu=$db->query($sql)->fetch(PDO::FETCH_NUM);

        $registro=array(
            'id_usuario' => -1,
            'nombre' => '',
            'apellido' => '',
            'email' => '',
            'password'=>'',
            'isjefeventas'=>'0',
            'isadministrador'=>'0',
            'activo'=>'1',
            'fechaCaptura'=>date("Y-m-d"),
            'AutorizadoUsuario'=>$regUsu==FALSE ? '' : $this->coalesce($regUsu[0],'') . " - " . date("d.m.y h:i")
        );
        return $registro;
    }

    public function loginUser($usua, $pass)
    {
        $c=new conectar();
        $db=$c->conexionPDO();

        $sql="SELECT per.codigo, 
        CONCAT(per.primer_apellido,' ',per.segundo_apellido,' ',per.primer_nombre) as n_prof 
        from persona as per 
        
            JOIN profesor as pro
            on pro.codigo_prof=per.codigo
            where per.codigo=:codigo and per.password=:password";
        $stmt = $db->prepare($sql);
        $stmt->bindParam("codigo", $usua,PDO::PARAM_STR) ;
        $stmt->bindParam("password", $pass,PDO::PARAM_STR) ;
        $stmt->execute();

        $count=$stmt->rowCount();
        $res=$stmt->fetch(PDO::FETCH_ASSOC);
        // var_dump($res);

        //$result=mysqli_query($conexion,$sql);
        //if(mysqli_num_rows($result) > 0){
        if($count>0){
            $_SESSION['nombre'] = $res['n_prof'];
            return 1;
        }else{
            return 0;
        }
    }

    public function traeID($datos){
        $c=new conectar();
        $conexion=$c->conexion();

        $password=sha1($datos[1]);

        $sql="SELECT id_usuario 
                from usuarios 
                where email='$datos[0]'
                and password='$password'
                and activo='1'";
        $result=mysqli_query($conexion,$sql);
        //return mysqli_fetch_row($result)[0];
        return mysqli_fetch_row($result);
    }

    public function obtenCursosUsuario($idusuario){
        $c=new conectar();
        $db=$c->conexionPDO();
        try {
            $sql = "SELECT c.nombre, pc.codigo_curso
                from profesor_curso pc
                INNER JOIN profesor p
                INNER JOIN curso c
                ON pc.codigo_prof=p.codigo_prof
                AND pc.codigo_curso=c.codigo_curso
                where pc.codigo_prof='$idusuario'";
            return $db->query($sql)->fetchAll(PDO::FETCH_NUM);

        }catch (Exception $e){
            return $e->getMessage();
        }
    }

    public function actualizaUsuario($datos){
        $c= new conectar();
        $db=$c->conexionPDO();
        $fecha=date('Y-m-d h:i:s');
        $Id=$datos['id_usuario'];

        $iduserCrea = $_SESSION['iduser'];
        //var_dump($iduserCrea);
        $sql="UPDATE usuarios SET nombre=?, apellido=?, isadministrador=?, isjefeventas=?
                ,password=? WHERE id_usuario=? and activo=1";
        try {
            $db->beginTransaction(); // also helps speed up your inserts.
            $stmt = $db->prepare($sql);
            $res = $stmt->execute(array($datos['nombre'],
                                    $datos['apellido'],
                                    $datos['isadministrador'],
                                    $datos['isjefeventas'],
                                    $datos['password'],
                                    $Id)
                                );
            if($res) {
                return $Id;
            }
            else
                return -1;
        }
        catch(PDOException $e)
        {
            //var_dump($e);
            return "Error: " . $e->getMessage();
        }
    }

    public function eliminaUsuario($idusuario){
        $c=new conectar();
        $conexion=$c->conexion();

        $sql="UPDATE usuarios SET activo='0' 
                where id_usuario='$idusuario'";
        return mysqli_query($conexion,$sql);
    }
    public function getInfo($codigo_profesor, $codigo_curso){
        $mysql = new conectar();
        $db = $mysql->conexionPDO();
        try {
        
            
            $datos = "SELECT * from profesor_curso p_c 
            WHERE p_c.codigo_prof='$codigo_profesor' AND p_c.codigo_curso='$codigo_curso'";
            return $db->query($datos)->fetchAll(PDO::FETCH_NUM);

        }catch (Exception $e){
            return $e->getMessage();
        }
    }

    public function getNotas($codigo_profesor, $codigo_curso, $fecha, $grupo){
        $mysql = new conectar();
        $db = $mysql->conexionPDO();
        
        try {
            
            $result = "CALL mostrar_notas(:codigo_profesor, :grupo, :codigo_curso,:fecha)";
            $stmt = $db->prepare($result);
            $stmt->bindParam("codigo_profesor",$codigo_profesor, PDO::PARAM_STR);
            $stmt->bindParam("codigo_curso",$codigo_curso, PDO::PARAM_STR);
            $stmt->bindParam("fecha",$fecha, PDO::PARAM_STR);
            $stmt->bindParam("grupo",$grupo, PDO::PARAM_STR);
            $stmt->execute();
            
            return $stmt->fetchAll(PDO::FETCH_ASSOC);

        }catch (Exception $e){
            return $e->getMessage();
        }

        
    }

}
 ?>