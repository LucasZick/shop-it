import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:shop/providers/cart.dart';
import 'package:shop/utils/constants.dart';

class Order {
  final String? id;
  final double? total;
  final List<CartItem>? products;
  final DateTime? date;

  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}

class Orders with ChangeNotifier {
  final String _baseUrl = '${Constants.baseApiUrl}/orders';
  String? _token;
  String? _userId;
  List<Order> _items = [];

  Orders([this._token, this._userId, this._items = const []]);

  List<Order> get items => [..._items];

  int? get itemsCount => _items.length;

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final response =
        await http.get(Uri.parse("$_baseUrl/$_userId.json?auth=$_token"));
    Map<String, dynamic>? data = json.decode(response.body);
    loadedItems.clear();
    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(
          Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(
              orderData['date'],
            ),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      productId: item['productId'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price'],
                    ))
                .toList(),
          ),
        );
      });
      notifyListeners();
    }
    _items = loadedItems.reversed.toList();
    return Future.value();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse("$_baseUrl/$_userId.json?auth=$_token"),
      body: json.encode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values
            .map((cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'title': cartItem.title,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                })
            .toList()
      }),
    );

    _items.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
