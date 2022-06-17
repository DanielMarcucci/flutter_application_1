class Customer {
  int id;
  String firstName;
  String secondName;
  String firstSurname;

  Customer(
      {required this.id,
      this.firstName = '',
      this.secondName = '',
      this.firstSurname = ''});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        firstName: json['first_name'],
        secondName: json['second_name'],
        firstSurname: json['first_surname']);
  }
}
