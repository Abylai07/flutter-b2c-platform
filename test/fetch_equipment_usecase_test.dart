// Example of Unit Testing for Use Cases
// This demonstrates how to test business logic in isolation

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';

// This would normally be imported from your domain layer
// For this example, we'll define mock versions

// Mock Entity
class Equipment {
  final String id;
  final String title;
  final double pricePerDay;

  Equipment({
    required this.id,
    required this.title,
    required this.pricePerDay,
  });
}

// Repository Interface (from domain layer)
abstract class EquipmentRepository {
  Future<Either<Failure, List<Equipment>>> getEquipmentList();
}

// Use Case being tested
class FetchEquipmentUseCase implements UseCase<List<Equipment>, NoParams> {
  final EquipmentRepository repository;

  FetchEquipmentUseCase(this.repository);

  @override
  Future<Either<Failure, List<Equipment>>> call(NoParams params) async {
    return await repository.getEquipmentList();
  }
}

// Mock Repository using Mocktail
class MockEquipmentRepository extends Mock implements EquipmentRepository {}

void main() {
  // System under test
  late FetchEquipmentUseCase useCase;
  late MockEquipmentRepository mockRepository;

  setUp(() {
    // Create mock and use case before each test
    mockRepository = MockEquipmentRepository();
    useCase = FetchEquipmentUseCase(mockRepository);
  });

  // Test data
  final tEquipmentList = [
    Equipment(
      id: '1',
      title: 'Professional Drill',
      pricePerDay: 50.0,
    ),
    Equipment(
      id: '2',
      title: 'Hammer',
      pricePerDay: 20.0,
    ),
  ];

  group('FetchEquipmentUseCase', () {
    test(
      'should return equipment list from repository when call is successful',
      () async {
        // arrange - Setup mock behavior
        when(() => mockRepository.getEquipmentList())
            .thenAnswer((_) async => Right(tEquipmentList));

        // act - Execute the use case
        final result = await useCase(NoParams());

        // assert - Verify the result
        expect(result, Right(tEquipmentList));
        verify(() => mockRepository.getEquipmentList()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ServerFailure when repository call fails',
      () async {
        // arrange
        final tServerFailure = ServerFailure('Server error');
        when(() => mockRepository.getEquipmentList())
            .thenAnswer((_) async => Left(tServerFailure));

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, Left(tServerFailure));
        verify(() => mockRepository.getEquipmentList()).called(1);
      },
    );

    test(
      'should return NetworkFailure when there is no internet connection',
      () async {
        // arrange
        final tNetworkFailure = NetworkFailure('No internet connection');
        when(() => mockRepository.getEquipmentList())
            .thenAnswer((_) async => Left(tNetworkFailure));

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, Left(tNetworkFailure));
        verify(() => mockRepository.getEquipmentList()).called(1);
      },
    );

    test(
      'should return empty list when no equipment is available',
      () async {
        // arrange
        final tEmptyList = <Equipment>[];
        when(() => mockRepository.getEquipmentList())
            .thenAnswer((_) async => Right(tEmptyList));

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, Right(tEmptyList));
        result.fold(
          (failure) => fail('Should not return failure'),
          (equipment) => expect(equipment, isEmpty),
        );
      },
    );
  });

  /// Example: Testing BLoC
  ///
  /// ```dart
  /// group('EquipmentBloc', () {
  ///   late EquipmentBloc bloc;
  ///   late MockFetchEquipmentUseCase mockFetchEquipment;
  ///
  ///   setUp(() {
  ///     mockFetchEquipment = MockFetchEquipmentUseCase();
  ///     bloc = EquipmentBloc(fetchEquipment: mockFetchEquipment);
  ///   });
  ///
  ///   tearDown(() {
  ///     bloc.close();
  ///   });
  ///
  ///   blocTest<EquipmentBloc, EquipmentState>(
  ///     'emits [Loading, Loaded] when equipment is fetched successfully',
  ///     build: () {
  ///       when(() => mockFetchEquipment(any()))
  ///           .thenAnswer((_) async => Right(tEquipmentList));
  ///       return bloc;
  ///     },
  ///     act: (bloc) => bloc.add(LoadEquipment()),
  ///     expect: () => [
  ///       EquipmentLoading(),
  ///       EquipmentLoaded(tEquipmentList),
  ///     ],
  ///     verify: (_) {
  ///       verify(() => mockFetchEquipment(NoParams())).called(1);
  ///     },
  ///   );
  ///
  ///   blocTest<EquipmentBloc, EquipmentState>(
  ///     'emits [Loading, Error] when fetch fails',
  ///     build: () {
  ///       when(() => mockFetchEquipment(any()))
  ///           .thenAnswer((_) async => Left(ServerFailure('Error')));
  ///       return bloc;
  ///     },
  ///     act: (bloc) => bloc.add(LoadEquipment()),
  ///     expect: () => [
  ///       EquipmentLoading(),
  ///       EquipmentError('Error'),
  ///     ],
  ///   );
  /// });
  /// ```

  /// Example: Testing Repository
  ///
  /// ```dart
  /// group('EquipmentRepository', () {
  ///   late EquipmentRepositoryImpl repository;
  ///   late MockEquipmentRemoteDataSource mockRemoteDataSource;
  ///   late MockNetworkInfo mockNetworkInfo;
  ///
  ///   setUp(() {
  ///     mockRemoteDataSource = MockEquipmentRemoteDataSource();
  ///     mockNetworkInfo = MockNetworkInfo();
  ///     repository = EquipmentRepositoryImpl(
  ///       remoteDataSource: mockRemoteDataSource,
  ///       networkInfo: mockNetworkInfo,
  ///     );
  ///   });
  ///
  ///   group('device is online', () {
  ///     setUp(() {
  ///       when(() => mockNetworkInfo.isConnected)
  ///           .thenAnswer((_) async => true);
  ///     });
  ///
  ///     test(
  ///       'should return remote data when call to remote source is successful',
  ///       () async {
  ///         // arrange
  ///         when(() => mockRemoteDataSource.getEquipmentList())
  ///             .thenAnswer((_) async => tEquipmentModelList);
  ///
  ///         // act
  ///         final result = await repository.getEquipmentList();
  ///
  ///         // assert
  ///         verify(() => mockRemoteDataSource.getEquipmentList());
  ///         expect(result, Right(tEquipmentList));
  ///       },
  ///     );
  ///
  ///     test(
  ///       'should return server failure when remote call throws exception',
  ///       () async {
  ///         // arrange
  ///         when(() => mockRemoteDataSource.getEquipmentList())
  ///             .thenThrow(ServerException());
  ///
  ///         // act
  ///         final result = await repository.getEquipmentList();
  ///
  ///         // assert
  ///         verify(() => mockRemoteDataSource.getEquipmentList());
  ///         expect(result, Left(ServerFailure()));
  ///       },
  ///     );
  ///   });
  ///
  ///   group('device is offline', () {
  ///     setUp(() {
  ///       when(() => mockNetworkInfo.isConnected)
  ///           .thenAnswer((_) async => false);
  ///     });
  ///
  ///     test(
  ///       'should return network failure when device is offline',
  ///       () async {
  ///         // act
  ///         final result = await repository.getEquipmentList();
  ///
  ///         // assert
  ///         verifyZeroInteractions(mockRemoteDataSource);
  ///         expect(result, Left(NetworkFailure()));
  ///       },
  ///     );
  ///   });
  /// });
  /// ```
}

// Best Practices for Testing:
//
// 1. **AAA Pattern**: Arrange, Act, Assert
//    - Arrange: Set up test data and mocks
//    - Act: Execute the code being tested
//    - Assert: Verify the results
//
// 2. **Test Naming**: Use descriptive names
//    Format: "should [expected behavior] when [condition]"
//
// 3. **Test Independence**: Each test should be independent
//    - Use setUp() for common initialization
//    - Use tearDown() for cleanup
//
// 4. **Mock External Dependencies**: Mock repositories, APIs, etc.
//    - Use Mocktail for mocking
//    - Verify interactions with mocks
//
// 5. **Test Edge Cases**:
//    - Empty lists
//    - Null values
//    - Error scenarios
//    - Boundary conditions
//
// 6. **Test Coverage**:
//    - Aim for 80%+ coverage for domain layer
//    - 100% coverage for critical business logic
//
// Run tests:
// flutter test
//
// Run with coverage:
// flutter test --coverage
// genhtml coverage/lcov.info -o coverage/html
// open coverage/html/index.html
