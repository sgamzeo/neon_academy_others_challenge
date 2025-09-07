import 'package:custom_components/components/buttons/custom_button.dart';
import 'package:custom_components/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:neon_others_challenge/core/services/iTunes_services.dart';

class ITunesSearchPage extends StatefulWidget {
  const ITunesSearchPage({super.key});

  @override
  State<ITunesSearchPage> createState() => _ITunesSearchPageState();
}

class _ITunesSearchPageState extends State<ITunesSearchPage> {
  final ITunesService _service = ITunesService();
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _songs = [];
  bool _isLoading = false;

  void _search() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _songs = [];
    });

    try {
      final results = await _service.searchSongs(query);
      setState(() {
        _songs = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('iTunes Song Search')),
      body: Padding(
        padding: Dimens.paddingLarge,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Search songs',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: _search,
                    text: 'Search',
                    size: ButtonSize.small,
                    fullWidth: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _songs.length,
                  itemBuilder: (context, index) {
                    final song = _songs[index] as Map<String, dynamic>?;

                    if (song == null) return const SizedBox();

                    return ListTile(
                      leading: song['artworkUrl60'] != null
                          ? Image.network(
                              song['artworkUrl60'].toString(),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(width: 50, height: 50),
                      title: Text(song['trackName']?.toString() ?? 'Unknown'),
                      subtitle: Text(
                        song['artistName']?.toString() ?? 'Unknown Artist',
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
