PGDMP                           r            Prueba    9.3.2    9.3.2 �    �	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �	           1262    22602    Prueba    DATABASE     z   CREATE DATABASE "Prueba" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_VE.UTF-8' LC_CTYPE = 'es_VE.UTF-8';
    DROP DATABASE "Prueba";
             postgres    false                        2615    22603    odbclink    SCHEMA        CREATE SCHEMA odbclink;
    DROP SCHEMA odbclink;
             postgres    false            �	           0    0    odbclink    ACL     �   REVOKE ALL ON SCHEMA odbclink FROM PUBLIC;
REVOKE ALL ON SCHEMA odbclink FROM postgres;
GRANT ALL ON SCHEMA odbclink TO postgres;
GRANT USAGE ON SCHEMA odbclink TO PUBLIC;
                  postgres    false    7                        2615    22604    pdi    SCHEMA        CREATE SCHEMA pdi;
    DROP SCHEMA pdi;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    8            �	           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    8            �            3079    11833    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �	           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    224            �            3079    22607    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                  false    8            �	           0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                       false    225            h           1247    22655    conns    TYPE     j   CREATE TYPE conns AS (
	id integer,
	connected boolean,
	dsn text,
	uid text,
	pwd text,
	connstr text
);
    DROP TYPE odbclink.conns;
       odbclink       postgres    false    7                       1255    22663    unnest(anyarray)    FUNCTION     �   CREATE FUNCTION unnest(anyarray) RETURNS SETOF anyelement
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
select $1[i] from generate_series(array_lower($1,1), array_upper($1,1)) as i
$_$;
 '   DROP FUNCTION public.unnest(anyarray);
       public       postgres    false    8            �            1259    22664    activos    TABLE     �   CREATE TABLE activos (
    id integer NOT NULL,
    descripcion character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL
);
    DROP TABLE pdi.activos;
       pdi         postgres    false    6            �	           0    0    COLUMN activos.id    COMMENT     P   COMMENT ON COLUMN activos.id IS 'numero secuencial para identificar el activo';
            pdi       postgres    false    174            �	           0    0    COLUMN activos.descripcion    COMMENT     D   COMMENT ON COLUMN activos.descripcion IS 'descripción del activo';
            pdi       postgres    false    174            �	           0    0    COLUMN activos.fecha_registro    COMMENT     L   COMMENT ON COLUMN activos.fecha_registro IS 'fecha de registro del activo';
            pdi       postgres    false    174            �	           0    0    COLUMN activos.valido    COMMENT     c   COMMENT ON COLUMN activos.valido IS 'campo para indicar si el registro esta vigente (1) o no (0)';
            pdi       postgres    false    174            �            1259    22669    activos_id_seq    SEQUENCE     p   CREATE SEQUENCE activos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE pdi.activos_id_seq;
       pdi       postgres    false    6    174            �	           0    0    activos_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE activos_id_seq OWNED BY activos.id;
            pdi       postgres    false    175            �            1259    22671    arancelesempresas    TABLE     �  CREATE TABLE arancelesempresas (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    cod_arancelario integer NOT NULL,
    unidad_id integer NOT NULL,
    cantidad integer NOT NULL,
    monto_anual double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    empresa_id integer NOT NULL
);
 "   DROP TABLE pdi.arancelesempresas;
       pdi         postgres    false    6            �	           0    0    COLUMN arancelesempresas.id    COMMENT     q   COMMENT ON COLUMN arancelesempresas.id IS 'numero secuencial de para identificar los aranceles de las empresas';
            pdi       postgres    false    176            �	           0    0 $   COLUMN arancelesempresas.descripcion    COMMENT     O   COMMENT ON COLUMN arancelesempresas.descripcion IS 'descripción del arancel';
            pdi       postgres    false    176            �	           0    0 "   COLUMN arancelesempresas.unidad_id    COMMENT     p   COMMENT ON COLUMN arancelesempresas.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';
            pdi       postgres    false    176            �	           0    0 '   COLUMN arancelesempresas.fecha_registro    COMMENT     W   COMMENT ON COLUMN arancelesempresas.fecha_registro IS 'fecha de registro del arancel';
            pdi       postgres    false    176            �	           0    0    COLUMN arancelesempresas.valido    COMMENT     i   COMMENT ON COLUMN arancelesempresas.valido IS 'campo para identificar si el registro esta vigente o no';
            pdi       postgres    false    176            �	           0    0 #   COLUMN arancelesempresas.empresa_id    COMMENT     �   COMMENT ON COLUMN arancelesempresas.empresa_id IS 'campo foráneo que contiene el identificador de la empresa que viene de la tabla gen_juridico de BDCADIVI';
            pdi       postgres    false    176            �            1259    22676    arancelesempresas_id_seq    SEQUENCE     z   CREATE SEQUENCE arancelesempresas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE pdi.arancelesempresas_id_seq;
       pdi       postgres    false    176    6            �	           0    0    arancelesempresas_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE arancelesempresas_id_seq OWNED BY arancelesempresas.id;
            pdi       postgres    false    177            �            1259    22678    archivo_estatus    TABLE     �   CREATE TABLE archivo_estatus (
    archivo_id integer NOT NULL,
    estatus_id integer NOT NULL,
    valido character varying(1),
    fecha_registro timestamp without time zone DEFAULT now()
);
     DROP TABLE pdi.archivo_estatus;
       pdi         postgres    false    6            �            1259    22682    archivo_presupuestos_tmp    TABLE     y  CREATE TABLE archivo_presupuestos_tmp (
    codarancel_id integer,
    unidad_id integer,
    fecha_cierre date,
    montousd double precision,
    cantidad integer NOT NULL,
    num_empleados integer,
    fecha_registro timestamp without time zone DEFAULT now(),
    valido character varying(1) NOT NULL,
    empresa_id integer,
    id_archivo_presupuesto integer NOT NULL
);
 )   DROP TABLE pdi.archivo_presupuestos_tmp;
       pdi         postgres    false    6            �            1259    22686    bienes    TABLE     w  CREATE TABLE bienes (
    id integer NOT NULL,
    codarancel_id integer NOT NULL,
    unidad_id integer NOT NULL,
    cant_pro_actual double precision NOT NULL,
    capac_max_anual_actual double precision NOT NULL,
    proyecto_id integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL
);
    DROP TABLE pdi.bienes;
       pdi         postgres    false    6            �	           0    0    COLUMN bienes.id    COMMENT     V   COMMENT ON COLUMN bienes.id IS 'número secuencial de identificación de los bienes';
            pdi       postgres    false    180            �	           0    0    COLUMN bienes.unidad_id    COMMENT     e   COMMENT ON COLUMN bienes.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';
            pdi       postgres    false    180            �	           0    0    COLUMN bienes.proyecto_id    COMMENT     Y   COMMENT ON COLUMN bienes.proyecto_id IS 'campo foráneo que viene de la tabla proyecto';
            pdi       postgres    false    180            �	           0    0    COLUMN bienes.fecha_registro    COMMENT     L   COMMENT ON COLUMN bienes.fecha_registro IS 'fecha de registro del arancel';
            pdi       postgres    false    180            �	           0    0    COLUMN bienes.valido    COMMENT     ^   COMMENT ON COLUMN bienes.valido IS 'campo para identificar si el registro esta vigente o no';
            pdi       postgres    false    180            �            1259    22691    bienes_id_seq    SEQUENCE     o   CREATE SEQUENCE bienes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE pdi.bienes_id_seq;
       pdi       postgres    false    180    6            �	           0    0    bienes_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE bienes_id_seq OWNED BY bienes.id;
            pdi       postgres    false    181            �            1259    23073 
   cronograma    TABLE     d  CREATE TABLE cronograma (
    insumo character varying(30),
    cod_arancelario integer,
    unidad_id integer,
    cantidad integer,
    costo_total numeric(38,6),
    fecha_estimada date,
    fecha_registro timestamp without time zone,
    valido character varying(1),
    proyecto_id integer,
    tipo character varying(100),
    id integer NOT NULL
);
    DROP TABLE pdi.cronograma;
       pdi         postgres    false    6            �            1259    23103    cronograma_id_seq    SEQUENCE     s   CREATE SEQUENCE cronograma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE pdi.cronograma_id_seq;
       pdi       postgres    false    220    6            �	           0    0    cronograma_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cronograma_id_seq OWNED BY cronograma.id;
            pdi       postgres    false    223            �            1259    22707    datosbasicos    TABLE     �  CREATE TABLE datosbasicos (
    id integer NOT NULL,
    num_declaracion character varying(10) NOT NULL,
    fecha_islr date NOT NULL,
    monto_islr double precision NOT NULL,
    num_empleados integer NOT NULL,
    numero_declaracionivss character varying(10) NOT NULL,
    fecha_ivss date NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    empresa_id integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE pdi.datosbasicos;
       pdi         postgres    false    6            �	           0    0    COLUMN datosbasicos.id    COMMENT     v   COMMENT ON COLUMN datosbasicos.id IS 'número secuencial que identifica el conjunto de datos basicos de la empresas';
            pdi       postgres    false    182            �	           0    0    COLUMN datosbasicos.valido    COMMENT     d   COMMENT ON COLUMN datosbasicos.valido IS 'campo para identificar si el registro esta vigente o no';
            pdi       postgres    false    182            �            1259    22712    datosbasicos_id_seq    SEQUENCE     u   CREATE SEQUENCE datosbasicos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE pdi.datosbasicos_id_seq;
       pdi       postgres    false    182    6            �	           0    0    datosbasicos_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE datosbasicos_id_seq OWNED BY datosbasicos.id;
            pdi       postgres    false    183            �            1259    22714    entidadesfinancieras    TABLE     �  CREATE TABLE entidadesfinancieras (
    id integer NOT NULL,
    financiamiento_id integer NOT NULL,
    capitalfinanciado double precision NOT NULL,
    banco_id integer NOT NULL,
    tasainteres double precision NOT NULL,
    anualidades double precision NOT NULL,
    plazoprestamo date NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL
);
 %   DROP TABLE pdi.entidadesfinancieras;
       pdi         postgres    false    6            �	           0    0    COLUMN entidadesfinancieras.id    COMMENT     h   COMMENT ON COLUMN entidadesfinancieras.id IS 'número secuencial que identifica la entidad financiera';
            pdi       postgres    false    184            �	           0    0 -   COLUMN entidadesfinancieras.financiamiento_id    COMMENT     t   COMMENT ON COLUMN entidadesfinancieras.financiamiento_id IS 'campo foráneo que viene de la tabla financiamientos';
            pdi       postgres    false    184            �	           0    0 *   COLUMN entidadesfinancieras.fecha_registro    COMMENT     Z   COMMENT ON COLUMN entidadesfinancieras.fecha_registro IS 'fecha de registro del arancel';
            pdi       postgres    false    184            �	           0    0 "   COLUMN entidadesfinancieras.valido    COMMENT     l   COMMENT ON COLUMN entidadesfinancieras.valido IS 'campo para identificar si el registro esta vigente o no';
            pdi       postgres    false    184            �            1259    22719    entidadesfinancieras_id_seq    SEQUENCE     }   CREATE SEQUENCE entidadesfinancieras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE pdi.entidadesfinancieras_id_seq;
       pdi       postgres    false    6    184            �	           0    0    entidadesfinancieras_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE entidadesfinancieras_id_seq OWNED BY entidadesfinancieras.id;
            pdi       postgres    false    185            �            1259    22721    estado    TABLE     ^   CREATE TABLE estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);
    DROP TABLE pdi.estado;
       pdi         postgres    false    6            �            1259    22724    estatus    TABLE     �   CREATE TABLE estatus (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    fecha_registro date,
    valido character varying(1) NOT NULL
);
    DROP TABLE pdi.estatus;
       pdi         postgres    false    6            �            1259    23080    exportaciones_paises    TABLE     z   CREATE TABLE exportaciones_paises (
    id integer NOT NULL,
    cpais character varying(6),
    cronograma_id integer
);
 %   DROP TABLE pdi.exportaciones_paises;
       pdi         postgres    false    6            �            1259    23078    exportaciones_paises_id_seq    SEQUENCE     }   CREATE SEQUENCE exportaciones_paises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE pdi.exportaciones_paises_id_seq;
       pdi       postgres    false    6    222            �	           0    0    exportaciones_paises_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE exportaciones_paises_id_seq OWNED BY exportaciones_paises.id;
            pdi       postgres    false    221            �            1259    22727    financiamientos    TABLE     1  CREATE TABLE financiamientos (
    id integer NOT NULL,
    capitalpropio double precision NOT NULL,
    proyecto_id integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    tipo_financiamiento_id integer NOT NULL
);
     DROP TABLE pdi.financiamientos;
       pdi         postgres    false    6            �	           0    0    COLUMN financiamientos.id    COMMENT     a   COMMENT ON COLUMN financiamientos.id IS 'número secuencial para identificar el financiamiento';
            pdi       postgres    false    188            �	           0    0 "   COLUMN financiamientos.proyecto_id    COMMENT     d   COMMENT ON COLUMN financiamientos.proyecto_id IS 'campo foránero que viene de la tabla proyectos';
            pdi       postgres    false    188            �	           0    0 %   COLUMN financiamientos.fecha_registro    COMMENT     U   COMMENT ON COLUMN financiamientos.fecha_registro IS 'fecha de registro del arancel';
            pdi       postgres    false    188            �	           0    0    COLUMN financiamientos.valido    COMMENT     g   COMMENT ON COLUMN financiamientos.valido IS 'campo para identificar si el registro esta vigente o no';
            pdi       postgres    false    188            �	           0    0 -   COLUMN financiamientos.tipo_financiamiento_id    COMMENT     x   COMMENT ON COLUMN financiamientos.tipo_financiamiento_id IS 'campo foráneo que viene de la tabla tipo financiamiento';
            pdi       postgres    false    188            �            1259    22732    financiamientos_id_seq    SEQUENCE     x   CREATE SEQUENCE financiamientos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE pdi.financiamientos_id_seq;
       pdi       postgres    false    188    6            �	           0    0    financiamientos_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE financiamientos_id_seq OWNED BY financiamientos.id;
            pdi       postgres    false    189            �            1259    22734 
   flujocajas    TABLE     �  CREATE TABLE flujocajas (
    id integer NOT NULL,
    inversion double precision NOT NULL,
    prestamo double precision NOT NULL,
    ingresos double precision NOT NULL,
    costos double precision NOT NULL,
    reinversion double precision NOT NULL,
    valor_residual double precision NOT NULL,
    pagos double precision NOT NULL,
    depreciacion_negativo double precision NOT NULL,
    utilidad_antesimp double precision NOT NULL,
    utilidad_despuesimp double precision NOT NULL,
    impuestos double precision NOT NULL,
    depreciacion_positivo double precision NOT NULL,
    flujo_operativo double precision NOT NULL,
    flujo_proyectado double precision NOT NULL,
    ingresos_rcb double precision NOT NULL,
    costos_rcb double precision NOT NULL,
    ingresos_rcbact double precision NOT NULL,
    costos_rcbact double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    proyecto_id integer NOT NULL
);
    DROP TABLE pdi.flujocajas;
       pdi         postgres    false    6            �            1259    22739    flujocajas_id_seq    SEQUENCE     s   CREATE SEQUENCE flujocajas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE pdi.flujocajas_id_seq;
       pdi       postgres    false    6    190            �	           0    0    flujocajas_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE flujocajas_id_seq OWNED BY flujocajas.id;
            pdi       postgres    false    191            �            1259    22741 	   municipio    TABLE     �   CREATE TABLE municipio (
    id integer NOT NULL,
    descripcion character varying(45) NOT NULL,
    estado_id integer NOT NULL
);
    DROP TABLE pdi.municipio;
       pdi         postgres    false    6            �            1259    22744 	   parroquia    TABLE     �   CREATE TABLE parroquia (
    id integer NOT NULL,
    descripcion character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);
    DROP TABLE pdi.parroquia;
       pdi         postgres    false    6            �            1259    22747    planinversion    TABLE     |  CREATE TABLE planinversion (
    id integer NOT NULL,
    activo_id integer NOT NULL,
    monto_total double precision NOT NULL,
    fondospropios double precision NOT NULL,
    financiamiento double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    proyecto_id integer NOT NULL
);
    DROP TABLE pdi.planinversion;
       pdi         postgres    false    6            �            1259    22752    planinversion_id_seq    SEQUENCE     v   CREATE SEQUENCE planinversion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE pdi.planinversion_id_seq;
       pdi       postgres    false    194    6            �	           0    0    planinversion_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE planinversion_id_seq OWNED BY planinversion.id;
            pdi       postgres    false    195            �            1259    22754    presupuestos    TABLE       CREATE TABLE presupuestos (
    id integer NOT NULL,
    codarancel_id integer NOT NULL,
    unidad_id integer NOT NULL,
    fecha_cierre date NOT NULL,
    cantidad integer NOT NULL,
    montousd double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    empresa_id integer NOT NULL
);
    DROP TABLE pdi.presupuestos;
       pdi         postgres    false    6            �            1259    22759    presupuestos_id_seq    SEQUENCE     u   CREATE SEQUENCE presupuestos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE pdi.presupuestos_id_seq;
       pdi       postgres    false    6    196            �	           0    0    presupuestos_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE presupuestos_id_seq OWNED BY presupuestos.id;
            pdi       postgres    false    197            �            1259    22761 	   proyectos    TABLE     �  CREATE TABLE proyectos (
    id integer NOT NULL,
    objetivoproducto text NOT NULL,
    nom_proyecto text NOT NULL,
    puntoreferencia text NOT NULL,
    calleavenida text NOT NULL,
    coordenadasutm text NOT NULL,
    empresa_id integer NOT NULL,
    tipo_proyecto_id integer NOT NULL,
    estado_id integer NOT NULL,
    municipio_id integer NOT NULL,
    ciudad character varying(30) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    mes_inicio character varying(15) NOT NULL,
    ano_inicio character varying(4) NOT NULL,
    mes_fin character varying(15) NOT NULL,
    ano_fin character varying(4) NOT NULL
);
    DROP TABLE pdi.proyectos;
       pdi         postgres    false    6            �            1259    22769    proyectos_id_seq    SEQUENCE     r   CREATE SEQUENCE proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE pdi.proyectos_id_seq;
       pdi       postgres    false    6    198            �	           0    0    proyectos_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE proyectos_id_seq OWNED BY proyectos.id;
            pdi       postgres    false    199            �            1259    22771    tipoproyectos    TABLE     �   CREATE TABLE tipoproyectos (
    id integer NOT NULL,
    descripcion character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL
);
    DROP TABLE pdi.tipoproyectos;
       pdi         postgres    false    6            �            1259    22776    tipoproyectos_id_seq    SEQUENCE     v   CREATE SEQUENCE tipoproyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE pdi.tipoproyectos_id_seq;
       pdi       postgres    false    200    6            �	           0    0    tipoproyectos_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE tipoproyectos_id_seq OWNED BY tipoproyectos.id;
            pdi       postgres    false    201            �            1259    22778    tiposfinanciamiento    TABLE     �   CREATE TABLE tiposfinanciamiento (
    id integer NOT NULL,
    descripcion character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL
);
 $   DROP TABLE pdi.tiposfinanciamiento;
       pdi         postgres    false    6            �            1259    22783    tiposfinanciamiento_id_seq    SEQUENCE     |   CREATE SEQUENCE tiposfinanciamiento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE pdi.tiposfinanciamiento_id_seq;
       pdi       postgres    false    202    6            �	           0    0    tiposfinanciamiento_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE tiposfinanciamiento_id_seq OWNED BY tiposfinanciamiento.id;
            pdi       postgres    false    203            �            1259    22785    totalflujocajas    TABLE     �  CREATE TABLE totalflujocajas (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    valor_neto double precision NOT NULL,
    costo_beneficio double precision NOT NULL,
    tasa_retorno double precision NOT NULL,
    tasa_rendimineto double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL
);
     DROP TABLE pdi.totalflujocajas;
       pdi         postgres    false    6            �            1259    22790    totalflujocajas_id_seq    SEQUENCE     x   CREATE SEQUENCE totalflujocajas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE pdi.totalflujocajas_id_seq;
       pdi       postgres    false    204    6            �	           0    0    totalflujocajas_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE totalflujocajas_id_seq OWNED BY totalflujocajas.id;
            pdi       postgres    false    205            �            1259    22792 
   det_bienes    TABLE     M  CREATE TABLE det_bienes (
    id integer NOT NULL,
    carancelario integer NOT NULL,
    nunidadmedida double precision NOT NULL,
    cant_pro_actual double precision NOT NULL,
    capac_max_anual_actual double precision NOT NULL,
    proyecto_id integer NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL
);
    DROP TABLE public.det_bienes;
       public         postgres    false    8            �            1259    22795    det_plan_inversion    TABLE     �  CREATE TABLE det_plan_inversion (
    id integer NOT NULL,
    activo_id integer NOT NULL,
    mtotal double precision NOT NULL,
    mfondospropios double precision NOT NULL,
    nfinanciamiento double precision NOT NULL,
    nempresa integer NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL,
    cusuario character varying(50) NOT NULL,
    gen_activos_id integer NOT NULL
);
 &   DROP TABLE public.det_plan_inversion;
       public         postgres    false    8            �            1259    22798    det_presupuesto    TABLE       CREATE TABLE det_presupuesto (
    id integer NOT NULL,
    codarancelsol integer NOT NULL,
    carancelario integer NOT NULL,
    cunidadmedida character varying(15) NOT NULL,
    montousd double precision NOT NULL,
    festimadacierre date NOT NULL,
    fregistro date NOT NULL,
    nusuario integer NOT NULL,
    bestatus character(1) NOT NULL,
    cusuario character varying(50) NOT NULL,
    cid integer NOT NULL,
    estado_id integer NOT NULL,
    municipio_id integer NOT NULL,
    parroquia_id integer NOT NULL
);
 #   DROP TABLE public.det_presupuesto;
       public         postgres    false    8            �            1259    22801    estatus    TABLE     �   CREATE TABLE estatus (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    fecha_registro date,
    valido character varying(1) NOT NULL
);
    DROP TABLE public.estatus;
       public         postgres    false    8            �            1259    22804    gen_activos    TABLE     �   CREATE TABLE gen_activos (
    id integer NOT NULL,
    dactivo character varying(150) NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL
);
    DROP TABLE public.gen_activos;
       public         postgres    false    8            �            1259    22807 
   gen_estado    TABLE     b   CREATE TABLE gen_estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);
    DROP TABLE public.gen_estado;
       public         postgres    false    8            �            1259    22810    gen_financiamiento    TABLE     �  CREATE TABLE gen_financiamiento (
    id integer NOT NULL,
    mcapitalpropio double precision NOT NULL,
    mcapitalfinanciado double precision NOT NULL,
    nbanco integer NOT NULL,
    ctasainteres character varying(10) NOT NULL,
    manualidades double precision NOT NULL,
    fplazoprestamo date NOT NULL,
    nempresa integer NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL,
    get_tipo_financiamiento_id integer NOT NULL,
    cusuario character varying(50) NOT NULL
);
 &   DROP TABLE public.gen_financiamiento;
       public         postgres    false    8            �            1259    22813    gen_municipio    TABLE     �   CREATE TABLE gen_municipio (
    id integer NOT NULL,
    dmunicipio character varying(45) NOT NULL,
    estado_id integer NOT NULL
);
 !   DROP TABLE public.gen_municipio;
       public         postgres    false    8            �            1259    23064    gen_pais    TABLE     h  CREATE TABLE gen_pais (
    cpais character varying(6) DEFAULT 1000 NOT NULL,
    dpais character varying(30) NOT NULL,
    sesion_id character varying(30) DEFAULT 0 NOT NULL,
    ddocumento_identificacion character varying(30) DEFAULT 0 NOT NULL,
    cdivisa_aceptada character varying(100) NOT NULL,
    bfiltroliq character varying(1) DEFAULT 1 NOT NULL
);
    DROP TABLE public.gen_pais;
       public         postgres    false    8            �            1259    22816    gen_parroquia    TABLE     �   CREATE TABLE gen_parroquia (
    id integer NOT NULL,
    dparroquia character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);
 !   DROP TABLE public.gen_parroquia;
       public         postgres    false    8            �            1259    22819    gen_proyecto    TABLE     #  CREATE TABLE gen_proyecto (
    id integer NOT NULL,
    dobjetivoproducto character varying(150) NOT NULL,
    dnombreproyecto character varying(150) NOT NULL,
    dpuntoreferencia character varying(150) NOT NULL,
    dcalleavenida character varying(150) NOT NULL,
    ccoordenadasutm character varying(100) NOT NULL,
    finicio date NOT NULL,
    ffin date NOT NULL,
    fregistro date NOT NULL,
    nempresa integer NOT NULL,
    bestatus character(1),
    cusuario character varying(50) NOT NULL,
    gen_tipo_proyecto_id integer NOT NULL
);
     DROP TABLE public.gen_proyecto;
       public         postgres    false    8            �            1259    22825    gen_tipo_financiamiento    TABLE     r   CREATE TABLE gen_tipo_financiamiento (
    id integer NOT NULL,
    dtipofinaciamiento character(250) NOT NULL
);
 +   DROP TABLE public.gen_tipo_financiamiento;
       public         postgres    false    8            �            1259    22828    gen_tipo_proyecto    TABLE     �   CREATE TABLE gen_tipo_proyecto (
    id integer NOT NULL,
    dtipoproyecto character varying(80) NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL
);
 %   DROP TABLE public.gen_tipo_proyecto;
       public         postgres    false    8            �            1259    23058    gen_unidades    TABLE     �   CREATE TABLE gen_unidades (
    cunidad character varying(4) NOT NULL,
    dunidad character varying(70) NOT NULL,
    sesion_id character varying(30) DEFAULT 0 NOT NULL
);
     DROP TABLE public.gen_unidades;
       public         postgres    false    8            O           2604    22831    id    DEFAULT     Z   ALTER TABLE ONLY activos ALTER COLUMN id SET DEFAULT nextval('activos_id_seq'::regclass);
 6   ALTER TABLE pdi.activos ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    175    174            R           2604    22832    id    DEFAULT     n   ALTER TABLE ONLY arancelesempresas ALTER COLUMN id SET DEFAULT nextval('arancelesempresas_id_seq'::regclass);
 @   ALTER TABLE pdi.arancelesempresas ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    177    176            W           2604    22833    id    DEFAULT     X   ALTER TABLE ONLY bienes ALTER COLUMN id SET DEFAULT nextval('bienes_id_seq'::regclass);
 5   ALTER TABLE pdi.bienes ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    181    180            {           2604    23105    id    DEFAULT     `   ALTER TABLE ONLY cronograma ALTER COLUMN id SET DEFAULT nextval('cronograma_id_seq'::regclass);
 9   ALTER TABLE pdi.cronograma ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    223    220            Z           2604    22836    id    DEFAULT     d   ALTER TABLE ONLY datosbasicos ALTER COLUMN id SET DEFAULT nextval('datosbasicos_id_seq'::regclass);
 ;   ALTER TABLE pdi.datosbasicos ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    183    182            ]           2604    22837    id    DEFAULT     t   ALTER TABLE ONLY entidadesfinancieras ALTER COLUMN id SET DEFAULT nextval('entidadesfinancieras_id_seq'::regclass);
 C   ALTER TABLE pdi.entidadesfinancieras ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    185    184            |           2604    23083    id    DEFAULT     t   ALTER TABLE ONLY exportaciones_paises ALTER COLUMN id SET DEFAULT nextval('exportaciones_paises_id_seq'::regclass);
 C   ALTER TABLE pdi.exportaciones_paises ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    222    221    222            `           2604    22838    id    DEFAULT     j   ALTER TABLE ONLY financiamientos ALTER COLUMN id SET DEFAULT nextval('financiamientos_id_seq'::regclass);
 >   ALTER TABLE pdi.financiamientos ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    189    188            c           2604    22839    id    DEFAULT     `   ALTER TABLE ONLY flujocajas ALTER COLUMN id SET DEFAULT nextval('flujocajas_id_seq'::regclass);
 9   ALTER TABLE pdi.flujocajas ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    191    190            f           2604    22840    id    DEFAULT     f   ALTER TABLE ONLY planinversion ALTER COLUMN id SET DEFAULT nextval('planinversion_id_seq'::regclass);
 <   ALTER TABLE pdi.planinversion ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    195    194            i           2604    22841    id    DEFAULT     d   ALTER TABLE ONLY presupuestos ALTER COLUMN id SET DEFAULT nextval('presupuestos_id_seq'::regclass);
 ;   ALTER TABLE pdi.presupuestos ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    197    196            j           2604    22842    id    DEFAULT     ^   ALTER TABLE ONLY proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos_id_seq'::regclass);
 8   ALTER TABLE pdi.proyectos ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    199    198            o           2604    22843    id    DEFAULT     f   ALTER TABLE ONLY tipoproyectos ALTER COLUMN id SET DEFAULT nextval('tipoproyectos_id_seq'::regclass);
 <   ALTER TABLE pdi.tipoproyectos ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    201    200            r           2604    22844    id    DEFAULT     r   ALTER TABLE ONLY tiposfinanciamiento ALTER COLUMN id SET DEFAULT nextval('tiposfinanciamiento_id_seq'::regclass);
 B   ALTER TABLE pdi.tiposfinanciamiento ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    203    202            u           2604    22845    id    DEFAULT     j   ALTER TABLE ONLY totalflujocajas ALTER COLUMN id SET DEFAULT nextval('totalflujocajas_id_seq'::regclass);
 >   ALTER TABLE pdi.totalflujocajas ALTER COLUMN id DROP DEFAULT;
       pdi       postgres    false    205    204            P	          0    22664    activos 
   TABLE DATA               C   COPY activos (id, descripcion, fecha_registro, valido) FROM stdin;
    pdi       postgres    false    174   ;      �	           0    0    activos_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('activos_id_seq', 1, false);
            pdi       postgres    false    175            R	          0    22671    arancelesempresas 
   TABLE DATA               �   COPY arancelesempresas (id, descripcion, cod_arancelario, unidad_id, cantidad, monto_anual, fecha_registro, valido, empresa_id) FROM stdin;
    pdi       postgres    false    176   X      �	           0    0    arancelesempresas_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('arancelesempresas_id_seq', 1, false);
            pdi       postgres    false    177            T	          0    22678    archivo_estatus 
   TABLE DATA               R   COPY archivo_estatus (archivo_id, estatus_id, valido, fecha_registro) FROM stdin;
    pdi       postgres    false    178   u      U	          0    22682    archivo_presupuestos_tmp 
   TABLE DATA               �   COPY archivo_presupuestos_tmp (codarancel_id, unidad_id, fecha_cierre, montousd, cantidad, num_empleados, fecha_registro, valido, empresa_id, id_archivo_presupuesto) FROM stdin;
    pdi       postgres    false    179   �      V	          0    22686    bienes 
   TABLE DATA               �   COPY bienes (id, codarancel_id, unidad_id, cant_pro_actual, capac_max_anual_actual, proyecto_id, fecha_registro, valido) FROM stdin;
    pdi       postgres    false    180   �      �	           0    0    bienes_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('bienes_id_seq', 1, false);
            pdi       postgres    false    181            ~	          0    23073 
   cronograma 
   TABLE DATA               �   COPY cronograma (insumo, cod_arancelario, unidad_id, cantidad, costo_total, fecha_estimada, fecha_registro, valido, proyecto_id, tipo, id) FROM stdin;
    pdi       postgres    false    220   �      �	           0    0    cronograma_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cronograma_id_seq', 1, false);
            pdi       postgres    false    223            X	          0    22707    datosbasicos 
   TABLE DATA               �   COPY datosbasicos (id, num_declaracion, fecha_islr, monto_islr, num_empleados, numero_declaracionivss, fecha_ivss, valido, empresa_id, fecha_registro) FROM stdin;
    pdi       postgres    false    182   �      �	           0    0    datosbasicos_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('datosbasicos_id_seq', 19, true);
            pdi       postgres    false    183            Z	          0    22714    entidadesfinancieras 
   TABLE DATA               �   COPY entidadesfinancieras (id, financiamiento_id, capitalfinanciado, banco_id, tasainteres, anualidades, plazoprestamo, fecha_registro, valido) FROM stdin;
    pdi       postgres    false    184         �	           0    0    entidadesfinancieras_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('entidadesfinancieras_id_seq', 1, false);
            pdi       postgres    false    185            \	          0    22721    estado 
   TABLE DATA               &   COPY estado (id, destado) FROM stdin;
    pdi       postgres    false    186   #      ]	          0    22724    estatus 
   TABLE DATA               C   COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
    pdi       postgres    false    187   @      �	          0    23080    exportaciones_paises 
   TABLE DATA               A   COPY exportaciones_paises (id, cpais, cronograma_id) FROM stdin;
    pdi       postgres    false    222   ]      �	           0    0    exportaciones_paises_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('exportaciones_paises_id_seq', 1, false);
            pdi       postgres    false    221            ^	          0    22727    financiamientos 
   TABLE DATA               r   COPY financiamientos (id, capitalpropio, proyecto_id, fecha_registro, valido, tipo_financiamiento_id) FROM stdin;
    pdi       postgres    false    188   z      �	           0    0    financiamientos_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('financiamientos_id_seq', 1, false);
            pdi       postgres    false    189            `	          0    22734 
   flujocajas 
   TABLE DATA               P  COPY flujocajas (id, inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact, fecha_registro, estatus, proyecto_id) FROM stdin;
    pdi       postgres    false    190   �      �	           0    0    flujocajas_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('flujocajas_id_seq', 1, false);
            pdi       postgres    false    191            b	          0    22741 	   municipio 
   TABLE DATA               8   COPY municipio (id, descripcion, estado_id) FROM stdin;
    pdi       postgres    false    192   �      c	          0    22744 	   parroquia 
   TABLE DATA               ;   COPY parroquia (id, descripcion, municipio_id) FROM stdin;
    pdi       postgres    false    193   �      d	          0    22747    planinversion 
   TABLE DATA               �   COPY planinversion (id, activo_id, monto_total, fondospropios, financiamiento, fecha_registro, estatus, proyecto_id) FROM stdin;
    pdi       postgres    false    194   �      �	           0    0    planinversion_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('planinversion_id_seq', 1, false);
            pdi       postgres    false    195            f	          0    22754    presupuestos 
   TABLE DATA               �   COPY presupuestos (id, codarancel_id, unidad_id, fecha_cierre, cantidad, montousd, fecha_registro, estatus, empresa_id) FROM stdin;
    pdi       postgres    false    196         �	           0    0    presupuestos_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('presupuestos_id_seq', 1, false);
            pdi       postgres    false    197            h	          0    22761 	   proyectos 
   TABLE DATA               �   COPY proyectos (id, objetivoproducto, nom_proyecto, puntoreferencia, calleavenida, coordenadasutm, empresa_id, tipo_proyecto_id, estado_id, municipio_id, ciudad, fecha_registro, estatus, mes_inicio, ano_inicio, mes_fin, ano_fin) FROM stdin;
    pdi       postgres    false    198   (      �	           0    0    proyectos_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('proyectos_id_seq', 1, false);
            pdi       postgres    false    199            j	          0    22771    tipoproyectos 
   TABLE DATA               J   COPY tipoproyectos (id, descripcion, fecha_registro, estatus) FROM stdin;
    pdi       postgres    false    200   �      �	           0    0    tipoproyectos_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('tipoproyectos_id_seq', 1, false);
            pdi       postgres    false    201            l	          0    22778    tiposfinanciamiento 
   TABLE DATA               P   COPY tiposfinanciamiento (id, descripcion, fecha_registro, estatus) FROM stdin;
    pdi       postgres    false    202   �      �	           0    0    tiposfinanciamiento_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('tiposfinanciamiento_id_seq', 1, false);
            pdi       postgres    false    203            n	          0    22785    totalflujocajas 
   TABLE DATA               �   COPY totalflujocajas (id, proyecto_id, valor_neto, costo_beneficio, tasa_retorno, tasa_rendimineto, fecha_registro, estatus) FROM stdin;
    pdi       postgres    false    204   �      �	           0    0    totalflujocajas_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('totalflujocajas_id_seq', 1, false);
            pdi       postgres    false    205            p	          0    22792 
   det_bienes 
   TABLE DATA               �   COPY det_bienes (id, carancelario, nunidadmedida, cant_pro_actual, capac_max_anual_actual, proyecto_id, fregistro, bestatus) FROM stdin;
    public       postgres    false    206   
      q	          0    22795    det_plan_inversion 
   TABLE DATA               �   COPY det_plan_inversion (id, activo_id, mtotal, mfondospropios, nfinanciamiento, nempresa, fregistro, bestatus, cusuario, gen_activos_id) FROM stdin;
    public       postgres    false    207   '      r	          0    22798    det_presupuesto 
   TABLE DATA               �   COPY det_presupuesto (id, codarancelsol, carancelario, cunidadmedida, montousd, festimadacierre, fregistro, nusuario, bestatus, cusuario, cid, estado_id, municipio_id, parroquia_id) FROM stdin;
    public       postgres    false    208   D      s	          0    22801    estatus 
   TABLE DATA               C   COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
    public       postgres    false    209   a      t	          0    22804    gen_activos 
   TABLE DATA               @   COPY gen_activos (id, dactivo, fregistro, bestatus) FROM stdin;
    public       postgres    false    210   ~      u	          0    22807 
   gen_estado 
   TABLE DATA               *   COPY gen_estado (id, destado) FROM stdin;
    public       postgres    false    211   �      v	          0    22810    gen_financiamiento 
   TABLE DATA               �   COPY gen_financiamiento (id, mcapitalpropio, mcapitalfinanciado, nbanco, ctasainteres, manualidades, fplazoprestamo, nempresa, fregistro, bestatus, get_tipo_financiamiento_id, cusuario) FROM stdin;
    public       postgres    false    212   �      w	          0    22813    gen_municipio 
   TABLE DATA               ;   COPY gen_municipio (id, dmunicipio, estado_id) FROM stdin;
    public       postgres    false    213   �      }	          0    23064    gen_pais 
   TABLE DATA               m   COPY gen_pais (cpais, dpais, sesion_id, ddocumento_identificacion, cdivisa_aceptada, bfiltroliq) FROM stdin;
    public       postgres    false    219   �      x	          0    22816    gen_parroquia 
   TABLE DATA               >   COPY gen_parroquia (id, dparroquia, municipio_id) FROM stdin;
    public       postgres    false    214   �%      y	          0    22819    gen_proyecto 
   TABLE DATA               �   COPY gen_proyecto (id, dobjetivoproducto, dnombreproyecto, dpuntoreferencia, dcalleavenida, ccoordenadasutm, finicio, ffin, fregistro, nempresa, bestatus, cusuario, gen_tipo_proyecto_id) FROM stdin;
    public       postgres    false    215   �%      z	          0    22825    gen_tipo_financiamiento 
   TABLE DATA               B   COPY gen_tipo_financiamiento (id, dtipofinaciamiento) FROM stdin;
    public       postgres    false    216   �%      {	          0    22828    gen_tipo_proyecto 
   TABLE DATA               L   COPY gen_tipo_proyecto (id, dtipoproyecto, fregistro, bestatus) FROM stdin;
    public       postgres    false    217   &      |	          0    23058    gen_unidades 
   TABLE DATA               <   COPY gen_unidades (cunidad, dunidad, sesion_id) FROM stdin;
    public       postgres    false    218   3&      �           2606    22847 	   bienes_pk 
   CONSTRAINT     G   ALTER TABLE ONLY bienes
    ADD CONSTRAINT bienes_pk PRIMARY KEY (id);
 7   ALTER TABLE ONLY pdi.bienes DROP CONSTRAINT bienes_pk;
       pdi         postgres    false    180    180            �           2606    22849 	   estado_pk 
   CONSTRAINT     G   ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);
 7   ALTER TABLE ONLY pdi.estado DROP CONSTRAINT estado_pk;
       pdi         postgres    false    186    186            �           2606    23085    exportacion_pais_id 
   CONSTRAINT     _   ALTER TABLE ONLY exportaciones_paises
    ADD CONSTRAINT exportacion_pais_id PRIMARY KEY (id);
 O   ALTER TABLE ONLY pdi.exportaciones_paises DROP CONSTRAINT exportacion_pais_id;
       pdi         postgres    false    222    222            ~           2606    22851 
   id_activos 
   CONSTRAINT     I   ALTER TABLE ONLY activos
    ADD CONSTRAINT id_activos PRIMARY KEY (id);
 9   ALTER TABLE ONLY pdi.activos DROP CONSTRAINT id_activos;
       pdi         postgres    false    174    174            �           2606    22853    id_arancelesempresa 
   CONSTRAINT     \   ALTER TABLE ONLY arancelesempresas
    ADD CONSTRAINT id_arancelesempresa PRIMARY KEY (id);
 L   ALTER TABLE ONLY pdi.arancelesempresas DROP CONSTRAINT id_arancelesempresa;
       pdi         postgres    false    176    176            �           2606    22855    id_archivo_estatus 
   CONSTRAINT     m   ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT id_archivo_estatus PRIMARY KEY (archivo_id, estatus_id);
 I   ALTER TABLE ONLY pdi.archivo_estatus DROP CONSTRAINT id_archivo_estatus;
       pdi         postgres    false    178    178    178            �           2606    22857    id_archivo_presupuestos 
   CONSTRAINT     {   ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT id_archivo_presupuestos PRIMARY KEY (id_archivo_presupuesto);
 W   ALTER TABLE ONLY pdi.archivo_presupuestos_tmp DROP CONSTRAINT id_archivo_presupuestos;
       pdi         postgres    false    179    179            �           2606    22859    id_datosbasicos 
   CONSTRAINT     S   ALTER TABLE ONLY datosbasicos
    ADD CONSTRAINT id_datosbasicos PRIMARY KEY (id);
 C   ALTER TABLE ONLY pdi.datosbasicos DROP CONSTRAINT id_datosbasicos;
       pdi         postgres    false    182    182            �           2606    22861    id_entidadesfinancieras 
   CONSTRAINT     c   ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT id_entidadesfinancieras PRIMARY KEY (id);
 S   ALTER TABLE ONLY pdi.entidadesfinancieras DROP CONSTRAINT id_entidadesfinancieras;
       pdi         postgres    false    184    184            �           2606    22863 
   id_estatus 
   CONSTRAINT     I   ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);
 9   ALTER TABLE ONLY pdi.estatus DROP CONSTRAINT id_estatus;
       pdi         postgres    false    187    187            �           2606    22867    id_financiamientos 
   CONSTRAINT     Y   ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT id_financiamientos PRIMARY KEY (id);
 I   ALTER TABLE ONLY pdi.financiamientos DROP CONSTRAINT id_financiamientos;
       pdi         postgres    false    188    188            �           2606    22869    id_flujocajas 
   CONSTRAINT     O   ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT id_flujocajas PRIMARY KEY (id);
 ?   ALTER TABLE ONLY pdi.flujocajas DROP CONSTRAINT id_flujocajas;
       pdi         postgres    false    190    190            �           2606    22873    id_presupuestos 
   CONSTRAINT     S   ALTER TABLE ONLY presupuestos
    ADD CONSTRAINT id_presupuestos PRIMARY KEY (id);
 C   ALTER TABLE ONLY pdi.presupuestos DROP CONSTRAINT id_presupuestos;
       pdi         postgres    false    196    196            �           2606    22875    id_tipofinanciamiento 
   CONSTRAINT     `   ALTER TABLE ONLY tiposfinanciamiento
    ADD CONSTRAINT id_tipofinanciamiento PRIMARY KEY (id);
 P   ALTER TABLE ONLY pdi.tiposfinanciamiento DROP CONSTRAINT id_tipofinanciamiento;
       pdi         postgres    false    202    202            �           2606    22877    id_tipoproyectos 
   CONSTRAINT     U   ALTER TABLE ONLY tipoproyectos
    ADD CONSTRAINT id_tipoproyectos PRIMARY KEY (id);
 E   ALTER TABLE ONLY pdi.tipoproyectos DROP CONSTRAINT id_tipoproyectos;
       pdi         postgres    false    200    200            �           2606    22879    id_totalflujocajas 
   CONSTRAINT     Y   ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT id_totalflujocajas PRIMARY KEY (id);
 I   ALTER TABLE ONLY pdi.totalflujocajas DROP CONSTRAINT id_totalflujocajas;
       pdi         postgres    false    204    204            �           2606    22881    municipio_pk 
   CONSTRAINT     M   ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);
 =   ALTER TABLE ONLY pdi.municipio DROP CONSTRAINT municipio_pk;
       pdi         postgres    false    192    192            �           2606    22883    parroquia_pk 
   CONSTRAINT     M   ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);
 =   ALTER TABLE ONLY pdi.parroquia DROP CONSTRAINT parroquia_pk;
       pdi         postgres    false    193    193            �           2606    23110    pk_cronograma_id 
   CONSTRAINT     R   ALTER TABLE ONLY cronograma
    ADD CONSTRAINT pk_cronograma_id PRIMARY KEY (id);
 B   ALTER TABLE ONLY pdi.cronograma DROP CONSTRAINT pk_cronograma_id;
       pdi         postgres    false    220    220            �           2606    22885    planinversion_pk 
   CONSTRAINT     U   ALTER TABLE ONLY planinversion
    ADD CONSTRAINT planinversion_pk PRIMARY KEY (id);
 E   ALTER TABLE ONLY pdi.planinversion DROP CONSTRAINT planinversion_pk;
       pdi         postgres    false    194    194            �           2606    22887    proyectos_pk 
   CONSTRAINT     M   ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_pk PRIMARY KEY (id);
 =   ALTER TABLE ONLY pdi.proyectos DROP CONSTRAINT proyectos_pk;
       pdi         postgres    false    198    198            �           2606    22889    descripcion__un 
   CONSTRAINT     W   ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT descripcion__un UNIQUE (dmunicipio);
 G   ALTER TABLE ONLY public.gen_municipio DROP CONSTRAINT descripcion__un;
       public         postgres    false    213    213            �           2606    22891    det_bienes_PK 
   CONSTRAINT     Q   ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT "det_bienes_PK" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.det_bienes DROP CONSTRAINT "det_bienes_PK";
       public         postgres    false    206    206            �           2606    22893    det_plan_inversion_pk 
   CONSTRAINT     _   ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_pk PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.det_plan_inversion DROP CONSTRAINT det_plan_inversion_pk;
       public         postgres    false    207    207            �           2606    22895    det_presupuesto_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_pk PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.det_presupuesto DROP CONSTRAINT det_presupuesto_pk;
       public         postgres    false    208    208            �           2606    22897    dtipoproyecto__un 
   CONSTRAINT     `   ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT dtipoproyecto__un UNIQUE (dtipoproyecto);
 M   ALTER TABLE ONLY public.gen_tipo_proyecto DROP CONSTRAINT dtipoproyecto__un;
       public         postgres    false    217    217            �           2606    22899 	   estado_pk 
   CONSTRAINT     K   ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.gen_estado DROP CONSTRAINT estado_pk;
       public         postgres    false    211    211            �           2606    22901    gen_activos_descripcion__un 
   CONSTRAINT     ^   ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_descripcion__un UNIQUE (dactivo);
 Q   ALTER TABLE ONLY public.gen_activos DROP CONSTRAINT gen_activos_descripcion__un;
       public         postgres    false    210    210            �           2606    22903    gen_activos_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.gen_activos DROP CONSTRAINT gen_activos_pk;
       public         postgres    false    210    210            �           2606    22905    gen_estado__un 
   CONSTRAINT     P   ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT gen_estado__un UNIQUE (destado);
 C   ALTER TABLE ONLY public.gen_estado DROP CONSTRAINT gen_estado__un;
       public         postgres    false    211    211            �           2606    22907    gen_financiamiento_pk 
   CONSTRAINT     _   ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_pk PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.gen_financiamiento DROP CONSTRAINT gen_financiamiento_pk;
       public         postgres    false    212    212            �           2606    23072    gen_pais_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY gen_pais
    ADD CONSTRAINT gen_pais_pkey PRIMARY KEY (cpais);
 @   ALTER TABLE ONLY public.gen_pais DROP CONSTRAINT gen_pais_pkey;
       public         postgres    false    219    219            �           2606    22909    gen_proyecto_pk 
   CONSTRAINT     S   ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_pk PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.gen_proyecto DROP CONSTRAINT gen_proyecto_pk;
       public         postgres    false    215    215            �           2606    22911    gen_tipo_financiamiento__un 
   CONSTRAINT     u   ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT gen_tipo_financiamiento__un UNIQUE (dtipofinaciamiento);
 ]   ALTER TABLE ONLY public.gen_tipo_financiamiento DROP CONSTRAINT gen_tipo_financiamiento__un;
       public         postgres    false    216    216            �           2606    22913    get_tipo_financiamiento_pk 
   CONSTRAINT     i   ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT get_tipo_financiamiento_pk PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.gen_tipo_financiamiento DROP CONSTRAINT get_tipo_financiamiento_pk;
       public         postgres    false    216    216            �           2606    22915 
   id_estatus 
   CONSTRAINT     I   ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.estatus DROP CONSTRAINT id_estatus;
       public         postgres    false    209    209            �           2606    22917    municipio_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.gen_municipio DROP CONSTRAINT municipio_pk;
       public         postgres    false    213    213            �           2606    22919    parroquia_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.gen_parroquia DROP CONSTRAINT parroquia_pk;
       public         postgres    false    214    214            �           2606    23063    pk_gun_spkunidad 
   CONSTRAINT     Y   ALTER TABLE ONLY gen_unidades
    ADD CONSTRAINT pk_gun_spkunidad PRIMARY KEY (cunidad);
 G   ALTER TABLE ONLY public.gen_unidades DROP CONSTRAINT pk_gun_spkunidad;
       public         postgres    false    218    218            �           2606    22921    tipo_proyecto_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT tipo_proyecto_pk PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.gen_tipo_proyecto DROP CONSTRAINT tipo_proyecto_pk;
       public         postgres    false    217    217            �           2606    22922    activos_plan    FK CONSTRAINT     o   ALTER TABLE ONLY planinversion
    ADD CONSTRAINT activos_plan FOREIGN KEY (activo_id) REFERENCES activos(id);
 A   ALTER TABLE ONLY pdi.planinversion DROP CONSTRAINT activos_plan;
       pdi       postgres    false    2174    174    194            �           2606    22927    archivo_estatus_estus_fk    FK CONSTRAINT     �   ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_estus_fk FOREIGN KEY (estatus_id) REFERENCES estatus(id) ON DELETE RESTRICT;
 O   ALTER TABLE ONLY pdi.archivo_estatus DROP CONSTRAINT archivo_estatus_estus_fk;
       pdi       postgres    false    2190    178    187            �           2606    22932    archivo_estatus_presupuestos_fk    FK CONSTRAINT     �   ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_presupuestos_fk FOREIGN KEY (archivo_id) REFERENCES archivo_presupuestos_tmp(id_archivo_presupuesto) ON DELETE RESTRICT;
 V   ALTER TABLE ONLY pdi.archivo_estatus DROP CONSTRAINT archivo_estatus_presupuestos_fk;
       pdi       postgres    false    179    2180    178            �           2606    22937    archivo_presupuestos_tmp_fk    FK CONSTRAINT     �   ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT archivo_presupuestos_tmp_fk FOREIGN KEY (id_archivo_presupuesto) REFERENCES presupuestos(id) ON DELETE RESTRICT;
 [   ALTER TABLE ONLY pdi.archivo_presupuestos_tmp DROP CONSTRAINT archivo_presupuestos_tmp_fk;
       pdi       postgres    false    196    2202    179            �           2606    22942    financiamiento_fk    FK CONSTRAINT     �   ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT financiamiento_fk FOREIGN KEY (financiamiento_id) REFERENCES financiamientos(id);
 M   ALTER TABLE ONLY pdi.entidadesfinancieras DROP CONSTRAINT financiamiento_fk;
       pdi       postgres    false    184    188    2192            �           2606    22947    financiamiento_tipo    FK CONSTRAINT     �   ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT financiamiento_tipo FOREIGN KEY (tipo_financiamiento_id) REFERENCES tiposfinanciamiento(id);
 J   ALTER TABLE ONLY pdi.financiamientos DROP CONSTRAINT financiamiento_tipo;
       pdi       postgres    false    188    202    2208            �           2606    23111    fk_cronograma_id    FK CONSTRAINT     �   ALTER TABLE ONLY exportaciones_paises
    ADD CONSTRAINT fk_cronograma_id FOREIGN KEY (cronograma_id) REFERENCES cronograma(id);
 L   ALTER TABLE ONLY pdi.exportaciones_paises DROP CONSTRAINT fk_cronograma_id;
       pdi       postgres    false    2250    220    222            �           2606    22952    municipio_estado_fk    FK CONSTRAINT     q   ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES estado(id);
 D   ALTER TABLE ONLY pdi.municipio DROP CONSTRAINT municipio_estado_fk;
       pdi       postgres    false    2188    192    186            �           2606    22957    parroquia_municipio_fk    FK CONSTRAINT     z   ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES municipio(id);
 G   ALTER TABLE ONLY pdi.parroquia DROP CONSTRAINT parroquia_municipio_fk;
       pdi       postgres    false    192    2196    193            �           2606    22962    poyecto_financiamiento    FK CONSTRAINT        ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT poyecto_financiamiento FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);
 M   ALTER TABLE ONLY pdi.financiamientos DROP CONSTRAINT poyecto_financiamiento;
       pdi       postgres    false    2204    198    188            �           2606    22967    proyecto_bienes    FK CONSTRAINT     o   ALTER TABLE ONLY bienes
    ADD CONSTRAINT proyecto_bienes FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);
 =   ALTER TABLE ONLY pdi.bienes DROP CONSTRAINT proyecto_bienes;
       pdi       postgres    false    180    198    2204            �           2606    22977    proyecto_flujo    FK CONSTRAINT     r   ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT proyecto_flujo FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);
 @   ALTER TABLE ONLY pdi.flujocajas DROP CONSTRAINT proyecto_flujo;
       pdi       postgres    false    2204    190    198            �           2606    22982    proyecto_flujototal    FK CONSTRAINT     |   ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT proyecto_flujototal FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);
 J   ALTER TABLE ONLY pdi.totalflujocajas DROP CONSTRAINT proyecto_flujototal;
       pdi       postgres    false    198    2204    204            �           2606    22992    proyecto_plan    FK CONSTRAINT     t   ALTER TABLE ONLY planinversion
    ADD CONSTRAINT proyecto_plan FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);
 B   ALTER TABLE ONLY pdi.planinversion DROP CONSTRAINT proyecto_plan;
       pdi       postgres    false    198    2204    194            �           2606    22997    tipo_proyecto_fk    FK CONSTRAINT     |   ALTER TABLE ONLY proyectos
    ADD CONSTRAINT tipo_proyecto_fk FOREIGN KEY (tipo_proyecto_id) REFERENCES tipoproyectos(id);
 A   ALTER TABLE ONLY pdi.proyectos DROP CONSTRAINT tipo_proyecto_fk;
       pdi       postgres    false    2206    198    200            �           2606    23002    det_bienes_gen_proyecto_fk    FK CONSTRAINT     �   ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT det_bienes_gen_proyecto_fk FOREIGN KEY (proyecto_id) REFERENCES gen_proyecto(id);
 O   ALTER TABLE ONLY public.det_bienes DROP CONSTRAINT det_bienes_gen_proyecto_fk;
       public       postgres    false    206    2236    215            �           2606    23007 !   det_plan_inversion_gen_activos_fk    FK CONSTRAINT     �   ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_gen_activos_fk FOREIGN KEY (gen_activos_id) REFERENCES gen_activos(id);
 ^   ALTER TABLE ONLY public.det_plan_inversion DROP CONSTRAINT det_plan_inversion_gen_activos_fk;
       public       postgres    false    210    207    2222            �           2606    23012    det_presupuesto_estado_fk    FK CONSTRAINT     �   ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);
 S   ALTER TABLE ONLY public.det_presupuesto DROP CONSTRAINT det_presupuesto_estado_fk;
       public       postgres    false    211    2224    208            �           2606    23017    det_presupuesto_municipio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);
 V   ALTER TABLE ONLY public.det_presupuesto DROP CONSTRAINT det_presupuesto_municipio_fk;
       public       postgres    false    208    2232    213            �           2606    23022    det_presupuesto_parroquia_fk    FK CONSTRAINT     �   ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_parroquia_fk FOREIGN KEY (parroquia_id) REFERENCES gen_parroquia(id);
 V   ALTER TABLE ONLY public.det_presupuesto DROP CONSTRAINT det_presupuesto_parroquia_fk;
       public       postgres    false    214    208    2234            �           2606    23027 -   gen_financiamiento_get_tipo_financiamiento_fk    FK CONSTRAINT     �   ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_get_tipo_financiamiento_fk FOREIGN KEY (get_tipo_financiamiento_id) REFERENCES gen_tipo_financiamiento(id);
 j   ALTER TABLE ONLY public.gen_financiamiento DROP CONSTRAINT gen_financiamiento_get_tipo_financiamiento_fk;
       public       postgres    false    216    212    2240            �           2606    23032 !   gen_proyecto_gen_tipo_proyecto_fk    FK CONSTRAINT     �   ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_gen_tipo_proyecto_fk FOREIGN KEY (gen_tipo_proyecto_id) REFERENCES gen_tipo_proyecto(id);
 X   ALTER TABLE ONLY public.gen_proyecto DROP CONSTRAINT gen_proyecto_gen_tipo_proyecto_fk;
       public       postgres    false    217    215    2244            �           2606    23037    municipio_estado_fk    FK CONSTRAINT     y   ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);
 K   ALTER TABLE ONLY public.gen_municipio DROP CONSTRAINT municipio_estado_fk;
       public       postgres    false    211    2224    213            �           2606    23042    parroquia_municipio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);
 N   ALTER TABLE ONLY public.gen_parroquia DROP CONSTRAINT parroquia_municipio_fk;
       public       postgres    false    2232    214    213            P	      x������ � �      R	      x������ � �      T	      x������ � �      U	      x������ � �      V	      x������ � �      ~	      x������ � �      X	      x������ � �      Z	      x������ � �      \	      x������ � �      ]	      x������ � �      �	      x������ � �      ^	      x������ � �      `	      x������ � �      b	      x������ � �      c	      x������ � �      d	      x������ � �      f	      x������ � �      h	   V   x�3�t�,N=�1_!%U!9?���$1%�(���9�$� '1�3�8%B�azZZ:�������������������%TڈӐ+F��� �'�      j	   2   x�3�L��-(-IL�/J,�4204�5��52Q04�26�2��,����� 
9      l	      x������ � �      n	      x������ � �      p	      x������ � �      q	      x������ � �      r	      x������ � �      s	      x������ � �      t	      x������ � �      u	      x������ � �      v	      x������ � �      w	      x������ � �      }	   �  x��X�R�:�V��/�Y�[�B� s8���Fc+���"��w;����p�����lm�������j���n9��L�aTQ��K徚N���q.�wq�����Z�f���?��8Nv�Dt+�_�֛�x&��:�9��� :��W�st��ʷ*⻗����Q�R�֌j.-�
ҵ���,�°�3AZ�����Z�?�N���j'���V�<#Z}�q-՝ڨ���a�2� ��N�z��/�Y*("��̐�rq�]��i�WRbB��z�"D�8��[Ǥ�6�����L��<�@$1�i��I�/���`�H���w�;k)��j�N˓g��Z� 'I����}k�%u8H�$�*q�V6�ծ��=�$�ڬ�3s:/h�F���i׼N�����q�;��U7M����X��� ��(J����ʚ걳d6�ё���۪�<���c[��ܬ���u��t�º��Z�s�һyX�2�(�2�o\g-sq�j�m�5��K3��Dj�\�E*>؍���=�1C���j�;��q%���a�9〪{|� /���85�!"f�C��7��Ҽ�����G�ݳäy5It
<(J�+��,�Zq���wt��w��Ñ�?��z=���H��W��y��d�������Vײ���h�ͫ,-�CMgp=,(����;��d�+��S=�����D�x��� t��3�4ur��%�����l�T�8�jD��zF�y�#�)SFV�w���pRx��P~���m�*�f����@�'�9����hn���W��;�I*N�	X-�Q��o�c��e�����ye%h���b&�؂�G�p��̩���*�b=ðۙ#�����S���(��q�C�p��9�B���&�����z�q�cl�ɺV���h���E}C�sA�8:>b��s��޼�7I2�R�a8v>�O8�MA���G�z��ݜ�rʭ�Ҽ��n��Ĉ�S=.��\9�J��Ʈ,�^�z�򎵄<)_�F�%�s���VC���H�KO����~ba��ښG��`Э6OӼ�țnd�T[U�nx �+.�w�1,�RN��A�%�{�0[Q��qoJ!��E+zհ�ՠ�K�]��D��]�Y8��|�/�l��|,�k$�%`3Ey� |a�1(f�9����~P�r+R��5��g&�'��l�TN �.C�/���^��s���G}�?aZS���m�k���\\)3���o��N�*,�R�o���hz�h2`h&�>� ,n���p�
W�����,�G��6���)��*c:5^<e\L�r㾽���3|l��(LV\��n�4���Ld!~W#+T�Crq��ݍsi0��Ğ+<	Tt�͝�����l���\�N7\w����X�؀}�e�>|&������K���@�F�T}t�v��bUPָ�?L?�@Oo�"�G��F�NM��hS%;]4������r���k6LT��\���[�`F��(����ϭ!.ц�~�im��^�l�ڏ���V�R�@�ĚY%�7�	x��A�7f�fc��e�C&�o@�ll�p� ޔ͈�]��<[eJ�xeZ��ƻ{z~=Wb�$�w��)Sp΍��F&�,.���Y%1���� e����Kȼ������)
��-�d������,B�[�ǋ-��g��v{k�Λ�'1Y���9X#�_¦Q�(�/f�R���{&�8p��׫��1�Y�r�K�gI�4���V�H��SՍ��D,�3����R�U`��&��\赳\�ir���5�-��Ȯ�7�v�XL�17�&�8����W<�8+Ƈ^���|l�����g4�YL7w��Q��䜧u�0|��5�����b�}ر_�$	}�p���j`Gձ4�9Ж���1S�bw;�pp�Z���8���7x�;ݽP�q�v|�4��mB8�vi�1�:=�~�K�t'���y�����w���c	�      x	      x������ � �      y	      x������ � �      z	      x������ � �      {	      x������ � �      |	   ^  x�]P�N�0<o��_��G��h��DQQ8 qq�2rb�u.�Nܸ��p��mPrؙٝoJ�֚�<A��J��%�R���j�w62|���N�N֨e���g��(�:�GP�R۪�t�Aa�Na��J{�	p�}�B�51IB��Ρ��H��>��P����������)d�6�Gi:�Q
��G\Al�Q�UA@�XM�b�.k�|�F�l:s�uD,�'kL�b��g;���Ϊ��;�G�_	��^Z]�sE�ët�Uwv�Z!�t�/b�j�U�6�Td�j�:�س�~�BN��,z��b�N�����R����B�qE�|�I�����C     