import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/main_controller.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/images.dart';
import 'package:tarim_ai/Data/models/current_weather_model.dart';
import 'package:tarim_ai/Data/strings.dart';
import 'package:velocity_x/velocity_x.dart';

class SmallWeatherApp extends StatelessWidget {
  const SmallWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var controller = Get.put(MainController());

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, weatherAppPath),
      child: Obx(
        () => controller.isloaded.value == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/sunny.jpg'), // Resminizin yolu
                      fit: BoxFit.cover, // Resmi container'a sığdırmak için
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: FutureBuilder(
                    future: controller.currentWeatherData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        CurrentWeatherData data = snapshot.data;

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data.name}"
                                  .text
                                  .uppercase
                                  .fontFamily("poppins_bold")
                                  .size(10)
                                  .letterSpacing(1)
                                  .color(theme.primaryColor)
                                  .make(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/weather/${data.weather![0].icon}.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "${data.main!.temp}$degree",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            fontSize: 20,
                                            fontFamily: "poppins",
                                          )),
                                      TextSpan(
                                          text: " ${data.weather![0].main}",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            letterSpacing: 1,
                                            fontSize: 10,
                                            fontFamily: "poppins",
                                          )),
                                    ],
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(3, (index) {
                                  var iconsList = [clouds, humidity, windspeed];
                                  var values = [
                                    "${data.clouds!.all}",
                                    "${data.main!.humidity}",
                                    "${data.wind!.speed} km/h"
                                  ];
                                  return Column(
                                    children: [
                                      Image.asset(
                                        iconsList[index],
                                        width: 60,
                                        height: 60,
                                      )
                                          .box
                                          .gray200
                                          .padding(const EdgeInsets.all(8))
                                          .roundedSM
                                          .make(),
                                      10.heightBox,
                                      values[index].text.gray400.make(),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
