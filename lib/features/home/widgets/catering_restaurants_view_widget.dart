import 'package:stackfood_multivendor/features/home/widgets/arrow_icon_button_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/restaurants_card_widget.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/features/restaurant/screens/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CateringRestaurantsViewWidget extends StatelessWidget {
  final bool isCatering;
  const CateringRestaurantsViewWidget({super.key, required this.isCatering});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(builder: (restController) {
        return (restController.cateringRestaurantList != null && restController.cateringRestaurantList!.isEmpty) ? const SizedBox() : Padding(
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isMobile(context)  ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeLarge),
          child: Container(
            width: Dimensions.webMaxWidth,
            height: 210,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Catering Restaurants', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600)),

                    ArrowIconButtonWidget(
                      onTap: () => Get.toNamed(RouteHelper.getAllRestaurantRoute(isCatering ? 'catering' : '')),
                    ),
                  ]),
                ),


                restController.cateringRestaurantList != null ? SizedBox(
                  height: 130,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                    itemCount: restController.cateringRestaurantList!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.getRestaurantRoute(restController.cateringRestaurantList![index].id),
                                arguments: RestaurantScreen(restaurant: restController.cateringRestaurantList![index]),
                              );
                            },
                            child: RestaurantsCardWidget(
                              isNewOnStackFood: true,
                              restaurant: restController.cateringRestaurantList![index],
                            ),
                          ),
                        );
                      },
                  ),
                ) : const RestaurantsCardShimmer(isNewOnStackFood: false),
             ],
            ),

          ),
        );
      }
    );
  }
}
