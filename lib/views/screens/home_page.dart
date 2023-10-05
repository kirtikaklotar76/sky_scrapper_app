import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_provider.dart';
import '../../controllers/theme_provider.dart';
import '../../helper/weather_helper.dart';
import '../../modals/weather_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    dynamic themePro = Provider.of<ThemeProvider>(context);

    List days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    List months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sup',
      'Oct',
      'Nov',
      'Dec',
    ];

    TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/image/app_logo.png",
            fit: BoxFit.cover,
          ),
        ),
        title: const Text(
          "Live Weather",
          style: TextStyle(fontSize: 26),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                themePro.isDark = !themePro.isDark;
              },
              icon: themePro.isDark
                  ? const Icon(
                      Icons.light_mode,
                      size: 34,
                    )
                  : const Icon(
                      Icons.dark_mode_rounded,
                      size: 34,
                    ),
            ),
          ),
        ],
        backgroundColor:
            themePro.isDark ? Color(0xff293251) : Color(0xffF4F9FF),
      ),
      backgroundColor: themePro.isDark ? Color(0xff293251) : Color(0xffF4F9FF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<HomeProvider>(builder: (context, provider, _) {
              return FutureBuilder(
                future: WeatherHelper.weatherHelper
                    .getWeather(cityName: provider.cityName),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    WeatherModel? weatherModel = snapShot.data;
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              controller: textController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: "Enter City Name",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    provider.cityName = textController.text;
                                    log("City name : $provider.cityName");
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                              ),
                              onSubmitted: (val) {
                                provider.cityName = val;
                              },
                            ),
                            SizedBox(
                              height: h * 0.03,
                            ),
                            Text(
                              weatherModel!.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              height: h * 0.001,
                            ),
                            Text(
                              weatherModel.weather[0]['main'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text(
                              "${weatherModel.main['temp'].toInt() - 273}°C",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 95,
                              ),
                            ),
                            SizedBox(height: h * 0.001),
                            Text(
                              "${days[DateTime.now().weekday]}, ${DateTime.now().day} ${months[DateTime.now().month]}",
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: h * 0.005),
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/image/wind.png',
                                                width: 52,
                                              ),
                                              SizedBox(height: h * 0.01),
                                              Text(
                                                "${weatherModel.wind['speed'].toStringAsFixed(1)} km/h",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: h * 0.01),
                                              const Text(
                                                "Wind",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/image/weather_sky.gif',
                                                width: 32,
                                              ),
                                              SizedBox(height: h * 0.01),
                                              Text(
                                                "${weatherModel.main['pressure'].toStringAsFixed(1)} km/h",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: h * 0.01),
                                              const Text(
                                                "Pressure",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: h * 0.02),
                                  Text(
                                    "Visibility : ${weatherModel.visibility} m",
                                    style: const TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  SizedBox(height: h * 0.03),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${weatherModel.coord['lon']}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: h * 0.01),
                                            const Text(
                                              "Longitude",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: h * 0.01),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${weatherModel.coord['lat']}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: h * 0.01),
                                            const Text(
                                              "Latitude",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: h * 0.01),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: themePro.isDark
                                    ? Color(0xff3CA2F7)
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapShot.hasError) {
                    return Text(" Error :- ${snapShot.hasError}");
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
