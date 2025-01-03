

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:spotify/business/entities/song.dart';
import 'package:spotify/business/usecases/song/get_news_songs.dart';

import '../../../core/configs/constants/status.dart';
import '../../../service_locator.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc(): super (const HomeState()){
    on<FetchNewsSongs>(_fetchNewsSongs);
  }

  void _fetchNewsSongs(FetchNewsSongs event, Emitter<HomeState> emit) async {
    var result= await sL<GetNewsSongsUseCase>().call();
    result.fold(
        (l){
          print(l);
          emit(state.copyWith(status:Status.error,message: l));
        },
        (r){
          print(r);
          emit(state.copyWith(status: Status.sucess, songs: r));
        }
    );
  }

}
