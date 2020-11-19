class ImageObj{
  String url;
  final int idImage;
  final int idProduct;

  ImageObj({this.url, this.idImage, this.idProduct});

  factory ImageObj.fromJson(Map<String, dynamic> json) {
    return ImageObj(
      idImage: json['id_image_imagesproduct'],
      idProduct: json['id_product_imagesproduct'],
    );
  }
}