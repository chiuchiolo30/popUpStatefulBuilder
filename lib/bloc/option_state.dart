part of 'option_bloc.dart';

class OptionState extends Equatable {
  final int option;
  const OptionState({required this.option});
  
  @override
  List<Object> get props => [ option ];

  OptionState copyWith({int? option}) => OptionState(option : option ?? this.option);
}

class BlocInitial extends OptionState {

  const BlocInitial() : super(option: 0);

}
