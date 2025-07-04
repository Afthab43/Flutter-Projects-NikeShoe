import 'package:brand_app/model/shoe.model.dart';
import 'package:brand_app/services/shoe_service.dart';
import 'package:brand_app/view/Screen/Details/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ShoeModel> _allShoes = [];
  List<ShoeModel> _filteredShoes = [];
  bool isLoading = true;
  String query = '';

  @override
  void initState() {
    super.initState();
    _loadShoes();
  }

  Future<void> _loadShoes() async {
    try {
      final data = await ShoeService.fetchShoes();
      setState(() {
        _allShoes = data;
        _filteredShoes = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching shoes: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterShoes(String input) {
    setState(() {
      query = input;
      if (query.isEmpty) {
        _filteredShoes = _allShoes;
      } else {
        _filteredShoes =
            _allShoes.where((shoe) {
              final name = shoe.name.toLowerCase();
              final tag = shoe.tag.toLowerCase();
              final search = query.toLowerCase();
              return name.contains(search) || tag.contains(search);
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: GoogleFonts.getFont(
            'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: _filterShoes,
              decoration: InputDecoration(
                hintText: ' Enter for Search',
                hintStyle: GoogleFonts.getFont(
                  'Poppins',
                  color: const Color.fromARGB(255, 141, 138, 138),
                  fontSize: 14,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/search.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromARGB(255, 235, 233, 233),
                filled: true,
              ),
            ),
          ),
          Expanded(
            child:
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _filteredShoes.isEmpty
                    ? Center(
                      child: Text(
                        'No products found.',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _filteredShoes.length,
                      itemBuilder: (context, index) {
                        final shoe = _filteredShoes[index];
                        return ListTile(
                          leading: Image.asset(
                            shoe.imageUrl,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(shoe.name),
                          subtitle: Text('\$${shoe.price}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => DetailView(
                                      isComeFromMoresection: false,
                                      shoeModel: shoe,
                                    ),
                              ),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
