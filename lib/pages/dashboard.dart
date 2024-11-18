import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

//State Management
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/riverpod/authState.dart';

//Routing
import 'package:go_router/go_router.dart';
import 'package:safe_stay/router/router.dart';
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userDetails = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hays yuki icode nani'),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
            }, 
            child: 
              const Text(
                'LOGOUT',
                style: TextStyle(
                  fontSize: 24, // You can adjust the font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // You can change the text color
                ),
              ),
            ),
        ], // You can choose any color you like
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(userDetails?.isAnonymous == true) ...{
              const Text('Welcome to Safe Stay: ',
              style: const TextStyle(
                fontSize: 24, // You can adjust the font size
                fontWeight: FontWeight.normal,
                color: Colors.black, // You can change the text color
                ),
              ),
              Text('is AnonUserLoggedIn? : ${userDetails?.isAnonymous.toString()}',
              style: const TextStyle(
                fontSize: 24, // You can adjust the font size
                fontWeight: FontWeight.bold,
                color: Colors.black, // You can change the text color
                ),
              )
            }else ...{
              Text('Welcome to Safe Stay, user  ${userDetails?.email.toString()}',
              style: const TextStyle(
                fontSize: 24, // You can adjust the font size
                fontWeight: FontWeight.bold,
                color: Colors.black, // You can change the text color
                ),
              )
            }
          ],
        )
      ),
    );
  }
}
