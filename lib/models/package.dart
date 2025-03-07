class Order {
  String date;
  String package;
  String customerName;
  String color;
  String phone;
  String email;
  String location;
  String size;
  double price;
  bool delivered;
  String deliveredStatus;

  Order() {
    this.date = DateTime.now().toString();
  }

  Order.create(String date, String pack, String name, String size, double price,
      String color, String phone, String email, String loc,bool isDelivered,String deliveredStatus) {
    this.date = date;
    this.package = pack;
    this.customerName = name;
    this.color = color;
    this.phone = phone;
    this.email = email;
    this.location = loc;
    this.size = size;
    this.price = price;
    this.delivered = isDelivered;
    this.deliveredStatus = deliveredStatus;
  }

  @override
  String toString() {
    return "Date: $date, Description: $customerName, Beneficiary: $size, Amount: " +
        price.toString();
  }
}
