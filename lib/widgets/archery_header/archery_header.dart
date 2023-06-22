import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

const kDefaultArcheryTriggerOffset = 200.0;

class ArcheryHeader extends Header {
  const ArcheryHeader({
    super.triggerOffset = kDefaultArcheryTriggerOffset,
    super.clamping = false,
    super.position = IndicatorPosition.above,
    super.processedDuration = Duration.zero,
    super.springRebound = false,
    super.hapticFeedback = false,
    super.safeArea = false,
    super.spring,
    super.readySpringBuilder,
    super.frictionFactor,
    super.infiniteOffset,
    super.hitOver,
    super.infiniteHitOver,
  });

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _ArcheryIndicator(
      state: state,
      reverse: state.reverse,
    );
  }
}

class _ArcheryIndicator extends StatefulWidget {
  //Indicator properties and state
  final IndicatorState state;

  //True for up and left & False for down and right
  final bool reverse;

  const _ArcheryIndicator({
    Key? key,
    required this.state,
    required this.reverse,
  }) : super(key: key);

  @override
  State<_ArcheryIndicator> createState() => __ArcheryIndicatorState();
}

class __ArcheryIndicatorState extends State<_ArcheryIndicator> {
  double get _offset => widget.state.offset;
  IndicatorMode get _mode => widget.state.mode;
  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  SMINumber? pull;
  SMITrigger? advance;
  StateMachineController? controller;
  RiveFile? _riveFile;

  @override
  void initState() {
    super.initState();
    widget.state.notifier.addModeChangeListener(_onModeChange);
    _loadRiveFile();
  }

  _loadRiveFile() {
    rootBundle
        .load('assets/animations/pull_to_refresh.riv')
        .then((value) async {
      setState(() {
        _riveFile = RiveFile.import(value);
      });
    });
  }

  @override
  void dispose() {
    widget.state.notifier.removeModeChangeListener(_onModeChange);
    controller?.dispose();
    super.dispose();
  }

  void _onModeChange(IndicatorMode mode, double offset) {
    switch (mode) {
      case IndicatorMode.drag:
        controller?.isActive = true;
        break;
      case IndicatorMode.ready:
        advance?.fire();
        break;
      case IndicatorMode.processed:
        advance?.fire();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_mode == IndicatorMode.drag || _mode == IndicatorMode.armed) {
      final percentage = (_offset / _actualTriggerOffset).clamp(0.0, 1.1) * 100;
      pull?.value = percentage;
    }
    return Container(
      width: SizeConfig.screenWidth,
      height: _offset,
      color: kPrimaryColor,
      child: (_offset > 0 && _riveFile != null)
          ? RiveAnimation.direct(
              _riveFile!,
              artboard: 'Bullseye',
              fit: BoxFit.cover,
              onInit: (artboard) {
                controller = StateMachineController.fromArtboard(
                    artboard, 'numberSimulation')!;
                controller?.isActive = false;
                if (controller == null) {
                  throw Exception(
                      'Unable to initialize state machine controller');
                }
                artboard.addController(controller!);
                pull = controller!.findInput<double>('pull') as SMINumber;
                advance = controller!.findInput<bool>('advance') as SMITrigger;
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
