
use gresiduos;
DELIMITER $$
/*
   Esta funcion permite el ingreso de nuvos datos 
*/
DROP FUNCTION IF EXISTS nuevoVista$$
CREATE FUNCTION nuevoVista(
    _nombreComercio VARCHAR(50),
    _patente VARCHAR(15),
    _direccion VARCHAR(250),
    _tipo VARCHAR(20),
    _nombrePersona VARCHAR(60),
    _correoE VARCHAR(100),
    _telefono VARCHAR(15),
    _cargo VARCHAR(20),
    _ResGenerados VARCHAR(75)
    )
    RETURNS INT(1) 
begin
    declare _cant int;
    set _cant =0;
    if _cant = 0 then
     set _cant =1;
        select count(idCliente) into _cant from cliente where idCliente = _idCliente;
            insert into vista(nombreComercio, patente, direccion, tipo, nombrePersona
            , correoE,telefono,cargo,ResGenerados) 
                values (_nombreComercio, _patente, _direccion, _tipo, _nombrePersona,
                 _correoE,_telefono,_cargo,_ResGenerados);
        else
            set _cant = 2;
    end if;
    return _cant;
end$$ 

/*
   Esta funcion permite el ingreso de nuvos datos 
*/

DROP FUNCTION IF EXISTS nuevoVermas$$
CREATE FUNCTION nuevoVermas(
    _separa VARCHAR(10),
    _lugarResSep VARCHAR(30),
    _calificacionCampaña VARCHAR(20),
    _mejoraServicio VARCHAR(100),
    _porqueNoSepara VARCHAR(100),
    _motivacion VARCHAR(30),
    _dondeColocaBasura VARCHAR(20),
    _califacacionServicioMuni VARCHAR(15),
    _mejoraServicioMuni VARCHAR(50)
    )
    RETURNS INT(1) 
begin
    declare _cant int;
    if _cant = 0 then
    set _cant =1;
            insert into vermas(separa, lugarResSep, calificacionCampaña,
             mejoraServicio, porqueNoSepara
            , motivacion,dondeColocaBasura,califacacionServicioMuni,mejoraServicioMuni) 
                values (_separa,_lugarResSep,_calificacionCampaña,
             _mejoraServicio, _porqueNoSepara
            , _motivacion,_dondeColocaBasura,_califacacionServicioMuni,_mejoraServicioMuni);
        else
            set _cant = 2;
        end if;
    return _cant;
end$$ 
/*
Esta funcion cadenaFiltro se encarga de 
*/
DROP FUNCTION IF EXISTS cadenaFiltro$$
CREATE FUNCTION cadenaFiltro (
    _parametros varchar(250),
    _campos varchar(120)) RETURNS VARCHAR (250)
begin
    declare _salida varchar (250);
    set @param = _parametros;
    set @campos = _campos;
    set @filtro = "";
    WHILE (LOCATE('&', @param) > 0) DO
        set @valor = SUBSTRING_INDEX(@param, '&', 1);
        set @param = substr(@param, LOCATE('&', @param)+1);
        set @campo = SUBSTRING_INDEX(@campos, '&', 1);
        set @campos = substr(@campos, LOCATE('&', @campos)+1);
        set @filtro = concat(@filtro, " `", @campo, "` LIKE '", @valor, "' and");       
    END WHILE;
    set @filtro = TRIM(TRAILING 'and' FROM @filtro);  
    return @filtro;
end$$

DROP PROCEDURE IF EXISTS filtrarGestionResiduos$$
CREATE PROCEDURE filtrarGestionResiduos (
    _parametros varchar(120), -- nombreComercio&patente&direccion&
                             /*tipo&nombrePersona&correoE&telefono&cargo&ResGenerados*/
    _pagina SMALLINT UNSIGNED, 
    _cantRegs SMALLINT UNSIGNED)
begin
    SELECT cadenaFiltro(_parametros, 'nombreComercio&patente&direccion&
    tipo&nombrePersona&correoE&telefono&cargo&ResGenerados') INTO @filtro;
    SELECT concat("SELECT * from vista where ", @filtro, " LIMIT ", 
        _pagina, ", ", _cantRegs) INTO @sql;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;  
end$$

--Parte de Madeley 

DROP FUNCTION IF EXISTS `editarVer`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `editarVer` (`_id` INT, `_separa` VARCHAR(10), `_lugarResSep` VARCHAR(30),
 `_calificacionCampaña` VARCHAR(20), `_mejoraServicio` VARCHAR(100), `_porqueNoSepara` VARCHAR(100), `_motivacion` VARCHAR(30),
 `_dondeColocaBasura` VARCHAR(20), `_calificacionServicioMuni` VARCHAR(15), `_mejoraServicioMuni` VARCHAR(50))
  RETURNS INT(1) begin
    declare _cant int;
    select count(id) into _cant from vermas where id = _id;
    if _cant > 0 then
        update vermas set
            separa = _idAdmin,
            lugarResSep = _lugarResSep,
            calificacionCampaña = _calificacionCampaña,
            mejoraServicio = _mejoraServicio,
            porqueNoSepara = _porqueNoSepara,
            motivacion = _motivacion,
            dondeColocaBasura = _dondeColocaBasura,
            calificacionServicioMuni = _calificacionServicioMuni,
            mejoraServicioMuni = _mejoraServicioMuni
        where id = _id;
    end if;
    return _cant;
end$$

DROP FUNCTION IF EXISTS `editarVista`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `editarVista` (`_id` INT, `_nombreComercio` VARCHAR(10), `_patente` VARCHAR(30),
 `_direccion` VARCHAR(20), `_tipo` VARCHAR(100), `_nombrePersona` VARCHAR(100), `_correoE` VARCHAR(30),
 `_telefono` VARCHAR(20), `_cargo` VARCHAR(15), `_resGenerados` VARCHAR(50))
  RETURNS INT(1) begin
    declare _cant int;
    select count(id) into _cant from vista where id = _id;
    if _cant > 0 then
        update vista set
            nombreComercio = _nombreComercio,
            patente = _patente,
            direccion = _direccion,
            tipo = _tipo,
            nombrePersona = _nombrePersona,
            correoE = _correoE,
            telefono = _telefono,
            cargo = _cargo,
            resGenerados = _resGenerados
        where id = _id;
    end if;
    return _cant;
end$$

DROP FUNCTION IF EXISTS `eliminarVer`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `eliminarVer` (`_id` INT(1)) RETURNS INT(1) begin
    declare _cant int;
    select count(id) into _cant from vermas where id = _id;
    if _cant > 0 then
        delete from vermas where id = _id;
    end if;
    return _cant;
end$$

DROP FUNCTION IF EXISTS `eliminarVista`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `eliminarVista` (`_id` INT(1)) RETURNS INT(1) begin
    declare _cant int;
    select count(id) into _cant from vista where id = _id;
    if _cant > 0 then
        delete from vista where id = _id;
    end if;
    return _cant;
end$$

DROP PROCEDURE IF EXISTS `buscarVer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarVer` (`_id` INT)  begin
    select * from vermas where id = _id;
end$$

DROP PROCEDURE IF EXISTS `buscarVista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarVista` (`_id` INT)  begin
    select * from vista where id = _id;
end$$
DELIMITER ;
