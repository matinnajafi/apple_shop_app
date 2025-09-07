class BannerImage {
  String? id;
  String? collectionId;
  String? thumbnail;
  String? categoryId;

  BannerImage(this.id, this.collectionId, this.thumbnail, this.categoryId);

  //thumbnail Url:
  //http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME
  factory BannerImage.fromMapJson(Map<String, dynamic> jsonObject) {
    return BannerImage(
      jsonObject['id'],
      jsonObject['collectionId'],
      'https://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}', // banner String [banner.png] ===> banner Url [http://.../banner.png]
      jsonObject[' categoryId'],
    );
  }
}
