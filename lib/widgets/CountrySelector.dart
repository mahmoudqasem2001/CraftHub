// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_state/city_screen.dart';
import 'package:flutter_country_state/flutter_country_state.dart';
import 'package:flutter_country_state/state_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';

class CountrySelector extends StatefulWidget {
  String selectedState = "";
  String selectedCity = "";
  String selectedCountry = "";
  CountrySelector({
    Key? key,
    required this.selectedState,
    required this.selectedCity,
    required this.selectedCountry,
  }) : super(key: key);

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            color: AppColors.lightPurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 25,
                  child: Text(
                    'Country:           ',
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 17)),
                  ),
                ),
                InkWell(
                  child: Container(
                    height: 24,
                    width: 200,
                    child: Text(
                      widget.selectedCountry,
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                              fontSize: 15)),
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => CountryScreen()),
                    // );
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      isDismissible: false,
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.66,
                        child: ShowCountryDialog(
                          searchHint: 'Search for a country',
                          substringBackground: Colors.black,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          countryHeaderStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          searchStyle: const TextStyle(color: Colors.black),
                          subStringStyle: const TextStyle(color: Colors.white),
                          selectedCountryBackgroundColor: Colors.pink,
                          notSelectedCountryBackgroundColor: Colors.white,
                          onSelectCountry: () {
                            setState(() {
                              widget.selectedCountry = Selected.country;
                              widget.selectedState = "Not Selected";
                              widget.selectedCity = "Not Selected";
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            color: AppColors.lightPurple,
          ),
          Container(
            color: AppColors.lightPurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 25,
                  child: Text(
                    'State:                ',
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 17)),
                  ),
                ),
                InkWell(
                  child: Container(
                    height: 24,
                    width: 200,
                    child: Text(
                      widget.selectedState,
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                              fontSize: 15)),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      isDismissible: false,
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.66,
                        child: ShowStateDialog(
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          stateHeaderStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          subStringStyle: const TextStyle(color: Colors.white),
                          substringBackground: Colors.black,
                          selectedStateBackgroundColor: Colors.orange,
                          notSelectedStateBackgroundColor: Colors.white,
                          onSelectedState: () {
                            setState(() {
                              widget.selectedState = Selected.state;
                              widget.selectedCity = "Not Selected";
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            color: AppColors.lightPurple,
          ),
          Container(
            color: AppColors.lightPurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 25,
                  child: Text(
                    'City:                  ',
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 17)),
                  ),
                ),
                InkWell(
                  child: Container(
                    height: 24,
                    width: 200,
                    child: Text(
                      widget.selectedCity,
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                              fontSize: 15)),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      isDismissible: false,
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ShowCityDialog(
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          subStringStyle: const TextStyle(color: Colors.white),
                          substringBackground: Colors.black,
                          selectedCityBackgroundColor: Colors.orange,
                          notSelectedCityBackgroundColor: Colors.white,
                          onSelectedCity: () {
                            setState(() {
                              widget.selectedCity = Selected.city;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
