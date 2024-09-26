
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_project/cubits/animal_cubit.dart';

// Mock dependencies if any (none needed here as per the interface document)
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});
		
		test('initial state is AnimalState with Cat', () {
			expect(animalCubit.state.text, 'Cat');
			expect(animalCubit.state.icon, Icons.pets);
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(Dog)] when toggleAnimal is called',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				isA<AnimalState>()
					..having((state) => state.text, 'text', 'Dog')
					..having((state) => state.icon, 'icon', Icons.person),
			],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(Cat)] when toggleAnimal is called twice',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal();
				cubit.toggleAnimal();
			},
			expect: () => [
				isA<AnimalState>()
					..having((state) => state.text, 'text', 'Dog')
					..having((state) => state.icon, 'icon', Icons.person),
				isA<AnimalState>()
					..having((state) => state.text, 'text', 'Cat')
					..having((state) => state.icon, 'icon', Icons.pets),
			],
		);
	});
}
