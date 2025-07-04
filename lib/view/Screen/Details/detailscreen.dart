import 'package:brand_app/model/models.dart';
import 'package:brand_app/utils/app_methods.dart';
import 'package:brand_app/view/Screen/Details/customdetailsviewappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailView extends StatefulWidget {
  final ShoeModel shoeModel;
  final bool isComeFromMoresection;

  const DetailView({
    super.key,
    required this.isComeFromMoresection,
    required this.shoeModel,
  });

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int? selectedSizeIndex;
  int? selectedColorIndex;

  Color getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'black':
        return Colors.black;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'white':
        return Colors.white;
      case 'green':
        return Colors.green;
      case 'grey':
        return Colors.grey;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shoeModel = widget.shoeModel;
    Size size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomDetailsViewAppBar(
        shoeModel: shoeModel,
        onFavToggle: () {
          setState(() {}); // Refresh UI on favorite toggle
        },
      ),

      body: Stack(
        children: [
          Column(
            children: [
              // Background "AIR" and shoe image
              SizedBox(
                width: size.width,
                height: size.height / 1.0,
                child: Stack(
                  children: [
                    Positioned.fill(
                      bottom: size.height * 0.47,
                      left: size.width * 0.08,
                      right: size.width * 0.08,
                      child: Center(
                        child: Text(
                          'AIR',
                          style: TextStyle(
                            fontSize: 150,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(
                              255,
                              180,
                              177,
                              177,
                            ).withOpacity(0.07),
                            letterSpacing: 10,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.17,
                      left: size.width * 0.08,
                      right: size.width * 0.08,
                      child: Image.asset(
                        shoeModel.imageUrl,
                        height: size.height * 0.22,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bottom Sheet
          Positioned(
            top: size.height / 5.1,
            left: 0,
            right: 0,
            bottom: 0,
            child: DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // Name and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              shoeModel.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.top,
                                    child: Transform.translate(
                                      offset: Offset(
                                        0,
                                        -6,
                                      ), // Adjust this value as needed
                                      child: Text(
                                        '\$',
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                          color: Color.fromARGB(
                                            255,
                                            206,
                                            93,
                                            1,
                                          ), // Orange
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${shoeModel.price}',
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      color: Color.fromARGB(
                                        255,
                                        0,
                                        0,
                                        0,
                                      ), // Black
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${shoeModel.rating}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.white,
                                size: 12,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Available Sizes
                        const Text(
                          "Available Sizes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: List.generate(shoeModel.sizes.length, (
                            index,
                          ) {
                            final size = shoeModel.sizes[index];
                            final isSelected = selectedSizeIndex == index;
                            return RawChip(
                              label: Text(
                                size,
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.orange.shade800
                                          : Colors.black,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  selectedSizeIndex = index;
                                });
                              },
                              backgroundColor: Colors.grey.shade200,
                              selectedColor: Colors.orange.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color:
                                      isSelected
                                          ? Colors.orange
                                          : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              showCheckmark: false,
                            );
                          }),
                        ),

                        const SizedBox(height: 20),

                        // Available Colors
                        const Text(
                          "Color",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: List.generate(shoeModel.colors.length, (
                            index,
                          ) {
                            final colorName = shoeModel.colors[index];
                            final color = getColorFromName(colorName);
                            final isSelected = selectedColorIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColorIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? Colors.orange
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: color,
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          shoeModel.description,
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 30),

                        Container(
                          margin: EdgeInsets.only(top: 11, left: 8, right: 8),
                          width: width,
                          height: height * 0.08,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                255,
                                132,
                                1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Add to cart logic
                              AppMethods.addToCart(widget.shoeModel, context);
                            },
                            child: Text(
                              "Add to cart",
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 20,
                        //   right: 20,
                        //   child: FloatingActionButton(
                        //     onPressed: () {
                        //       // TODO: Add to cart logic
                        //     },
                        //     backgroundColor: Colors.orange,
                        //     child: const Icon(
                        //       Icons.add_shopping_cart,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
