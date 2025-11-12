import 'package:shaligram_transport_app/models/setNotificationDetail.dart';

class SetNotificationData{
  //These are the values that this Demo model can store
  late String title;
  late List<SetNotificationDetail> list;

//default Constructor
  SetNotificationData(titles,lists){
    title = titles;
    list = lists;
  }

}