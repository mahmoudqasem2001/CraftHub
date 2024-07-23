import 'package:flutter/material.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';

class ArtistSearchResultWidget extends StatelessWidget {
  const ArtistSearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.lightPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 6),
            child: Container(
              width: size.width * 0.16,
              height: size.width * 0.16,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5),
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/Person.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Alex Morial',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              /*SizedBox(
                height: 5,
              ),*/
              /* SizedBox(
                height: 5,
              ),*/
              Text(
                'Music Making',
                style: TextStyle(fontSize: 12, color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
