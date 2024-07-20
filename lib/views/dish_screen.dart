import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/dish_view_model.dart';
import '../widgets/dish_card.dart';
import '../widgets/dish_card_horizontal.dart';

class DishScreen extends ConsumerStatefulWidget {
  @override
  _DishScreenState createState() => _DishScreenState();
}

class _DishScreenState extends ConsumerState<DishScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch dishes when the screen initializes
    ref.read(dishViewModelProvider.notifier).fetchDishes();
  }

  @override
  Widget build(BuildContext context) {
    final dishes = ref.watch(dishViewModelProvider);

    // Debug: Print the number of dishes
    print('Number of dishes: ${dishes.length}');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Recipes',
            style: TextStyle(
              fontSize: 20, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.grey[800], // Dark grey color for the heart icon
            ),
            onPressed: () {
              // Handle the wishlist action here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Wishlist button pressed!'),
                ),
              );
            },
          ),
        ],
      ),
      body: dishes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with centered text overlay and search bar
                  Stack(
                    children: [
                      dishes.length > 2
                          ? Image.network(
                              dishes[2].imageUrl ??
                                  'https://via.placeholder.com/400x250', // Fallback URL
                              height: 400,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 400,
                              width: double.infinity,
                              color: Colors.grey,
                              child: Icon(Icons.image, size: 50, color: Colors.white),
                            ),
                      Positioned(
                        top: 20,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Dish of the day',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                dishes.length > 2
                                    ? dishes[2].dishName ?? 'Unknown Dish'
                                    : 'No Dish Available',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // First Horizontal ListView
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Discover regional delights',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Container(
                    height: 360, // Adjust height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dishes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DishCardHorizontal(
                            dishName: dishes[index].dishName ?? 'Unknown Dish',
                            imageUrl: dishes[index].imageUrl ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  // Second Horizontal ListView
                  Container(
                    color: Colors.black, // Background color for title and list
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Breakfasts for champions',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 360, // Adjust height as needed
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dishes.length,
                            itemBuilder: (context, index) {
                              // Reverse the list for the second ListView
                              final reversedIndex = dishes.length - 1 - index;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DishCardHorizontal(
                                  dishName: dishes[reversedIndex].dishName ??
                                      'Unknown Dish',
                                  imageUrl: dishes[reversedIndex].imageUrl ?? '',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  // Vertical ListView
                  ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // Prevent vertical scroll
                    shrinkWrap: true,
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DishCard(
                          dishName: dishes[index].dishName ?? 'Unknown Dish',
                          imageUrl: dishes[index].imageUrl ?? '',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
