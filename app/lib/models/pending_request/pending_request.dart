class PendingRequest {
  int id;
  String monto;
  DateTime fecha;
  Map<String, dynamic> categoria;
  Map<String, dynamic> cliente;
  String nombre;
  String? description;
  PendingRequest({
    required this.id,
    required this.monto,
    required this.fecha,
    required this.categoria,
    required this.cliente,
    required this.nombre,
    this.description = "This task has no description",
  });
  // Getters
  int get getId => id;
  String get getMonto => monto;
  DateTime get getFecha => fecha;
  Map<String, dynamic> get getCategoria => categoria;
  Map<String, dynamic> get getCliente => cliente;

  String? get getDescription => description;

  String get getNombre => nombre;
  // Setters
  set setId(int value) {
    id = value;
  }

  set setMonto(String value) {
    monto = value;
  }

  set setFecha(DateTime value) {
    fecha = value;
  }

  set setCategoria(Map<String, dynamic> value) {
    categoria = value;
  }

  set setCliente(Map<String, dynamic> value) {
    cliente = value;
  }

  set setNombre(String value) {
    nombre = value;
  }

  set setDescription(String? value) {
    description = value;
  }
}
