import 'package:covid_19_tracker_in_flutter/services/covid_api.dart';
import 'package:covid_19_tracker_in_flutter/ui/helper/app_colors.dart';
import 'package:covid_19_tracker_in_flutter/ui/helper/app_strings.dart';
import 'package:covid_19_tracker_in_flutter/ui/widgets/app_bar.dart';
import 'package:covid_19_tracker_in_flutter/ui/widgets/app_bottombar.dart';
import 'package:covid_19_tracker_in_flutter/ui/widgets/globe_status.dart';
import 'package:covid_19_tracker_in_flutter/ui/widgets/turkey_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLight,
      appBar: CovidAppBar(),
      bottomNavigationBar: AppBottomNavigationBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GlobeStatus(),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppStrings.pageTurkeyDetails);
              },
              child: TurkeyStatus(),
            ),
            //Text("Aktif Vaka" + test.activeCases.toString()),
            //Text("Ölüm" + test.totalDeaths.toString()),
            //Text("İyileşen" + test.totalRecovered.toString()),
            //Text("Vaka" + test.totalCases.toString()),
          ],
        ),
      ),
    );
  }

  Future<Response> getGlobalData() async {
    var dio = Dio();
    createHttpRequestConfig(dio);
    Response response;
    await dio.get(CovidAPI.baseUrl).then((resp) {
      response = resp;
    });
    return response;
  }

  createHttpRequestConfig(dio) {
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 15000;
    dio.options.responseType = ResponseType.plain;
  }
}