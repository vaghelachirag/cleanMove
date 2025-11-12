import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shaligram_transport_app/models/passenger/notification/getPassengerNotificationDetail.dart';
import 'package:shaligram_transport_app/provider/passenger/Notification/getPassengerNotificationProvider.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import '../../../../utils/internetChecker.dart';
import "package:collection/collection.dart";

class NotificationViewController extends GetxController {

  RxBool isLoading = RxBool(true);
  var notificationList = <NotificationList>[].obs;
  var dateMap = {}.obs;
  var itemsInCategory=  <NotificationList>[].obs;
  RxString filterTag = "".obs;
  

  NotificationViewController({required this.getStorage});


  // For Store Data
  GetStorage getStorage;


  // For UserName
  var userName = RxString("");

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  // final GetPassengerNotificationProvider _getPassengerNotificationProvider = Get.find<GetPassengerNotificationProvider>();


  RxString passengerId = RxString("");


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    passengerId.value = getStorage.read(AppConstant.userId);
    setUserName();
  }


  loadNotification() async {
    isLoading.value = true;
    if (controller.is_InternetConnected.value) {
      await GetPassengerNotificationProvider()
          .getPassengerNotification("24545")
          .then((value) {
        notificationList.value = value ?? [];
   

        if(notificationList.isEmpty) {
          notificationList.value = [

            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "today check",
              createdDate: DateTime.parse("2024-03-11T11:11:22.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,


            ),

            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "today check2",
              createdDate: DateTime.parse("2024-03-11T11:11:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,


            ),
            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "yesterday check",
              createdDate: DateTime.parse("2024-03-10T01:21:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,

            ),


            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "yesterday check2",
              createdDate: DateTime.parse("2024-03-10T11:21:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,

            ),


            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "Date Check",
              createdDate: DateTime.parse("2024-03-05T11:11:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,


            ),

            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "Date Check06",
              createdDate: DateTime.parse("2024-03-02T11:11:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,
            ),

            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "Date Check1",
              createdDate: DateTime.parse("2024-02-29T11:11:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,
            ),
            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "Date Check2",
              createdDate: DateTime.parse("2024-02-28T11:11:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,
            ),
            NotificationList(
              passengerNotificationId: 3,
              notificationTitle: "Date Check2",
              createdDate: DateTime.parse("2024-02-28T11:11:20.95"),
              notificationMessage: "Hello there! You are signed up!",
              employeeId: 0,
              isRead: true,
              isDiscard: false,
              isActive: true,
              isDelete: false,
              createdBy: 1,
              updatedBy: 1,
            ),
          ];
        }
        getFilterDateTime();
        isLoading.value = false;
      });
    }
  }


  void setUserName() {
    userName.value = getStorage.read(AppConstant.profileName);
  }


  DateTime changeDateFormate(String strDate) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(strDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(inputDate);
    return DateFormat("dd-MM-yyyy").parse(outputDate).toLocal();
  }


  getFilterDateTime() {
    Map groupItemsByCategory() {
      return groupBy(notificationList, (item) {
        DateTime previousDate = changeDateFormate(DateTime.now().toString())
            .subtract(const Duration(days: 1));
        if(changeDateFormate(item.createdDate.toString()) == changeDateFormate(
            DateTime.now().toString())){
          filterTag.value = "Today";
        }else if(changeDateFormate(item.createdDate.toString()) == previousDate){
          filterTag.value = "YesterDay";
        }else {
          filterTag.value = DateFormat('EEEE dd MMM').format(
              DateTime.parse(
                  item.createdDate.toString()));
        }
        return filterTag.value;
      });
    }
    dateMap.value = groupItemsByCategory();
  }

}



