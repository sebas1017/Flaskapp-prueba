PGDMP     &    8        	        x            Clientes    12.3    12.3     (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    90358    Clientes    DATABASE     �   CREATE DATABASE "Clientes" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE "Clientes";
                postgres    false            ,           0    0    DATABASE "Clientes"    COMMENT     Q   COMMENT ON DATABASE "Clientes" IS 'Administración  de clientes app responsive';
                   postgres    false    2859                        2615    98602    temporal    SCHEMA        CREATE SCHEMA temporal;
    DROP SCHEMA temporal;
                postgres    false            �            1255    98615    create_my_temp_table(integer)    FUNCTION     $  CREATE FUNCTION public.create_my_temp_table(identificacion integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
    insert into temporal.facturas_borradas ( select * from facturas where id_cliente  = identificacion);
   delete from clientes  where cedula  = identificacion;
end $$;
 C   DROP FUNCTION public.create_my_temp_table(identificacion integer);
       public          postgres    false            �            1255    98605    stable_function()    FUNCTION     �   CREATE FUNCTION public.stable_function() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
begin
    perform create_my_temp_table();
    return 'ok';
end $$;
 (   DROP FUNCTION public.stable_function();
       public          postgres    false            �            1259    90359    clientes    TABLE     �   CREATE TABLE public.clientes (
    cedula integer NOT NULL,
    nombre_cliente character varying(45),
    direccion character varying(45),
    telefono character varying(45)
);
    DROP TABLE public.clientes;
       public         heap    postgres    false            �            1259    98621    detalle_factura    TABLE     �   CREATE TABLE public.detalle_factura (
    id_codigo_detalle integer NOT NULL,
    id_factura integer NOT NULL,
    id_producto integer
);
 #   DROP TABLE public.detalle_factura;
       public         heap    postgres    false            �            1259    98619 %   detalle_factura_id_codigo_detalle_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_factura_id_codigo_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.detalle_factura_id_codigo_detalle_seq;
       public          postgres    false    209            -           0    0 %   detalle_factura_id_codigo_detalle_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.detalle_factura_id_codigo_detalle_seq OWNED BY public.detalle_factura.id_codigo_detalle;
          public          postgres    false    208            �            1259    98583    facturas    TABLE     �   CREATE TABLE public.facturas (
    cod_factura integer NOT NULL,
    id_cliente integer,
    cantidad_productos integer,
    fecha_compra date,
    val_total double precision,
    metodo_pago character varying
);
    DROP TABLE public.facturas;
       public         heap    postgres    false            �            1259    98581    facturas_cod_factura_seq    SEQUENCE     �   CREATE SEQUENCE public.facturas_cod_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.facturas_cod_factura_seq;
       public          postgres    false    206            .           0    0    facturas_cod_factura_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.facturas_cod_factura_seq OWNED BY public.facturas.cod_factura;
          public          postgres    false    205            �            1259    90364 	   productos    TABLE     �   CREATE TABLE public.productos (
    cod_prod integer NOT NULL,
    categoria character varying(50),
    nombre character varying(40),
    precio double precision,
    cantidad_bodega integer,
    estado character varying(20)
);
    DROP TABLE public.productos;
       public         heap    postgres    false            �            1259    98606    facturas_borradas    TABLE     �   CREATE TABLE temporal.facturas_borradas (
    cod_factura integer,
    id_cliente integer,
    cantidad_productos integer,
    fecha_compra date,
    val_total double precision,
    metodo_pago character varying
);
 '   DROP TABLE temporal.facturas_borradas;
       temporal         heap    postgres    false    4            �
           2604    98624 !   detalle_factura id_codigo_detalle    DEFAULT     �   ALTER TABLE ONLY public.detalle_factura ALTER COLUMN id_codigo_detalle SET DEFAULT nextval('public.detalle_factura_id_codigo_detalle_seq'::regclass);
 P   ALTER TABLE public.detalle_factura ALTER COLUMN id_codigo_detalle DROP DEFAULT;
       public          postgres    false    208    209    209            �
           2604    98586    facturas cod_factura    DEFAULT     |   ALTER TABLE ONLY public.facturas ALTER COLUMN cod_factura SET DEFAULT nextval('public.facturas_cod_factura_seq'::regclass);
 C   ALTER TABLE public.facturas ALTER COLUMN cod_factura DROP DEFAULT;
       public          postgres    false    205    206    206                      0    90359    clientes 
   TABLE DATA           O   COPY public.clientes (cedula, nombre_cliente, direccion, telefono) FROM stdin;
    public          postgres    false    203   %       %          0    98621    detalle_factura 
   TABLE DATA           U   COPY public.detalle_factura (id_codigo_detalle, id_factura, id_producto) FROM stdin;
    public          postgres    false    209   �%       "          0    98583    facturas 
   TABLE DATA           u   COPY public.facturas (cod_factura, id_cliente, cantidad_productos, fecha_compra, val_total, metodo_pago) FROM stdin;
    public          postgres    false    206   �%                  0    90364 	   productos 
   TABLE DATA           a   COPY public.productos (cod_prod, categoria, nombre, precio, cantidad_bodega, estado) FROM stdin;
    public          postgres    false    204   X&       #          0    98606    facturas_borradas 
   TABLE DATA           �   COPY temporal.facturas_borradas (cod_factura, id_cliente, cantidad_productos, fecha_compra, val_total, metodo_pago) FROM stdin;
    temporal          postgres    false    207   �&       /           0    0 %   detalle_factura_id_codigo_detalle_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.detalle_factura_id_codigo_detalle_seq', 30, true);
          public          postgres    false    208            0           0    0    facturas_cod_factura_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.facturas_cod_factura_seq', 26, true);
          public          postgres    false    205            �
           2606    98626 /   detalle_factura clientes_detalles_facturas_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT clientes_detalles_facturas_pkey PRIMARY KEY (id_codigo_detalle, id_factura);
 Y   ALTER TABLE ONLY public.detalle_factura DROP CONSTRAINT clientes_detalles_facturas_pkey;
       public            postgres    false    209    209            �
           2606    98591    facturas clientes_facturas_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT clientes_facturas_pkey PRIMARY KEY (cod_factura);
 I   ALTER TABLE ONLY public.facturas DROP CONSTRAINT clientes_facturas_pkey;
       public            postgres    false    206            �
           2606    90363    clientes clientes_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (cedula);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    203            �
           2606    90368 !   productos clientes_productos_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT clientes_productos_pkey PRIMARY KEY (cod_prod);
 K   ALTER TABLE ONLY public.productos DROP CONSTRAINT clientes_productos_pkey;
       public            postgres    false    204            �
           2606    98597    facturas fk_clientes_facturas    FK CONSTRAINT     �   ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT fk_clientes_facturas FOREIGN KEY (id_cliente) REFERENCES public.clientes(cedula) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.facturas DROP CONSTRAINT fk_clientes_facturas;
       public          postgres    false    2713    206    203               m   x�-�;�0 �99�%fP~v��-��Ɂ���瀁��eJ)E�t���r�C��&�t����.�T]��T��1b���n�&��u��T�M�������T�n��/*      %   S   x�-���0�3S'�K���F�����k�h���Ws��&�0���d>է܆�����A%_�~�Sf��R�呷����?�U�      "   c   x��α@0F���w!��jg��d�M*1Y��cb�8�7g C �_H� W����3�)��eZҼ��ư����yW=NsN:�>�3r*��F�5          Z   x�=��� E��LT`P1��&$�	�+��C4���������N(�Yo��Rb3�	
�IkM3am0��^�Z�4��^3�-�      #      x������ � �     