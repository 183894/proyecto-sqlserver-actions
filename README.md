# Proyecto Integrador: GitHub Actions + Docker + Microsoft SQL Server

## Descripción

Este proyecto consiste en automatizar el despliegue de una base de datos Microsoft SQL Server utilizando Docker y GitHub Actions.

Se creó una base de datos llamada `EmpresaDB`, en la cual se implementaron tablas, un procedimiento almacenado y un trigger para registrar las ventas y llevar un control del inventario.

También se configuraron workflows de GitHub Actions para ejecutar automáticamente los scripts SQL y generar un reporte CSV con las existencias de los productos.

## Objetivo general

Construir una solución de integración continua que permita iniciar SQL Server en un contenedor Docker, crear una base de datos y ejecutar su lógica de negocio mediante procedimientos almacenados y triggers, utilizando GitHub Actions para automatizar el proceso.

## Tecnologías utilizadas

- **GitHub:** plataforma para almacenar el código fuente y administrar el repositorio.
- **GitHub Actions:** herramienta utilizada para automatizar la ejecución de los workflows.
- **Docker:** permite ejecutar SQL Server dentro de un contenedor.
- **Microsoft SQL Server:** sistema gestor de bases de datos utilizado para almacenar y procesar la información.
- **SQL:** lenguaje utilizado para crear las tablas, procedimientos almacenados, triggers y consultas.
- **GitHub Secrets:** permite almacenar de forma segura la contraseña del administrador de SQL Server.

## Estructura del proyecto

```text
proyecto-sqlserver-actions/
│
├── .github/
│   └── workflows/
│       ├── deploy.yml
│       └── report.yml
│
├── sql/
│   ├── create_database.sql
│   ├── create_tables.sql
│   ├── create_procedure.sql
│   ├── create_trigger.sql
│   └── test_data.sql
│
└── README.md
```

## Base de datos

La base de datos utilizada en el proyecto se llama `EmpresaDB`.

### Tabla Ventas

Almacena la información de las ventas registradas.

| Campo | Descripción |
|---|---|
| VentaID | Identificador de la venta. |
| Producto | Nombre del producto vendido. |
| Cantidad | Cantidad de productos vendidos. |
| Fecha | Fecha en la que se registró la venta. |

### Tabla AuditoriaVentas

Permite llevar un registro de las ventas que se realizan.

| Campo | Descripción |
|---|---|
| AuditoriaID | Identificador del registro de auditoría. |
| VentaID | Identificador de la venta relacionada. |
| FechaRegistro | Fecha en la que se registró la auditoría. |
| Mensaje | Descripción de la operación realizada. |

### Tabla Inventario

Almacena las existencias disponibles de cada producto.

Esta tabla se utiliza para actualizar las cantidades disponibles cada vez que se registra una venta.

## Procedimiento almacenado

Se implementó el procedimiento almacenado `sp_RegistrarAuditoria`, encargado de registrar la información de las ventas en la tabla `AuditoriaVentas`.

Además, se utiliza para actualizar las existencias del inventario a partir de las cantidades vendidas.

## Trigger

Se creó el trigger `trg_AuditarVenta`, asociado a la tabla `Ventas`.

El trigger se ejecuta automáticamente después de insertar una venta y utiliza la tabla lógica `inserted` para obtener los registros que se acaban de agregar.

Se implementó utilizando procesamiento por conjuntos, permitiendo manejar inserciones múltiples en una sola operación.

## GitHub Actions y Docker

El workflow `deploy.yml` automatiza el despliegue de SQL Server.

Sus principales actividades son:

1. Descargar el repositorio.
2. Iniciar SQL Server en Docker.
3. Esperar a que SQL Server esté disponible.
4. Crear la base de datos `EmpresaDB`.
5. Ejecutar los scripts para crear las tablas, el procedimiento almacenado y el trigger.
6. Insertar los datos de prueba.
7. Verificar las ventas y el inventario.
8. Detener el contenedor al finalizar.

La contraseña del administrador se obtiene desde GitHub Secrets mediante la variable `MSSQL_SA_PASSWORD`.

## Generación del reporte CSV

Se creó un segundo workflow llamado `report.yml`, encargado de generar un reporte de las existencias del inventario.

Este workflow puede ejecutarse manualmente o de manera programada.

El reporte contiene el nombre de cada producto y sus existencias disponibles.

El archivo generado se publica como Artifact en GitHub Actions, permitiendo descargarlo posteriormente.

El archivo generado es:

`inventario.csv`

## Resultados

Se comprobó el funcionamiento del proyecto mediante la ejecución de los workflows de GitHub Actions.

Se verificó que:

- SQL Server inicia correctamente en Docker.
- La base de datos `EmpresaDB` se crea automáticamente.
- Las tablas y los objetos SQL se crean correctamente.
- Las ventas se registran en la tabla de auditoría.
- El inventario se actualiza de acuerdo con las ventas.
- El trigger admite inserciones múltiples.
- El reporte CSV se genera y se publica como Artifact.

## Conclusión

Con este proyecto se logró automatizar el despliegue de una base de datos utilizando Docker y GitHub Actions.

También se comprendió la importancia de los procedimientos almacenados y los triggers para implementar la lógica de negocio dentro de SQL Server.

El uso de procesamiento por conjuntos permitió manejar varias ventas al mismo tiempo, mientras que GitHub Actions facilitó la ejecución automática de los scripts y la generación del reporte CSV.

Finalmente, el proyecto permitió poner en práctica conceptos de bases de datos, integración continua y automatización de procesos.
