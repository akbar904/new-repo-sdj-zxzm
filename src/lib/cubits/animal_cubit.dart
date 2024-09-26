
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Model representing an animal with text and icon
class Animal {
	final String text;
	final IconData icon;

	Animal({required this.text, required this.icon});
}

// State for the AnimalCubit
class AnimalState {
	final String text;
	final IconData icon;

	AnimalState({required this.text, required this.icon});
}

// Cubit for managing the state of the displayed animal
class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit()
		: super(AnimalState(text: 'Cat', icon: Icons.pets));

	void toggleAnimal() {
		if (state.text == 'Cat') {
			emit(AnimalState(text: 'Dog', icon: Icons.person));
		} else {
			emit(AnimalState(text: 'Cat', icon: Icons.pets));
		}
	}
}
