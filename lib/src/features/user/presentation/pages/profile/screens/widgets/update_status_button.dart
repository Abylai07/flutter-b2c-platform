import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_detail_entity.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/widgets/sent_otp_alert.dart';

import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../widgets/buttons/main_button.dart';
import '../../../../widgets/show_error_snackbar.dart';
import '../../bloc/order_detail.dart';
import '../../bloc/update_status/update_status_cubit.dart';

class UpdateStatusButton extends StatelessWidget {
  const UpdateStatusButton({super.key, required this.entity});

  final OrderDetailEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateStatusCubit, UpdateStatusState>(
      listener: (context, state) {
        TextEditingController controller = TextEditingController();

        if (state.status.isWrongOtp) {
          sentOtpAlert(context, error: true, controller: controller, onTap: () {
            context.read<UpdateStatusCubit>().updateStatus(
                  id: entity.id,
                  status: getNextStatus(entity.status),
                  otp: controller.text,
                );
            Navigator.pop(context);
          });
        } else if (state.status.isNeedOtp) {
          sentOtpAlert(context, error: false, controller: controller,
              onTap: () {
            context.read<UpdateStatusCubit>().updateStatus(
                id: entity.id,
                status: getNextStatus(entity.status),
                otp: controller.text);
            Navigator.pop(context);
          });
        } else if (state.status.isSuccess) {
          context.read<OrderDetailCubit>().fetchOrderDetail(entity.id);
        } else if (state.status.isError) {
          showErrorSnackBar(context, S.of(context).somethingWrong);
        }
      },
      builder: (context, state) {
        return CustomMainButton(
          text: getButtonText(context, entity.status) ?? '',
          isLoading: state.status.isLoading,
          onTap: () {
            String nextStatus = getNextStatus(entity.status);
            if (nextStatus.isNotEmpty) {
              context
                  .read<UpdateStatusCubit>()
                  .updateStatus(id: entity.id, status: nextStatus);
            }
          },
        );
      },
    );
  }

  String getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case 'new':
        return 'accepted';
      case 'accepted':
        return 'in_progress';
      case 'in_progress':
        return 'closed';
      default:
        return '';
    }
  }

  String? getButtonText(BuildContext ctx, String key) {
    final data = {
      'new': 'Принят заказ',
      'accepted': 'Выдать заказ',
      'in_progress': 'Завершить заказ',
    };
    return data[key];
  }
}
