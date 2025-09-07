import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neon_others_challenge/feature/coral/cubit/coral_cubit.dart';
import 'package:neon_others_challenge/feature/home/home_page.dart';
import 'package:neon_others_challenge/objectbox.dart';
import 'package:neon_others_challenge/feature/ticketmaster_event_app/event_cubit.dart';

import 'core/services/ticketmaster_service.dart';

late ObjectBox objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TicketmasterService service = TicketmasterService();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<EventCubit>(create: (_) => EventCubit(service)),
            BlocProvider<CoralCubit>(create: (_) => CoralCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Aqualis Coral App',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: HomePage(),
          ),
        );
      },
    );
  }
}
