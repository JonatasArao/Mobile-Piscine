import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
                Auth.currentUser?.photoURL != null
                    ? NetworkImage(Auth.currentUser!.photoURL!)
                    : null,
            child:
                Auth.currentUser?.photoURL == null
                    ? const Icon(Icons.person, size: 30)
                    : null,
          ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(
                Auth.currentUser?.displayName ?? 'Guest',
                style: const TextStyle(fontSize: 20),
                softWrap: true,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await Auth.sigOut();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(15, 15),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Colors.white,
            ),
            child: FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Colors.red[900],
            ),
          ),
        ],
      ),
    );
  }
}
