import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/channel_model.dart';
import '../../core/providers.dart';
import '../../core/repository/channels_repository.dart';

class ChannelsState {
  final List<ChannelModel> channels;
  final bool isLoading;
  final String? error;

  const ChannelsState({
    this.channels = const [],
    this.isLoading = false,
    this.error,
  });

  ChannelsState copyWith({
    List<ChannelModel>? channels,
    bool? isLoading,
    String? error,
  }) {
    return ChannelsState(
      channels: channels ?? this.channels,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ChannelsViewModel extends StateNotifier<ChannelsState> {
  final ChannelsRepository _repository;

  ChannelsViewModel(this._repository) : super(const ChannelsState()) {
    loadChannels();
  }

  Future<void> loadChannels() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final channels = await _repository.getChannels();
      state = state.copyWith(channels: channels, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadChannelsByCategory(int categoryId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final channels = await _repository.getChannelsByCategory(categoryId);
      state = state.copyWith(channels: channels, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final channelsViewModelProvider =
    StateNotifierProvider<ChannelsViewModel, ChannelsState>((ref) {
  final repository = ref.watch(channelsRepositoryProvider);
  return ChannelsViewModel(repository);
});
