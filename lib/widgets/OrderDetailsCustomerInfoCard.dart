// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/ArtistOrdersPage.dart';
import 'package:grad_new_project/Views/ArtistOrdersPageDetails.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/models/order_details_model.dart';

class OrderDetailsCustomerInfoCard extends StatelessWidget {
  final OrderDetails orderDetails;

  OrderDetailsCustomerInfoCard({
    required this.orderDetails,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.93,
        height: size.height * 0.193,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(241, 230, 255, 1)),
        child: Row(
          children: [
            Column(children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height / 120,
                    left: 4,
                    bottom: size.height / 100,
                    right: 0),
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.brown,
                  size: 21,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height / 120,
                    left: 4,
                    bottom: size.height / 80,
                    right: 0),
                child: Icon(
                  Icons.location_on_rounded,
                  color: AppColors.brown,
                  size: 21,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height / 120,
                    left: 4,
                    bottom: size.height / 80,
                    right: 0),
                child: Icon(
                  Icons.phone_in_talk_rounded,
                  color: AppColors.brown,
                  size: 21,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height / 140,
                    bottom: size.height / 110,
                    left: 9,
                    right: 0),
                child: Icon(
                  Icons.email_rounded,
                  color: AppColors.brown,
                  size: 21,
                ),
              ),
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 7, bottom: 8, left: 5, right: 8),
                  child: Text(
                    'Customer Name:',
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.brown,
                            fontSize: 14.5)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 7, bottom: 8, left: 5, right: 8),
                  child: Text(
                    'Shipping Address:',
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.brown,
                            fontSize: 14.5)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 7, bottom: 8, left: 5, right: 8),
                  child: Text(
                    'Phone Number:',
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.brown,
                            fontSize: 14.5)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 6, bottom: 8, left: 5, right: 8),
                  child: Text(
                    'Email Address:',
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.brown,
                            fontSize: 14.5)),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 8, left: 2),
                  child: Text(
                    orderDetails.customerName,
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                            fontSize: 14.5)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 8, left: 2),
                  child: Text(
                    orderDetails.shippingAddress,
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                            fontSize: 14.5)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 8, left: 2),
                  child: Text(
                    orderDetails.phoneNumber,
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                            fontSize: 14.5)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, left: 2),
                  child: Text(
                    orderDetails.email,
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                            fontSize: 14.5)),
                  ),
                ),
              ],
            )
          ],
        )

        /*Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.brown,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  'Customer Name: ',
                  style: GoogleFonts.philosopher(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                          fontSize: 16)),
                ),
              ),
              Text(
                "Lubna Bsharat",
                style: GoogleFonts.philosopher(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 18)),
              ),
              /*  SizedBox(
                width: size.width * 0.55,
              ),*/
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Icon(
                  Icons.location_on_rounded,
                  color: AppColors.brown,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  'Shipping Address: ',
                  style: GoogleFonts.philosopher(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                          fontSize: 16)),
                ),
              ),
              Text(
                "Nablus",
                style: GoogleFonts.philosopher(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 18)),
              ),
              /*  SizedBox(
                width: size.width * 0.55,
              ),*/
            ],
          ),
        ],
      ),*/
        );
  }
}
