import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:shades_cast/screens/add_funfact/bloc/add_funfact_bloc.dart';

void main() {
  group('AddFunfactBloc', () {
    AddFunfactBloc addFunfactBloc = AddFunfactBloc();

    setUp(() {
      addFunfactBloc = AddFunfactBloc();
    });

    tearDown(() {
      addFunfactBloc.close();
    });

    test('emits [AddFunfactSuccessState] when FunfactSubmitted event is added',
        () {
      final fact = 'Some fun fact';
      expectLater(
        addFunfactBloc.stream,
        emitsInOrder([AddFunfactSuccessState()]),
      );

      addFunfactBloc.add(FunfactSubmitted(fact: fact));
    });

    test(
        'emits [AddFunfactErrorState] when an error occurs during fun fact submission',
        () {
      final fact = 'Some fun fact';
      final error = 'Some error message';

      expectLater(
        addFunfactBloc.stream,
        emitsInOrder([AddFunfactErrorState()]),
      );

      addFunfactBloc.add(FunfactSubmitted(fact: fact));
      // addFunfactBloc.onError(error);
    });
  });
}
