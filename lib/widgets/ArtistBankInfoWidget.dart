import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/EditableTextFieldWithLabel.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';
import 'package:grad_new_project/widgets/TextFiledWithLable.dart';

class ArtistBankInfoWidget extends StatefulWidget {
  ArtistBankInfoWidget({
    super.key,
    required TextEditingController bankNameController,
    required TextEditingController accountNumberController,
    // required TextEditingController projectNameController,
    required this.size,
  })  : _bankNameController = bankNameController,
        _accountNumberController = accountNumberController;
  // _projectNameController = projectNameController;

  final TextEditingController _bankNameController;
  final TextEditingController _accountNumberController;
  final Size size;

  @override
  State<ArtistBankInfoWidget> createState() => _ArtistBankInfoWidgetState();
}

class _ArtistBankInfoWidgetState extends State<ArtistBankInfoWidget> {
  bool _currentIsVisible = false;
  bool _newIsVisible = false;
  bool _confirmIsVisible = false;
  String currency = " current currency";
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //   Icon(Icons.s)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Bank Account Information',
              style: GoogleFonts.anta(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                      fontSize: isDesktop ? 15 : 21)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 12),
            child: Text(
              "All the Text Field here are Editable, you can update your Bank information as you like."
              " Don't forget to save the changes!"
              "We need this Information when buyers purchase your items."
              "Don't Worry! It's safe, we never share it, and funds go straight to your account.",
              style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                      fontSize: isDesktop ? 11 : 12.5)),
            ),
          ),
          EditableTextFieldWithLabel(
            label: 'Bank Name:      ',
            currentInfo: 'Current Bank Name',
            controller: widget._bankNameController,
          ),
          Container(
            height: 18,
            color: AppColors.lightPurple,
          ),
          EditableTextFieldWithLabel(
            label: 'Account Number:      ',
            currentInfo: 'Current Number',
            controller: widget._accountNumberController,
          ),
          Container(
            height: 20,
            color: AppColors.lightPurple,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // width: width,
                //color: AppColors.lightPurple,
                height: widget.size.height * 0.04,
                child: Text(
                  'Select Your Account Currency',
                  style: GoogleFonts.philosopher(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 14)),
                ),
              ),
              TextFiledContainer(
                  widthFactor: 0.74,
                  heightFactor: 0.045,
                  borderRadius: 15,
                  child: TextFormField(
                    onTap: () {
                      showCurrencyPicker(
                        context: context,
                        showFlag: true,
                        showCurrencyName: true,
                        showCurrencyCode: true,
                        onSelect: (Currency currency) {
                          setState(() {
                            this.currency = currency.name;
                          });

                          //print('Select currency: ${currency.name}');
                        },
                      );
                    },
                    readOnly: true,
                    //textAlignVertical: TextAlignVertical.top,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Color.fromARGB(201, 111, 53, 165),
                          fontWeight: FontWeight.bold),
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: this.currency,
                      hintStyle: TextStyle(
                          color: Color.fromARGB(201, 111, 53, 165),
                          fontSize: 14.1),
                      border: InputBorder.none,
                    ),
                  )),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: widget.size.height * .02, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDesktop) Navigator.pop(context);
                    },
                    child: Text(
                      "Discard",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.primary,
                      ),
                      overlayColor: MaterialStateProperty.all(
                        AppColors.overlayColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: widget.size.height * .02),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDesktop) Navigator.pop(context);
                    },
                    child: Text(
                      "  Save  ",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.primary,
                      ),
                      overlayColor: MaterialStateProperty.all(
                        AppColors.overlayColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
