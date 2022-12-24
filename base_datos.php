<?php
    setlocale(LC_ALL, 'es_PE', 'es');
    date_default_timezone_set('America/Lima');
	class conectar{
		private $servidor="localhost";
		private $usuario="root";
		private $password="";
		private $bd="bd_universidad";

		private static $db=null;
        private static $conexion=null;
		public function conexionPDO(){
			//$conexion=mysqli_connect($this->servidor,$this->usuario,$this->password,$this->bd);
            if(self::$db==null){
                self::$db = new PDO("mysql:dbname=".$this->bd.";host=".$this->servidor.";charset=utf8", "$this->usuario", "$this->password" );
                self::$db->exec("set names utf8;");
            }
			return self::$db;
			//return $conexion;
		}
		public function conexion(){
		    if(self::$conexion==null){
                self::$conexion=mysqli_connect($this->servidor,$this->usuario,$this->password,$this->bd);
            }
			return self::$conexion;
		}
	}

 ?>