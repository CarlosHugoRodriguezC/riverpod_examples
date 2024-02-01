import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/future_providers.dart';

class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  FamilyFutureScreenState createState() => FamilyFutureScreenState();
}

class FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {
  int pokemonId = 3;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final pokemonName = ref.watch(pokemonProvider(pokemonId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon $pokemonId'),
      ),
      body: Center(
        child: pokemonName.when(
          data: (data) => Text(data),
          error: ((error, stackTrace) => Text(error.toString())),
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
              if (pokemonId <= 1) return;
              setState(() {
                pokemonId--;
              });
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'next',
            child: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                pokemonId++;
              });
            },
          ),
        ],
      ),
    );
  }
}
