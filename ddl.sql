CREATE TABLE producto (
    codigo_producto VARCHAR(15) PRIMARY KEY UNIQUE,
    nombre VARCHAR(70),
    id_gama VARCHAR(50),
    id_dimensiones VARCHAR(25),
    id_proveedor VARCHAR(50) NULL,
    descripcion TEXT NULL,
    cantidad_en_stock SMALLINT(6),
    precio_venta DECIMAL(15, 2),
    precio_proveedor DECIMAL(15, 2),
    FOREIGN KEY (id_gama) REFERENCES gama_producto(gama),
    FOREIGN KEY (id_dimensiones) REFERENCES dimensiones(id_dimensiones),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE gama_producto (
    gama VARCHAR(50) PRIMARY KEY UNIQUE,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256)
);

CREATE TABLE dimensiones (
    id_dimensiones VARCHAR(15) PRIMARY KEY UNIQUE,
    ancho DECIMAL(5, 2) NULL,
    alto DECIMAL(5, 2) NULL,
    profundo INTEGER NULL,
    diametro DECIMAL(5, 2) NULL
);

CREATE TABLE detalle_pedido (
    codigo_pedido INT(11),
    codigo_producto VARCHAR(15),
    cantidad INT(11),
    precio_unidad DECIMAL(15, 2),
    numero_linea SMALLINT(6),
    PRIMARY KEY (codigo_pedido, codigo_producto),
    FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
    FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto)
);

CREATE TABLE pedido (
    codigo_pedido INT(11) PRIMARY KEY UNIQUE,
    fecha_pedido DATE,
    fecha_esperada DATE,
    fecha_entrega DATE NULL,
    estado VARCHAR(15),
    comentarios TEXT NULL,
    codigo_cliente INT(11),
    FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);

CREATE TABLE cliente (
    codigo_cliente INT(11) AUTO_INCREMENT PRIMARY KEY UNIQUE,
    nombre_cliente VARCHAR(50),
    id_contacto INT(11),
    id_direccion INT(11),
    codigo_empleado INT(11) NULL,
    limite_credito DECIMAL(15, 2),
    FOREIGN KEY (id_contacto) REFERENCES contacto(id_contacto),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (codigo_empleado) REFERENCES empleado(codigo_empleado)
);

CREATE TABLE proveedor (
    id_proveedor VARCHAR(50) PRIMARY KEY,
    nombre_proveedor VARCHAR(50),
    id_contacto INT(11),
    id_direccion INT(11),
    FOREIGN KEY (id_contacto) REFERENCES contacto(id_contacto),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
);

CREATE TABLE contacto (
    id_contacto INT(11) PRIMARY KEY,
    nombre_contacto VARCHAR(30) NULL,
    apellido_contacto VARCHAR(30) NULL,
    telefono VARCHAR(15),
    fax VARCHAR(15)
);

CREATE TABLE pago (
    id_transaccion VARCHAR(50),
    codigo_cliente INT(11),
    forma_pago VARCHAR(40),
    fecha_pago DATE,
    total DECIMAL(15, 2),
    PRIMARY KEY (id_transaccion),
    FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);

CREATE TABLE pais(
    id_pais INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
    );

CREATE TABLE region(
    id_region INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_pais INT(11) NOT NULL,
    CONSTRAINT FK_region_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais));

CREATE TABLE ciudad(
    id_ciudad INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_region INT(11) NOT NULL,
    CONSTRAINT FK_ciudad_region FOREIGN KEY (id_region) REFERENCES region(id_region)
);

CREATE TABLE direccion(
    id_direccion INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50),
    barrio VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10),
    id_ciudad INT(11) NOT NULL,
    CONSTRAINT FK_direccion_ciudad FOREIGN KEY(id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE empleado (
    codigo_empleado INT(11) PRIMARY KEY UNIQUE,
    nombre_empleado VARCHAR(50),
    apellido_empleado1 VARCHAR(50),
    apellido_empleado2 VARCHAR(50) NULL,
    extension VARCHAR(10),
    email VARCHAR(100),
    puesto VARCHAR(50) NULL,
    codigo_jefe INT(11) NULL,
    CONSTRAINT FK_empleado_jefe FOREIGN KEY (codigo_jefe) REFERENCES empleado(codigo_empleado),
    codigo_oficina VARCHAR(10),
    CONSTRAINT FK_empleado_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina)
);

CREATE TABLE oficina (
    codigo_oficina INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    id_direccion INT,
    PRIMARY KEY (codigo_oficina),
    CONSTRAINT FK_direccion_oficina FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);