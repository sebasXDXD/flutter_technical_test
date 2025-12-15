# 🎬 Rick and Morty App (Ejemplo)

Una aplicación móvil desarrollada en Flutter que consume la API de Rick and Morty, implementando una arquitectura modular con BLoC/Cubit y separación clara de capas de datos y presentación.

---

## 🚀 Requisitos Previos

Antes de comenzar, asegúrate de tener instalados los siguientes requisitos en tu entorno de desarrollo:

- **Flutter SDK:** Versión `3.38.5` o superior
- **Dart SDK:** Incluido con Flutter
- **Editor de Código:** VS Code o Android Studio con los plugins de Flutter/Dart instalados

Puedes verificar tu versión de Flutter ejecutando el siguiente comando:

```bash
flutter --version
```

---

## 📁 Arquitectura del Proyecto

La aplicación sigue una arquitectura modular basada en **features** con separación de capas:

```
lib/
│
├── core/                             # 🔧 Código transversal y reutilizable
│   ├── constants/                    # Constantes globales (URLs, keys, etc.)
│   │   └── api_constants.dart
│   │
│   ├── helpers/                      # Utilidades generales
│   │   └── dio_client.dart           # Cliente HTTP configurado
│   │
│   ├── routes/                       # Definición de rutas de la app
│   │   └── app_routes.dart
│   │
│   └── widgets/                      # Widgets globales reutilizables
│       ├── custom_snackbar.dart
│       ├── floating_back_button.dart
│       ├── global_loading.dart
│       └── global_error.dart
│
├── features/                         # 🎯 Features desacoplados por dominio
│
│   ├── api_characters/               # Feature: Personajes desde la API
│   │   ├── cubit/                    # Estado (Cubit + State)
│   │   │   ├── api_characters_cubit.dart
│   │   │   └── api_characters_state.dart
│   │   │
│   │   ├── data/                     # Capa de datos
│   │   │   ├── datasources/
│   │   │   │   └── rick_morty_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── api_character_model.dart
│   │   │   └── repositories/
│   │   │       └── rick_morty_repository.dart
│   │   │
│   │   └── view/                     # UI del feature
│   │       ├── pages/
│   │       │   ├── api_characters_list_page.dart
│   │       │   └── api_character_dropdown_page.dart
│   │       │
│   │       └── widgets/
│   │           ├── buttons/
│   │           │   └── new_character_button.dart
│   │           ├── api_character_dropdown_page_body.dart
│   │           ├── characters_body.dart
│   │           ├── characters_list.dart
│   │           └── error_state.dart
│
│   ├── character_detail/             # Feature: Detalle de personaje
│   │   ├── cubit/
│   │   │   ├── character_detail_cubit.dart
│   │   │   └── character_detail_state.dart
│   │   │
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── character_detail_remote_datasource.dart
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   │       └── character_detail_repository.dart
│   │   │
│   │   └── view/
│   │       ├── pages/
│   │       └── widgets/
│
│   └── preferences/                  # Feature: Preferencias guardadas
│       ├── cubit/
│       │   ├── preference_cubit.dart
│       │   └── preference_state.dart
│       │
│       ├── data/
│       │   ├── datasources/
│       │   │   └── character_preference_local_datasource.dart
│       │   ├── models/
│       │   │   ├── character_preference_model.dart
│       │   │   ├── character_preference_edit_model.dart
│       │   │   ├── character_prepared_preference.dart
│       │   │   └── character_update_preference_input_model.dart
│       │   └── repositories/
│       │       └── character_preference_repository.dart
│       │
│       └── view/
│           ├── pages/
│           │   └── character_preferences_page.dart
│           └── widgets/
│
├── app.dart                          # 🏠 Configuración principal de la app
└── main.dart                         # 🚪 Punto de entrada
                    # 🚪 Punto de entrada de la aplicación
```

---

## 🏗️ Capas de la Arquitectura

### 1. **Core Layer** (Transversal)
Contiene código compartido entre todos los features:
- **constants**: URLs de API, colores, estilos globales
- **errors**: Excepciones personalizadas
- **helpers**: Clientes HTTP (Dio), utilidades
- **routes**: Configuración de navegación
- **widgets**: Componentes UI reutilizables

## 🎨 Características Principales

- ✅ Arquitectura limpia y modular
- ✅ Separación de responsabilidades (Data, Domain, Presentation)
- ✅ Gestión de estado con BLoC/Cubit
- ✅ Validaciones de formularios
- ✅ Manejo de errores personalizado
- ✅ Navegación con rutas nombradas
- ✅ UI responsive y moderna

---

## 🔄 Flujo de Datos

```
View (Widget) → Cubit → Repository → DataSource → API
     ↑                                              ↓
     └──────────── Estado actualizado ←────────────┘
```

1. **View** dispara una acción (ej: botón presionado)
2. **Cubit** maneja la lógica de negocio
3. **Repository** coordina las fuentes de datos
4. **DataSource** realiza la petición HTTP
5. **Cubit** emite un nuevo estado
6. **View** se reconstruye con los nuevos datos

---

## 📦 Instalación

```bash
# Clonar el repositorio
git clone https://github.com/sebasXDXD/flutter_technical_test.git

# Navegar al directorio
cd flutter_technical_test

# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

---

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo
- **Dart**: Lenguaje de programación
- **flutter_bloc**: Gestión de estado
- **dio**: Cliente HTTP
- **equatable**: Comparación de objetos
- **Provider**: Inyección de dependencias

---

## 📝 Convenciones de Código

- Nombres de archivos en `snake_case`
- Clases en `PascalCase`
- Variables y funciones en `camelCase`
- Constantes en `UPPER_SNAKE_CASE`
- Un widget por archivo (cuando sea posible)

---



## 👨‍💻 Autor

**Sebastian Urbina**
- GitHub: [@sebastiannurbina](https://github.com/sebasXDXD)
- Email: sebastianurbina.idetp@gmail.com