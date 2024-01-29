import 'app_export.dart';

class PokiesController {
  const PokiesController({
    required this.start,
    required this.stop,
  });

  final Function({required int? hitRollItemIndex}) start;
  final Function({required int reelIndex}) stop;
}

class Pokies extends StatefulWidget {
  const Pokies({
    Key? key,
    required this.rollItems,
    this.multiplyNumberOfSlotItems = 2,
    this.shuffle = true,
    this.width = 232,
    this.height = 96,
    this.reelWidth = 72,
    this.reelHeight = 96,
    this.reelItemExtent = 48,
    this.reelSpacing = 8,
    required this.onCreated,
    required this.onFinished,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final int multiplyNumberOfSlotItems;
  final bool shuffle;
  final double width;
  final double height;
  final double reelWidth;
  final double reelHeight;
  final double reelItemExtent;
  final double reelSpacing;
  final Function(PokiesController) onCreated;
  final Function(List<int> resultIndexes) onFinished;

  @override
  State<Pokies> createState() => _PokiesState();
}

class _PokiesState extends State<Pokies> {
  late PokiesController _slotMachineController;

  Map<int, _ReelController> _reelControllers = {};
  List<RollItem> _actualRollItems = [];
  List<int> _resultIndexes = [];
  int _stopCounter = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.multiplyNumberOfSlotItems; i++) {
      _actualRollItems.addAll([...widget.rollItems]);
    }

    _slotMachineController = PokiesController(
      start: _start,
      stop: _stop,
    );

    widget.onCreated(_slotMachineController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _Reel(
              reelWidth: widget.reelWidth,
              reelHeight: widget.reelHeight,
              itemExtent: widget.reelItemExtent,
              rollItems: _actualRollItems,
              shuffle: widget.shuffle,
              onCreated: (lc) => _reelControllers[0] = lc,
            ),
            SizedBox(width: widget.reelSpacing),
            _Reel(
              reelWidth: widget.reelWidth,
              reelHeight: widget.reelHeight,
              itemExtent: widget.reelItemExtent,
              rollItems: _actualRollItems,
              shuffle: widget.shuffle,
              onCreated: (lc) => _reelControllers[1] = lc,
            ),
            SizedBox(width: widget.reelSpacing),
            _Reel(
              reelWidth: widget.reelWidth,
              reelHeight: widget.reelHeight,
              itemExtent: widget.reelItemExtent,
              rollItems: _actualRollItems,
              shuffle: widget.shuffle,
              onCreated: (lc) => _reelControllers[2] = lc,
            ),
            SizedBox(width: widget.reelSpacing),
            _Reel(
              reelWidth: widget.reelWidth,
              reelHeight: widget.reelHeight,
              itemExtent: widget.reelItemExtent,
              rollItems: _actualRollItems,
              shuffle: widget.shuffle,
              onCreated: (lc) => _reelControllers[3] = lc,
            ),
          ],
        ),
      ],
    );
  }

  _start({required int? hitRollItemIndex}) {
    _stopCounter = 0;
    _resultIndexes = [];

    final win = hitRollItemIndex != null;
    if (win) {
      final index = hitRollItemIndex;
      if (index == null) return;
      _resultIndexes.addAll([index, index, index, index]);
    } else {
      _resultIndexes = _randomResultIndexes(widget.rollItems.length);
    }
    _reelControllers.forEach((key, _) => _reelControllers[key]!.start());
  }

  _stop({required int reelIndex}) {
    assert(reelIndex >= 0 && reelIndex <= 4);

    final lc = _reelControllers[reelIndex];
    if (lc == null) return;

    lc.stop(to: _resultIndexes[reelIndex]);

    _stopCounter++;
    if (_stopCounter == 4) {
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onFinished(_resultIndexes);
      });
    }
  }

  List<int> _randomResultIndexes(int length) {
    bool ok = false;
    List<int> _indexes = [];
    while (!ok) {
      final arr = [
        Random().nextInt(length),
        Random().nextInt(length),
        Random().nextInt(length),
        Random().nextInt(length)
      ];
      if (arr[0] != arr[1] ||
          arr[0] != arr[2] ||
          arr[0] != arr[3] ||
          arr[1] != arr[2] ||
          arr[1] != arr[3] ||
          arr[2] != arr[3]) {
        _indexes = arr;
        ok = true;
      }
    }
    return _indexes;
  }
}

class _ReelController {
  const _ReelController({
    required this.start,
    required this.stop,
  });

  final Function start;
  final Function({required int to}) stop;
}

class _Reel extends StatefulWidget {
  const _Reel({
    Key? key,
    required this.rollItems,
    required this.reelWidth,
    required this.reelHeight,
    required this.itemExtent,
    this.shuffle = true,
    required this.onCreated,
    this.imageWidget,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final double reelWidth;
  final double reelHeight;
  final double itemExtent;
  final bool shuffle;
  final Widget? imageWidget;

  final Function(_ReelController) onCreated;

  @override
  State<_Reel> createState() => __ReelState();
}

class __ReelState extends State<_Reel> {
  late Timer timer;
  late _ReelController _laneController;
  final _scrollController = FixedExtentScrollController(initialItem: 0);
  final _sliderController = CarouselController();

  int counter = 0;
  List<RollItem> _actualRollItems = [];

  @override
  void initState() {
    super.initState();

    _actualRollItems = widget.rollItems;

    if (widget.shuffle) _actualRollItems.shuffle();

    _laneController = _ReelController(
      start: _start,
      stop: _stop,
    );
    widget.onCreated(_laneController);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(0),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Container(
          //color: Colors.white,
          width: widget.reelWidth,
          height: widget.reelHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.imageWidget ?? Container(),
              //  Container( decoration: AppDecoration.gradientTealToGreen.copyWith(borderRadius: BorderRadius.circular(30)),),
              Container(
                decoration: AppDecoration.gradientTealToGreen
                    .copyWith(borderRadius: BorderRadius.circular(20)),
                child: CarouselSlider.builder(
                  disableGesture: true,
                  carouselController: _sliderController,
                  options: CarouselOptions(
                      height: 350,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 0.5),
                  itemCount: _actualRollItems.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                          width: widget.reelWidth,
                          height: widget.itemExtent,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: AppDecoration.circleAround(itemIndex == 0,
                              color: appTheme.green),
                          child:
                              Center(child: _actualRollItems[itemIndex].child)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _start() {
    counter = 0;
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _sliderController.animateToPage(
        counter,
        duration: Duration(milliseconds: 50),
        curve: Curves.linear,
      );
      counter--;
    });
  }

  _stop({required int to}) {
    timer.cancel();
    final hitItemIndex =
        _actualRollItems.indexWhere((item) => item.index == to);

    final mod = (-counter) % _actualRollItems.length - 1;
    final addCount = (_actualRollItems.length - mod) +
        (_actualRollItems.length - hitItemIndex) -
        1;

    _sliderController.animateToPage(
      counter - addCount,
      duration: const Duration(milliseconds: 750),
      curve: Curves.decelerate,
    );
  }
}

class RollItem {
  const RollItem({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;
}
