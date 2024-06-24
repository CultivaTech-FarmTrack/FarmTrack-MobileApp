class DevicesCatalog{
  final int id;
  final String model;
  final String category;
  final int price;
  final String imageUrl;
  final int stock;
  final String specifications;


   DevicesCatalog({
    required this.id,
    required this.model,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.stock,
    required this.specifications,
  });

  

  DevicesCatalog.fromJson(Map<String, dynamic> json)
  :
      id = json['id'],
      model= json['model'],
      category= json['category'],
      price= json['price'],
      imageUrl= json['imageUrl'],
      stock= json['stock'],
      specifications= json['specifications'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
      'stock': stock,
      'specifications': specifications
    };
  }
}