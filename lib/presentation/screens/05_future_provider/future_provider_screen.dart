import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/future_providers.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonName = ref.watch(pokemonNameProvider);
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
        child: pokemonName.when(
          data: (data) => Text(data),
          error: (error, stackTrace) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'previous',
            backgroundColor: colorTheme.secondaryContainer,
            child: const Icon(Icons.history),
            onPressed: () {
              // ref.invalidate(pokemonNameProvider);
              ref.read(pokemonIdProvider.notifier).previousPokemon();
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'next',
            child: const Icon(Icons.refresh),
            onPressed: () {
              // ref.invalidate(pokemonNameProvider);
              ref.read(pokemonIdProvider.notifier).nextPokemon();
            },
          ),
        ],
      ),
    );
  }
}
