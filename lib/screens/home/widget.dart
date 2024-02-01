import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_scout/service/loading.dart';

import '../../bloc/repo_bloc.dart';
import '../../config/routes.dart';
import '../../constants/app_constants.dart';
import '../../models/repo.dart';
import '../../widgets/option_widget.dart';
import '../../widgets/owner_widget.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
    required this.repo,
  });

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade700,
      ),
      child: Text(repo.language!,
          style: const TextStyle(
            fontSize: 12,
          )),
    );
  }
}

class RepoContainer extends StatelessWidget {
  final Repo repo;
  const RepoContainer({
    super.key,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.details, arguments: repo);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade800,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OwnerWidget(owner: repo.owner),
              vGap5,
              Text(
                repo.name,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: titleStyle,
              ),
              vGap5,
              Text(
                repo.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
              vGap5,
              Row(
                children: [
                  StarGazerWidget(
                    stargazersCount: repo.stargazersCount,
                  ),
                  hGap10,
                  if (repo.language != null) LanguageWidget(repo: repo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}

enum SortType { stars, forks, updated }

enum OrderType { asc, desc }

class MyPopupMenuButton extends StatefulWidget {
  final String sort;
  final String order;
  const MyPopupMenuButton({super.key, required this.sort, required this.order});

  @override
  State<MyPopupMenuButton> createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  List<bool> selectedValues = [false, false, false, false, false];

  SortType getSortType(String value) {
    switch (value) {
      case 'stars':
        return SortType.stars;
      case 'forks':
        return SortType.forks;
      case 'updated':
        return SortType.updated;
      default:
        return SortType.stars;
    }
  }

  OrderType getOrderType(String value) {
    switch (value) {
      case 'asc':
        return OrderType.asc;
      case 'desc':
        return OrderType.desc;
      default:
        return OrderType.desc;
    }
  }

  String getSortValue(SortType sortType) {
    switch (sortType) {
      case SortType.stars:
        return 'stars';
      case SortType.forks:
        return 'forks';
      case SortType.updated:
        return 'updated';
      default:
        return 'stars';
    }
  }

  late SortType _sortType;
  late OrderType _orderType;

  @override
  void initState() {
    _sortType = getSortType(widget.sort);
    _orderType = getOrderType(widget.order);
    setState(() {
      selectedValues[_sortType.index] = true;
      selectedValues[SortType.values.length + _orderType.index] = true;
      log("${SortType.values.length + _orderType.index}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: PopupMenuButton<int>(
        itemBuilder: (context) => <PopupMenuEntry<int>>[
          CheckedPopupMenuItem<int>(
            value: 0,
            checked: selectedValues[0],
            child: const Text('Stars'),
          ),
          CheckedPopupMenuItem<int>(
            value: 1,
            checked: selectedValues[1],
            child: const Text('Forks'),
          ),
          CheckedPopupMenuItem<int>(
            value: 2,
            checked: selectedValues[2],
            child: const Text('Updated'),
          ),
          const PopupMenuDivider(),
          CheckedPopupMenuItem<int>(
            value: 3,
            checked: selectedValues[3],
            child: const Text('Ascending'),
          ),
          CheckedPopupMenuItem<int>(
            value: 4,
            checked: selectedValues[4],
            child: const Text('Descending'),
          ),
        ],
        onSelected: (value) {
          setState(() {
            if (value < SortType.values.length) {
              _sortType = SortType.values[value];
              for (int i = 0; i < SortType.values.length; i++) {
                if (i != value) {
                  selectedValues[i] = false;
                } else {
                  selectedValues[i] = true;
                }
              }
            } else {
              int orderIndex = value - SortType.values.length;
              log("order index : $orderIndex");
              _orderType = (orderIndex == 0) ? OrderType.asc : OrderType.desc;
              log("value : $value");
              selectedValues[value] = true;

              (_orderType == OrderType.asc)
                  ? selectedValues[value + 1] = false
                  : selectedValues[value - 1] = false;
            }

            // * TODO: Add loading
            //Loading.dismiss(context);
           
            context.read<RepoBloc>().add(SortRepo(
                  sort: getSortValue(_sortType),
                  order: _orderType == OrderType.asc ? 'asc' : 'desc',
                ));
          });

          // * TODO: Dismiss loading
          //Loading.dismiss(context);
          
        },
        icon: const Icon(Icons.sort),
      ),
    );
  }
}
