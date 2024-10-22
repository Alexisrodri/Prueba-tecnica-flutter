# Yu-Gi-Oh! Card Viewer App

Esta aplicación es una prueba técnica desarrollada con Flutter para visualizar cartas de Yu-Gi-Oh!. Cuenta con dos pantallas principales: un catálogo general de cartas y una sección de cartas baneadas. Además, incluye filtrado por archetype, scroll infinito para cargar más cartas a medida que el usuario navega, y una vista individual para cada carta con detalles y descripción.

La visualización de cartas se realiza con un diseño estilo "masonry" para aprovechar mejor el espacio en la pantalla.

## Características

- **Pantalla de Catálogo de Cartas**: Muestra todas las cartas de Yu-Gi-Oh! disponibles, con la opción de hacer scroll infinito.
- **Pantalla de Cartas Baneadas**: Muestra las cartas que están actualmente baneadas en el juego.
- **Filtro por Archetype**: Filtra las cartas por archetype específico.
- **Visualización Detallada de Cartas**: Cada carta tiene su propia vista con detalles y descripción.
- **Scroll Infinito**: A medida que se navega en el catálogo, se cargan más cartas automáticamente.
- **Diseño tipo Masonry**: Utiliza una cuadrícula estilo "masonry" para mostrar las cartas.

## Paquetes Utilizados

- **[flutter_riverpod](https://pub.dev/packages/flutter_riverpod) (v2.5.3)**: Utilizado para el manejo de estado reactivo en la aplicación.
- **[flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) (v0.7.0)**: Para el diseño estilo "masonry" en la visualización de cartas.
- **[dio](https://pub.dev/packages/dio) (v5.7.0)**: Cliente HTTP para realizar las peticiones a la API de cartas de Yu-Gi-Oh!.
- **[go_router](https://pub.dev/packages/go_router) (v14.3.0)**: Utilizado para la navegación entre las diferentes pantallas de la app.

## Requisitos

- **Flutter**: Channel stable, 3.24.3
- **Sistema Operativo**: Microsoft Windows [Versión 10.0.22631.4317] o superior.

## Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/usuario/yu-gi-oh-card-viewer.git
   cd yu-gi-oh-card-viewer
   ```

2. Instala las dependencias:

   ```bash
   flutter pub get
   ```

3. Ejecuta la aplicación en un dispositivo o emulador::

   ```bash
   flutter pub get
   ```

# Estructura de carpetas

- lib
- [config/](.\lib\config)
  - [router/](.\lib\config\router)
    - [app_router.dart](.\lib\config\router\app_router.dart)
  - [theme/](.\lib\config\theme)
  - [config.dart](.\lib\config\config.dart)
- [features/](.\lib\features)
  - [cards/](.\lib\features\cards)
    - [domain/](.\lib\features\cards\domain)
    - [infrastructure/](.\lib\features\cards\infrastructure)
- [presentation/](.\lib\presentation)
  - [providers/](.\lib\presentation\providers)
    - [cards_provider.dart](.\lib\presentation\providers\cards_provider.dart)
    - [cards_repository_provider.dart](.\lib\presentation\providers\cards_repository_provider.dart)
    - [card_provider.dart](.\lib\presentation\providers\card_provider.dart)
    - [providers.dart](.\lib\presentation\providers\providers.dart)
    - [selected_archetype_provider.dart](.\lib\presentation\providers\selected_archetype_provider.dart)
  - [screens/](.\lib\presentation\screens)
    - [cards/](.\lib\presentation\screens\cards)
    - [home/](.\lib\presentation\screens\home)
  - [screens.dart](.\lib\presentation\screens.dart)
- [widgets/](.\lib\widgets)
  - [cards_cardview.dart](.\lib\widgets\cards_cardview.dart)
  - [card_details.dart](.\lib\widgets\card_details.dart)
  - [custom_buttom.dart](.\lib\widgets\custom_buttom.dart)
  - [custom_labels.dart](.\lib\widgets\custom_labels.dart)
  - [custom_list_masonry.dart](.\lib\widgets\custom_list_masonry.dart)
  - [full_screen_loader.dart](.\lib\widgets\full_screen_loader.dart)
  - [widgets.dart](.\lib\widgets\widgets.dart)
- [main.dart](.\lib\main.dart)
