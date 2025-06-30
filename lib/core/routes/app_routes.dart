class AppRoutes {
  // Rotas de autenticação
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  // Rotas do usuário comum
  static const String userHome = '/user-home';
  static const String newsDetail = '/news-detail';
  static const String forumList = '/forum-list';
  static const String forumTopicDetail = '/forum-topic-detail';
  static const String chatList = '/chat-list';
  static const String chatScreen = '/chat-screen';
  static const String createPost = '/create-post';
  static const String userProfile = '/user-profile';
  static const String editProfile = '/edit-profile';
  static const String userSettings = '/user-settings';
  static const String userMenuOverlay = '/user-menu-overlay'; // Pode ser uma rota para o overlay
  static const String searchScreen = '/search-screen';

  // Rotas do administrador
  static const String adminLogin = '/admin-login';
  // Adicione outras rotas de admin aqui futuramente
}