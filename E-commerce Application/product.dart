class ProductDetailPage extends StatelessWidget {
  final dynamic product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product['image'], height: 200),
            SizedBox(height: 10),
            Text(
              product['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("\$${product['price']}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(product['description']),
            SizedBox(height: 10),
            Text("Rating: ${product['rating']['rate']} / 5"),
          ],
        ),
      ),
    );
  }
}
