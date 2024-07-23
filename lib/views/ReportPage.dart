import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:responsive_framework/responsive_row_column.dart';

class ReportPage extends StatefulWidget {
  static String routeName = 'report';
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String _selectedReason = '';
  //String _selectedAction = 'Block';
  List<String> options = [
    "Contains nudity or erotic messages",
    "Contains advertisement",
    "Contains personal information",
    "Harmful information involving minors",
    "Other violations"
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Report Comment',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    fontSize: 16)),
          ),
          shadowColor: AppColors.orange,
          //backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),

        ),
        body: ResponsiveRowColumn(
            layout: !isDesktop
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                  child: Container(
                      width: !isDesktop ? size.width : size.width * 0.5,
                      child: Image.asset("assets\\images\\Report.jpg"))),
              ResponsiveRowColumnItem(
                child: SizedBox(
                  height: size.height * 0.02,
                ),
              ),
              ResponsiveRowColumnItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isDesktop)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Report the Comment',
                          style: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  fontSize: 36)),
                        ),
                      ),
                    Container(
                      width: !isDesktop ? size.width : size.width * 0.38,
                      child: ListView.builder(
                        shrinkWrap: true, // Avoid unnecessary scrolling
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile<String>(
                            // tileColor: AppColors.lightPurple,
                            activeColor: AppColors.primary,
                            hoverColor: AppColors.lightPurple2,
                            title: Text(
                              options[index],
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      // color: AppColors.overlayColor,
                                      fontSize: 14)),
                            ),
                            value: options[index],
                            groupValue: _selectedReason,
                            onChanged: (value) {
                              setState(() {
                                _selectedReason = value!;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ElevatedButton(
                      // Add your button here
                      onPressed: _selectedReason != ''
                          ? () {
                              // Submit report logic
                            }
                          : null,
                      child:
                          Text('Submit Report'), // Adjust button text as needed
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: AppColors.lightPurple,
                          foregroundColor: AppColors.white,
                          backgroundColor: AppColors.primary,
                          fixedSize: Size(
                              !isDesktop
                                  ? size.width * 0.85
                                  : size.width * 0.37,
                              !isDesktop ? 12 : 16)),
                    ),
                  ],
                ),
              ),
            ]),
      );
    });
  }
}
/*  
class _ReportPageState extends State<ReportPage> {
  String? _selectedReason; // Changed to nullable to allow no selection
  String _selectedAction = 'Block';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report and Block this review'),
      ),
      body: ListView(
        children: <Widget>[
          RadioListTile<String>(
            title: const Text('Contains nudity or erotic messages'),
            value: 'nudity',
            groupValue: _selectedReason,
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
            },
          ),
          // ... other RadioListTile widgets for different report reasons ...
          DropdownButton<String>(
            value: _selectedAction,
            onChanged: (String? newValue) {
              setState(() {
                _selectedAction = newValue!;
              });
            },
            items: <String>['Block', 'Report', 'Both']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: _selectedReason != null ? () {
              // Submit report logic
            } : null, // Button is disabled if _selectedReason is null
            child: Text('Submit'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // Disabled color
                  }
                  return Theme.of(context).primaryColor; // Regular color
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


 */