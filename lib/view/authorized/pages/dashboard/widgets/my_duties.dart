part of '../dashboard_view.dart';

class _MyDuties extends StatelessWidget {
  const _MyDuties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: ListTile(
                  title: Text('Dashboard Design'),
                  subtitle: LinearProgressIndicator(value: 0.5),
                ),
              ),
              const SizedBox(width: 20),
              const _CustomCircleAvatar(
                url: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
              ),
              const SizedBox(width: 5),
              const _CustomCircleAvatar(
                url: 'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D',
              ),
              const SizedBox(width: 5),
              const _CustomCircleAvatar(
                url: 'https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg',
              ),
              const SizedBox(width: 10),
              IconButton(onPressed: () => true, icon: const Icon(Icons.chevron_right))
            ],
          ),
        );
      },
    );
  }
}

class _CustomCircleAvatar extends StatelessWidget {
  const _CustomCircleAvatar({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundImage: NetworkImage(url),
    );
  }
}
