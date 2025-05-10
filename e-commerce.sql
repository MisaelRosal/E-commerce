-- Crear la base de datos
CREATE DATABASE e_commerce;

USE e_commerce;

-- Tabla Rol
CREATE TABLE Rol (
    idRol INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla Usuario (base para Cliente y Vendedor)
CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL, 
    idRol INT NOT NULL,
    tipoUsuario VARCHAR(20) NOT NULL,
    FOREIGN KEY (idRol) REFERENCES Rol(idRol)
);

-- Tabla Tienda
CREATE TABLE Tienda (
    idTienda INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20) DEFAULT '0000-0000' NOT NULL
);

-- Tabla Vendedor (hereda de Usuario)
CREATE TABLE Vendedor (
    idVendedor INT PRIMARY KEY,
    idTienda INT NOT NULL,
    FOREIGN KEY (idVendedor) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (idTienda) REFERENCES Tienda(idTienda)
);

-- Tabla Cliente (hereda de Usuario)
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    direccion VARCHAR(200),
    telefono VARCHAR(20) DEFAULT '0000-0000' NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Usuario(idUsuario)
);

-- Tabla Categoria
CREATE TABLE Categoria (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla Producto
CREATE TABLE Producto (
    idProducto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    descripcion TEXT,
    idCategoria INT NOT NULL,
    idVendedor INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_precio CHECK (precio >= 0),
    CONSTRAINT chk_stock CHECK (stock >= 0),
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL,
    idCliente INT NOT NULL,
    CONSTRAINT chk_estado CHECK (estado IN ('pendiente', 'procesando', 'enviado', 'entregado', 'cancelado')),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabla DetallePedido
CREATE TABLE DetallePedido (
    idDetallePedido INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_precio_unitario CHECK (precio_unitario >= 0),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto),
    UNIQUE (idPedido, idProducto)
);

-- Tabla Factura
CREATE TABLE Factura (
    idFactura INT PRIMARY KEY AUTO_INCREMENT,
    numero_factura VARCHAR(20) UNIQUE NOT NULL,
    fecha_emision DATE,
    subtotal DECIMAL(10,2) NOT NULL,
    impuestos DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    idPedido INT NOT NULL,
    idCliente INT NOT NULL,
    CONSTRAINT chk_subtotal CHECK (subtotal >= 0),
    CONSTRAINT chk_impuestos CHECK (impuestos >= 0),
    CONSTRAINT chk_total CHECK (total >= 0),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
); 

-- Insertar datos básicos de roles
INSERT INTO Rol (nombre) VALUES 
('Administrador'),
('Vendedor'),
('Cliente');





