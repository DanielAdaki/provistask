import 'package:get/get.dart';
import 'package:provitask_app/common/socket.dart';
import 'package:provitask_app/components/controllers/provitask_bottom_bar_controller.dart';
import 'package:provitask_app/controllers/auth/login_controller.dart';
import 'package:provitask_app/controllers/auth/register_controller.dart';
import 'package:provitask_app/controllers/home/home_provider_controller.dart';
import 'package:provitask_app/controllers/home/pending_page_provider_controller.dart';
import 'package:provitask_app/controllers/statistics/statistics_controller.dart';
import 'package:provitask_app/pages/freelancers/UI/freelancers_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_controller.dart';
import 'package:provitask_app/pages/chat/chat_home/UI/chat_home_controller.dart';
import 'package:provitask_app/controllers/home/home_controller.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';

import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_provider/UI/profile_provider_controller.dart';
//import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';
import 'package:provitask_app/pages/splash/UI/splash_controller.dart';
import 'package:provitask_app/pages/tasks/UI/tasks_controller.dart';
import 'package:provitask_app/pages/verification_provider/UI/verification_provider_controller.dart';
import 'package:provitask_app/pages/welcome/UI/welcome_controller.dart';
//import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.put<RegisterController>(RegisterController());

    //Get.lazyPut<RegisterProviderController>(() => RegisterProviderController());
    Get.lazyPut<VerificationProviderController>(
        () => VerificationProviderController());
    Get.lazyPut<ProfileProviderController>(() => ProfileProviderController());
    Get.lazyPut<RegisterTaskController>(() => RegisterTaskController(),
        fenix: true);

    Get.lazyPut<WelcomeController>(() => WelcomeController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<FreelancersController>(() => FreelancersController());
    Get.lazyPut<TasksController>(() => TasksController());

    Get.lazyPut<ChatHomeController>(() => ChatHomeController());
    Get.lazyPut<ChatConversationController>(() => ChatConversationController());
    Get.lazyPut<ProvitaskBottomBarController>(
        () => ProvitaskBottomBarController());

    Get.lazyPut<ChatHomeController>(() => ChatHomeController());
    Get.lazyPut<HomeProviderController>(() => HomeProviderController(),
        fenix: true);
    Get.lazyPut<PendingPageController>(() => PendingPageController(),
        fenix: true);
    Get.lazyPut<SocketController>(() => SocketController(), fenix: true);
    Get.lazyPut<StatisticsController>(() => StatisticsController(),
        fenix: true);

    Get.put(LocationController(), permanent: true);
    // Get.lazyPut<LocationController>(() => LocationController(), fenix: true);

    Get.lazyPut<ChatConversationController>(() => ChatConversationController(),
        fenix: true);

    // aplico el find a LocationController

    //  Get.find<LocationController>();
  }
}
