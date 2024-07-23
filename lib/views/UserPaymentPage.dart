// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_cubit.dart';
import 'package:grad_new_project/widgets/CreditCardWidget.dart';
import 'package:grad_new_project/widgets/PaypalWidget.dart';
import 'package:grad_new_project/widgets/TextFiledWithLable.dart';
import 'package:grad_new_project/widgets/UserAppBar.dart';
import 'package:responsive_framework/responsive_row_column.dart';

enum PayMethod { Paypal, CreditCard }

/// This is the stateful widget that the main application instantiates.
class UserPaymentPage extends StatefulWidget {
  static const String routeName = 'user-payment';
  const UserPaymentPage({super.key});

  @override
  State<UserPaymentPage> createState() => _UserPaymentPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _UserPaymentPageState extends State<UserPaymentPage> {
  PayMethod _pay = PayMethod.Paypal;
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cvvCodeController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final CartCubit cartCubit = context.read<CartCubit>();

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
        appBar:
            UserAppBar(withLogo: false, title: "Payment", generalSearch: true),
        body: ResponsiveRowColumn(
          layout: !isDesktop
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResponsiveRowColumnItem(
              child: Padding(
                padding: const EdgeInsets.only(top: 78.0),
                child: Container(
                  width: isDesktop ? size.width * 0.38 : size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text("      Price",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(200, 141, 87, 193)),
                          )),
                      Text("      \$500",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          )),
                      SizedBox(
                        height: 10,
                        width: 5,
                      ),
                      Text("      Choose payment method:",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(200, 141, 87, 193)),
                          )),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: !isDesktop
                                ? size.width * 0.4
                                : size.width * 0.17,
                            //  height: size.height * 0.002,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: _pay == PayMethod.Paypal
                                      ? AppColors.primary
                                      : AppColors.lightPurple2),
                              // color: AppColors.grey2,
                            ),
                            child: ListTile(
                              title: Text(
                                'Paypal',
                                style: GoogleFonts.philosopher(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                textAlign: TextAlign.start,
                              ),
                              leading: Radio<PayMethod>(
                                value: PayMethod.Paypal,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => _pay == PayMethod.Paypal
                                        ? AppColors.primary
                                        : AppColors.lightPurple2),
                                focusColor: MaterialStateColor.resolveWith(
                                    (states) => _pay == PayMethod.Paypal
                                        ? AppColors.primary
                                        : AppColors.lightPurple2),
                                groupValue: _pay,
                                onChanged: (PayMethod? value) {
                                  setState(() {
                                    _pay = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            width: !isDesktop
                                ? size.width * 0.45
                                : size.width * 0.17,
                            //  height: size.height * 0.002,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: _pay == PayMethod.CreditCard
                                      ? AppColors.primary
                                      : AppColors.lightPurple2),
                              // color: AppColors.grey2,
                            ),
                            child: ListTile(
                              title: Text(
                                'Credit Card',
                                style: GoogleFonts.philosopher(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                textAlign: TextAlign.start,
                              ),
                              leading: Radio<PayMethod>(
                                value: PayMethod.CreditCard,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => _pay == PayMethod.CreditCard
                                        ? AppColors.primary
                                        : AppColors.lightPurple2),
                                focusColor: MaterialStateColor.resolveWith(
                                    (states) => _pay == PayMethod.CreditCard
                                        ? AppColors.primary
                                        : AppColors.lightPurple2),
                                groupValue: _pay,
                                onChanged: (PayMethod? value) {
                                  setState(() {
                                    _pay = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      _pay == PayMethod.Paypal
                          ? PaypalWidget(
                              emailController: _emailController,
                              passwordController: _passwordController,
                            )
                          : CreditCardWidget(
                              cardNumberController: _cardNumberController,
                              cvvCodeController: _cvvCodeController,
                              userNameController: _userNameController),
                      Padding(
                        padding:
                            EdgeInsets.only(top: size.height * .01, left: 25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            onPressed: () {
                              cartCubit.checkout();
                              // Navigator.pop(context);
                            },
                            child: Text(
                              "  Complete Payment  ",
                              style: TextStyle(color: AppColors.white),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: !isDesktop
                                        ? size.width * 0.19
                                        : size.width * 0.13,
                                    vertical: 3),
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
                ),
              ),
            ),
            if (isDesktop)
              ResponsiveRowColumnItem(
                child: Image.asset(
                  "assets/images/PaymentInfo.jpg",
                  width: size.width * .5,
                  height: size.height * 0.7,
                ),
              ),
          ],
        ),
      );
    });
  }
}
