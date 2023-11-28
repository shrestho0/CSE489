import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/configs/firebase_options.dart';
import 'package:tictactoe/pages/auth_pages/auth_handler_page.dart';
import 'package:tictactoe/pages/auth_pages/forgot_password_page.dart';
import 'package:tictactoe/pages/auth_pages/login_with_password_page.dart';
import 'package:tictactoe/pages/auth_pages/register_page.dart';
import 'package:tictactoe/pages/game_pages/confirm_match_page.dart';
import 'package:tictactoe/pages/game_pages/find_players_online.dart';
import 'package:tictactoe/pages/game_pages/invite_someone_to_play.dart';
import 'package:tictactoe/pages/game_pages/join_with_invitation_code_page.dart';
import 'package:tictactoe/pages/game_pages/post_game_page.dart';
import 'package:tictactoe/pages/game_pages/the_game_page.dart';
import 'package:tictactoe/pages/protected_pages/misc_pages/leaderboard.dart';
import 'package:tictactoe/pages/protected_pages/misc_pages/personal_game_record.dart';
import 'package:tictactoe/pages/protected_pages/misc_pages/personal_game_record_all.dart';
import 'package:tictactoe/pages/protected_pages/misc_pages/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tictactoe',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black87, background: Colors.white),
        useMaterial3: true,
        fontFamily: "IBMPlexMono",
      ),
      home: const AuthHandlerPage(),

      /// routes will be here
      routes: {
        // Auth Pages
        "/forgot-password": (context) => const ForgotPasswordPage(),
        "/register": (context) => const RegisterPage(),
        "/login": (context) => const LoginWithPassword(),

        /// Protected Pages

        // Game Pages
        "/find-players-online": (context) => const FindPlayersOnline(),
        "/join-with-invitation-code": (context) =>
            const JoinWithInvitationCodePage(),
        "/invite-someone-to-play": (context) => const InviteSomeonePage(),
        "/confirm-match": (context) => const ConfirmMatchPage(),
        "/rematch-or-end-session": (context) => const PostGamePage(),
        "/the-game-page": (context) => const TheGamePage(),

        // Misc Pages
        "/profile": (context) => const ProfilePage(),
        "/leaderboard": (context) => const Leaderboard(),
        "/personal-game-record": (context) => const PersonalGameRecord(),
        "/personal-game-record-all": (context) => const PersonalGameRecordAll(),

        // Record Pages

        //
      },
    );
  }
}
