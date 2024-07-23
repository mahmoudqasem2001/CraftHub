import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ArtistProfileFromUser.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = 'product-details';
  const ProductDetailsScreen({
    super.key,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final Map<String, dynamic> item = args[0] as Map<String, dynamic>;
    final CartCubit cartCubit = context.read<CartCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.brown,
          ),
          onPressed: () {
            AppRouter.goBackTOScreen();
          },
        ),
        title: Text(
          "Item details",
          style: GoogleFonts.philosopher(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 19)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                item['image'].toString().contains(Constants.host)
                    ? item['image']
                    : '${Constants.host}${item['image']}',
                height: 250,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    item['is_favorite']
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: item['is_favorite'] ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      item['is_favorite'] = !item['is_favorite'];
                    });
                    if (item['fun'] != null) {
                      item['fun'](item, item['bloc_state']);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final String apiUrl =
                    '${Constants.baseUrl}accounts/19/details/';

                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final token = prefs.getString('accessToken');
                try {
                  final response = await http.get(
                    Uri.parse(apiUrl),
                    headers: <String, String>{
                      'Authorization': 'Bearer $token',
                    },
                  );
                  print(response.body);
                  if (response.statusCode == 200) {
                    final Map<String, dynamic> responseData =
                        jsonDecode(response.body);

                    Map<String, dynamic> artistData = {
                      "artist": {
                        "id": responseData['id'],
                        "first_name": responseData['first_name'],
                        "last_name": responseData['last_name'],
                        "profile": {
                          "id": responseData['profile']['id'],
                          "project_name": responseData['profile']
                              ['project_name'],
                          "image": responseData['profile']['image'],
                          "items": responseData['profile']['items'],
                          "category": responseData['profile']['category'],
                          "followers_count": responseData['profile']
                              ['followers_count'],
                        }
                      }
                    };

                    // Navigate to ArtistProfileFromUser route with artistData
                    AppRouter.goTOScreen(
                        ArtistProfileFromUser.routeName, artistData);
                  } else {
                    throw Exception('Failed to fetch artist details');
                  }
                } catch (e) {
                  print('Error fetching artist details: $e');
                  // Handle error state or show error message
                }
              },
              child: Text(
                '${item['profile']['artist']} - ${item['profile']['project_name']}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '\$${item['price']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.thumb_up, color: Colors.purple),
                const SizedBox(width: 4),
                Text('${item['count_likes']} likes'),
                const SizedBox(width: 16),
                const Icon(Icons.comment, color: Colors.purple),
                const SizedBox(width: 4),
                Text('${item['count_comments']} comments'),
              ],
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: item['comments'].length,
                itemBuilder: (context, index) {
                  print(item['image'].toString().contains(Constants.host)
                      ? item['comments'][index]['user']['image']
                      : '${Constants.host}${item['comments'][index]['user']['image']}');
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: ListTile(
                      title: Text(
                          '${item['comments'][index]['user']['first_name']} ${item['comments'][index]['user']['last_name']}'),
                      subtitle: Text(item['comments'][index]['comment']),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              item['comments'][index]['user']
                                      .toString()
                                      .contains(Constants.host)
                                  ? item['comments'][index]['user']['image']
                                  : '${Constants.host}${item['comments'][index]['user']['image']}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextFiledContainer(
              widthFactor: 1,
              heightFactor: 0.065,
              borderRadius: 29,
              child: TextFormField(
                onFieldSubmitted: (value) async {
                  if (value.trim().isNotEmpty) {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    final response = await http.post(
                      Uri.parse("${Constants.baseUrl}items/comments/"),
                      headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer ${prefs.get('accessToken')}"
                      },
                      body: jsonEncode(
                          {"item": item['id'], "comment": value.toString()}),
                    );

                    if (response.statusCode == 201) {
                      setState(() {
                        (item['comments'] as List)
                            .insert(0, jsonDecode(response.body));
                      });
                    }
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Type here...",
                  hintStyle: TextStyle(
                    color: AppColors.hintTextColor,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart action
                  item['item_quantity'] = 1;
                  cartCubit.addToCart(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
