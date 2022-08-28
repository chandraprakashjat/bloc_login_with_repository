import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

//ignore:avoid_print
    print('onChange ${bloc.runtimeType} ${change.toString()}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    //ignore:avoid_print
    print('on Event ${bloc.runtimeType} ${event.toString()}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    //ignore:avoid_print
    print('on Transition ${bloc.runtimeType} ${transition.toString()}');
  }
}
