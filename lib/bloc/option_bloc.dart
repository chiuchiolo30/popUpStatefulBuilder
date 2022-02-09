import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'option_event.dart';
part 'option_state.dart';

class OptionBloc extends Bloc<OptionEvent, OptionState> {
  OptionBloc() : super(const BlocInitial()) {
  
    on<ChangeOption>((_, emit) async {
      emit(state.copyWith(option: 1));
      await Future.delayed( const Duration(milliseconds: 1500), () => emit(state.copyWith(option: 2 + Random().nextInt(2) ) ) );
    });

    on<StateInitial>((_, emit) => emit(state.copyWith(option: 0)));


  }
}
