import 'package:flutter/src/widgets/scroll_controller.dart';
import 'package:get/get.dart';
import '../../models/api_status.dart';
import '../../provider/paggination_provider.dart';
import '../../widget/common_widget.dart';
import 'getSurveyListResponse.dart';
import 'partner/getPartnerListResponse.dart';

class PagginationController extends GetxController {

    RxBool  isLoading = RxBool(false);
    RxBool isFirstLoadRunning = RxBool(false);
    final RxBool isLoadMoreRunning =  RxBool(false) ;

    final PaginationProvider _paginationProvider = Get.find<PaginationProvider>();

   int _page = 0;
  final int _limit = 15;
  final RxBool hasNextPage = RxBool(true);
  var surveyList = <GetSurveyListData>[].obs;

    var partnerList = <GetPartnerListData>[].obs;
  @override
  void onInit() {
    super.onInit();
    isFirstLoadRunning.value = true;
    getPartnerList();
  }

   getAllPost(ScrollController controller) {
     isLoading.value = true;
     if (hasNextPage.value == true && isFirstLoadRunning.value == false && isLoadMoreRunning.value == false && controller.position.extentAfter < 300) {
       isLoadMoreRunning.value = true;
       _page += 1;
       _paginationProvider.getAllPost(_page.toString(),_limit.toString()).then((value) => {
         if (value is Success<GetSurveyResponse>) {
           surveyList.value.addAll(value.data.data),
          isFirstLoadRunning.value = false,
           isLoading.value = false,
           isLoadMoreRunning.value = false,
           print("Size: ${surveyList.length}"),
         } else if (value is Failure<GetSurveyResponse>) {
           showSnakeBar(buildContext, "Response Failed!"),
           hasNextPage.value = false,
           isLoadMoreRunning.value = false,
         }
       }).onError((error, stackTrace) => {
       }
       );
     }
  }
     getPost(){
      isLoading.value = true;
      _page += 1;
      _paginationProvider.getAllPost(_page.toString(),_limit.toString()).then((value) => {
        if (value is Success<GetSurveyResponse>) {
          surveyList.value.addAll(value.data.data),
          isFirstLoadRunning.value = false,
          isLoading.value = false,
          print("Size: ${surveyList.length}"),
        } else if (value is Failure<GetSurveyResponse>) {
          showSnakeBar(buildContext, "Response Failed!"),
          hasNextPage.value = false
        }
      }).onError((error, stackTrace) => {
      });
      isLoadMoreRunning.value = false;
  }

  getPartnerList(){
    isLoading.value = true;
    _page += 1;
    _paginationProvider.getAllPartner(_page.toString(),_limit.toString()).then((value) => {
      if (value is Success<GetPartnerListResponse>) {
        partnerList.value.addAll(value.data.data),
        isFirstLoadRunning.value = false,
        isLoading.value = false,
        print("Size: ${surveyList.length}"),
      } else if (value is Failure<GetSurveyResponse>) {
        showSnakeBar(buildContext, "Response Failed!"),
        hasNextPage.value = false
      }
    }).onError((error, stackTrace) => {
    });
    isLoadMoreRunning.value = false;
  }

    getAllPartnerList(ScrollController controller) {
      isLoading.value = true;
      if (hasNextPage.value == true && isFirstLoadRunning.value == false && isLoadMoreRunning.value == false && controller.position.extentAfter < 300) {
        isLoadMoreRunning.value = true;
        _page += 1;
        _paginationProvider.getAllPartner(_page.toString(),_limit.toString()).then((value) => {
          if (value is Success<GetPartnerListResponse>) {
            partnerList.value.addAll(value.data.data),
            isFirstLoadRunning.value = false,
            isLoading.value = false,
            isLoadMoreRunning.value = false,
            print("Size: ${surveyList.length}"),
            if(value.data.data.isEmpty){
              hasNextPage.value = false
            }
          } else if (value is Failure<GetSurveyResponse>) {
            showSnakeBar(buildContext, "Response Failed!"),
            hasNextPage.value = false,
            isLoadMoreRunning.value = false,
          }
        }).onError((error, stackTrace) => {
        }
        );
      }
    }
}

