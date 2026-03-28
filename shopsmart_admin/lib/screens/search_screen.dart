import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../widgets/product_widget.dart';
import '../widgets/title_text.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel> productList = passedCategory == null
        ? productsProvider.products
        : productsProvider.findByCategory(categoryName: passedCategory);
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitlesTextWidget(label: passedCategory ?? "Search Products"),
          elevation: 0,
        ),
        body: productList.isEmpty
            ? const Center(child: TitlesTextWidget(label: "No product found"))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15.0),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchTextController,
                        onChanged: (value) {
                          setState(() {
                            productListSearch = productsProvider.searchQuery(
                                searchText: searchTextController.text,
                                passedList: productList);
                          });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            productListSearch = productsProvider.searchQuery(
                                searchText: searchTextController.text,
                                passedList: productList);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search products...",
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: searchTextController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      searchTextController.clear();
                                      productListSearch.clear();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                )
                              : null,
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (searchTextController.text.isNotEmpty &&
                        productListSearch.isEmpty) ...[
                      const Expanded(
                        child: Center(
                          child: TitlesTextWidget(label: "No products found"),
                        ),
                      ),
                    ] else
                      Expanded(
                        child: DynamicHeightGridView(
                          itemCount: searchTextController.text.isNotEmpty
                              ? productListSearch.length
                              : productList.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          builder: (context, index) {
                            return ProductWidget(
                              productId: searchTextController.text.isNotEmpty
                                  ? productListSearch[index].productId
                                  : productList[index].productId,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
