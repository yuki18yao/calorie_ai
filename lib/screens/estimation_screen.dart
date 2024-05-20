import 'dart:io';
import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class EstimationScreen extends StatelessWidget {
  final String imagePath;

  const EstimationScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Estimation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.file(
                    File(imagePath),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Estimation',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'OpenAI API texts',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                'List of Ingredients',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4, // Replace with the actual number of ingredients
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return Text(
                    'Ingredient ${index + 1}', // Replace with actual ingredient data
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
