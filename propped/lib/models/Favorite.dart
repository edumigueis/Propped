import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

import 'package:propped/utils/Constants.dart';

class Favorite {
  final int id;
  final String code;
  final int user;
  final int product;

  Favorite({this.id, this.code, this.user, this.product});

  static Future<Favorite> save(Favorite fav) async{
    final http.Response response = await http.post(
      'http://' + Constants.serverIP + '/favorites',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_user_favorite': fav.user.toString(),
        'id_product_favorite': fav.product.toString(),
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      /*debugPrint(response.body.toString());
      debugPrint(jsonDecode(response.body));*/
      return new Favorite(user: fav.user, product: fav.product);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add item to wishlist');
    }
  }

  static Future<Response> delete(Favorite toBeDeleted) async{

      final http.Response response = await http.delete(
        'http://' + Constants.serverIP + '/favorites/'+toBeDeleted.user.toString()+'/' + toBeDeleted.product.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      return response;
  }

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
        id: json['id_favorite'],
        code: json['code_favorite'],
        user: json['id_user_favorite'],
        product: json['id_product_favorite'],
    );
  }
}