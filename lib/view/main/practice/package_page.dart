import 'package:flutter/material.dart';
import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/repository/api_practice.dart';
import 'package:apps_education/view/main/practice/question_page.dart';
import 'package:apps_education/models/network_response.dart';
import 'package:apps_education/models/list_package.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({Key? key, required this.id}) : super(key: key);
  static String route = "package_page";
  final String id;
  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  ListPackage? paketSoalList;
  getPaketSoal() async {
    final mapelREsult = await PracticeApi().getPaketSoal(widget.id);
    if (mapelREsult.status == Status.success) {
      paketSoalList = ListPackage.fromJson(mapelREsult.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaketSoal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setting_Reusable.color.grey,
      appBar: AppBar(
        title: Text("Paket Soal"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pilih Paket Soal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: paketSoalList == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(paketSoalList!.data!.length,
                              (index) {
                            final currentPaketSoal =
                                paketSoalList!.data![index];
                            return Container(
                                padding: EdgeInsets.all(3),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: PaketSoalWidget(data: currentPaketSoal));
                          }).toList(),
                        ),
                      )

                // GridView.count(
                //     mainAxisSpacing: 10,
                //     crossAxisSpacing: 10,
                //     crossAxisCount: 2,
                //     childAspectRatio: 4 / 3,
                //     children:

                //     // [
                //     // PaketSoalWodget(),
                //     // PaketSoalWodget(),
                //     // PaketSoalWodget(),
                //     // PaketSoalWodget()
                //     // ],
                //     ),
                ),
          ],
        ),
      ),
    );
  }
}

class PaketSoalWidget extends StatelessWidget {
  const PaketSoalWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final DataPackage data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => QuestionPage(id: data.exerciseId!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        // margin: const EdgeInsets.all(13.0),
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withOpacity(0.2)),
              padding: EdgeInsets.all(12),
              child: Image.asset(
                Setting_Reusable.asset.icNote,
                width: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              data.exerciseTitle!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${data.jumlahDone}/${data.jumlahSoal} Paket Soal",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: Setting_Reusable.color.greySubtitleHome),
            ),
          ],
        ),
      ),
    );
  }
}
