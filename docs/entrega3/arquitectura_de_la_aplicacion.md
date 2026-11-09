# Arquitectura de la Aplicación

Este documento describe la arquitectura técnica seleccionada para el desarrollo de la aplicación funcional del sistema de gestión de la Copa Mundial de la FIFA, abarcando el stack tecnológico, la estructura de capas y el esquema de conexión a la base de datos institucional.

## 1. Stack Tecnológico

Para cumplir con los requerimientos del proyecto, se optó por un desarrollo basado en tecnologías estándar de la industria:
- **Backend:** Java utilizando el framework **Spring Boot**.
- **Persistencia:** Spring Data JPA / Hibernate para la gestión de las entidades y el mapeo con las 16 tablas normalizadas del modelo relacional.
- **Frontend:** Motor de plantillas **Thymeleaf** con HTML5 y Bootstrap, lo que permite una interfaz web limpia y ligera integrada directamente en el servidor.
- **Construcción:** Maven para la gestión de dependencias y compilación.

## 2. Estructura de Capas

La aplicación está organizada bajo una arquitectura de tres capas para mantener separada la interfaz, la lógica y los datos:

- **Capa de Presentación:** Controladores web de Spring Boot que gestionan las rutas HTTP y renderizan las vistas con Thymeleaf para la administración de catálogos, partidos y reportes.
- **Capa de Negocio:** Servicios que encapsulan la lógica operativa, validaciones de negocio y manejo de transacciones.
- **Capa de Persistencia:** Repositorios que interactúan de forma transparente con la base de datos a través de JPA.

## 3. Conexión a la Base de Datos

La aplicación se conecta al servidor oficial de la universidad mediante el driver JDBC de Oracle, utilizando las credenciales asignadas a cada equipo:

- **URL de Conexión:** `jdbc:oracle:thin:@orion.javeriana.edu.co:1521/LAB`
- **Credenciales:** Se configuran mediante variables de entorno o en el archivo `application.properties` utilizando los usuarios institucionales provistos para el laboratorio.