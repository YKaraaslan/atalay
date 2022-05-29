part of '../dashboard_view.dart';

class _Announcement extends StatelessWidget {
  const _Announcement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: ServicePath.announcementCollectionReference.orderBy('createdAt', descending: true).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          AnnouncementModel model = AnnouncementModel.fromJson(snapshot.data!.docs.first.data() as Map<String, Object?>);
          return _AnnouncementBody(model: model);
        }
        return Container();
      },
    );
  }
}

class _AnnouncementBody extends StatelessWidget {
  const _AnnouncementBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AnnouncementModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: AppPaddings.appPadding,
          decoration: BoxDecoration(
              color: context.read<DarkThemeProvider>().darkTheme ? Theme.of(context).cardColor : const Color.fromARGB(255, 213, 231, 247), borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Duyuru',
                    style: Styles.cardTitleStyle(),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(Assets.megaphone, width: 20),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(model.text),
              const SizedBox(
                height: 10,
              ),
              _Author(model: model),
            ],
          ),
        ),
        const _Button(),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.read<AuthProvider>().announcementsCreate,
      child: Consumer<DashboardViewModel>(
        builder: (context, viewmodel, child) => Align(
          alignment: Alignment.topRight,
          child: OutlinedButton(
            onPressed: () => viewmodel.addAnnouncement(context),
            child: const Text('Duyuru Ekle'),
          ),
        ),
      ),
    );
  }
}

class _Author extends StatelessWidget {
  const _Author({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AnnouncementModel model;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: ServicePath.usersCollectionReference.doc(model.createdBy).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel userModel = UserModel.fromJson(snapshot.data!.data() as Map<String, Object?>);
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userModel.imageURL),
                radius: 10,
              ),
              const SizedBox(width: 10),
              Text(
                userModel.fullName,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 10),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
