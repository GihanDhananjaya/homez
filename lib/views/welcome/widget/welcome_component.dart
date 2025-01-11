import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/home_category_entity.dart';

class WelcomeComponent extends StatelessWidget {
  final HomeCategoryEntity homeCategoryEntity;


  const WelcomeComponent({
    required this.homeCategoryEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: homeCategoryEntity.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Image.asset(homeCategoryEntity.image, color: Colors.black, width: 24),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Text(
              homeCategoryEntity.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}