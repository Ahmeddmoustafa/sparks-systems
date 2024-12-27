import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sparks_app/cubits/graph_cubit.dart';
import 'package:sparks_app/cubits/locale_cubit.dart';
import 'package:sparks_app/data/data_repository.dart';
import 'package:sparks_app/generated/l10n.dart';
import 'package:sparks_app/resources/Managers/colors_manager.dart';
import 'package:sparks_app/resources/Managers/values_manager.dart';
import 'package:sparks_app/resources/Utils/responsive.dart';
import 'package:sparks_app/widgets/statistics_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GraphCubit(dataRepository: DataRepositoryImpl())..loadGraphData(),
        ),
        BlocProvider(
          create: (context) => LocaleCubit(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale(state.locale),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: 'Sparks Systems',
            theme: ThemeData(
              // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final List<Color> gradientColors = const [
    ColorManager.contentColorCyan,
    ColorManager.contentColorBlue,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 136, 194, 240),
        title: Text(S.of(context).appTitle),
        centerTitle: true,
        actions: [
          Switch(
            value: context.read<LocaleCubit>().state.locale == 'en',
            onChanged: (value) {
              context.read<LocaleCubit>().changeLocale(value);
            },
            activeColor: ColorManager.PrimaryColor,
          )
        ],
      ),
      body: BlocConsumer<GraphCubit, GraphState>(
        listener: (context, state) {
          if (state.appState == AppState.success) {
            context.read<GraphCubit>().calculateMetrics();
          } else if (state.appState == AppState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorText),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatisticsWidget(
                    title: S.of(context).orderMetrics,
                    value: state.orders.length),
                StatisticsWidget(
                  title: S.of(context).salesMetrics,
                  value: state.avgSales.roundToDouble(),
                ),
                StatisticsWidget(
                    title: S.of(context).returnsMetrics,
                    value: state.numOfReturns),
                const SizedBox(height: AppSize.s20),
                Container(
                  padding: const EdgeInsets.only(right: AppSize.s25),
                  width: MediaQuery.sizeOf(context).width,
                  height: 300,
                  child: LineChart(mainData(context)),
                ),
                const SizedBox(height: AppSize.s10),
                Center(child: Text(S.of(context).months))
              ],
            ),
          );
        },
      ),
    );
  }

  LineChartData mainData(BuildContext context) {
    final state = context.read<GraphCubit>().state;
    return LineChartData(
      // backgroundColor: Color.fromARGB(255, 4, 4, 62),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            // color: AppColors.mainGridLineColor,
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            // color: AppColors.mainGridLineColor,
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: const AxisTitles(
          // axisNameWidget: Text("Months"),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            // getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Text(S.of(context).orders),
          sideTitles: SideTitles(
            showTitles: true,
            interval: (state.maxValue / 5).roundToDouble(),
            // getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: 12,
      minY: 0,
      maxY: state.maxValue.toDouble() + 1,
      lineBarsData: [
        LineChartBarData(
          spots: mapToFlSpotList(state.graphData),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  gradientColors.map((color) => color.withAlpha(3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> mapToFlSpotList(Map<int, int> data) {
    List<FlSpot> flSpots = [];
    for (int i = 1; i <= 12; i++) {
      // Use the map value if it exists, otherwise default to 0
      int yValue = data[i] ?? 0;
      flSpots.add(FlSpot(i.toDouble(), yValue.toDouble()));
    }
    return flSpots;
  }
}
