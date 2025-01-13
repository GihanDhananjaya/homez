import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/views/welcome/widget/welcome_component.dart';

import '../../bloc/homzes_bloc.dart';
import '../../bloc/homzes_state.dart';
import '../../common/app_button.dart';
import '../../domain/entity/home_category_entity.dart';
import '../../utils/app_images.dart';
import '../catalog1/catalog1_view.dart';

class HomzesWelcomeView extends StatefulWidget {
  const HomzesWelcomeView({super.key});

  @override
  State<HomzesWelcomeView> createState() => _HomzesWelcomeViewState();
}

class _HomzesWelcomeViewState extends State<HomzesWelcomeView> {
  PropertyBloc homzesBloc = PropertyBloc();
  List<HomeCategoryEntity> nearestLocations = [
    HomeCategoryEntity(name: 'Rent', image: AppImages.appRent, color: Colors.white38),
    HomeCategoryEntity(name: 'Buy', image:AppImages.appRent, color: Colors.amber),
    HomeCategoryEntity(name: 'Sell', image: AppImages.appRent, color: Colors.brown),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PropertyBloc>(
        create: (_) => homzesBloc,

        child: BlocListener<PropertyBloc, PropertyState>(
            listener: (_, state) {},
            child: Stack(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.74), // Adjust opacity as needed
                    BlendMode.darken, // Blend mode to darken the image
                  ),
                  child: Image.asset(AppImages.appWelcome,
                      fit: BoxFit.cover,
                      height:double.infinity,
                      width: double.infinity),
                ),
                Positioned(
                  top: 90 ,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AppImages.appHomzes,height: 21,width: 98,),
                      InkResponse(
                          onTap: (){},
                          child: Image.asset(AppImages.appMenu,height: 50,width: 50,)),
                    ],
                  ),
                ),      
                 Positioned(
                  top: (MediaQuery.of(context).size.height / 2) ,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 70.0),
                        child: Text("Find the best place for you",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 36,
                              color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),),
                      ),

                      SizedBox(height: 60,),
                      SizedBox(
                        height: 172,
                        child: ListView.builder(
                          itemCount: nearestLocations.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: WelcomeComponent(
                                homeCategoryEntity: nearestLocations[index],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20,),

                      AppButton(buttonText: 'Create an account', onTapButton: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>  Catalog1View()),
                        );
                      },)


                    ]
                  ),
                ),
              ],
            )
        ),

      ),
    );
  }
}
