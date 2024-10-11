import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const mockKey = 'test-value';
  const mockValue = 'test-value';
  final mockException = Exception('Test Exception');

  late PersistentStorage persistentStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    persistentStorage =
        PersistentStorage(sharedPreferences: mockSharedPreferences);
  });

  group('PersistentStorage', () {
    group('read', () {
      test('should return value for a given key', () async {
        // Arrange
        when(() => mockSharedPreferences.getString(mockKey))
            .thenReturn(mockValue);

        // Act
        final result = await persistentStorage.read(key: mockKey);

        // Assert
        expect(result, mockValue);
        verify(() => mockSharedPreferences.getString(mockKey)).called(1);
      });

      test('should return null if no value is found for a given key', () async {
        // Arrange
        when(() => mockSharedPreferences.getString(mockKey)).thenReturn(null);

        // Act
        final result = await persistentStorage.read(key: mockKey);

        // Assert
        expect(result, isNull);
        verify(() => mockSharedPreferences.getString(mockKey)).called(1);
      });

      test('should throw StorageException if SharedPreferences throws an error',
          () async {
        // Arrange
        when(() => mockSharedPreferences.getString(mockKey))
            .thenThrow(mockException);

        // Act & Assert
        expect(() async => persistentStorage.read(key: mockKey),
            throwsA(isA<StorageException>()),);
      });
    });

    group('write', () {
      test('should write a key-value pair successfully', () async {
        // Arrange
        when(() => mockSharedPreferences.setString(mockKey, mockValue))
            .thenAnswer((_) async => true);

        // Act
        await persistentStorage.write(key: mockKey, value: mockValue);

        // Assert
        verify(() => mockSharedPreferences.setString(mockKey, mockValue))
            .called(1);
      });

      test('should throw StorageException if SharedPreferences throws an error',
          () async {
        // Arrange
        when(() => mockSharedPreferences.setString(mockKey, mockValue))
            .thenThrow(mockException);

        // Act & Assert
        expect(
          () async =>
              persistentStorage.write(key: mockKey, value: mockValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('delete', () {
      test('should delete a value for a given key successfully', () async {
        // Arrange
        when(() => mockSharedPreferences.remove(mockKey))
            .thenAnswer((_) async => true);

        // Act
        await persistentStorage.delete(key: mockKey);

        // Assert
        verify(() => mockSharedPreferences.remove(mockKey)).called(1);
      });

      test('should throw StorageException if SharedPreferences throws an error',
          () async {
        // Arrange
        when(() => mockSharedPreferences.remove(mockKey))
            .thenThrow(mockException);

        // Act & Assert
        expect(() async => persistentStorage.delete(key: mockKey),
            throwsA(isA<StorageException>()),);
      });
    });

    group('clear', () {
      test('should clear all key-value pairs successfully', () async {
        // Arrange
        when(() => mockSharedPreferences.clear()).thenAnswer((_) async => true);

        // Act
        await persistentStorage.clear();

        // Assert
        verify(() => mockSharedPreferences.clear()).called(1);
      });

      test('should throw StorageException if SharedPreferences throws an error',
          () async {
        // Arrange
        when(() => mockSharedPreferences.clear()).thenThrow(mockException);

        // Act & Assert
        expect(() async => persistentStorage.clear(),
            throwsA(isA<StorageException>()),);
      });
    });
  });
}
