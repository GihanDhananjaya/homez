import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/views/catalog1/widget/new_offers_component.dart';
import 'package:homez/views/catalog1/widget/seasonal_location_tile.dart';
import '../../bloc/homzes_bloc.dart';
import '../../bloc/homzes_event.dart';
import '../../bloc/homzes_state.dart';
import '../../domain/entity/category1_entity.dart';
import '../../domain/entity/property_list_entity.dart';
import '../../common/app_search_component.dart';
import '../add_details/add_details_view.dart';
import '../../utils/app_images.dart';
import '../catlog3/catalog3_view.dart';

class Catalog1View extends StatelessWidget {

  final List<PropertyListEntity> propertyListEntity = [
    PropertyListEntity(imageUrl: AppImages.appWelcome, title: 'Modern House', price: 1200, rating: 2, reviewCount: 45),
    PropertyListEntity(imageUrl: AppImages.appWelcome, title: 'Modern House', price: 1200, rating: 2, reviewCount: 45),
    PropertyListEntity(imageUrl: AppImages.appWelcome, title: 'Modern House', price: 1200, rating: 2, reviewCount: 45),
    PropertyListEntity(imageUrl: AppImages.appWelcome, title: 'Modern House', price: 1200, rating: 2, reviewCount: 45)
  ];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyBloc()..add(FetchProperties()),
      child: Scaffold(
        body: BlocBuilder<PropertyBloc, PropertyState>(
          builder: (context, state) {
            if (state is PropertyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PropertyError) {
              return Center(child: Text(state.error));
            } else if (state is PropertyLoaded) {
              final properties = state.properties;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                      child: Container(
                        height: 220,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration:  BoxDecoration(color: Colors.limeAccent.withOpacity(0.6)),
                        child: Column(
                          children: [
                            const SizedBox(height: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(AppImages.appMenu2, height: 24, width: 24),
                                Spacer(),
                                const Text(
                                  'Hi, Gihan',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(width: 10,),
                                InkResponse(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>  AddPropertyScreen()),
                                    );
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Text('A'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            AppSearchComponent(
                              searchCriteria: AppSearchCriteria(
                                onSubmit: (query) {
                                  // Search action
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildSectionHeader('Featured', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>  Catalog3View(properties: properties)),
                      );
                    }),
                    SizedBox(height: 10),
                    _buildHorizontalPropertyList(properties),
                    const SizedBox(height: 20),

                    _buildSectionHeader('New Offers', () {}),
                    _buildVerticalPropertyList(),
                  ],
                ),
              );
            }
            return const Center(child: Text('No properties found.'));
          },
        ),
      ),
    );
  }


  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: onViewAll,
            child: const Text(
              'View all',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalPropertyList(List<Property> properties) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return PropertyCard(
             category1Entity: property,
          );
        },
      ),
    );
  }

  Widget _buildVerticalPropertyList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: propertyListEntity.length,
      itemBuilder: (context, index) {
        final property = propertyListEntity[index];
        return PropertyCardWithRating(
          propertyListEntity: property,
        );
      },
    );
  }
}
