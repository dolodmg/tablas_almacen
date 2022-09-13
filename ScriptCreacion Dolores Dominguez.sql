CREATE SCHEMA Almacenes;
USE Almacenes;

CREATE TABLE Provincias (
	idProvincia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Ciudades (
	codPostal INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    idProvincia INT,
    CONSTRAINT fk_ciudad_prov FOREIGN KEY (idProvincia) REFERENCES Provincias(idProvincia)
);

CREATE TABLE Direcciones (
	idDireccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(40) NOT NULL,
    numero INT NOT NULL,
    codPostal INT NOT NULL,
    CONSTRAINT fk_direc_ciudad FOREIGN KEY (codPostal) REFERENCES Ciudades(codPostal)
);

CREATE TABLE Almacenes (
  idAlmacen INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  idDireccion INT NOT NULL,
  CONSTRAINT fk_almacen_direc FOREIGN KEY (idDireccion) REFERENCES Direcciones(idDireccion)
);

CREATE TABLE Horarios (
	idHorario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    horarioApertura TIME NOT NULL,
    horarioCierre TIME NOT NULL,
    diaSemana VARCHAR(30)
);

CREATE TABLE HorariosAlmacen (
	idAlmacen INT NOT NULL,
    idHorario INT NOT NULL,
    PRIMARY KEY (idAlmacen,idHorario),
    CONSTRAINT fk_horaAl_almacen FOREIGN KEY (idAlmacen) REFERENCES Almacenes(idAlmacen),
    CONSTRAINT fk_horaAl_hora FOREIGN KEY (idHorario) REFERENCES Horarios(idHorario)
);

CREATE TABLE Proveedores (
	idProveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    telefono VARCHAR(40) NOT NULL,
    idDireccion INT NOT NULL,
    CONSTRAINT fk_proveedor_direccion FOREIGN KEY (idDireccion) REFERENCES Direcciones(idDireccion)
);
    
CREATE TABLE Articulos (
	idArticulo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    precio FLOAT NOT NULL,
    stock INT NOT NULL
);    

CREATE TABLE Inventarios (
	idInventario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idAlmacen INT NOT NULL,
    CONSTRAINT fk_inventario_almacen FOREIGN KEY (idAlmacen) REFERENCES Almacenes(idAlmacen)
);

CREATE TABLE InventariosArticulos (
	idInventario INT NOT NULL,
    idArticulo INT NOT NULL,
    PRIMARY KEY (idInventario,idArticulo),
    CONSTRAINT fk_invArticulo_inventario FOREIGN KEY (idInventario) REFERENCES Inventarios(idInventario),
    CONSTRAINT fk_invArticulo_articulo FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo)
);

CREATE TABLE Compras (
	idCompra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    montoTotal FLOAT NOT NULL,
    fecha DATE NOT NULL,
    idProveedor INT NOT NULL,
    idAlmacen INT NOT NULL,
    CONSTRAINT fk_compra_proveedor FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor),
    CONSTRAINT fk_compra_almacen FOREIGN KEY (idAlmacen) REFERENCES Almacenes(idAlmacen)
);
    
CREATE TABLE ItemCompras (
	idItem INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cantidad INT NOT NULL,
    precioUnidad FLOAT NOT NULL,
    idArticulo INT,
    idCompra INT,
    CONSTRAINT fk_itemC_articulo FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo),
    CONSTRAINT fk_itemC_compra FOREIGN KEY (idCompra) REFERENCES Compras(idCompra)
);

CREATE TABLE Clientes (
	idCliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    dni INT NOT NULL,
    telefono VARCHAR(40) NOT NULL,
    idDireccion INT NOT NULL,
    CONSTRAINT fk_cliente_direccion FOREIGN KEY (idDireccion) REFERENCES Direcciones(idDireccion)
);

CREATE TABLE Ventas (
	idVenta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    precioTotal FLOAT DEFAULT NULL,
    fecha DATE NOT NULL,
    idCliente INT NOT NULL,
    idAlmacen INT NOT NULL,
    CONSTRAINT fk_venta_cliente FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    CONSTRAINT fk_venta_almacen FOREIGN KEY (idAlmacen) REFERENCES Almacenes(idAlmacen)
);

CREATE TABLE ItemVentas (
	idItem INT NOT NULL	AUTO_INCREMENT PRIMARY KEY,
    cantidad INT NOT NULL,
    precioUnidad FLOAT NOT NULL,
    idVenta INT NOT NULL,
    idArticulo INT NOT NULL,
    CONSTRAINT fk_itemV_venta FOREIGN KEY (idVenta) REFERENCES Ventas(idVenta),
    CONSTRAINT fk_itemV_articulo FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo)
);

CREATE TABLE Sueldos (
	idSueldo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    montoNeto FLOAT NOT NULL,
    montoBruto FLOAT NOT NULL
);

CREATE TABLE Empleados (
	idEmpleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombreApellido VARCHAR(50) NOT NULL,
    dni INT NOT NULL,
    telefono VARCHAR(40) NOT NULL,
    mail VARCHAR(50) NOT NULL,
    idDireccion INT NOT NULL,
    idAlmacen INT NOT NULL,
    idSueldo INT NOT NULL,
    CONSTRAINT fk_empleado_direccion FOREIGN KEY (idDireccion) REFERENCES Direcciones(idDireccion),
    CONSTRAINT fk_empleado_almacen FOREIGN KEY (idAlmacen) REFERENCES Almacenes(idAlmacen),
    CONSTRAINT fk_empleado_sueldo FOREIGN KEY (idSueldo) REFERENCES Sueldos(idSueldo)
);

CREATE TABLE Categorias (
	idCategoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(40) NOT NULL
);

CREATE TABLE EmpleadosCategorias (
	idCategoria INT NOT NULL,
    idEmpleado INT NOT NULL,
    PRIMARY KEY (idCategoria,idEmpleado),
    CONSTRAINT fk_empleadoCat_cat FOREIGN KEY (idCategoria) REFERENCES Categorias(idCategoria),
    CONSTRAINT fk_empleadoCat_empleado FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);