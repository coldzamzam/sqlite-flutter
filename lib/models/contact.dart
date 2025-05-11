class Contact {
  int _id = 0;
  String _name = '';
  String _phone = '';

  // Konstruktor versi 1
  Contact(this._name, this._phone);

  // Konstruktor versi 2: Konversi dari Map ke Contact
  Contact.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _phone = map['phone'];
  }

  // Getter
  int get id => _id;
  String get name => _name;
  String get phone => _phone;

  // Setter
  set name(String value) {
    _name = value;
  }
  
  set phone(String value) {
    _phone = value;
  }

  // Konversi dari Contact ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'phone': _phone,
    };
  }
}
