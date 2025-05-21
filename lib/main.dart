// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/stopwatch_viewmodel.dart';
import 'views/stopwatch_view.dart';
import 'package:device_preview/device_preview.dart'; // Para pruebas en dispositivos

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => const MyApp(),
    ), // Habilitamos DevicePreview para pruebas en dispositivos
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Proveemos el StopwatchViewModel a nuestro árbol de widgets.
    return ChangeNotifierProvider(
      create:
          (context) => StopwatchViewModel(), // Crea la instancia del ViewModel.
      child: MaterialApp(
        title: 'Cronómetro MVVM Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            // Estilo base para botones
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        home:
            const StopwatchView(), // La Vista principal de nuestra aplicación.
      ),
    );
  }
}
// El widget MyApp es el punto de entrada de la aplicación y configura el tema y el proveedor del ViewModel.
// El widget StopwatchView es la vista principal que muestra el cronómetro y los botones de control.
// El uso de ChangeNotifierProvider permite que el ViewModel notifique a la Vista sobre cambios en su estado.
// Esto es esencial para el patrón MVVM, donde la Vista se actualiza automáticamente cuando el ViewModel cambia.