// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_country_state/city_screen.dart';
import 'package:flutter_country_state/flutter_country_state.dart';
import 'package:flutter_country_state/state_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/widgets/TextFiledContainer.dart';

class LocationSelectorWithTextField extends StatefulWidget {
  String selectedState = "";
  String selectedCity = "";
  String selectedCountry = "";

  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  LocationSelectorWithTextField({
    Key? key,
    required this.selectedState,
    required this.selectedCity,
    required this.selectedCountry,
    required this.countryController,
    required this.stateController,
    required this.cityController,
  }) : super(key: key);

  @override
  State<LocationSelectorWithTextField> createState() =>
      _LocationSelectorWithTextFieldState();
}

//****   Note: here when the location is selected I set the hint text
// of the text field to hold the selected COuntry/city/state  ***** */
class _LocationSelectorWithTextFieldState
    extends State<LocationSelectorWithTextField> {
  Color countryTextColor = Color.fromRGBO(111, 53, 165, 0.341);
  bool countrySelected = false;
  bool citySelected = false;
  bool stateSelected = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("      Country",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(200, 141, 87, 193)),
                    )),
                SizedBox(
                  // height: 5,
                  width: 5,
                ),
                TextFiledContainer(
                    widthFactor: 0.74,
                    heightFactor: 0.045,
                    borderRadius: 15,
                    child: TextFormField(
                      readOnly: true,
                      //textAlignVertical: TextAlignVertical.top,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Color.fromARGB(201, 111, 53, 165),
                            fontWeight: FontWeight.bold),
                      ),
                      obscureText: false,
                      controller: widget.countryController,
                      validator: (value) {
                        setState(() {
                          //_errorText = widget.validator!(value);
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: widget.selectedCountry,
                        hintStyle: TextStyle(
                          color: countrySelected
                              ? Color.fromARGB(201, 111, 53, 165)
                              : Color.fromRGBO(111, 53, 165, 0.341),
                          fontSize: 14.1,
                        ),
                        icon: null,
                        border: InputBorder.none,
                      ),
                      onTap: () {
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              countryHeaderStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              searchStyle: const TextStyle(color: Colors.black),
                              subStringStyle:
                                  const TextStyle(color: Colors.white),
                              selectedCountryBackgroundColor: Colors.pink,
                              notSelectedCountryBackgroundColor: Colors.white,
                              onSelectCountry: () {
                                setState(() {
                                  widget.selectedCountry = Selected.country;
                                  countrySelected = true;
                                  widget.countryController.text =
                                      Selected.country;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    )),
                /*if (_errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      _errorText!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),*/
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.76,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*  if (!isDesktop)
                    SizedBox(
                      width: 100,
                    ),*/
                  Expanded(
                    child: Container(
                      width: isDesktop
                          ? MediaQuery.of(context).size.width * 0.1453
                          : MediaQuery.of(context).size.width * 0.36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("      State",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(200, 141, 87, 193)),
                              )),
                          SizedBox(
                            // height: 5,
                            width: 5,
                          ),
                          TextFiledContainer(
                              widthFactor: 0.367,
                              heightFactor: 0.045,
                              borderRadius: 15,
                              child: TextFormField(
                                readOnly: true,
                                //textAlignVertical: TextAlignVertical.top,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(201, 111, 53, 165),
                                      fontWeight: FontWeight.bold),
                                ),
                                obscureText: false,
                                controller: widget.stateController,
                                validator: (value) {
                                  setState(() {
                                    //_errorText = widget.validator!(value);
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: widget.selectedState,
                                  hintStyle: TextStyle(
                                    color: stateSelected
                                        ? Color.fromARGB(201, 111, 53, 165)
                                        : Color.fromRGBO(111, 53, 165, 0.341),
                                    fontSize: 14.1,
                                  ),
                                  icon: null,
                                  border: InputBorder.none,
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    isDismissible: false,
                                    builder: (context) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.66,
                                      child: ShowStateDialog(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        stateHeaderStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        subStringStyle: const TextStyle(
                                            color: Colors.white),
                                        substringBackground: Colors.black,
                                        selectedStateBackgroundColor:
                                            Colors.orange,
                                        notSelectedStateBackgroundColor:
                                            Colors.white,
                                        onSelectedState: () {
                                          setState(() {
                                            widget.selectedState =
                                                Selected.state;
                                            stateSelected = true;
                                            widget.stateController.text =
                                                Selected.state;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )),
                          /*if (_errorText != null)
                                          Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _errorText!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                                          ),*/
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  /* Expanded(
                    child: SizedBox(
                      width: 7,
                    ),
                  ),*/
                  // city
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 7),
                      width: isDesktop
                          ? MediaQuery.of(context).size.width * 0.1453
                          : MediaQuery.of(context).size.width * 0.36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("      City",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(200, 141, 87, 193)),
                              )),
                          SizedBox(
                            // height: 5,
                            width: 5,
                          ),
                          TextFiledContainer(
                              widthFactor: 0.367,
                              heightFactor: 0.045,
                              borderRadius: 15,
                              child: TextFormField(
                                readOnly: true,
                                //textAlignVertical: TextAlignVertical.top,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(201, 111, 53, 165),
                                      fontWeight: FontWeight.bold),
                                ),
                                obscureText: false,
                                controller: widget.cityController,
                                validator: (value) {
                                  setState(() {
                                    //_errorText = widget.validator!(value);
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: widget.selectedCity,
                                  hintStyle: TextStyle(
                                    color: citySelected
                                        ? Color.fromARGB(201, 111, 53, 165)
                                        : Color.fromRGBO(111, 53, 165, 0.341),
                                    fontSize: 14.1,
                                  ),
                                  icon: null,
                                  border: InputBorder.none,
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    isDismissible: false,
                                    builder: (context) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      child: ShowCityDialog(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        subStringStyle: const TextStyle(
                                            color: Colors.white),
                                        substringBackground: Colors.black,
                                        selectedCityBackgroundColor:
                                            Colors.orange,
                                        notSelectedCityBackgroundColor:
                                            Colors.white,
                                        onSelectedCity: () {
                                          setState(() {
                                            widget.selectedCity = Selected.city;
                                            citySelected = true;
                                            widget.cityController.text =
                                                Selected.city;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )),
                          /*if (_errorText != null)
                                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _errorText!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                                        ),*/
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
            // state
          ],
        ),
      );
    });
  }
}
