// lib/features/user/home/screens/search_screen.dart
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // Lista de resultados de busca (simulada)
  bool _isLoading = false;

  // Lista de itens "reais" para simular a busca
  final List<String> _allSearchableItems = [
    'Notícia: Inflação em queda',
    'Notícia: Novas tecnologias em IA',
    'Fórum: Dicas de Flutter',
    'Fórum: Receitas saudáveis',
    'Usuário: Ana Paula',
    'Usuário: Carlos Eduardo',
    'Notícia: Esportes radicais',
    'Fórum: Viagens e turismo',
    'Usuário: Mariana Oliveira',
  ];

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulação de uma busca assíncrona com atraso
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _searchResults = _allSearchableItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar por notícias, fóruns, usuários...',
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch(''); // Limpa os resultados ao limpar o campo
                    },
                  )
                : null,
          ),
          onChanged: _performSearch, // Realiza a busca a cada alteração
          onSubmitted: _performSearch, // Realiza a busca ao submeter (Enter)
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty && _searchController.text.isNotEmpty
              ? Center(child: Text('Nenhum resultado encontrado para "${_searchController.text}".')) // REMOVIDO 'const'
              : _searchResults.isEmpty && _searchController.text.isEmpty
                  ? const Center(child: Text('Comece a digitar para buscar notícias, fóruns ou usuários.'))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: const Icon(Icons.search),
                            title: Text(_searchResults[index]),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Clicou em: ${_searchResults[index]}')),
                              );
                              // TODO: Em um app real, navegar para a tela de detalhes do item encontrado
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
