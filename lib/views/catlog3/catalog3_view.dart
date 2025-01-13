import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/views/catalog1/widget/new_offers_component.dart';
import 'package:homez/views/catalog1/widget/seasonal_location_tile.dart';
import 'package:homez/views/catlog3/widget/popular_rent_component.dart';
import '../../bloc/homzes_bloc.dart';
import '../../bloc/homzes_event.dart';
import '../../bloc/homzes_state.dart';
import '../../domain/entity/category1_entity.dart';
import '../../domain/entity/property_list_entity.dart';
import '../../common/app_search_component.dart';
import '../add_details/add_details_view.dart';
import '../../utils/app_images.dart';
import '../catlog3/catalog3_view.dart';

class Catalog3View extends StatelessWidget {

  final List<Property> properties;
  Catalog3View({Key? key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyBloc()..add(FetchProperties()),
      child: Scaffold(
        body: BlocBuilder<PropertyBloc, PropertyState>(
          builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                      child: Container(
                        height: 146,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration:  BoxDecoration(color: Colors.greenAccent.withOpacity(0.6)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(AppImages.appMenu2, height: 24, width: 24),
                            SizedBox(width: 11,),
                            Expanded(
                              child: AppSearchComponent(
                                searchCriteria: AppSearchCriteria(
                                  onSubmit: (query) {
                                    // Search action
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Popular rent offers',style: TextStyle(
                      fontWeight: FontWeight.w700,fontSize: 18
                    ),),
                    SizedBox(height: 10),
                    _buildHorizontalPropertyList(properties),

                  ],
                ),
              );
            }
              ,
        ),
      ),
    );
  }


  Widget _buildHorizontalPropertyList(List<Property> properties) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return PopularRentComponent(
          propertyListEntity: property,
        );
      },
    );
  }

}
