import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List products = [];
  int page = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        fetchMoreProducts();
      }
    });
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products?limit=10&page=$page'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
        isLoading = false;
      });
    }
  }

  Future<void> fetchMoreProducts() async {
    setState(() {
      isLoading = true;
      page++;
    });
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products?limit=10&page=$page'));
    if (response.statusCode == 200) {
      setState(() {
        products.addAll(json.decode(response.body));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce App"),
      ),
      body: isLoading && products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: products.length + 1,
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink();
                }
                return ProductCard(product: products[index]);
              },
            ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final dynamic product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product['image'], width: 50, height: 50),
      title: Text(product['title']),
      subtitle: Text("\$${product['price']}"),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)));
      },
    );
  }
}
