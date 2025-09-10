// ignore: file_names
class Productimage {
  String? imageUrl;
  String? productId;

  Productimage(this.imageUrl, this.productId);

  factory Productimage.fromMapJson(Map<String, dynamic> jsonObject) {
    return Productimage(
      'https://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      jsonObject['product_id'],
    );
  }
}
