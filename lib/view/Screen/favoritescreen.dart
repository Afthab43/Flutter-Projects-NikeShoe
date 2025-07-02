// import 'package:brand_app/model/models.dart';
import 'package:brand_app/utils/app_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = AppMethods.favoritesList; // however you store your list

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Favorites',
          style: GoogleFonts.getFont(
            'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body:
          favorites.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Favorities added',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text('Once you have added come back !! '),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return ListTile(
                    leading: Image.asset(item.imageUrl, width: 50),
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toString()}'),
                    trailing: IconButton(
                      icon: Icon(CupertinoIcons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          AppMethods.toggleFavorite(item, context);
                        });
                      },
                    ),
                  );
                },
              ),
    );
  }
}
