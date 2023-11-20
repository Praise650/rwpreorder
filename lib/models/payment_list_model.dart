class PaymentListModel {
  final String id;
  final String date;
  final String package;
  final String color;
  final String phone;
  final String email;
  final String location;
  final String size;
  final double price;
  final bool delivered;
  final String fullname;
  final String deliveryStatus;

  PaymentListModel({
    this.id,
    this.date,
    this.package,
    this.color,
    this.phone,
    this.email,
    this.location,
    this.size,
    this.price,
    this.delivered,
    this.fullname,
    this.deliveryStatus,
  });

  factory PaymentListModel.fromJson(Map<String, dynamic> json, String userId) =>
      PaymentListModel(
        id: userId.isNotEmpty ? userId : '',
        date: json['date'],
        package: json['package'],
        color: json['color'],
        phone: json['phone_number'],
        email: json['email'],
        location: json['location'],
        size: json['size'],
        price: json['price'],
        delivered: json['delivered'],
        fullname: json['full_name'],
        deliveryStatus: json['deliveredStatus'],
      );

  @override
  String toString() {
    return "Date: $date, Description: $fullname, Beneficiary: $size, Amount: " +
        price.toString();
  }
}
