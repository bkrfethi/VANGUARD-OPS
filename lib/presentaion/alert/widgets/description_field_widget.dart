import 'package:flutter/material.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';

class DescriptionFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const DescriptionFieldWidget({
    this.controller,
    this.hintText = 'Type Here...',
    this.onChanged,
    super.key,
  });

  @override
  State<DescriptionFieldWidget> createState() => _DescriptionFieldWidgetState();
}

class _DescriptionFieldWidgetState extends State<DescriptionFieldWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AlertDimensions.paddingM),
      decoration: BoxDecoration(
        color: AlertColors.darkSurface,
        borderRadius: BorderRadius.circular(AlertDimensions.radiusM),
        border: AlertBorders.subtle,
        boxShadow: AlertShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: AlertColors.textSecondary, size: AlertDimensions.iconXS),
              SizedBox(width: AlertDimensions.paddingS),
              Text(
                'Description',
                style: TextStyle(
                  color: AlertColors.textPrimary,
                  fontSize: AlertTypography.sizeM,
                  fontWeight: AlertTypography.weightSemiBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AlertDimensions.paddingS),
          Text(
            'Give a quick brief.',
            style: TextStyle(
              color: AlertColors.textSecondary,
              fontSize: AlertTypography.sizeS,
            ),
          ),
          const SizedBox(height: AlertDimensions.paddingM),
          TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            maxLines: 4,
            minLines: 3,
            style: const TextStyle(
              color: AlertColors.textPrimary,
              fontSize: AlertTypography.sizeM,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: AlertColors.textTertiary,
                fontSize: AlertTypography.sizeM,
              ),
              filled: true,
              fillColor: AlertColors.darkInput,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AlertDimensions.paddingM,
                vertical: AlertDimensions.paddingS,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AlertDimensions.radiusS),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AlertDimensions.radiusS),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AlertDimensions.radiusS),
                borderSide: const BorderSide(
                  color: AlertColors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
