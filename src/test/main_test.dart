
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('MyApp builds and contains HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('AnimalCubit Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		blocTest<AnimalCubit, AnimalState>(
			'Initial state is AnimalState with Cat and Clock icon',
			build: () => animalCubit,
			verify: (cubit) {
				expect(cubit.state, AnimalState(animal: Animal(text: 'Cat', icon: Icons.access_time)));
			},
		);

		blocTest<AnimalCubit, AnimalState>(
			'Toggles animal from Cat to Dog',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				AnimalState(animal: Animal(text: 'Dog', icon: Icons.person)),
			],
		);

		blocTest<AnimalCubit, AnimalState>(
			'Toggles animal from Dog to Cat',
			build: () => animalCubit,
			seed: () => AnimalState(animal: Animal(text: 'Dog', icon: Icons.person)),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				AnimalState(animal: Animal(text: 'Cat', icon: Icons.access_time)),
			],
		);
	});
}
