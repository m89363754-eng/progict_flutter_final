part of 'auth_cubit_cubit.dart';

sealed class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object> get props => [];
}

final class AuthCubitInitial extends AuthCubitState {}

final class AuthCubiSuccess extends AuthCubitState {}

final class AuthCubitfailur extends AuthCubitState {
  final String message;

  const AuthCubitfailur({required this.message});
}

final class AuthCubitLoading extends AuthCubitState {}
