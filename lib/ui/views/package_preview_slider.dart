import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

class PackagePreviewSlide extends StatefulWidget {
  final double height;

  const PackagePreviewSlide({
    Key key,
    this.height,
  }) : super(key: key);

  @override
  _PackagePreviewSlideState createState() => _PackagePreviewSlideState();
}

class _PackagePreviewSlideState extends State<PackagePreviewSlide> {
  Map<String, String> images = {
    Assets.preorder_1:
        'This package contains a Varsity Jacket for \u20A6 6000.00',
    Assets.preorder_2:
        'This package contains a Tee shirt for \u20A6 3000.00',
    Assets.preorder_3:
        'This package contains a Tote bag for \u20A6 2000.00',
    Assets.preorder_4:
        'This package contains a Hoodie for \u20A6 6000.00',
    Assets.preorder_5:
    'This package contains a Varsity Jacket for \u20A6 6000.00',
    Assets.preorder_6:
        'This package contains a Tee shirt for \u20A6 3000.00',
    Assets.preorder_7:
        'This package contains the black branded jotter for \u20A6 800.00',
    Assets.preorder_8:
        'This package contains a sweat shirt for \u20A6 4000.00',
    Assets.preorder_9:
        'This package contains a black face cap for \u20A6 2000.00',
    // Assets.preorder_10:
    //     'This package contains the branded jotter and pen for \u20A6 500.00',
  };

  int carouselIndex = 0;
  final double defaultCarouselHeight = 300;
  double carouselHeight;

  @override
  void initState() {
    super.initState();
    carouselHeight = defaultCarouselHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageCard(
                  image_asset: images.keys.toList()[index],
                  unShrinkCallback: () {
                    setState(() {
                      carouselHeight = 190;
                    });
                  },
                ),
              );
            },
            options: CarouselOptions(
              height: carouselHeight ?? defaultCarouselHeight,
              viewportFraction: 0.95,
              enlargeCenterPage: true,
              onPageChanged: (newIndex, reason) {
                setState(() {
                  carouselIndex = newIndex;
                  carouselHeight = defaultCarouselHeight;
                });
              },
            ),
          ),
          IndicatorWidget(
            count: images.length,
            currentIndex: carouselIndex,
            activeColor: widget.height ?? Theme.of(context).accentColor,
            inactiveColor: App.secondaryColorLight,
          ),
          Container(
              color: Colors.grey[300],
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${images.values.toList()[carouselIndex]}',
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ))),
        ],
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({
    Key key,
    @required this.count,
    @required this.currentIndex,
    @required this.activeColor,
    @required this.inactiveColor,
  }) : super(key: key);

  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            count,
            (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 5,
                  width: 16,
                  decoration: BoxDecoration(
                    color: index == currentIndex ? activeColor : inactiveColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
      ),
    );
  }
}

class ImageCard extends StatefulWidget {
  final String image_asset;
  final Function unShrinkCallback;

  const ImageCard({
    Key key,
    @required this.image_asset,
    this.unShrinkCallback,
  }) : super(key: key);

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: AssetImage(widget.image_asset), fit: BoxFit.fill)),
      ),
    );
  }
}
