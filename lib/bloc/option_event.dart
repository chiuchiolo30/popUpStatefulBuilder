part of 'option_bloc.dart';

abstract class OptionEvent extends Equatable {
  const OptionEvent();

  @override
  List<Object> get props => [];
}

class ChangeOption extends OptionEvent {}
class StateInitial extends OptionEvent {}
