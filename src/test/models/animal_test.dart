
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_package_name/models/animal.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should be created with correct text and icon', () {
			// Arrange
			const text = 'Cat';
			const icon = Icons.pets;

			// Act
			final animal = Animal(text: text, icon: icon);

			// Assert
			expect(animal.text, text);
			expect(animal.icon, icon);
		});
	});
}
