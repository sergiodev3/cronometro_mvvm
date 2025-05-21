// viewmodels/stopwatch_viewmodel.dart
import 'dart:async'; // Para usar la clase Timer
import 'package:flutter/foundation.dart';
import '../models/stopwatch_model.dart';

// El ViewModel maneja la lógica de presentación y estado del cronómetro.
class StopwatchViewModel extends ChangeNotifier {
  // Instancia privada del Modelo.
  final StopwatchModel _stopwatch = StopwatchModel();
  Timer? _timer; // Timer para actualizar el tiempo transcurrido.

  // Getters públicos para que la Vista acceda a los datos formateados y al estado.
  String get displayTime {
    // Formatea los milisegundos a MM:SS:mm
    int totalSeconds = _stopwatch.milliseconds ~/ 1000;
    int minutes = (totalSeconds ~/ 60) % 60;
    int seconds = totalSeconds % 60;
    int hundredths =
        (_stopwatch.milliseconds % 1000) ~/ 10; // Dos dígitos para milisegundos

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredthsStr = hundredths.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr:$hundredthsStr';
  }

  bool get isRunning => _stopwatch.isRunning;
  bool get canStart => !_stopwatch.isRunning && _stopwatch.milliseconds == 0;
  bool get canResume => !_stopwatch.isRunning && _stopwatch.milliseconds > 0;
  bool get canStop => _stopwatch.isRunning;
  bool get canReset => _stopwatch.milliseconds > 0;

  // Acción para iniciar o reanudar el cronómetro.
  void startOrResume() {
    if (_stopwatch.isRunning) return; // Si ya está corriendo, no hacer nada.

    _stopwatch.isRunning = true;
    // El Timer se ejecuta cada 50 milisegundos para una actualización más fluida de los centisegundos.
    // Podrías ajustarlo a 10ms para mayor precisión si la UI lo soporta bien.
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      _stopwatch.milliseconds += 30;
      notifyListeners(); // Notifica a la Vista para que se actualice.
    });
    notifyListeners(); // Notifica el cambio de estado de isRunning y los botones.
  }

  // Acción para detener (pausar) el cronómetro.
  void stop() {
    if (!_stopwatch.isRunning) return; // Si no está corriendo, no hacer nada.

    _timer?.cancel(); // Detiene el Timer.
    _stopwatch.isRunning = false;
    notifyListeners(); // Notifica a la Vista el cambio de estado.
  }

  // Acción para reiniciar el cronómetro.
  void reset() {
    _timer?.cancel(); // Detiene el Timer si estaba corriendo.
    _stopwatch.milliseconds = 0;
    _stopwatch.isRunning = false;
    notifyListeners(); // Notifica a la Vista para que se actualice y muestre 00:00:00 y actualice botones.
  }

  // Es buena práctica limpiar los recursos (como el Timer) cuando el ViewModel ya no se necesite.
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
