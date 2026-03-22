import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_theme.dart';
import 'player_view_model.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  final String videoUrl;
  final String title;

  const PlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize player when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(playerViewModelProvider.notifier)
          .initializePlayer(widget.videoUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playerViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state.error != null
              ? _buildErrorView(state.error!)
              : state.chewieController != null
                  ? Chewie(controller: state.chewieController!)
                  : const Center(
                      child: Text(
                        'Unable to load video',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref
                .read(playerViewModelProvider.notifier)
                .initializePlayer(widget.videoUrl),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ref.read(playerViewModelProvider.notifier).disposePlayer();
    super.dispose();
  }
}
