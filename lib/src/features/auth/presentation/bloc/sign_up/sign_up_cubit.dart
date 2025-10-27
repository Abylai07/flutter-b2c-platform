import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import '../../../../../common/utils/firebase_api/notifications.dart';
import '../../../../../common/utils/shared_preference.dart';
import '../../../../../domain/usecase/user/sign_up_usecase.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signDataUseCase, this.signOtpUseCase, this.signCodeUseCase,
      this.signPasswordUseCase)
      : super(const SignUpState());

  final SignOtpUseCase signOtpUseCase;
  final SignVerifyUseCase signCodeUseCase;
  final SignDataUseCase signDataUseCase;
  final SignPasswordUseCase signPasswordUseCase;


  void signUpOtp(Map<String, dynamic> data) async {
    emit(const SignUpState(status: SignUpStatus.loading));

    final failureOrAuth = await signOtpUseCase(MapParams(data));

    emit(
      failureOrAuth.fold(
        (l) => SignUpState(
          status: SignUpStatus.errorOtp,
          message: l.message,
        ),
        (r) {
          if (r['authorized'] == false) {
            return SignUpState(
              status: SignUpStatus.successOtp,
              entity: r,
            );
          } else {
            return const SignUpState(
              status: SignUpStatus.errorOtp,
              message: 'authorized',
            );
          }
        },
      ),
    );
  }

  void signUpVerify(Map<String, dynamic> data) async {
    emit(const SignUpState(status: SignUpStatus.loading));

    final failureOrAuth = await signCodeUseCase(MapParams(data));

    if (failureOrAuth.isRight()) {
      final data = failureOrAuth.toOption().toNullable();
    }
    emit(
      failureOrAuth.fold(
          (l) => SignUpState(
                status: SignUpStatus.errorVerify,
                message: l.message,
              ), (r) {
        SharedPrefs().setAccessToken(r.token);
        SharedPrefs().setRefreshToken(r.refreshToken);
        Notifications().init(r.token);
        return const SignUpState(
          status: SignUpStatus.successVerify,
          entity: {},
        );
      }),
    );
  }

  void signUpData(Map<String, dynamic> data) async {
    emit(const SignUpState(status: SignUpStatus.loading));

    final failureOrAuth = await signDataUseCase(MapParams(data));

    emit(
      failureOrAuth.fold(
        (l) => SignUpState(
          status: SignUpStatus.errorData,
          message: l.message,
        ),
        (r) => const SignUpState(
          status: SignUpStatus.successData,
          entity: {},
        ),
      ),
    );
  }

  void signUpPassword(Map<String, dynamic> data) async {
    emit(const SignUpState(status: SignUpStatus.loading));

    final failureOrAuth = await signPasswordUseCase(MapParams(data));

    emit(
      failureOrAuth.fold(
        (l) => SignUpState(
          status: SignUpStatus.errorPassword,
          message: l.message,
        ),
        (r) => SignUpState(
          status: SignUpStatus.successPassword,
          entity: r,
        ),
      ),
    );
  }
}
