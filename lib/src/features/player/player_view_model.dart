import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayerState {
  final ChewieController? chewieController;
  final bool isLoading;
  final String? error;

  const PlayerState({
    this.chewieController,
    this.isLoading = false,
    this.error,
  });

  PlayerState copyWith({
    ChewieController? chewieController,
    bool? isLoading,
    String? error,
  }) {
    return PlayerState(
      chewieController: chewieController ?? this.chewieController,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class PlayerViewModel extends StateNotifier<PlayerState> {
  VideoPlayerController? _videoPlayerController;

  PlayerViewModel() : super(const PlayerState());

  Future<void> initializePlayer(String videoUrl) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _videoPlayerController!.initialize();

      final chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightBlue,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        autoInitialize: true,
      );

      state =
          state.copyWith(chewieController: chewieController, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void disposePlayer() {
    _videoPlayerController?.dispose();
    state.chewieController?.dispose();
    state = const PlayerState();
  }
}

final playerViewModelProvider =
    StateNotifierProvider<PlayerViewModel, PlayerState>((ref) {
  return PlayerViewModel();
});
