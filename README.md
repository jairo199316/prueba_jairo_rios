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

Notas sobre tests:
- En los tests se usan `ProviderScope(overrides: [...])` para sustituir providers asíncronos por respuestas deterministas (por ejemplo, `Right(CountriesResponse(...))`).
- Para evitar problemas con timers y autoDispose providers en el teardown, los tests usan `ProviderScope(overrides: ...)` montado en el árbol de widgets en lugar de crear un `ProviderContainer` externo.

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

Si quieres ejecutar una pantalla concreta en modo prueba de UI, usa `flutter run -d <device>` y navega en la app.

### Cómo ejecutar tests
Para ejecutar los tests añadidos (por pantalla):
```bash
flutter test test/presentation/pages/form_screen_test.dart \
  test/presentation/pages/detail_screen_test.dart \
  test/presentation/pages/home_screen_test.dart \
  test/presentation/pages/user_address_screen_test.dart
```

O para ejecutar todo el suite:
```bash
flutter test
```

### Notas y recomendaciones
- El test de guardado (`form_screen_test.dart`) actualmente invoca directamente el método `addUser` del `State` del `FormScreen` para simular el flujo de guardado sin depender de la estructura exacta del botón en la UI. Si deseas una prueba de UI más robusta, se recomienda agregar una `Key` al botón de guardar y luego hacer `tester.tap(find.byKey(Key('save_button')))` en el test.
- Se recomienda revisar y extender la separación entre `data/domain/presentation` si el proyecto crece (añadir interfaces de repositorio, mappers y tests unitarios para use-cases).
- Manejo de errores: los providers devuelven `Either<Failure, Response>` — en UI se muestra un `TextWidget` con el mensaje de error cuando el provider falla.

### Contribuir
- Fork y abre un PR con cambios pequeños y pruebas asociadas.
- Si añades nuevas providers o widgets, actualiza los tests y usa overrides en las pruebas para mantenerlas determinísticas.

---

Si quieres, puedo:
- Añadir una `Key('save_button')` al botón de guardar en `FormScreen` y actualizar el test para usar esa Key (esto haría el test de UI más directo).
- Generar documentación adicional o diagramas de los providers.

Fecha: 24 de octubre de 2025
# prueba_jairo_rios

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
