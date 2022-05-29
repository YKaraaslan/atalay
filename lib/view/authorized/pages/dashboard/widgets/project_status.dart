part of '../dashboard_view.dart';

class _ProjectsStatus extends StatelessWidget {
  const _ProjectsStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: ServicePath.projectsCollectionReference.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int total = snapshot.data!.docs.length;
          int active = snapshot.data!.docs.where((element) => element.get('status') == 'active').length;
          int finished = snapshot.data!.docs.where((element) => element.get('status') == 'finished').length;

          return _ProjectStatusBody(total: total, active: active, finished: finished);
        } else {
          return Container();
        }
      },
    );
  }
}

class _ProjectStatusBody extends StatelessWidget {
  const _ProjectStatusBody({
    Key? key,
    required this.total,
    required this.active,
    required this.finished,
  }) : super(key: key);

  final int total;
  final int active;
  final int finished;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircularIndicators(total: total, active: active, finished: finished),
        const SizedBox(width: 35),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TotalProject(total: total),
              const SizedBox(
                height: 15,
              ),
              _ActiveProject(active: active),
              const SizedBox(
                height: 15,
              ),
              _FinishedProjects(finished: finished),
            ],
          ),
        )
      ],
    );
  }
}

class _FinishedProjects extends StatelessWidget {
  const _FinishedProjects({
    Key? key,
    required this.finished,
  }) : super(key: key);

  final int finished;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 6),
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.yellow[600],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$finished',
              style: Styles.defaultDateTextStyle(context),
            ),
            Text(
              'Biten Proje',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        )
      ],
    );
  }
}

class _ActiveProject extends StatelessWidget {
  const _ActiveProject({
    Key? key,
    required this.active,
  }) : super(key: key);

  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 6),
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.blue[700],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$active',
              style: Styles.defaultDateTextStyle(context),
            ),
            Text(
              'Aktif Proje',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        )
      ],
    );
  }
}

class _TotalProject extends StatelessWidget {
  const _TotalProject({
    Key? key,
    required this.total,
  }) : super(key: key);

  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 6),
          child: const CircleAvatar(
            radius: 8,
            backgroundColor: Colors.orange,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$total',
              style: Styles.defaultDateTextStyle(context),
            ),
            Text(
              'Toplam Proje',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        )
      ],
    );
  }
}

class _CircularIndicators extends StatelessWidget {
  const _CircularIndicators({
    Key? key,
    required this.total,
    required this.active,
    required this.finished,
  }) : super(key: key);

  final int total;
  final int active;
  final int finished;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _CustomCircularStepProgressIndicator(
          inProgress: total > 0 ? 100 : 0,
          color: Colors.orange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$total',
                style: Styles.defaultDateTextStyle(context),
              ),
              const Text('Toplam Proje'),
            ],
          ),
        ),
        _CustomCircularStepProgressIndicator(
          inProgress: 100 * active ~/ total,
          color: Colors.blue[700],
        ),
        _CustomCircularStepProgressIndicator(
          inProgress: 100 * finished ~/ total,
          color: Colors.yellow[600],
        ),
      ],
    );
  }
}

class _CustomCircularStepProgressIndicator extends StatelessWidget {
  const _CustomCircularStepProgressIndicator({Key? key, required this.inProgress, required this.color, this.child}) : super(key: key);
  final int inProgress;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircularStepProgressIndicator(
      width: Sizes.width_40percent(context),
      height: Sizes.width_40percent(context),
      totalSteps: 100,
      currentStep: inProgress,
      stepSize: 0,
      selectedColor: color,
      unselectedColor: Colors.transparent,
      padding: 0,
      selectedStepSize: 15,
      roundedCap: (_, __) => true,
      child: child,
    );
  }
}
