import 'package:auth/src/auth_screen/bloc/auth_event.dart';
import 'package:auth/src/auth_screen/bloc/auth_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final Connectivity _connectivity = Connectivity();

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthState.initState()) {
    on<SignInWithEmailAndPasswordEvent>(_signInWithEmailAndPassword);
    on<SignInWithAppleEvent>(_signInWithApple);
    on<SignInWithFacebookEvent>(_signInWithFacebook);
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<RegisterWithEmailAndPasswordEvent>(_registerWithEmailAndPassword);
    on<UpdateUserRegisteredStatusEvent>(_onUpdateUserRegisteredStatusEvent);
    on<UpdateUserNotRegisteredStatusEvent>(_onUpdateUserNotRegisteredStatusEvent);
    on<CheckOfflineModeEvent>(_onCheckOfflineMode);

    _connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          add(
            CheckOfflineModeEvent(
              isInternetAvailable: false,
            ),
          );
        } else {
          add(
            CheckOfflineModeEvent(
              isInternetAvailable: true,
            ),
          );
        }
      },
    );
  }

  void _onUpdateUserRegisteredStatusEvent(
    UpdateUserRegisteredStatusEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        isUserRegistered: true,
      ),
    );
  }

  void _onUpdateUserNotRegisteredStatusEvent(
    UpdateUserNotRegisteredStatusEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        isUserRegistered: false,
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(
    SignInWithEmailAndPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final String _email = event.email;
    final String _password = event.password;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }

    final User? user = await _authRepository.signInWithEmailAndPassword(
      EmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      ),
    );

    if (user == null) {
      Fluttertoast.showToast(
        msg: 'general.cant_sign_in_toast'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _signInWithApple(
    SignInWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signInWithSocial(
      AppleSignIn(),
    );
  }

  Future<void> _signInWithFacebook(
    SignInWithFacebookEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signInWithSocial(
      FacebookSignIn(),
    );
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signInWithSocial(
      GoogleSignIn(),
    );
  }

  Future<void> _registerWithEmailAndPassword(
    RegisterWithEmailAndPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final String _email = event.email;
    final String _password = event.password;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }

    final User? user = await _authRepository.signUpWithEmailAndPassword(
      EmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      ),
    );

    if (user == null) {
      Fluttertoast.showToast(
        msg: 'general.cant_register_toast'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _onCheckOfflineMode(
    CheckOfflineModeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        isInternetAvailable: event.isInternetAvailable,
      ),
    );
  }
}
