import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/dish.dart';

// Provider for the DishViewModel, managing the state of the list of dishes
final dishViewModelProvider =
    StateNotifierProvider<DishViewModel, List<Dish>>((ref) {
  return DishViewModel();
});

// ViewModel class for managing the state of dishes
class DishViewModel extends StateNotifier<List<Dish>> {
  // Constructor initializes the state with an empty list of dishes
  DishViewModel() : super([]);

  // Asynchronous method to fetch dishes from a remote API
  Future<void> fetchDishes() async {
    // Sending a GET request to the API endpoint
    final response = await http.get(Uri.parse(
        'https://fls8oe8xp7.execute-api.ap-south-1.amazonaws.com/dev/nosh-assignment'));

    // Checking if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Decoding the JSON response
      final List<dynamic> data = json.decode(response.body);

      // Mapping the decoded JSON data to a list of Dish objects and updating the state
      state = data.map((dish) => Dish.fromJson(dish)).toList();
    } else {
      // Throwing an exception if the API request fails
      throw Exception('Failed to load dishes');
    }
  }
}
