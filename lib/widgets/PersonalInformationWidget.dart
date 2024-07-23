import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/widgets/CountrySelector.dart';
import 'package:grad_new_project/widgets/EditableTextFieldWithLabel.dart';

import '../services/account_services.dart';
import '../view_model/account_cubit/account_cubit.dart';
import '../view_model/account_cubit/account_state.dart';

class PersonalInformationWidget extends StatefulWidget {
  const PersonalInformationWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.size,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final Size size;

  @override
  State<PersonalInformationWidget> createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  @override
  void initState() {
    super.initState();

    context.read<AccountCubit>().fetchCustomerAccountInfo();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //   Icon(Icons.s)
          Text(
            'Personal Information',
            style: GoogleFonts.anta(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                    fontSize: isDesktop ? 11 : 22)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 12),
            child: Text(
              "All the Text Field here are Editable, you can update your information as you like. Don't forget to save the changes!",
              style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                      fontSize: isDesktop ? 11 : 13)),
            ),
          ),
          BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
              if (state is AccountLoading) {
                return CircularProgressIndicator();
              } else if (state is AccountLoaded) {
                final account = state.account;
                widget.firstNameController.text = account.firstName;
                widget.lastNameController.text = account.lastName;
                widget.emailController.text = account.email;

                return Column(
                  children: [
                    EditableTextFieldWithLabel(
                      label: 'First Name:      ',
                      currentInfo: account.firstName,
                      controller: widget.firstNameController,
                    ),
                    EditableTextFieldWithLabel(
                      label: 'Last Name:       ',
                      currentInfo: account.lastName,
                      controller: widget.lastNameController,
                    ),
                    EditableTextFieldWithLabel(
                      label: 'Email Address: ',
                      currentInfo: account.email,
                      controller: widget.emailController,
                    ),
                    CountrySelector(
                      selectedCountry: account.country,
                      selectedState: account.state,
                      selectedCity: account.city,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: widget.size.height * .04, right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Discard",
                                style: TextStyle(color: AppColors.white),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
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
                          padding:
                              EdgeInsets.only(top: widget.size.height * .04),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: ElevatedButton(
                              onPressed: () {
                                final updatedFields = {
                                  'firstName': widget.firstNameController.text,
                                  'lastName': widget.lastNameController.text,
                                  'email': widget.emailController.text,
                                };
                                context
                                    .read<AccountCubit>()
                                    .updateProfileInfo(updatedFields);
                              },
                              child: Text(
                                "  Save  ",
                                style: TextStyle(color: AppColors.white),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
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
              } else if (state is AccountFailure) {
                return Text('Failed to load account information');
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      );
    });
  }
}
