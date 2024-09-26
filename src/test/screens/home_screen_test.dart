
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/screens/home_screen.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('HomeScreen', () {
		late MockAnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('displays initial animal text and icon', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(text: 'Cat', icon: Icons.pets));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.pets), findsOneWidget);
		});

		testWidgets('toggles animal text and icon on tap', (WidgetTester tester) async {
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([
					AnimalState(text: 'Cat', icon: Icons.pets),
					AnimalState(text: 'Dog', icon: Icons.person),
				]),
			);
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(text: 'Cat', icon: Icons.pets));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.pets), findsOneWidget);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
