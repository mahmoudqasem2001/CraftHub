import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/view_model/search_cubit/search_cubit.dart';

class GeneralSearchOptionsWidget extends StatefulWidget {
  const GeneralSearchOptionsWidget({super.key});

  static bool artistsSelected = false;
  static bool itemsSelected = false;
  static bool projectsSelected = false;
  @override
  State<GeneralSearchOptionsWidget> createState() =>
      _GeneralSearchOptionsWidgetState();
}

class _GeneralSearchOptionsWidgetState
    extends State<GeneralSearchOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final SearchCubit searchCubit = context.read<SearchCubit>();

    return Row(
      children: [
        SizedBox(
          width: size.width * 0.03,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ElevatedButton(
              onPressed: () {
                searchCubit.clear();
                setState(() {
                  GeneralSearchOptionsWidget.artistsSelected =
                      !GeneralSearchOptionsWidget.artistsSelected;

                  if (GeneralSearchOptionsWidget.artistsSelected) {
                    GeneralSearchOptionsWidget.itemsSelected = false;
                    GeneralSearchOptionsWidget.projectsSelected = false;
                  }
                });
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                ),
                backgroundColor: MaterialStateProperty.all(
                  GeneralSearchOptionsWidget.artistsSelected
                      ? AppColors.primary
                      : AppColors.lightPurple,
                ),
                overlayColor: MaterialStateProperty.all(
                  AppColors.primary,
                ),
              ),
              child: Text(
                "Artists",
                style: TextStyle(
                    color: GeneralSearchOptionsWidget.artistsSelected
                        ? AppColors.white
                        : AppColors.brown),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ElevatedButton(
                onPressed: () {
                  searchCubit.clear();
                  setState(() {
                    GeneralSearchOptionsWidget.itemsSelected =
                        !GeneralSearchOptionsWidget.itemsSelected;
                    if (GeneralSearchOptionsWidget.itemsSelected) {
                      GeneralSearchOptionsWidget.artistsSelected = false;
                      GeneralSearchOptionsWidget.projectsSelected = false;
                    }
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    GeneralSearchOptionsWidget.itemsSelected
                        ? AppColors.primary
                        : AppColors.lightPurple,
                  ),
                  overlayColor: MaterialStateProperty.all(
                    AppColors.primary,
                  ),
                ),
                child: Text(
                  " Items ",
                  style: TextStyle(
                      color: GeneralSearchOptionsWidget.itemsSelected
                          ? AppColors.white
                          : AppColors.brown),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ElevatedButton(
                onPressed: () {
                  searchCubit.clear();
                  setState(() {
                    GeneralSearchOptionsWidget.projectsSelected =
                        !GeneralSearchOptionsWidget.projectsSelected;
                    if (GeneralSearchOptionsWidget.projectsSelected) {
                      GeneralSearchOptionsWidget.artistsSelected = false;
                      GeneralSearchOptionsWidget.itemsSelected = false;
                    }
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    GeneralSearchOptionsWidget.projectsSelected
                        ? AppColors.primary
                        : AppColors.lightPurple,
                  ),
                  overlayColor: MaterialStateProperty.all(
                    AppColors.primary,
                  ),
                ),
                child: Text(
                  "Projects",
                  style: TextStyle(
                      color: GeneralSearchOptionsWidget.projectsSelected
                          ? AppColors.white
                          : AppColors.brown),
                ),
              )),
        ),
      ],
    );
  }
}
