import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<bool> {
  AuthCubit() : super(false);

  void changeAuth({required bool showLogin}) => emit(showLogin);
}
