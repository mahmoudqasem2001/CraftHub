import 'dart:io';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/ArtistBottomBar.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/views/WebArtistDrawar.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';
import 'package:grad_new_project/widgets/TextFiledWithLable.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import '../services/payment_services.dart';
import '../view_model/payment_cubit/payment_cubit.dart';
import '../view_model/payment_cubit/payment_state.dart';

class ArtistPaymentInfoCompletionPage extends StatefulWidget {
  static String routeName = 'payment-info-completion-';
  const ArtistPaymentInfoCompletionPage({super.key});

  @override
  State<ArtistPaymentInfoCompletionPage> createState() =>
      _ArtistPaymentInfoCompletionPageState();
}

class _ArtistPaymentInfoCompletionPageState
    extends State<ArtistPaymentInfoCompletionPage> {
  String currency = "Currency";
  bool currencySelected = false;

  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => PaymentCubit(PaymentServicesImpl()),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isDesktop = constraints.maxWidth > 900;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leadingWidth: 160,
            foregroundColor: AppColors.brown,
            shadowColor: AppColors.orange,
            surfaceTintColor: AppColors.white,
            elevation: 2,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            leading: Padding(
              padding: const EdgeInsets.only(top: 10, left: 7, bottom: 10),
              child: Image.asset('assets/images/Icon.png', height: 30),
            ),
          ),
          body: BlocListener<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentAddSuccess) {
                if (isDesktop) {
                  AppRouter.goTOScreen(WebArtistDrawar.routeName);
                } else {
                  AppRouter.goTOScreen(ArtistBottomBar.routeName);
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Payment info added successfully!')));
              } else if (state is PaymentFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.error}')));
              }
            },
            child: BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
              if (state is PaymentLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return ResponsiveRowColumn(
                layout: !isDesktop
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                rowCrossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveRowColumnItem(
                    child: SingleChildScrollView(
                      child: Container(
                        width: isDesktop ? size.width * 0.4 : size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  left: isDesktop ? 35 : 15,
                                ),
                                child: Container(
                                  width: !isDesktop
                                      ? size.width * 0.9
                                      : size.width * 0.35,
                                  child: Text(
                                    'Payment Information',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkBrown,
                                            fontSize: isDesktop ? 24 : 17)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: isDesktop ? 20 : 8,
                                    left: isDesktop ? 35 : 15,
                                    bottom: 20),
                                child: Container(
                                  width: !isDesktop
                                      ? size.width * 0.9
                                      : size.width * 0.35,
                                  child: Text(
                                    "For secure online payments, we need some basic info from you to process payments when buyers purchase your items. It's safe, we never share it, and funds go straight to your account.",
                                    style: GoogleFonts.philosopher(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkBrown,
                                            fontSize: !isDesktop ? 11 : 13)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Column(
                                  children: [
                                    TextFiledWithLabel(
                                      controller: _bankNameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Bank Name must not be empty";
                                        }
                                        return null;
                                      },
                                      heightFactor: 0.045,
                                      widthFactor: 0.74,
                                      borderRadius: 15,
                                      label: 'Bank Name',
                                      obscureText: false,
                                    ),
                                    TextFiledWithLabel(
                                      controller: _accountNumberController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Account Number must not be empty";
                                        } else if (value.length < 9) {
                                          return "Account Number must be more than 8 characters";
                                        }
                                        return null;
                                      },
                                      heightFactor: 0.045,
                                      widthFactor: 0.74,
                                      borderRadius: 15,
                                      label: 'Account Number',
                                      obscureText: false,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: isDesktop ? 20 : 15,
                                          ),
                                          child: Text("Currency",
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        200, 141, 87, 193)),
                                              )),
                                        ),
                                        SizedBox(width: 5),
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
                                                  onSelect:
                                                      (Currency currency) {
                                                    setState(() {
                                                      this.currency =
                                                          currency.name;
                                                      currencySelected = true;
                                                    });
                                                  },
                                                );
                                              },
                                              readOnly: true,
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        201, 111, 53, 165),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: this.currency,
                                                hintStyle: TextStyle(
                                                    color: currencySelected
                                                        ? Color.fromARGB(
                                                            201, 111, 53, 165)
                                                        : Color.fromRGBO(111,
                                                            53, 165, 0.341),
                                                    fontSize: 14.1),
                                                border: InputBorder.none,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.03),
                                    if (!isDesktop)
                                      Container(
                                          width: size.width * 0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ImageWidget(
                                                size: size,
                                                isDesktop: isDesktop,
                                              ),
                                              SaveButton(
                                                  bankNameController:
                                                      _bankNameController,
                                                  accountNumberController:
                                                      _accountNumberController,
                                                  currency: currency),
                                            ],
                                          ))
                                  ],
                                ),
                              ),
                              if (isDesktop)
                                SaveButton(
                                    bankNameController: _bankNameController,
                                    accountNumberController:
                                        _accountNumberController,
                                    currency: currency),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isDesktop)
                    ResponsiveRowColumnItem(
                      child: Container(
                        width: size.width * 0.4,
                        child: ImageWidget(
                          size: size,
                          isDesktop: isDesktop,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required TextEditingController bankNameController,
    required TextEditingController accountNumberController,
    required this.currency,
  })  : _bankNameController = bankNameController,
        _accountNumberController = accountNumberController;

  final TextEditingController _bankNameController;
  final TextEditingController _accountNumberController;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: ElevatedButton(
        onPressed: () {
          final paymentCubit = context.read<PaymentCubit>();

          paymentCubit.addPaymentInfo(
              bankName: _bankNameController.text,
              accountNumber: _accountNumberController.text,
              currency: currency);
        },
        child: Text(
          "Save and SignIn",
          style: TextStyle(color: AppColors.white),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 30, vertical: 2),
          ),
          backgroundColor: MaterialStateProperty.all(AppColors.primary),
          overlayColor: MaterialStateProperty.all(AppColors.overlayColor),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.size,
    required this.isDesktop,
  }) : super(key: key);

  final Size size;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/PaymentInfo.jpg",
      width: !isDesktop ? size.width * .4 : size.width * 0.6,
      height: !isDesktop ? size.height * 0.37 : size.height * 0.7,
    );
  }
}
