import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/models/user_model.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import 'add_to_team_viewmodel.dart';

class AddToTeam extends StatelessWidget {
  const AddToTeam({Key? key, required this.userReceivedList, this.multiSelection = true}) : super(key: key);
  final List<UserModel> userReceivedList;
  final bool multiSelection;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'choose_for_team'.tr(),
        actions: const [SizedBox()],
      ),
      onPageBuilder: (context, value) => _Body(userReceivedList: userReceivedList, multiSelection: multiSelection),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.userReceivedList, required this.multiSelection}) : super(key: key);
  final List<UserModel> userReceivedList;
  final bool multiSelection;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final AddToTeamViewModel _viewModel = context.read<AddToTeamViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.userModels = [];
    _viewModel.selectedUsers = widget.userReceivedList;
    if (!widget.multiSelection) {
      _viewModel.selectedUsers = [];
    }
    _viewModel.getUsers();
  }

  bool isSelected(AddToTeamViewModel _viewModel, int index) {
    return _viewModel.selectedUsers.any((element) => element.id == _viewModel.userModels[index].id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AddToTeamViewModel _viewModel, child) {
        if (_viewModel.userModels.isEmpty) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) => const _ShimmerEffect(),
          );
        }
        return Stack(
          children: [
            ListView.builder(
              itemCount: _viewModel.userModels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if (widget.multiSelection) {
                      return _viewModel.selectUser(index);
                    } else {
                      _viewModel.selectedUsers = [];
                      _viewModel.selectUser(index);
                      return Navigator.pop(context, _viewModel.selectedUsers);
                    }
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_viewModel.userModels[index].imageURL),
                  ),
                  title: isSelected(_viewModel, index)
                      ? Text(
                          _viewModel.userModels[index].fullName,
                          style: const TextStyle(color: Colors.blue),
                        )
                      : Text(_viewModel.userModels[index].fullName),
                  subtitle: isSelected(_viewModel, index)
                      ? Text(
                          _viewModel.userModels[index].position,
                          style: TextStyle(color: Colors.blue[300]),
                        )
                      : Text(_viewModel.userModels[index].position),
                  trailing: isSelected(_viewModel, index)
                      ? const Icon(
                          Icons.check,
                          color: Colors.blue,
                        )
                      : const SizedBox(),
                );
              },
            ),
            Visibility(
              visible: widget.multiSelection,
              child: Positioned(
                bottom: 10,
                left: 100,
                right: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _viewModel.selectedUsers);
                  },
                  child: Text(
                    _viewModel.selectedUsers.length.toString() + " kisi sec",
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: AnimatedShimmer.round(
              size: 45,
            ),
            title: const AnimatedShimmer(
              height: 10,
              width: 10,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            subtitle: const AnimatedShimmer(
              height: 10,
              width: 100,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey.shade100,
          ),
        ],
      ),
    );
  }
}