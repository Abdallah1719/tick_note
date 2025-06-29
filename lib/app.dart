import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/core/routes/app_router.dart';
import 'package:tick_note/core/services/service_locator.dart';
import 'package:tick_note/core/theme/cubit/theme_cubit.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
import 'package:tick_note/features/splash/presentation/screens/splash_screen.dart';
import 'package:tick_note/generated/l10n.dart';
import 'package:tick_note/l10n/cubit/local_cubit.dart';

class TickNote extends StatelessWidget {
  const TickNote({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..loadSavedLocale()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => sl<NotesCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, String>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: LocaleCubit.localizationsDelegates,
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale(locale),
                title: 'TickNote',
                theme: context.watch<ThemeCubit>().currentTheme(),
                home: const SplashScreen(),
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).title)),
      body: const Center(child: Text('Welcome to TickNote!')),
    );
  }
}
