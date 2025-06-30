import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

// Importe todas as telas aqui
import 'package:nuntius/features/auth/screens/splash_screen.dart';
import 'package:nuntius/features/auth/screens/welcome_screen.dart';
import 'package:nuntius/features/auth/screens/login_screen.dart';
import 'package:nuntius/features/auth/screens/register_screen.dart';

import 'package:nuntius/features/user/home/screens/home_screen.dart';
import 'package:nuntius/features/user/news/screens/news_detail_screen.dart';
import 'package:nuntius/features/user/forum/screens/forum_list_screen.dart';
import 'package:nuntius/features/user/forum/screens/forum_topic_detail_screen.dart';
import 'package:nuntius/features/user/chat/screens/chat_list_screen.dart';
import 'package:nuntius/features/user/chat/screens/chat_screen.dart';
import 'package:nuntius/features/user/create_content/screens/create_post_screen.dart';
import 'package:nuntius/features/user/profile/screens/user_profile_screen.dart';
import 'package:nuntius/features/user/profile/screens/edit_profile_screen.dart';
import 'package:nuntius/features/user/profile/screens/user_settings_screen.dart';
import 'package:nuntius/features/user/profile/screens/user_menu_overlay.dart';
import 'package:nuntius/features/user/search/screens/search_screen.dart';

import 'package:nuntius/features/admin/screens/admin_login_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Rotas de autenticação
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      // Rotas do usuário comum
      case AppRoutes.userHome:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.newsDetail:
        return MaterialPageRoute(builder: (_) => const NewsDetailScreen());
      case AppRoutes.forumList:
        return MaterialPageRoute(builder: (_) => const ForumListScreen());
      case AppRoutes.forumTopicDetail:
        return MaterialPageRoute(builder: (_) => const ForumTopicDetailScreen());
      case AppRoutes.chatList:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case AppRoutes.chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case AppRoutes.createPost:
        return MaterialPageRoute(builder: (_) => const CreatePostScreen());
      case AppRoutes.userProfile:
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case AppRoutes.userSettings:
        return MaterialPageRoute(builder: (_) => const UserSettingsScreen());
      case AppRoutes.userMenuOverlay:
        return MaterialPageRoute(builder: (_) => const UserMenuOverlay());
      case AppRoutes.searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      // Rotas do administrador
      case AppRoutes.adminLogin:
        return MaterialPageRoute(builder: (_) => const AdminLoginScreen());

      default:
        return MaterialPageRoute(builder: (_) => const Text('Erro: Rota não encontrada!'));
    }
  }
}