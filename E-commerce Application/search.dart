class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List searchResults = [];
  bool isLoading = false;

  Future<void> searchProducts(String query) async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/search?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                searchProducts(query);
              },
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: searchResults[index]);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
