import 'package:flutter/material.dart';

class DishCard extends StatelessWidget {
  final String dishName;
  final String imageUrl;

  const DishCard({
    Key? key,
    required this.dishName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Shadow effect to give the card a lifted appearance
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded corners
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ), // Rounded corners for the image
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl, // Load image from the network
                        height: 300,
                        width: double.infinity, // Full width of the container
                        fit: BoxFit.cover, // Cover the entire space without distortion
                      )
                    : Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.grey, // Placeholder color if no image
                        child: Icon(Icons.image, size: 50, color: Colors.white), // Placeholder icon
                      ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to wishlist')), // Show message on tap
                    );
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white70, // Wishlist icon color
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dishName, // Display the name of the dish
              style: TextStyle(
                fontSize: 18, // Font size for the dish name
                fontWeight: FontWeight.bold, // Bold text style
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 16), // Time icon
                SizedBox(width: 4),
                Text("20 minutes"), // Placeholder time
                SizedBox(width: 8),
                Icon(Icons.circle, size: 8, color: Colors.green), // Indicator for dish type
                SizedBox(width: 4),
                Text("Vegetarian"), // Placeholder dish type
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  size: 16,
                  color: index < 4 ? Colors.amber : Colors.grey, // Filled stars for rating
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
