import 'package:app/src/blocs/theme/state.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent();

  @override
  List<Object> get props => [];
}

class SwitchTheme extends ThemeEvent {
  ThemeEnum theme;

  SwitchTheme({@required this.theme});
}
