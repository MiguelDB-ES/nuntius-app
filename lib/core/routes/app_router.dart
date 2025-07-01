import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

// Importe todas as telas que são rotas
import 'package:nuntius/features/auth/screens/login_screen.dart';
import 'package:nuntius/features/auth/screens/register_screen.dart';
import 'package:nuntius/features/auth/screens/splash_screen.dart';
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
import 'package:nuntius/features/user/profile/screens/user_menu_overlay.dart'; // Caminho correto para o user_menu_overlay
import 'package:nuntius/features/user/search/screens/search_screen.dart';
import 'package:nuntius/features/admin/screens/admin_login_screen.dart'; // Caminho correto para o admin_login_screen

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // O argumento passado para a rota (se houver)
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.welcome:
        // Se tiver uma WelcomeScreen, descomente e use aqui
        // return MaterialPageRoute(builder: (_) => const WelcomeScreen());
        return MaterialPageRoute(builder: (_) => const Text('Welcome Screen (a ser implementada)')); // Placeholder
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      // Rotas do utilizador comum
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
        // Garante que o argumento é uma String para contactName
        if (args is String) {
          return MaterialPageRoute(builder: (_) => ChatScreen(contactName: args));
        }
        // Retorna uma tela de erro ou um valor padrão se o argumento for inválido
        return MaterialPageRoute(builder: (_) => const Text('Erro: Nome do contato não fornecido para o chat!'));
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
