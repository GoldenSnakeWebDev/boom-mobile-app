// "boom_type" : "image",
// "network": "6362b237b11f989c35773a4b",
// "description":"SOME description",
// "image_url": "http://localhost:4000/NFTS/NFTS-a46c2e4e-5b67-11ed-9234-0123456789ab-1667473757993.png",
// "title":"The First Boom",
// "quantity": "10",
// "tags": "some,next,booms,andNewWeGetIt",
// "fixed_price": "0",
// "price":"1.02"

class NewPostModel {
  final String boomType;
  final String network;
  final String description;
  final String title;
  final String imageUrl;
  final String quantity;
  final String tags;
  final String fixedPrice;
  final String price;
  final String timestamp;

  NewPostModel({
    required this.boomType,
    required this.network,
    required this.description,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.tags,
    required this.fixedPrice,
    required this.price,
    required this.timestamp,
  });
}
