CREATE OR REPLACE
PACKAGE BODY BASE AS

  PROCEDURE CREA_GERENTE(
    P_DATOS IN TGERENTE,
    P_USERPASS IN VARCHAR2,
    P_USUARIO OUT USUARIO%ROWTYPE,
    P_GERENTE OUT GERENTE%ROWTYPE
  ) AS
    SECUENCIA NUMBER;
  BEGIN
    INSERT INTO USUARIO (ID,NOMBRE, APELLIDOS, TELEFONO, DIRECCION, CORREO,USUARIOORACLE)
    VALUES (seq_usuarios.nextval,P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, P_DATOS.NOMBRE || seq_usuarios.currval );

    INSERT INTO GERENTE (ID, DESPACHO, HORARIO, CENTRO_ID)
    VALUES (seq_usuarios.currval, P_DATOS.DESPACHO, P_DATOS.HORARIO, P_DATOS.CENTRO);

    EJECUTAR_SQL('CREATE USER ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || ' IDENTIFIED BY ' || P_USERPASS);
    EJECUTAR_SQL('GRANT R_GERENTE TO ' || P_DATOS.NOMBRE||SEQ_USUARIOS.CURRVAL);
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.VEJERCICIO FOR LIFEFIT.VEJERCICIO');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.VM_EJERCICIOS FOR LIFEFIT.VM_EJERCICIOS');

    SECUENCIA := SEQ_USUARIOS.CURRVAL;
    SELECT * INTO P_USUARIO FROM USUARIO WHERE ID = SECUENCIA;
    SELECT * INTO P_GERENTE FROM GERENTE WHERE ID = SECUENCIA;

  EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error al crear gerente. Detalles: ' || SQLERRM);
  END CREA_GERENTE;

  PROCEDURE CREA_ENTRENADOR(
    P_DATOS IN TENTRENADOR,
    P_USERPASS IN VARCHAR2,
    P_USUARIO OUT USUARIO%ROWTYPE,
    P_ENTRENADOR OUT ENTRENADOR%ROWTYPE
  ) AS 
    SECUENCIA NUMBER;
  BEGIN
    INSERT INTO USUARIO (ID,NOMBRE, APELLIDOS, TELEFONO, DIRECCION, CORREO,USUARIOORACLE)
    VALUES (seq_usuarios.nextval,P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, P_DATOS.NOMBRE || seq_usuarios.currval );
        
    INSERT INTO ENTRENADOR (ID, DISPONIBILIDAD, CENTRO_ID)
    VALUES (seq_usuarios.currval, P_DATOS.DISPONIBILIDAD, P_DATOS.CENTRO);
    
    EJECUTAR_SQL('CREATE USER ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || ' IDENTIFIED BY ' || P_USERPASS);
    EJECUTAR_SQL('GRANT R_ENTRENADOR TO ' || P_DATOS.NOMBRE||SEQ_USUARIOS.CURRVAL);
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.V_CORREO_USUARIO FOR LIFEFIT.V_CORREO_USUARIO');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.V_OBJETIVO_CLIENTE FOR LIFEFIT.V_OBJETIVO_CLIENTE');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.V_VIDEO_SESION FOR LIFEFIT.V_VIDEO_SESION');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.V_VIDEOS FOR LIFEFIT.V_VIDEOS');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.V_DATOS_CLIENTE FOR LIFEFIT.V_DATOS_CLIENTE');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.VEJERCICIO FOR LIFEFIT.VEJERCICIO');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.VM_EJERCICIOS FOR LIFEFIT.VM_EJERCICIOS');
    
    SECUENCIA := SEQ_USUARIOS.CURRVAL;
    SELECT * INTO P_USUARIO FROM USUARIO WHERE ID = SECUENCIA;
    SELECT * INTO P_ENTRENADOR FROM ENTRENADOR WHERE ID = SECUENCIA;
    
  EXCEPTION 
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error al crear entrenador. Detalles: ' || SQLERRM);
  END CREA_ENTRENADOR;

  PROCEDURE CREA_CLIENTE(
	        P_DATOS IN TCLIENTE,
	        P_USERPASS IN VARCHAR2,
	        P_USUARIO OUT USUARIO%ROWTYPE,
	        P_CLIENTE OUT CLIENTE%ROWTYPE
    ) AS
        SECUENCIA NUMBER;
  BEGIN
    INSERT INTO USUARIO (ID, NOMBRE, APELLIDOS, TELEFONO, DIRECCION, CORREO) 
    VALUES (SEQ_USUARIOS.NEXTVAL, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE);
    
    INSERT INTO CLIENTE (ID, OBJETIVO, CENTRO_ID, DIETA_ID) 
    VALUES (SEQ_USUARIOS.CURRVAL, P_DATOS.OBJETIVOS, P_DATOS.CENTRO, P_DATOS.DIETA);
    
    EJECUTAR_SQL('CREATE USER ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || ' IDENTIFIED BY ' || P_USERPASS);
    EJECUTAR_SQL('GRANT R_CLIENTE TO ' || P_DATOS.NOMBRE||SEQ_USUARIOS.CURRVAL);
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.V_CITA FOR LIFEFIT.V_CITA');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.V_SESION FOR LIFEFIT.V_SESION');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.VEJERCICIO FOR LIFEFIT.VEJERCICIO');
    EJECUTAR_SQL('CREATE SYNONYM ' || P_DATOS.NOMBRE || SEQ_USUARIOS.CURRVAL || '.VM_EJERCICIOS FOR LIFEFIT.VM_EJERCICIOS');
    
    SECUENCIA := SEQ_USUARIOS.CURRVAL;
    SELECT * INTO P_USUARIO FROM USUARIO WHERE ID = SECUENCIA;
    SELECT * INTO P_CLIENTE FROM CLIENTE WHERE ID = SECUENCIA;
    
  EXCEPTION 
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error al crear cliente. Detalles: ' || SQLERRM);
  END CREA_CLIENTE;

  PROCEDURE ELIMINA_USER(P_ID USUARIO.ID%TYPE) AS
    NOMBRE VARCHAR2(32);
  BEGIN
    SELECT USUARIOORACLE INTO NOMBRE FROM USUARIO WHERE ID = P_ID;
    UPDATE USUARIO SET USUARIOORACLE = NULL WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error al eliminar infraestructura del usuario. Detalles: Usuario con ID = ' || p_id || ', no encontrado en la tabla Usuario');
    END IF;
    EJECUTAR_SQL('DROP USER ' || NOMBRE || ' CASCADE');
  END ELIMINA_USER;

  PROCEDURE ELIMINA_CLIENTE(P_ID USUARIO.ID%TYPE) AS
    BEGIN
    DELETE FROM CLIENTE WHERE ID = P_ID;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar infraestructura del cliente. Detalles: Cliente con ID = ' || p_id || ', no encontrado en la tabla Cliente');
    END IF;
    ELIMINA_USER(P_ID);
  END ELIMINA_CLIENTE;

  PROCEDURE ELIMINA_GERENTE(P_ID USUARIO.ID%TYPE) AS
  BEGIN
    DELETE FROM GERENTE WHERE ID = P_ID;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar infraestructura del gerente. Detalles: Gerente con ID = ' || p_id || ', no encontrado en la tabla Gerente');
    END IF;
    ELIMINA_USER(P_ID);
  END ELIMINA_GERENTE;

  PROCEDURE ELIMINA_ENTRENADOR(P_ID USUARIO.ID%TYPE) AS
  BEGIN
    DELETE FROM ENTRENADOR WHERE ID = P_ID;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar infraestructura del entrenador. Detalles: Entrenador con ID = ' || p_id || ', no encontrado en la tabla Entrenador');
    END IF;
    ELIMINA_USER(P_ID);
  END ELIMINA_ENTRENADOR;

  PROCEDURE ELIMINA_CENTRO(P_ID CENTRO.ID%TYPE) AS
    CURSOR cur_gerente IS SELECT ID, CENTRO_ID FROM GERENTE;
    CURSOR cur_entrenador IS SELECT ID, CENTRO_ID FROM ENTRENADOR;
    CURSOR cur_cliente IS SELECT ID, CENTRO_ID FROM CLIENTE;
    v_count INTEGER;
  BEGIN
    
    SELECT COUNT(*) INTO v_count FROM CENTRO WHERE ID = p_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar infraestructura del centro. Detalles: Centro con ID = ' || p_id || ', no encontrado en la tabla Centro');
    END IF;
    FOR gerente_rec IN cur_gerente LOOP
        IF gerente_rec.CENTRO_ID = P_ID THEN
            ELIMINA_GERENTE(gerente_rec.ID);
        END IF;
    END LOOP;
    FOR entrenador_rec IN cur_entrenador LOOP
        IF entrenador_rec.CENTRO_ID = P_ID THEN
            ELIMINA_ENTRENADOR(entrenador_rec.ID);
        END IF;
    END LOOP;
    FOR cliente_rec IN cur_cliente LOOP
        IF cliente_rec.CENTRO_ID = P_ID THEN
            ELIMINA_CLIENTE(cliente_rec.ID);
        END IF;
    END LOOP;
    DELETE FROM CENTRO WHERE ID = P_ID;
  END ELIMINA_CENTRO;

  PROCEDURE EJECUTAR_SQL(ACCION IN VARCHAR2) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    EXECUTE IMMEDIATE ACCION;
  END EJECUTAR_SQL;

END BASE;
