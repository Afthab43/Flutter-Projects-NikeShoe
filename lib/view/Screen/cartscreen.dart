// import 'package:brand_app/view/Screen/empty_state.dart';
import 'package:brand_app/data/dummy.dart';
import 'package:brand_app/model/shoe.model.dart';
import 'package:brand_app/utils/app_methods.dart';
import 'package:brand_app/view/Screen/empty_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int lengthsOfItemsOnBag =
      itemsOnCart.length; // aading to cart to an emppy cart
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          width: width,
          height: height,
          // color: Colors.red,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: height * 0.11,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shopping ',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Cart',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                itemsOnCart.isEmpty
                    ? EmptyState()
                    : Column(
                      children: [
                        _mainCartProductAddedList(width, height),
                        Divider(color: Colors.grey.shade300),
                        _totalAndButtonNext(width, height),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _totalAndButtonNext(double width, double height) {
    return SizedBox(
      // margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: width,
      height: height * 0.13,
      // color: Colors.blue,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " ${lengthsOfItemsOnBag} Items",
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                '\$${AppMethods.allTheItemsOnCart()}',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 11),
            width: width,
            height: height * 0.08,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                backgroundColor: const Color.fromARGB(255, 255, 132, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Add to cart logic
              },
              child: Text(
                "Next",
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _mainCartProductAddedList(double width, double height) {
    return SizedBox(
      width: width,
      height: height * 0.55,
      // color: Colors.red,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: itemsOnCart.length,
        itemBuilder: (context, index) {
          ShoeModel currentCartItem =
              itemsOnCart[index]; // item inside the index --added
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: width,
            height: height * 0.18,
            // color: Colors.amber.shade300,
            child: Row(
              children: [
                //item image
                SizedBox(
                  width: width * 0.36,
                  // color: Colors.blue,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        width: width * 0.38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.grey.shade200,
                        ),
                      ),
                      Positioned(
                        right: 2,
                        bottom: 15,
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(-28 / 360),
                          child: SizedBox(
                            width: 140,
                            height: 140,
                            child: Image(
                              image: AssetImage(currentCartItem.imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2),

                //item name and prive
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentCartItem.name.toUpperCase(),
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
                            text: ' ${currentCartItem.price}',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: Color.fromARGB(255, 0, 0, 0), // Black
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        //increment and delete
                        GestureDetector(
                          onTap: () {
                            //plus decremnt
                            setState(() {
                              itemsOnCart.add(currentCartItem);
                              lengthsOfItemsOnBag = itemsOnCart.length;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200,
                            ),
                            child: Center(child: Text('x1')),
                          ),
                        ),

                        SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              itemsOnCart.remove(currentCartItem);
                              lengthsOfItemsOnBag = itemsOnCart.length;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200,
                            ),
                            child: Icon(
                              CupertinoIcons.delete,
                              size: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
