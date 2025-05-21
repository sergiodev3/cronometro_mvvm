// models/stopwatch_model.dart

// El Modelo representa los datos crudos del cronómetro.
class StopwatchModel {
  int milliseconds; // Almacenamos el tiempo en milisegundos
  bool isRunning; // Indica si el cronómetro está activo

  StopwatchModel({this.milliseconds = 0, this.isRunning = false});
}
