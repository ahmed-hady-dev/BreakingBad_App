import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/characters_cubit.dart';
import 'core/blocObserver/bloc_observer.dart';
import 'core/constants.dart';
import 'core/dioHelper/dio_helper.dart';
import 'core/router/router.dart';
import 'view/home/view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharactersCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'BreakingBad App',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.indigo,
            appBarTheme: const AppBarTheme(
              color: MyColors.darkBlue,
            )),
        home: HomeView(),
      ),
    );
  }
}
