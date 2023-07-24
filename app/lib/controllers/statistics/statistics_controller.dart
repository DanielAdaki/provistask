import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:get/get.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';
import 'package:provitask_app/services/preferences.dart';

final logger = Logger();
final _prefs = Preferences();

class StatisticsController extends GetxController {
  final locationAddress = Rx<String>('');

  final isLoading = false.obs;
  final user = _prefs.user;

  final mensualEarning = '556.60'.obs;

  final rateReliability = '90'.obs;

  final todayEarning = '12.50'.obs;

  final selectedMonth = DateTime.now().month.obs;
  final selectedDay = DateTime.now().day.obs;

  final filteredPendingRequests = <PendingRequest>[].obs;

  final last30DaysEarnings = '3500'.obs;

  final last30DaysTope = '30000'.obs;

  final last30DaysProgress = 0.0.obs;

  Rx<MetricsProgress> currentMetricsResponse =
      Rx<MetricsProgress>(MetricsProgress(percentage: 95, name: 'Response'));
  // ahora con currentMetricsAcceptance

  Rx<MetricsProgress> currentMetricsAcceptance =
      Rx<MetricsProgress>(MetricsProgress(percentage: 96, name: 'Acceptance'));

  Rx<MetricsProgress> currentMetricsRejection =
      Rx<MetricsProgress>(MetricsProgress(percentage: 98, name: 'Reliability'));

  @override
  void onInit() async {
    super.onInit();
    calcularProgresoLast30Days();
  }

  //

  void calcularProgresoLast30Days() {
    double progreso = double.parse(last30DaysEarnings.value) /
        double.parse(last30DaysTope.value);
    last30DaysProgress.value = progreso;
  }
}

class MetricsProgress {
  final double percentage;
  final String name;
  Widget get progressWidget => LinearProgressIndicator(
        value: percentage / 100,
        backgroundColor: Colors.grey[300],
        color: const Color(0XFF170591),
      );

  MetricsProgress({required this.percentage, required this.name});
}
