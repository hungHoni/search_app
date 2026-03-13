import '../domain/models/search_result.dart';

final Map<String, List<Map<String, String>>> phase2MobileContent = {
  'flutter architecture': [
    {
      'title': 'The Widget Tree',
      'summary': 'In Flutter, everything is a widget. The framework builds three separate trees: the Widget tree (configurations), Element tree (lifecycle), and RenderObject tree (layout/painting). Understanding this hierarchy is key to optimizing performance.',
    },
    {
      'title': 'State Management Patterns',
      'summary': 'Architecting large apps requires separating logic from UI. Common patterns include BLoC (Business Logic Component) using Streams, Riverpod for compile-safe dependency injection, and Provider for simple tree-based state dispersal.',
    },
    {
      'title': 'The Layered Engine',
      'summary': 'The Flutter engine is written in C++ and handles low-level graphics via Impeller/Skia. Above it sits the Dart framework, which provides the Material and Cupertino design libraries used by developers.',
    },
    {
      'title': 'Platform Channels',
      'summary': 'When you need to access native features like GPS or sensors, Flutter uses asynchronous message passing via MethodChannels. This allows Dart to communicate with Swift (iOS) and Kotlin (Android).',
    },
    {
      'title': 'Keys and Reconciliation',
      'summary': 'Keys (ValueKey, GlobalKey) help Flutter preserve state when widgets move around the tree. They are essential for modifying collections of stateful widgets like lists without losing user input or scroll position.',
    },
  ],
  'swiftui fundamentals': [
    {
      'title': 'Declarative UI',
      'summary': 'SwiftUI uses a declarative syntax, meaning you describe what the UI should look like, and the framework handles the "how" of updating it when state changes.',
    },
    {
      'title': 'State and Binding',
      'summary': 'Core property wrappers like @State, @Binding, and @ObservedObject manage the flow of data. A change in state automatically triggers a UI re-render on the body property.',
    },
    {
      'title': 'View Builders',
      'summary': 'SwiftUI relies on trailing closures and the ViewBuilder attribute to allow for clean, DSL-like code when stacking components like VStack, HStack, and ZStack.',
    },
    {
      'title': 'Modifiers',
      'summary': 'Layout and styling are applied through chained modifiers. The order matters: `.padding().background(Color.blue)` is different from `.background(Color.blue).padding()`.',
    },
    {
      'title': 'NavigationStack',
      'summary': 'Modern SwiftUI navigation uses NavigationStack and NavigationPath to manage complex, data-driven routing flows that are easy to deep-link into.',
    },
  ],
  'jetpack compose': [
    {
      'title': 'Composable Functions',
      'summary': 'Compose is Android’s modern UI toolkit. UI is built using functions annotated with @Composable, which can be easily reused and tested in isolation.',
    },
    {
      'title': 'Recomposition',
      'summary': 'The framework only re-executes the specific functions whose state has changed, making it highly efficient compared to the old XML View system.',
    },
    {
      'title': 'State Hoisting',
      'summary': 'A pattern where state is moved to a caller to make a component stateless. This improves reusability and makes state management more predictable.',
    },
    {
      'title': 'Modifier System',
      'summary': 'Like SwiftUI, Compose uses Modifiers to decorate or augment composables, handling everything from click listeners to padding and border styling.',
    },
    {
      'title': 'Material You Integration',
      'summary': 'Compose provides deep, native support for Material Design 3 (Material You), including dynamic color themes derived from the user’s wallpaper.',
    },
  ],
};
