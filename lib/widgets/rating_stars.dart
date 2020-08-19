import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {

  final int rating;

  RatingStars({this.rating});

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for(int i = 0; i < rating; i++){
      stars = stars + '⭐  ';
    }
    stars.trim();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(stars, style: TextStyle(fontSize: 18),),
    );
  }
}