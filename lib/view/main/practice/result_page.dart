import 'package:flutter/material.dart';
import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/models/network_response.dart';
import 'package:apps_education/models/response_result.dart';
import 'package:apps_education/repository/api_practice.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.exerciseId}) : super(key: key);
  final String exerciseId;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ResponseResult? resultData;
  getResult() async {
    final result = await PracticeApi().getResult(widget.exerciseId);
    if (result.status == Status.success) {
      resultData = ResponseResult.fromJson(result.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setting_Reusable.color.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: resultData == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                        Text(
                          "Tutup",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Selamat",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text(
                      "Kamu telah menyelesaikan Kuiz ini",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Image.asset(
                      Setting_Reusable.asset.imgResult,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Nilai kamu:",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      resultData!.data!.result!.jumlahScore!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 96,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
