## Prueba Jairo Rios

Proyecto Flutter de ejemplo usado para pruebas y desarrollo. Contiene una pequeña aplicación para registrar usuarios con direcciones (país, estado, ciudad), listar usuarios y ver direcciones.

### Funcionalidad
- Registrar usuarios con nombre, apellido, fecha de nacimiento y una o más direcciones (país, estado, ciudad).
- Visualizar la lista de usuarios registrados.
- Ver los detalles de cada usuario y sus direcciones.
- El flujo de guardar usuario muestra un diálogo de carga y notifica con SnackBars el resultado.

### Estructura y arquitectura
El proyecto sigue una variante de la arquitectura limpia (Clean Architecture) simplificada:

- `lib/core/` : constantes (strings, tamaños) y utilidades.
- `lib/domain/` : entidades y contratos (use cases / repositorios en la capa de dominio).
- `lib/data/` : implementaciones para repositorios y mapeo a respuestas remotas (no todas las capas están completamente separadas en este ejercicio, pero la intención es esa).
- `lib/presentation/` : UI, widgets y providers (Riverpod). Aquí se encuentran las páginas (`pages/`), widgets reutilizables (`widgets/`) y providers (`provider/`).

Patrón de estado y dependencias:
- State management: Riverpod (flutter_riverpod). Se usan `FutureProvider`, `FutureProvider.family` y `StateProvider`.
- Manejo de respuestas: se usa `Either<Failure, Response>` (paquete dartz) para envolver respuestas y errores de red.
- Tests: `flutter_test` con Provider overrides para sustituir providers asíncronos en pruebas.

### Providers relevantes
- `countriesFutureProvider` — carga la lista de países.
- `statesFutureProvider(country)` — carga estados para un país (es `family`).
- `citiesFutureProvider({ 'country':..., 'state': ... })` — carga ciudades para un estado (es `family`).
- `getUsersFutureProvider` — obtiene la lista de usuarios; se fuerza recarga cuando cambia `usersListVersionProvider`.
- `usersListVersionProvider` (StateProvider) — usado como señal para invalidar/recargar la lista de usuarios.
- `saveUserFutureProvider(user)` — guarda un usuario (usado por `FormScreen`).

### Widgets importantes
- `SelectWithLoadingWidget<T>` (en `presentation/widgets/select_with_loading_widget.dart`): componente genérico que consume un `FutureProvider` y muestra DropdownButtonFormField con loading/error.

### Tests añadidos
En `test/presentation/pages/` se crearon tests por pantalla (un archivo por pantalla):
- `detail_screen_test.dart`
- `form_screen_test.dart`
- `home_screen_test.dart`
- `user_address_screen_test.dart`

### Cómo ejecutar la app
Requisitos: tener Flutter instalado y configurado (ruta de `flutter` en PATH).

1) Obtener dependencias:
```bash
flutter pub get
```

2) Ejecutar en iOS simulador o Android emulator:
```bash
flutter run
```