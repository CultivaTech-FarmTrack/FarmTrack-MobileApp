import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ProjectView extends StatefulWidget {
  const ProjectView({Key? key}) : super(key: key);

  @override
  State<ProjectView> createState() => _ProjectView();
}

class _ProjectView extends State<ProjectView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Manage your projects",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),

        )
    );
  }
}