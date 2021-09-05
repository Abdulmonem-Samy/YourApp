import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your/Logic/events/PostEvent.dart';
import 'package:your/Logic/states/post_state.dart';
import 'package:your/data_layer/models/post_model.dart';



/////////////////PostBloc/////////////////////

class PostBloc extends Bloc<PostEvent,PostState>{

  PostBloc():super(PostState(post: Post(), states: 'initial'));

  @override
  Stream<PostState> mapEventToState(PostEvent event) async*{

  }

}