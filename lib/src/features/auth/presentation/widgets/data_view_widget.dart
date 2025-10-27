// import 'package:flutter/material.dart';
// import 'package:b2c_platform/src/common/enums.dart';
//
// import '../../../../../common/utils/l10n/generated/l10n.dart';
// import '../../../../../common/utils/parsers/date_parser.dart';
// import '../../../../widgets/custom_text_field.dart';
//
// class DataViewWidget extends StatelessWidget {
//   const DataViewWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         20.height,
//         CustomTextFieldWidget(
//           readOnly: true,
//           initialValue: AppUtils.phoneMaskFormatter.getMaskedText(),
//           hintText: S.of(context).phoneNumber,
//           inputFormatters: [AppUtils.phoneMaskFormatter],
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12.0),
//           child: CustomTextFieldWidget(
//             hintText: S.of(context).name,
//           ),
//         ),
//         CustomTextFieldWidget(
//           hintText: S.of(context).surname,
//         ),
//         12.height,
//         CustomTextFieldWidget(
//           hintText: S.of(context).birthday,
//         ),
//       ],
//     );
//   }
// }
