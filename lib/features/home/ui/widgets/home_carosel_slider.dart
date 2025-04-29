import 'package:bazario/app/app_colors.dart';
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';
import 'package:bazario/features/common/controllers/sliders_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeCaroselSlider extends StatefulWidget {
  const HomeCaroselSlider({super.key});

  @override
  State<HomeCaroselSlider> createState() => _HomeCaroselSliderState();
}

class _HomeCaroselSliderState extends State<HomeCaroselSlider> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSliderController>(
      builder: (sliderController) {
        return Visibility(
          visible: sliderController.getSliderInProgress == false,
          replacement: SizedBox(
            height: 200,
            child: CenterCircularProgressIndicator(),
          ),
          child: Visibility(
            visible: sliderController.sliders.isEmpty,
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    viewportFraction: 0.9,
                    height: 200.0,
                  ),
                  items:
                      sliderController.sliders.map((slider) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: BoxDecoration(
                                color: AppColors.themeColor,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(slider.photoUrl),
                                  fit:
                                      BoxFit
                                          .cover, // You can adjust the fit if needed
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  slider.description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < sliderController.sliders.length; i++)
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          color:
                              _selectedIndex == i
                                  ? AppColors.themeColor
                                  : Colors.white,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
