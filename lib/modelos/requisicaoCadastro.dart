import 'package:uuid/uuid.dart';

class RequisicaoCadastro {
  String id;
  String timestamp;
  String idEleitor;
  String assintatura;

  RequisicaoCadastro(this.idEleitor) {
    var novaId = Uuid();
    this.id = novaId.v4();
    this.timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  }

  String dados() {
    return "${this.id}:${this.timestamp}:${this.idEleitor}";
  }

  Map<String, String> paraJson() {
    return {
      'idEleitor': this.idEleitor,
      'id': this.id,
      'timestamp': this.timestamp,
      'assinatura': this.assintatura,
    };
  }
}
