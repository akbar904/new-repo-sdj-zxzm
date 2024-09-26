
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/models/animal.dart';

class AnimalDisplay extends StatelessWidget {
	const AnimalDisplay({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, AnimalState>(
			builder: (context, state) {
				return GestureDetector(
					onTap: () => context.read<AnimalCubit>().toggleAnimal(),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(state.animal.text),
							Icon(state.animal.icon),
						],
					),
				);
			},
		);
	}
}
