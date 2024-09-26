
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:animal_switcher/widgets/animal_display.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/models/animal.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalDisplay Widget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
			when(() => animalCubit.state).thenReturn(AnimalState(Animal(text: 'Cat', icon: Icons.access_time)));
		});

		testWidgets('displays initial animal (Cat) with clock icon', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: animalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays updated animal (Dog) with person icon when clicked', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([AnimalState(Animal(text: 'Dog', icon: Icons.person))]),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: animalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
