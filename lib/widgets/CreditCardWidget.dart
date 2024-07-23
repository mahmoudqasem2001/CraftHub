import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';

class CreditCardWidget extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cvvCodeController;
  final TextEditingController userNameController;

  CreditCardWidget({
    Key? key,
    required this.cardNumberController,
    required this.cvvCodeController,
    required this.userNameController,
  }) : super(key: key);

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  String? _cardNumberErrorText;
  String? _cvvErrorText;
  String? _userNameErrorText;
  DateTime? selectedDate;
  String dateText = "DD/MM/YYYY";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 12),
            child: Text(
              "To finalize your order, please provide your credit card details, including the card number, expiration date, and CVV code."
              " Make sure all information is accurate to avoid any delays in processing your payment.",
              style: GoogleFonts.philosopher(
                textStyle: TextStyle(
                  color: AppColors.brown,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Text(
            "  Card Number",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(200, 141, 87, 193),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            width: size.width * 0.74,
            height: size.height * 0.065,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.hintTextColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: widget.cardNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    _cardNumberErrorText = "Card Number must not be empty";
                  });
                } else if (value.length < 9) {
                  setState(() {
                    _cardNumberErrorText =
                        "Card Number must be more than 8 characters";
                  });
                } else {
                  setState(() {
                    _cardNumberErrorText = null;
                  });
                }
                return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                hintText: "xxxx xxxx xxxx",
                hintStyle: TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  EXP. Date",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(200, 141, 87, 193),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      height: size.height * 0.065,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.hintTextColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          selectedDate = await showDatePickerDialog(
                            disabledCellsTextStyle: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                color: AppColors.lightPurple2,
                                fontSize: 12,
                              ),
                            ),
                            currentDateTextStyle: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                            ),
                            splashRadius: 20,
                            height: size.height * 0.3,
                            width: size.width * 0.4,
                            daysOfTheWeekTextStyle: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                            ),
                            enabledCellsTextStyle: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                color: AppColors.brown,
                                fontSize: 12,
                              ),
                            ),
                            context: context,
                            minDate: DateTime.now(),
                            maxDate: DateTime(2028, 12, 31),
                          );
                          setState(() {
                            dateText = selectedDate.toString();
                          });
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: dateText,
                          hintStyle: TextStyle(
                            color: dateText == "DD/MM/YYYY"
                                ? AppColors.hintTextColor
                                : const Color.fromARGB(193, 0, 0, 0),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  CVV Code",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(200, 141, 87, 193),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      height: size.height * 0.065,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.hintTextColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: widget.cvvCodeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              _cvvErrorText = "CVV Code must not be empty";
                            });
                          } else if (value.length > 3) {
                            setState(() {
                              _cvvErrorText =
                                  "CVV Code must not be more than 3 digits";
                            });
                          } else if (value.length != 3) {
                            setState(() {
                              _cvvErrorText = "CVV Code must be only 3 digits";
                            });
                          } else {
                            setState(() {
                              _cvvErrorText = null;
                            });
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "XXX",
                          hintStyle: TextStyle(
                            color: AppColors.hintTextColor,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "  Name",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(200, 141, 87, 193),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            width: size.width * 0.74,
            height: size.height * 0.065,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.hintTextColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: widget.userNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    _userNameErrorText = "User Name must not be empty";
                  });
                } else {
                  setState(() {
                    _userNameErrorText = null;
                  });
                }
                return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
