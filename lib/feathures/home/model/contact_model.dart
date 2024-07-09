class ContactUs {
  final String id;
  final String fullname;
  final String email;
  final String address;
  final String phone;
  final String message;

  ContactUs(
      {required this.id,
      required this.fullname,
      required this.email,
      required this.address,
      required this.phone,
      required this.message});

  factory ContactUs.fromJson(Map<String, dynamic> json) {
    return ContactUs(
        id: json['_id'],
        fullname: json['fullname'],
        email: json['email'],
        address: json['address'],
        phone: json['phone'],
        message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'address': address,
      'phone': phone,
      'message': message
    };
  }
}
