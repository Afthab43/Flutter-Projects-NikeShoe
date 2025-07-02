import 'package:brand_app/model/shoe.model.dart';
import 'package:brand_app/utils/app_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDetailsViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ShoeModel shoeModel;
  final VoidCallback onFavToggle;

  const CustomDetailsViewAppBar({
    super.key,
    required this.shoeModel,
    required this.onFavToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Logo',
        style: GoogleFonts.getFont(
          'Poppins',
          color: const Color(0XFF0D120E),
          letterSpacing: 0.2,
          fontSize: 35,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(CupertinoIcons.arrow_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              AppMethods.isFavorite(shoeModel)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              AppMethods.toggleFavorite(shoeModel, context);
              onFavToggle(); // Tell DetailView to rebuild
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
