# Sistema de Control de Asistencia

Backend para un sistema de **control de asistencia de trabajadores**, desarrollado con Java, Spring Boot, MyBatis y PostgreSQL.

El proyecto utiliza Docker y Docker Compose para facilitar el despliegue del backend y de la base de datos en un entorno reproducible.

> **Estado actual de `main`:** versión base del proyecto con infraestructura Docker, conexión a PostgreSQL y CRUD de feriados implementado. Las funcionalidades desarrolladas en ramas `feature/*` que todavía no hayan sido integradas no forman parte de esta versión.

---

## 1. Descripción del proyecto

El proyecto tiene como objetivo proporcionar una API REST para gestionar información relacionada con el control de asistencia de trabajadores.

La base de datos contempla entidades relacionadas con:

- Sucursales.
- Trabajadores.
- Turnos.
- Asignaciones de turnos.
- Marcaciones.
- Feriados.
- Incidencias de asistencia.

Actualmente, la rama `main` contiene la implementación del CRUD correspondiente a **Feriados**.

---

## 2. Tecnologías utilizadas

### Backend

- Java 25
- Spring Boot 4.0.8
- Spring Web MVC
- MyBatis
- Maven

### Base de datos

- PostgreSQL 17

### Infraestructura

- Docker
- Docker Compose

### Control de versiones

- Git
- GitHub

### Herramientas utilizadas durante el desarrollo

- IntelliJ IDEA
- Postman
- PowerShell

---

## 3. Arquitectura del backend

El backend sigue una separación por capas:

```text
Cliente HTTP / Postman
          │
          ▼
     Controller
          │
          ▼
       Service
          │
          ▼
       Mapper
          │
          ▼
     PostgreSQL
```

Cada capa tiene una responsabilidad específica.

### Controller

Recibe las solicitudes HTTP y devuelve las respuestas de la API.

### Service

Contiene la lógica de aplicación y coordina las operaciones entre el Controller y el Mapper.

### Mapper

Utiliza MyBatis para ejecutar las consultas SQL contra PostgreSQL.

### Model

Representa las entidades utilizadas por la aplicación.

### DTO

Representa los datos recibidos desde las solicitudes HTTP cuando una operación no necesita utilizar directamente todos los campos del modelo.

---

## 4. Estructura general del proyecto

```text
control-asistencia-app
│
├── backend
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── com.asistencia.crud
│   │   │   │       ├── controller
│   │   │   │       ├── dto
│   │   │   │       ├── mapper
│   │   │   │       ├── model
│   │   │   │       ├── service
│   │   │   │       └── CrudAsistenciaApplication.java
│   │   │   │
│   │   │   └── resources
│   │   │       └── application.properties
│   │   │
│   │   └── test
│   │       └── java
│   │
│   ├── .mvn
│   ├── Dockerfile
│   ├── pom.xml
│   ├── mvnw
│   └── mvnw.cmd
│
├── database
│   ├── script_consultas.sql
│   ├── script_control_asistencia_v1.sql
│   └── script_insercion_datos.sql
│
├── compose.yaml
├── .env.example
├── .gitignore
└── README.md
```

---

## 5. Base de datos

La aplicación utiliza PostgreSQL como sistema gestor de base de datos.

El modelo actualmente contempla las siguientes tablas:

```text
sucursal
trabajador
turno
asignacion_turno
marcacion
feriado
incidencia_asistencia
```

Los scripts SQL necesarios se encuentran dentro de:

```text
database/
```

Entre ellos:

```text
script_control_asistencia_v1.sql
script_insercion_datos.sql
script_consultas.sql
```

---

## 6. CRUD disponible actualmente

En la rama `main`, la API dispone del CRUD de:

```text
Feriado
```

Ruta base:

```text
/api/feriados
```

### Endpoints

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/api/feriados` | Lista todos los feriados |
| `GET` | `/api/feriados/{id}` | Busca un feriado por ID |
| `POST` | `/api/feriados` | Registra un nuevo feriado |
| `PUT` | `/api/feriados/{id}` | Actualiza un feriado existente |
| `DELETE` | `/api/feriados/{id}` | Elimina un feriado |

---

## 7. Ejemplo de consulta

### Obtener todos los feriados

```http
GET http://localhost:8080/api/feriados
```

Una respuesta puede tener la siguiente estructura:

```json
[
    {
        "idFeriado": 1,
        "idSucursal": 1,
        "fecha": "2026-07-28",
        "nombre": "Fiestas Patrias",
        "tipo": "NACIONAL",
        "laborable": false,
        "estado": "VIGENTE"
    }
]
```

---

## 8. Ejemplo de registro

Para registrar un feriado:

```http
POST http://localhost:8080/api/feriados
```

El cuerpo de la solicitud debe enviarse como JSON.

Ejemplo:

```json
{
    "idSucursal": 1,
    "fecha": "2026-07-28",
    "nombre": "Fiestas Patrias",
    "tipo": "NACIONAL",
    "laborable": false,
    "estado": "VIGENTE"
}
```

Una creación correcta devuelve:

```text
201 Created
```

---

## 9. Configuración de la aplicación

La configuración principal del backend se encuentra en:

```text
backend/src/main/resources/application.properties
```

La aplicación utiliza variables de entorno para evitar almacenar información sensible directamente en el código.

La conexión puede utilizar una configuración equivalente a:

```properties
spring.datasource.url=${DB_URL:jdbc:postgresql://localhost:5434/asistencia_db}
spring.datasource.username=asistencia_admin
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=org.postgresql.Driver
```

También se encuentra habilitada la conversión automática de nombres de PostgreSQL a camelCase:

```properties
mybatis.configuration.map-underscore-to-camel-case=true
```

Por ejemplo:

```text
PostgreSQL            Java

id_feriado      →     idFeriado
id_sucursal     →     idSucursal
```

---

## 10. Variables de entorno

Por seguridad, las contraseñas no deben almacenarse directamente en el repositorio.

El proyecto utiliza:

```text
.env
```

para valores locales y privados.

Este archivo está excluido mediante `.gitignore`.

Se proporciona:

```text
.env.example
```

como referencia.

Ejemplo:

```env
DB_PASSWORD=coloque_aqui_su_password
```

Para ejecutar el proyecto, se debe crear localmente un archivo:

```text
.env
```

y establecer el valor correspondiente.

> Nunca se debe subir el archivo `.env` con credenciales reales al repositorio.

---

## 11. Ejecución con Docker Compose

### Requisitos

Antes de ejecutar el proyecto se necesita:

- Git.
- Docker Desktop o Docker Engine con Docker Compose.
- Puertos requeridos disponibles.

### Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
```

Ingresar al proyecto:

```bash
cd control-asistencia-app
```

### Configurar variables de entorno

Crear:

```text
.env
```

tomando como referencia:

```text
.env.example
```

---

## 12. Validar Docker Compose

Antes de levantar los servicios se puede comprobar la configuración mediante:

```bash
docker compose config
```

Si la configuración es correcta, se pueden construir y levantar los servicios.

---

## 13. Construir y levantar los contenedores

Desde la raíz del proyecto:

```bash
docker compose up -d --build
```

Este comando:

1. Construye la imagen del backend.
2. Levanta PostgreSQL.
3. Levanta el backend Spring Boot.
4. Configura la comunicación entre los servicios.

---

## 14. Comprobar los servicios

Para revisar los contenedores:

```bash
docker compose ps
```

Para consultar los logs del backend:

```bash
docker compose logs crud-asistencia --tail=50
```

La aplicación debe iniciar en:

```text
http://localhost:8080
```

---

## 15. Comunicación entre servicios

Cuando el backend se ejecuta directamente desde IntelliJ, puede conectarse a PostgreSQL mediante:

```text
localhost:5434
```

Cuando el backend se ejecuta dentro de Docker, utiliza la red interna de Docker:

```text
postgres-asistencia:5432
```

Mientras tanto, el cliente HTTP accede al backend mediante:

```text
http://localhost:8080
```

Representación:

```text
Postman
   │
   │ localhost:8080
   ▼
Backend Spring Boot
   │
   │ red interna Docker
   │ postgres-asistencia:5432
   ▼
PostgreSQL
```

---

## 16. Compilación del backend

Para compilar manualmente el proyecto desde Windows:

```powershell
cd backend
.\mvnw.cmd clean package
```

El resultado esperado es:

```text
BUILD SUCCESS
```

El archivo JAR generado se almacena dentro de:

```text
backend/target/
```

---

## 17. Dockerfile

El backend dispone de su propio:

```text
backend/Dockerfile
```

La imagen utiliza Java para ejecutar el JAR generado por Maven.

Conceptualmente:

```text
Código Java
    │
    ▼
Maven
    │
    ▼
JAR
    │
    ▼
Dockerfile
    │
    ▼
Imagen Docker
    │
    ▼
Contenedor Spring Boot
```

---

## 18. Persistencia de PostgreSQL

PostgreSQL utiliza un volumen Docker para mantener la información de la base de datos.

Esto permite que los datos sobrevivan aunque los contenedores sean detenidos o recreados.

Conceptualmente:

```text
Contenedor PostgreSQL
          │
          ▼
     Volumen Docker
          │
          ▼
   Datos persistentes
```

Por tanto:

```text
Recrear contenedor ≠ eliminar automáticamente los datos
```

---

## 19. Pruebas

El proyecto incluye pruebas unitarias para las capas implementadas.

Las pruebas utilizan:

- JUnit.
- Mockito.

La estrategia utilizada consiste en probar cada unidad de forma aislada.

### Prueba del Service

```text
Service REAL
    │
    ▼
Mapper MOCK
```

### Prueba del Controller

```text
Controller REAL
     │
     ▼
Service MOCK
```

Esto permite comprobar el comportamiento de cada capa sin depender directamente de PostgreSQL.

---

## 20. Ejecutar las pruebas

Desde:

```text
backend/
```

se puede ejecutar:

```powershell
.\mvnw.cmd test
```

También se ejecutan durante:

```powershell
.\mvnw.cmd clean package
```

La compilación debe finalizar correctamente antes de construir una nueva imagen del backend.

---

## 21. Control de versiones

El proyecto utiliza Git y GitHub.

Actualmente se sigue una estrategia basada en:

```text
main
  │
  └── develop
        │
        └── feature/*
```

### `main`

Contiene la versión principal y estable del proyecto.

### `develop`

Se utiliza como rama de integración para el desarrollo.

### `feature/*`

Se utiliza para desarrollar funcionalidades específicas de forma aislada.

Ejemplo:

```text
feature/crud-sucursal
```

---

## 22. Convención de commits

El proyecto utiliza mensajes basados en **Conventional Commits**.

Formato:

```text
tipo: descripción
```

Algunos tipos utilizados son:

```text
feat:   nueva funcionalidad
fix:    corrección
test:   pruebas
docs:   documentación
chore:  configuración o mantenimiento
```

Ejemplos:

```text
chore: configura estructura inicial del proyecto
feat: implementa nueva funcionalidad
test: agrega pruebas de la funcionalidad
docs: agrega documentación del proyecto
```

---

## 23. Estado actual de la rama `main`

La rama `main` representa actualmente la versión base estable del proyecto.

Contiene:

- Estructura organizada del proyecto.
- Backend Spring Boot.
- PostgreSQL.
- MyBatis.
- Dockerfile.
- Docker Compose.
- Variables de entorno.
- Scripts de base de datos.
- CRUD de feriados.
- Pruebas asociadas a la funcionalidad implementada.

Las funcionalidades desarrolladas en ramas `feature/*` no forman parte de `main` hasta que sean revisadas e integradas mediante el flujo de trabajo definido para el proyecto.

---

## 24. Funcionalidades futuras

La base de datos está preparada para ampliar progresivamente la API con funcionalidades relacionadas con:

```text
Sucursal
Trabajador
Turno
Asignación de turnos
Marcación
Incidencia de asistencia
```

Cada nueva funcionalidad podrá desarrollarse en una rama independiente:

```text
develop
│
├── feature/crud-sucursal
├── feature/crud-trabajador
├── feature/crud-turno
└── ...
```

y posteriormente pasar por el proceso de revisión e integración correspondiente.

---

## 25. Flujo general del sistema

```text
Cliente / Postman
       │
       │ HTTP / JSON
       ▼
Spring Boot
       │
       ▼
Controller
       │
       ▼
Service
       │
       ▼
MyBatis Mapper
       │
       ▼
PostgreSQL
       │
       ▼
Respuesta JSON
```

---

## 26. Resumen

El proyecto proporciona la base de una API REST para un sistema de control de asistencia.

La arquitectura actual combina:

```text
Java 25
   +
Spring Boot
   +
MyBatis
   +
PostgreSQL
   +
Docker
   +
Docker Compose
   +
Git
   +
GitHub
```

La rama `main` conserva la versión estable actual, mientras que las nuevas funcionalidades se desarrollan en ramas separadas antes de ser integradas.

Esta estructura permite que el proyecto continúe creciendo de manera organizada, manteniendo separación de responsabilidades, control de versiones y aislamiento de nuevas funcionalidades.



Esta estructura permite que el proyecto continúe creciendo de manera organizada, manteniendo separación de responsabilidades, control de versiones y aislamiento de nuevas funcionalidades.

