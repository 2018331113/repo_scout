import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/api.dart';
import 'bloc/repo_bloc.dart';
import 'config/routes.dart';
import 'repository/remote_repository.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    log('BLOC EVENT: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('BLOC ERROR: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('BLOC TRANSITION: $transition ');
    super.onTransition(bloc, transition);
  }
}

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RepoBloc(
            repository: RemoteRepository(api: Api()),
          )
        )
      ],
      child: MaterialApp(
        title: 'Repo Scout',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}
