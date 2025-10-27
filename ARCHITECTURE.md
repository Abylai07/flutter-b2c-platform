# Architecture Documentation

## Table of Contents

- [Overview](#overview)
- [Clean Architecture Layers](#clean-architecture-layers)
- [Feature-First Organization](#feature-first-organization)
- [Design Patterns](#design-patterns)
- [Data Flow](#data-flow)
- [Dependency Management](#dependency-management)
- [State Management](#state-management)
- [Error Handling](#error-handling)
- [Testing Strategy](#testing-strategy)
- [Code Generation](#code-generation)
- [Best Practices](#best-practices)

---

## Overview

B2C Platform follows **Clean Architecture** principles combined with **Feature-First** structure. This architecture ensures:

- **Independence of Frameworks**: Business logic doesn't depend on Flutter
- **Testability**: Each layer can be tested in isolation
- **Independence of UI**: UI can change without affecting business logic
- **Independence of Database**: Can switch data sources easily
- **Independence of External Services**: Business rules don't know about the outside world

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                       │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │   Pages    │  │   Widgets  │  │    BLoC    │            │
│  └────────────┘  └────────────┘  └────────────┘            │
└────────────────────────┬────────────────────────────────────┘
                         │ Events/States
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                       Domain Layer                            │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │  Entities  │  │  Use Cases │  │ Repositories│            │
│  │            │  │            │  │ (Interfaces)│            │
│  └────────────┘  └────────────┘  └────────────┘            │
└────────────────────────┬────────────────────────────────────┘
                         │ Either<Failure, Success>
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                        Data Layer                             │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │   Models   │  │Data Sources│  │Repositories │            │
│  │            │  │            │  │ (Impls)     │            │
│  └────────────┘  └────────────┘  └────────────┘            │
└────────────────────────┬────────────────────────────────────┘
                         │ HTTP/Local
                         ▼
                   External Services
                   (API, Database, etc.)
```

### Project Structure

```
lib/
└── src/
    ├── core/                      # Shared core components
    │   ├── error/                 # Error handling & exceptions
    │   ├── usecases/              # Base use case classes
    │   └── platform/              # Platform-specific implementations
    │
    ├── common/                    # Shared utilities
    │   ├── utils/                 # Utilities (routing, l10n, etc.)
    │   ├── app_styles/            # Theme & styling
    │   ├── widgets/               # Shared widgets
    │   └── constants.dart         # App-wide constants
    │
    └── features/                  # Feature-First structure ⭐
        │
        ├── auth/                  # Authentication feature
        │   ├── data/
        │   │   ├── datasources/   # Remote & local data sources
        │   │   ├── models/        # Data transfer objects
        │   │   └── repositories/  # Repository implementations
        │   ├── domain/
        │   │   ├── entities/      # Business models
        │   │   ├── repositories/  # Repository interfaces
        │   │   └── usecases/      # Business logic
        │   └── presentation/
        │       ├── bloc/          # State management
        │       ├── pages/         # UI screens
        │       └── widgets/       # Feature-specific widgets
        │
        ├── equipment/             # Equipment management feature
        │   ├── data/
        │   ├── domain/
        │   └── presentation/
        │
        ├── orders/                # Orders feature
        │   ├── data/
        │   ├── domain/
        │   └── presentation/
        │
        └── profile/               # User profile feature
            ├── data/
            ├── domain/
            └── presentation/
```

**Key Points:**
- Each **feature** contains its own `data`, `domain`, and `presentation` layers
- **core/** contains shared infrastructure (errors, base use cases, platform code)
- **common/** contains shared UI components, utilities, and constants
- Features are **independent** and can be developed, tested, and deployed separately

---

## Clean Architecture Layers

### 1. Presentation Layer (`lib/src/features/{feature}/presentation/`)

**Responsibility**: Handle UI and user interactions within a specific feature

**Components**:
- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components
- **BLoC**: State management and business logic coordination

**Example Structure**:
```dart
// Page
class EquipmentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentBloc, EquipmentState>(
      builder: (context, state) {
        return state.when(
          loading: () => LoadingWidget(),
          loaded: (items) => EquipmentListView(items),
          error: (message) => ErrorWidget(message),
        );
      },
    );
  }
}

// BLoC
class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  final FetchEquipmentUseCase fetchEquipment;

  EquipmentBloc(this.fetchEquipment) : super(EquipmentInitial()) {
    on<LoadEquipment>(_onLoadEquipment);
  }

  Future<void> _onLoadEquipment(
    LoadEquipment event,
    Emitter<EquipmentState> emit,
  ) async {
    emit(EquipmentLoading());
    final result = await fetchEquipment(NoParams());
    result.fold(
      (failure) => emit(EquipmentError(failure.message)),
      (items) => emit(EquipmentLoaded(items)),
    );
  }
}
```

**Rules**:
- ✅ Can depend on Domain layer
- ❌ Cannot depend on Data layer
- ✅ Contains UI logic only
- ❌ No business logic

---

### 2. Domain Layer (`lib/src/features/{feature}/domain/`)

**Responsibility**: Core business logic and rules for a specific feature

**Components**:
- **Entities**: Business objects (pure Dart classes)
- **Use Cases**: Business operations
- **Repository Interfaces**: Abstract contracts for data operations

**Example Structure**:
```dart
// Entity
class Equipment extends Equatable {
  final String id;
  final String title;
  final String description;
  final double pricePerDay;
  final EquipmentStatus status;

  const Equipment({
    required this.id,
    required this.title,
    required this.description,
    required this.pricePerDay,
    required this.status,
  });

  @override
  List<Object?> get props => [id, title, description, pricePerDay, status];
}

// Repository Interface
abstract class EquipmentRepository {
  Future<Either<Failure, List<Equipment>>> getEquipmentList();
  Future<Either<Failure, Equipment>> getEquipmentById(String id);
  Future<Either<Failure, Unit>> createEquipment(Equipment equipment);
}

// Use Case
class FetchEquipmentUseCase implements UseCase<List<Equipment>, NoParams> {
  final EquipmentRepository repository;

  FetchEquipmentUseCase(this.repository);

  @override
  Future<Either<Failure, List<Equipment>>> call(NoParams params) async {
    return await repository.getEquipmentList();
  }
}

// Base Use Case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
```

**Rules**:
- ✅ Independent of all other layers
- ✅ Pure Dart code (no Flutter imports)
- ✅ Contains business logic
- ❌ No framework dependencies

---

### 3. Data Layer (`lib/src/features/{feature}/data/`)

**Responsibility**: Data management and external communication for a specific feature

**Components**:
- **Models**: DTOs for serialization/deserialization
- **Data Sources**: API, Database, Cache implementations
- **Repository Implementations**: Concrete implementations of domain repositories

**Example Structure**:
```dart
// Model (with json_serializable)
@JsonSerializable()
class EquipmentModel extends Equipment {
  const EquipmentModel({
    required String id,
    required String title,
    required String description,
    required double pricePerDay,
    required EquipmentStatus status,
  }) : super(
    id: id,
    title: title,
    description: description,
    pricePerDay: pricePerDay,
    status: status,
  );

  factory EquipmentModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentModelToJson(this);
}

// Data Source
abstract class EquipmentRemoteDataSource {
  Future<List<EquipmentModel>> getEquipmentList();
  Future<EquipmentModel> getEquipmentById(String id);
  Future<void> createEquipment(EquipmentModel equipment);
}

class EquipmentRemoteDataSourceImpl implements EquipmentRemoteDataSource {
  final Dio dio;

  EquipmentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<EquipmentModel>> getEquipmentList() async {
    try {
      final response = await dio.get('/equipment');
      return (response.data as List)
          .map((json) => EquipmentModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}

// Repository Implementation
class EquipmentRepositoryImpl implements EquipmentRepository {
  final EquipmentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EquipmentRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Equipment>>> getEquipmentList() async {
    if (await networkInfo.isConnected) {
      try {
        final equipmentList = await remoteDataSource.getEquipmentList();
        return Right(equipmentList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
```

**Rules**:
- ✅ Implements Domain interfaces
- ✅ Handles data transformation (Model ↔ Entity)
- ✅ Manages caching strategies
- ❌ No business logic

---

## Feature-First Organization

Each feature is self-contained with all its layers:

```
lib/src/
├── features/
│   ├── authentication/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   └── auth_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── auth_response_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── sign_in_usecase.dart
│   │   │       └── sign_up_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   ├── sign_in_page.dart
│   │       │   └── sign_up_page.dart
│   │       └── widgets/
│   │           ├── auth_form.dart
│   │           └── otp_input.dart
│   │
│   ├── equipment/
│   │   └── ... (same structure)
│   │
│   └── orders/
│       └── ... (same structure)
```

### Benefits

- **Modularity**: Each feature is independent
- **Scalability**: Easy to add/remove features
- **Team Collaboration**: Multiple developers can work on different features
- **Code Organization**: Clear structure, easy to navigate
- **Testing**: Test features in isolation

---

## Design Patterns

### 1. Repository Pattern

**Purpose**: Abstract data sources from business logic

```dart
// Domain Layer - Interface
abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);
}

// Data Layer - Implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, User>> getUser(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.getUser(id);
        localDataSource.cacheUser(user);
        return Right(user);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final user = await localDataSource.getCachedUser(id);
        return Right(user);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }
}
```

### 2. Use Case Pattern

**Purpose**: Encapsulate single business operations

```dart
class CreateOrderUseCase implements UseCase<Order, CreateOrderParams> {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  @override
  Future<Either<Failure, Order>> call(CreateOrderParams params) async {
    // Validation
    if (params.startDate.isAfter(params.endDate)) {
      return Left(ValidationFailure('Invalid date range'));
    }

    // Business logic
    final totalCost = _calculateCost(params);

    // Repository call
    return await repository.createOrder(
      params.equipmentId,
      params.startDate,
      params.endDate,
      totalCost,
    );
  }

  double _calculateCost(CreateOrderParams params) {
    // Business logic for cost calculation
    final days = params.endDate.difference(params.startDate).inDays;
    return params.pricePerDay * days;
  }
}
```

### 3. BLoC Pattern

**Purpose**: Manage application state

```dart
// Events
abstract class OrderEvent {}

class LoadOrders extends OrderEvent {}
class CreateOrder extends OrderEvent {
  final CreateOrderParams params;
  CreateOrder(this.params);
}

// States
abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}
class OrdersLoaded extends OrderState {
  final List<Order> orders;
  OrdersLoaded(this.orders);
}
class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

// BLoC
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FetchOrdersUseCase fetchOrders;
  final CreateOrderUseCase createOrder;

  OrderBloc({
    required this.fetchOrders,
    required this.createOrder,
  }) : super(OrderInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<CreateOrder>(_onCreateOrder);
  }

  Future<void> _onLoadOrders(
    LoadOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await fetchOrders(NoParams());
    result.fold(
      (failure) => emit(OrderError(_mapFailureToMessage(failure))),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }
}
```

### 4. Dependency Injection (GetIt)

**Purpose**: Manage dependencies and promote loose coupling

```dart
final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => OrderBloc(
    fetchOrders: sl(),
    createOrder: sl(),
  ));

  // Use Cases
  sl.registerLazySingleton(() => FetchOrdersUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));

  // Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
```

---

## Data Flow

### Request Flow (User Action → API)

```
1. User taps button
   ↓
2. Widget dispatches Event to BLoC
   ↓
3. BLoC calls Use Case
   ↓
4. Use Case executes business logic
   ↓
5. Use Case calls Repository
   ↓
6. Repository checks network/cache
   ↓
7. Repository calls Data Source
   ↓
8. Data Source makes API call
   ↓
9. Response flows back (Model → Entity)
   ↓
10. BLoC emits new State
   ↓
11. UI rebuilds
```

### Response Flow (API → UI)

```
API Response (JSON)
   ↓
Data Source (catches exceptions)
   ↓
Model (fromJson)
   ↓
Repository (Model → Entity, Either)
   ↓
Use Case (business logic)
   ↓
BLoC (State emission)
   ↓
UI (BlocBuilder rebuilds)
```

---

## State Management

### BLoC Architecture

```dart
// 1. Define Events
abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String phone;
  final String password;
  SignInRequested(this.phone, this.password);
}

// 2. Define States
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// 3. Implement BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;

  AuthBloc(this.signInUseCase) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signInUseCase(
      SignInParams(phone: event.phone, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
}

// 4. Use in UI
BlocProvider(
  create: (context) => sl<AuthBloc>(),
  child: BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    builder: (context, state) {
      if (state is AuthLoading) {
        return LoadingIndicator();
      }
      if (state is AuthAuthenticated) {
        return HomePage(user: state.user);
      }
      return SignInForm();
    },
  ),
)
```

---

## Error Handling

### Failure Classes

```dart
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred'])
      : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'No internet connection'])
      : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred'])
      : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}
```

### Exception Handling

```dart
// Data Source
class EquipmentRemoteDataSourceImpl implements EquipmentRemoteDataSource {
  @override
  Future<EquipmentModel> getEquipment(String id) async {
    try {
      final response = await dio.get('/equipment/$id');
      if (response.statusCode == 200) {
        return EquipmentModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw NetworkException();
      }
      throw ServerException();
    }
  }
}

// Repository
class EquipmentRepositoryImpl implements EquipmentRepository {
  @override
  Future<Either<Failure, Equipment>> getEquipment(String id) async {
    try {
      final equipment = await remoteDataSource.getEquipment(id);
      return Right(equipment);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
```

---

## Testing Strategy

### 1. Unit Tests (Domain Layer)

```dart
void main() {
  late FetchEquipmentUseCase useCase;
  late MockEquipmentRepository mockRepository;

  setUp(() {
    mockRepository = MockEquipmentRepository();
    useCase = FetchEquipmentUseCase(mockRepository);
  });

  test('should return equipment list from repository', () async {
    // Arrange
    final equipmentList = [tEquipment1, tEquipment2];
    when(() => mockRepository.getEquipmentList())
        .thenAnswer((_) async => Right(equipmentList));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, Right(equipmentList));
    verify(() => mockRepository.getEquipmentList()).called(1);
  });
}
```

### 2. BLoC Tests

```dart
void main() {
  late EquipmentBloc bloc;
  late MockFetchEquipmentUseCase mockFetchEquipment;

  setUp(() {
    mockFetchEquipment = MockFetchEquipmentUseCase();
    bloc = EquipmentBloc(fetchEquipment: mockFetchEquipment);
  });

  blocTest<EquipmentBloc, EquipmentState>(
    'emits [Loading, Loaded] when equipment is fetched successfully',
    build: () {
      when(() => mockFetchEquipment(any()))
          .thenAnswer((_) async => Right([tEquipment1]));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadEquipment()),
    expect: () => [
      EquipmentLoading(),
      EquipmentLoaded([tEquipment1]),
    ],
  );
}
```

### 3. Widget Tests

```dart
void main() {
  testWidgets('should show loading indicator when state is loading',
      (tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => MockEquipmentBloc(),
          child: EquipmentListPage(),
        ),
      ),
    );

    // Act
    whenListen(
      mockBloc,
      Stream.fromIterable([EquipmentLoading()]),
    );
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

---

## Code Generation

### Freezed (Immutable Models)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipment.freezed.dart';
part 'equipment.g.dart';

@freezed
class Equipment with _$Equipment {
  const factory Equipment({
    required String id,
    required String title,
    required String description,
    required double pricePerDay,
    required EquipmentStatus status,
    List<String>? images,
  }) = _Equipment;

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);
}
```

### Commands

```bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (continuous generation)
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Best Practices

### 1. Code Organization
- ✅ One class per file
- ✅ Group related files in folders
- ✅ Use barrel files for exports
- ✅ Follow consistent naming conventions

### 2. Dependency Management
- ✅ Use dependency injection
- ✅ Program to interfaces, not implementations
- ✅ Avoid circular dependencies
- ✅ Keep dependencies explicit

### 3. State Management
- ✅ Single source of truth
- ✅ Immutable state
- ✅ Clear event/state naming
- ✅ Handle all possible states

### 4. Error Handling
- ✅ Use Either for error handling
- ✅ Specific error types
- ✅ User-friendly error messages
- ✅ Log errors appropriately

### 5. Testing
- ✅ Test business logic thoroughly
- ✅ Mock external dependencies
- ✅ Test edge cases
- ✅ Maintain high test coverage

### 6. Performance
- ✅ Implement pagination
- ✅ Cache frequently accessed data
- ✅ Optimize images
- ✅ Use const constructors

---

## Conclusion

This architecture provides:
- **Maintainability**: Easy to understand and modify
- **Testability**: Each layer can be tested independently
- **Scalability**: Easy to add new features
- **Flexibility**: Easy to change implementations
- **Team Collaboration**: Clear separation of concerns

For questions or suggestions, please refer to the main [README.md](README.md).
