import 'package:flutter_bloc/flutter_bloc.dart';

import 'homzes_event.dart';
import 'homzes_state.dart';

class HomzesBloc extends Bloc<HomzesEvent, HomzesState>{
  HomzesBloc(): super(HomzesInitial()){


  }


}