
import 'dart:convert';

class Client {

  String  id;
  String  title;
  double  price;
  bool    available;
  String  photoUrl;

  Client(
    {
      this.id,
      this.title,
      this.price,
      this.available,
      this.photoUrl,
    }
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "available": available,
    "photoUrl": photoUrl,
  };

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id:         json["id"],
    title:      json["title"],
    price:      json["price"],
    available:  json["available"],
    photoUrl:   json["photoUrl"],
  );

  
}

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());
