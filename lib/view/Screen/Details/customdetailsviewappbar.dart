import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDetailsViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDetailsViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading: IconButton(
        icon: const Icon(CupertinoIcons.arrow_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(CupertinoIcons.heart),
            onPressed: () {
              // Add favorite functionality here
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
