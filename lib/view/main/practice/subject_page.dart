import 'package:flutter/material.dart';
import 'package:apps_education/models/list_subject.dart';
import 'package:apps_education/view/main/practice/home.dart';
import 'package:apps_education/view/main/practice/package_page.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({Key? key, required this.mapel}) : super(key: key);
  static String route = "subject_page";

  final ListSubject mapel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: ListView.builder(
            itemCount: mapel.data!.length,
            itemBuilder: (context, index) {
              final currentMapel = mapel.data![index];
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PackagePage(id: currentMapel.courseId!),
                      ),
                    );
                  },
                  child: MapelWidget(
                    title: currentMapel.courseName!,
                    totalPacket: currentMapel.jumlahMateri!,
                    totalDone: currentMapel.jumlahDone!,
                  ));
            }),
      ),
    );
  }
}
