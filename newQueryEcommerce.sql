CREATE TABLE Rol (
    idRol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Usuario (
    IdUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    Celular VARCHAR(20),
    idRol INT,
    FOREIGN KEY (idRol) REFERENCES Rol(idRol)
);

CREATE TABLE Categoria (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Producto (
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),  -- No permitir precios negativos
    stock INT NOT NULL CHECK (stock >= 0),  -- No permitir stock negativo
    idCategoria INT,
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);

CREATE TABLE Tienda (
    idTienda INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(IdUsuario) ON DELETE CASCADE  -- Eliminar en cascada
);

CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    estado VARCHAR(50),
    IdUsuario INT,
    idTienda INT,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario) ON DELETE CASCADE,  -- Eliminar en cascada
    FOREIGN KEY (idTienda) REFERENCES Tienda(idTienda) ON DELETE CASCADE  -- Eliminar en cascada
);

CREATE TABLE Detalle (
    idDetalle INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT NOT NULL CHECK (cantidad >= 0),  -- No permitir cantidades negativas
    precioUnitario DECIMAL(10,2) NOT NULL CHECK (precioUnitario >= 0),  -- No permitir precios negativos
    idPedido INT,
    idProducto INT,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido) ON DELETE CASCADE,  -- Eliminar en cascada
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE  -- Eliminar en cascada
);

CREATE TABLE Factura (
    idFactura INT AUTO_INCREMENT PRIMARY KEY,
    fechaEmision DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0),  -- No permitir valores negativos
    idPedido INT UNIQUE,
    IdUsuario INT,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido) ON DELETE CASCADE,  -- Eliminar en cascada
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario) ON DELETE CASCADE  -- Eliminar en cascada
);
