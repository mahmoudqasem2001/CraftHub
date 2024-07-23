// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:grad_new_project/Views/UserCompletionPage.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';

class CategoriesButtons extends StatefulWidget {
  final Map<String, int> categories;

  CategoriesButtons({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<CategoriesButtons> createState() => _CategoriesButtonsState();
}

class _CategoriesButtonsState extends State<CategoriesButtons> {
  Map<String, int> categories = {};

  final Map<String, bool> _buttonStates = {};
  final List<String> _interestedInCategories =
      []; // contains the selected categories
  int count = 0;
  @override
  void initState() {
    super.initState();
    // Initialize button states
    categories = widget.categories;
    categories.keys.forEach((key) {
      _buttonStates[key] = false;
    });
  }

  // Callback function to handle button press
  void _onButtonPressed(String key) {
    setState(() {
      _buttonStates[key] = !_buttonStates[key]!;
      if (_buttonStates[key]!) {
        _interestedInCategories.add(key);
        interestedCategories[count.toString()] = categories[key] ?? 0;
        count += 1;
      } else {
        _interestedInCategories.remove(key);
        interestedCategories.remove(count.toString());
        if (count > 0) {
          count -= 1;
        }
      }
    });
    print(interestedCategories);
    /* ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pressed $key with value ${categories[key]}')),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 0, // Spacing between rows
                childAspectRatio: 3 / 1,
                mainAxisExtent: 50,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String key = categories.keys.elementAt(index);
                bool isPressed = _buttonStates[key]!;

                return /*ElevatedButton(
                        onPressed: () => _onButtonPressed(context, key, value),
                        child: Text(key),
                      );*/
                    Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: Container(
                      height: 2,
                      width: 2,
                      child: ElevatedButton(
                        onPressed: () => _onButtonPressed(key),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            isPressed
                                ? AppColors.primary
                                : AppColors.lightPurple,
                          ),
                          overlayColor: MaterialStateProperty.all(
                            AppColors.overlayColor,
                          ),
                        ),
                        child: Text(
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          key,
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                isPressed ? AppColors.white : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
