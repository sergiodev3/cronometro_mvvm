// views/stopwatch_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/stopwatch_viewmodel.dart';

// La Vista muestra la UI del cronómetro y delega las acciones al ViewModel.
class StopwatchView extends StatelessWidget {
  const StopwatchView({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos Consumer para escuchar cambios y reconstruir la UI.
    // También podemos acceder al viewModel directamente con Provider.of si no necesitamos reconstruir
    // una parte específica con el builder.
    // final viewModel = Provider.of<StopwatchViewModel>(context); // Opción alternativa de acceso

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronómetro MVVM'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Consumer reconstruye este Text cuando 'displayTime' cambia.
            Consumer<StopwatchViewModel>(
              builder: (context, viewModel, child) {
                return Text(
                  viewModel
                      .displayTime, // Obtiene el tiempo formateado del ViewModel.
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'monospace', // Para que los números tengan el mismo ancho
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            // Fila de botones para controlar el cronómetro.
            Consumer<StopwatchViewModel>(
              // Usamos otro Consumer para la lógica de habilitación de botones
              builder: (context, viewModel, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Botón Iniciar / Reanudar
                    ElevatedButton.icon(
                      icon: Icon(
                        viewModel.isRunning || viewModel.canResume
                            ? Icons.play_arrow
                            : Icons.play_arrow,
                      ),
                      label: Text(viewModel.canResume ? 'Reanudar' : 'Iniciar'),
                      // Habilitado si no está corriendo.
                      onPressed:
                          viewModel.isRunning
                              ? null
                              : () {
                                viewModel.startOrResume();
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Botón Detener
                    ElevatedButton.icon(
                      icon: const Icon(Icons.pause),
                      label: const Text('Detener'),
                      // Habilitado solo si está corriendo.
                      onPressed:
                          viewModel.isRunning
                              ? () {
                                viewModel.stop();
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            // Botón Reiniciar
            Consumer<StopwatchViewModel>(
              // Consumer para la lógica del botón reiniciar
              builder: (context, viewModel, child) {
                return ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                  // Habilitado si el tiempo es mayor a 0.
                  onPressed:
                      viewModel.canReset
                          ? () {
                            viewModel.reset();
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
