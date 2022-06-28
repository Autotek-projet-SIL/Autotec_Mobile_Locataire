class BaridiMobAccount {
  String? _email;
  String? _rip;
  static final BaridiMobAccount _instance = BaridiMobAccount._internal();
  factory BaridiMobAccount() {
    return _instance;
  }

  BaridiMobAccount._internal() {
    _email = "artificcontactpro@gmail.com";
    _rip = "0007934312342353";
  }
  get email => _email;
  set email(value) => _email = value;
  get rip => _rip;
  set rip(value) => _rip = value;
}
