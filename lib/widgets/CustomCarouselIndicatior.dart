import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/announcement_model.dart';

class CustomCarouselIndicator extends StatefulWidget {
  final List<AnnouncementModel> announcements;
  const CustomCarouselIndicator({
    super.key,
    required this.announcements,
  });

  @override
  State<CustomCarouselIndicator> createState() =>
      _CustomCarouselIndicatorState();
}

class _CustomCarouselIndicatorState extends State<CustomCarouselIndicator> {
  late CarouselController _controller;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  List<Widget> imageSliders(bool isDesktop) => widget.announcements
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: item.imgUrl,
                fit: BoxFit.cover,
                width: isDesktop ? 800 : 1000.0,
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 800;

      return Column(
        children: [
          CarouselSlider(
            items: imageSliders(isDesktop),
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: isDesktop ? 5 : 2,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dummyAnnouncements.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Theme.of(context).primaryColor)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
