import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());

  void signup({required String email, required String password}) async {
    try {
      emit(AuthCubitLoading());
      final user = FirebaseAuth.instance;
      await user.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthCubiSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthCubitfailur(message: e.message!));
    }
  }

  void login({required String email, required String password}) async {
    try {
      emit(AuthCubitLoading());
      final user = FirebaseAuth.instance;
      await user.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthCubiSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthCubitfailur(message: e.message!));
    }
  }

  String get userName {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'Guest';
    return user.displayName ?? user.email ?? 'User';
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(AuthCubitInitial());
  }
}
