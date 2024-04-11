import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tarim_ai/Controllers/main_controller.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/models/current_weather_model.dart';
import 'package:tarim_ai/Data/models/hourly_weather_model.dart';
import 'package:tarim_ai/Data/strings.dart';
import 'package:velocity_x/velocity_x.dart';

class SmallWeatherApp extends StatefulWidget {
  const SmallWeatherApp({super.key});

  @override
  State<SmallWeatherApp> createState() => _SmallWeatherAppState();
}

class _SmallWeatherAppState extends State<SmallWeatherApp> {
  @override
  Widget build(BuildContext context) {
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
                  child: newMethod(controller),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  FutureBuilder<dynamic> newMethod(MainController controller) {
    return FutureBuilder(
      future: controller.currentWeatherData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          CurrentWeatherData data = snapshot.data;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "${data.name}"
                        .text
                        .size(20)
                        .letterSpacing(1)
                        .color(kWhiteColor)
                        .make(),
                    Image.asset(
                      "assets/weather/${data.weather![0].icon}.png",
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${data.main!.temp}$degree",
                        style: const TextStyle(
                          color: kWhiteColor,
                          fontSize: 20,
                          fontFamily: "poppins",
                        )),
                    Text(" ${data.weather![0].main}",
                        style: const TextStyle(
                          color: kWhiteColor,
                          letterSpacing: 1,
                          fontSize: 20,
                          fontFamily: "poppins",
                        )),
                  ],
                ),
                FutureBuilder(
                  future: controller.hourlyWeatherData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      HourlyWeatherData hourlyData = snapshot.data;

                      return SizedBox(
                        height: 95,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: hourlyData.list!.length > 6
                              ? 6
                              : hourlyData.list!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var dateTime = DateTime.fromMillisecondsSinceEpoch(
                                hourlyData.list![index].dt!.toInt() * 1000);
                            var period = DateFormat('a')
                                .format(dateTime); // AM veya PM'yi alır
                            var hour =
                                DateFormat('h').format(dateTime); // Saati alır
                            var time =
                                "$hour$period"; // 12AM veya 12PM şeklinde birleştirir

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    time, // Saat metni
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 2),
                                  Image.asset(
                                    "assets/weather/${hourlyData.list![index].weather![0].icon}.png",
                                    width: 45,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${hourlyData.list![index].main!.temp}°",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
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
    );
  }
}
