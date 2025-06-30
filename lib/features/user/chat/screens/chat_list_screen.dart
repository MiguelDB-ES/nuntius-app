// lib/features/user/chat/screens/chat_list_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class ChatConversation {
  final String id;
  final String participantName;
  final String lastMessage;
  final String lastMessageTime;
  final String? participantProfilePictureUrl;

  ChatConversation({
    required this.id,
    required this.participantName,
    required this.lastMessage,
    required this.lastMessageTime,
    this.participantProfilePictureUrl,
  });

  factory ChatConversation.fromMap(Map<String, dynamic> map) {
    return ChatConversation(
      id: map['id'] as String,
      participantName: map['participantName'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageTime: map['lastMessageTime'] as String,
      participantProfilePictureUrl: map['participantProfilePictureUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participantName': participantName,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'participantProfilePictureUrl': participantProfilePictureUrl,
    };
  }
}

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatConversation> _conversations = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadChatConversations();
  }

  Future<void> _loadChatConversations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      final List<ChatConversation> fetchedConversations = [];

      if (mounted) {
        setState(() {
          _conversations = fetchedConversations;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erro ao carregar conversas: $e';
          _isLoading = false;
        });
      }
      debugPrint('Erro ao carregar conversas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Conversas'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : _conversations.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 80,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhuma conversa ainda.',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Comece uma nova conversa com seus contatos!',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Funcionalidade "Nova Conversa" a ser implementada!')),
                              );
                            },
                            icon: const Icon(Icons.add_comment),
                            label: const Text('Nova Conversa'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = _conversations[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12.0),
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundImage: conversation.participantProfilePictureUrl != null &&
                                      conversation.participantProfilePictureUrl!.isNotEmpty
                                  ? NetworkImage(conversation.participantProfilePictureUrl!)
                                  : null,
                              child: (conversation.participantProfilePictureUrl == null ||
                                      conversation.participantProfilePictureUrl!.isEmpty)
                                  ? Text(
                                      conversation.participantName.isNotEmpty
                                          ? conversation.participantName[0].toUpperCase()
                                          : '?',
                                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                    )
                                  : null,
                              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                            ),
                            title: Text(
                              conversation.participantName,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              conversation.lastMessage,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              conversation.lastMessageTime,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.chatScreen,
                                arguments: conversation.id,
                              );
                            },
                          ),
                        );
                      },
                    ),
      floatingActionButton: _isLoading || _errorMessage != null || _conversations.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidade "Nova Conversa" a ser implementada!')),
                );
              },
              icon: const Icon(Icons.add_comment),
              label: const Text('Nova Conversa'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
    );
  }
}
