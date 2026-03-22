import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../home/home_screen.dart';
import 'splash_state.dart';
import 'splash_view_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(splashViewModelProvider.notifier).init());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(splashViewModelProvider);

    // Navigate to home when ready
    if (state.status == SplashStatus.ready) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SplashState state) {
    switch (state.status) {
      case SplashStatus.loading:
      case SplashStatus.idle:
        return const CircularProgressIndicator();

      case SplashStatus.maintenance:
        return _MaintenanceView(message: state.settings?.updateMessage ?? 'Under maintenance');

      case SplashStatus.updateRequired:
        return _UpdateView(message: state.settings?.updateMessage ?? 'Update available');

      case SplashStatus.error:
        return _ErrorView(message: state.message ?? 'Something went wrong');

      case SplashStatus.ready:
        return const CircularProgressIndicator(); // Will navigate away
    }
  }
}

class _MaintenanceView extends StatelessWidget {
  final String message;

  const _MaintenanceView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.build_rounded, size: 80, color: Colors.white70),
        const SizedBox(height: 20),
        Text(
          'Maintenance Mode',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _UpdateView extends StatelessWidget {
  final String message;

  const _UpdateView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Available',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Launch update URL (update flow)
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline_rounded, size: 80, color: Colors.redAccent),
        const SizedBox(height: 20),
        Text(
          'Error',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
