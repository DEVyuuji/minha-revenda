class Client {
  String id;
  String name;
  String phone;
  String email;
  String cpf;
  String address;

  Client({required this.id, required this.name, required this.phone, required this.email, required this.cpf, required this.address});
}

class Product {
  String id;
  String name;
  String brand;
  String sku;
  double costPrice;
  double salePrice;
  int quantity;
  String category;

  Product({required this.id, required this.name, required this.brand, required this.sku, required this.costPrice, required this.salePrice, required this.quantity, required this.category});
}
