import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Actividad/act_home.dart';
import 'package:app_flutter/Equipo/team_home.dart';
import 'package:app_flutter/Proyecto/pro_home.dart';
import 'package:app_flutter/Proyecto/pro_info.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final DocumentSnapshot op;
  NavigationDrawerWidget({Key? key, required this.op,}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    const name = 'ALFAPRO';
    const urlname = "https://cdn.discordapp.com/attachments/496323745254735872/1033556701808443412/launcher.png";
    
    return Drawer(
      child: Material(
        color: const Color(0xff26282c),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlname,
              name: name,
              onClicked: () => {}
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white),
                  buildMenuItem(
                    text: 'Datos',
                    icon: Icons.folder,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Actividad',
                    icon: Icons.schedule_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Equipo',
                    icon: Icons.group,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 16),
                   buildMenuItem(
                    text: 'Regresar a proyectos',
                    icon: Icons.arrow_back_ios_new_sharp,
                    onClicked: () => selectedItem(context, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 20)),
          child: Row(
            children: [
              CircleAvatar(radius: 40, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => pro_info(pinfo: op),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => act_home(ah: op),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => team_home(th: op),
        ));
        break;
        case 3:
           Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => pro_home(),
       ));
        break;
    }
  }
}
