// import 'package:flutter/foundation.dart';
import 'package:brand_app/data/dummy.dart';
import 'package:brand_app/model/models.dart';
import 'package:brand_app/services/shoe_service.dart';
import 'package:brand_app/utils/app_methods.dart';
import 'package:brand_app/view/Screen/Details/detailscreen.dart';
import 'package:flutter/cupertino.dart';
// import 'package:brand_app/model/shoe.model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ShoeModel> filteredShoes = [];

  Future<void> loadShoes() async {
    try {
      final data = await ShoeService.fetchShoes();
      setState(() {
        _shoes = data;
        filteredShoes = data; // ✅ show all data initially
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching shoes: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterShoes(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredShoes = _shoes; // ✅ show all when input is empty
      });
      return;
    }

    final results =
        _shoes.where((shoe) {
          final nameLower = shoe.name.toLowerCase();
          final tagLower = shoe.tag.toLowerCase();
          final input = query.toLowerCase();
          return nameLower.contains(input) || tagLower.contains(input);
        }).toList();

    setState(() {
      filteredShoes = results;
    });
  }

  // int selectedIndexOfCategory = 0;
  final ScrollController _scrollController = ScrollController();
  int selectedIndexOfCategory = 0;

  // / ✅ Add these:
  List<ShoeModel> _shoes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadShoes(); // ✅ fetch shoes from API
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: const Color.fromARGB(255, 244, 241, 241),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80,
          // backgroundColor: const Color.fromARGB(255, 241, 241, 241),
          title: Text(
            'Logo',
            style: GoogleFonts.getFont(
              'Poppins',
              color: Color(0XFF0D120E),
              letterSpacing: 0.2,
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Our',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Color(0XFF0D120E),
                    letterSpacing: 0.2,
                    fontSize: 30,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // -----------------
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Products',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Color(0XFF0D120E),
                    letterSpacing: 0.2,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // -----------------search bar-----------------
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 320,
                      height: 50,
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterShoes, //
                        decoration: InputDecoration(
                          hintText: ' Enter for Search',
                          hintStyle: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color.fromARGB(255, 141, 138, 138),
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/icons/search.png',
                              width: 24,
                              height: 24,
                            ),
                          ),

                          fillColor: const Color.fromARGB(255, 235, 233, 233),
                          filled: true,
                          focusColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // borderSide: BorderSide(
                            //   color: Colors.grey, // normal border color
                            //   width: 1,
                            // ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    // -----------------filter button-----------------
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(
                                255,
                                179,
                                172,
                                172,
                                // ignore: deprecated_member_use
                              ).withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 8,
                              offset: const Offset(
                                2,
                                2,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        width: 50,
                        height: 50,

                        child: IconButton(
                          icon: Image.asset(
                            'assets/icons/filter.png',
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {
                            // Add filter functionality here
                          },
                          tooltip: 'Filter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              // -----------------all categories-----------------
              Column(children: [_categoryView(size)]),
              SizedBox(height: size.height * 0.02),

              // -----------------all products-----------------
              Container(
                height: size.width * 0.89,
                width: size.height,
                // color: const Color.fromARGB(
                //   255,
                //   244,
                //   241,
                //   241,
                // ), //const Color.fromARGB(255, 244, 241, 241)
                child:
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : filteredShoes.isEmpty
                        ? Center(
                          child: Text(
                            'No products found',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        )
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredShoes.length, //* fetch api data
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            ShoeModel model = filteredShoes[index];
                            return GestureDetector(
                              onTap: () {
                                // we will navigaete to details screen of the item
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailView(
                                          isComeFromMoresection: false,
                                          shoeModel: model,
                                        ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size.height * 0.020,
                                      vertical: size.width * 0.03,
                                    ),

                                    width: size.width / 1.5,
                                    height: size.height * 0.8,
                                    decoration: BoxDecoration(
                                      color: Colors.white, //^ color
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    // color: const Color.fromARGB(255, 255, 255, 255),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: size.width * 0.35,
                                              height: size.width * 0.35,
                                              decoration: BoxDecoration(
                                                color: Colors.orange.shade100,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            RotationTransition(
                                              turns:
                                                  const AlwaysStoppedAnimation(
                                                    -0.06,
                                                  ),
                                              child: Image.asset(
                                                model.imageUrl,
                                                height: size.height * 0.3,
                                                width: size.width * 0.57,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            model.name,
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              color: const Color.fromARGB(
                                                255,
                                                0,
                                                0,
                                                0,
                                              ),
                                              letterSpacing: 0.2,
                                              fontSize: 21,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 8,
                                          ),
                                          child: Text(
                                            model.tag,
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                132,
                                                1,
                                              ),
                                              letterSpacing: 0.2,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 8,
                                          ),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment.top,
                                                  child: Transform.translate(
                                                    offset: Offset(
                                                      0,
                                                      -6,
                                                    ), // Adjust this value as needed
                                                    child: Text(
                                                      '\$',
                                                      style:
                                                          GoogleFonts.getFont(
                                                            'Poppins',
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  206,
                                                                  93,
                                                                  1,
                                                                ), // Orange
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ${model.price}',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Color.fromARGB(
                                                      255,
                                                      0,
                                                      0,
                                                      0,
                                                    ), // Black
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 30,
                                    left: 30,
                                    child: GestureDetector(
                                      onTap: () {
                                        AppMethods.toggleFavorite(
                                          model,
                                          context,
                                        );
                                        setState(() {}); // Update UI
                                      },
                                      child: Icon(
                                        AppMethods.isFavorite(model)
                                            ? CupertinoIcons.heart_fill
                                            : CupertinoIcons.heart,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

  //^ widget for category view
  Widget _categoryView(Size size) {
    return Row(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.05,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndexOfCategory == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndexOfCategory = index;
                  });

                  // Animate scroll to center the selected item
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final itemWidth = 100.0; // Approximate chip width
                    final screenCenter = size.width / 2;
                    final scrollOffset =
                        (index * itemWidth) - screenCenter + (itemWidth / 2);

                    _scrollController.animateTo(
                      scrollOffset.clamp(
                        _scrollController.position.minScrollExtent,
                        _scrollController.position.maxScrollExtent,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Chip(
                    label: Text(
                      categories[index]['name']!,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: isSelected ? 16 : 14,
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isSelected ? Colors.orange : Colors.transparent,
                        width: 1.8,
                      ),
                    ),
                    elevation: isSelected ? 2 : 0,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
