import 'package:flutter/material.dart';
import 'package:katolika/model/color.dart';

class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const HeaderBar({super.key});

  @override
  State<HeaderBar> createState() => _HeaderBarState();
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _HeaderBarState extends State<HeaderBar> {
  late TextStyle style;
  FocusNode focusNode = FocusNode();
  bool isSearching = false;
  late Widget appBarTitle;
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    isSearching = false;
    style = const TextStyle(color: primaryLight);
    appBarTitle = IconButton(
      onPressed: () {},
      icon: Image.asset(
        'assets/images/ic_launcher1.png',
        height: 52,
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: appBarTitle,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Image.asset(
          'assets/images/icons/menu-alt-1.png',
          height: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(actionIcon.icon, color: primaryLight),
          onPressed: () {
            if (actionIcon.icon == Icons.search) {
              actionIcon = const Icon(Icons.close, color: primaryLight);
              appBarTitle = TextField(
                focusNode: focusNode,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(color: primaryLight, fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryLight)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryLight)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 5.1),
                  ),
                  prefixIcon: const Icon(Icons.search, color: primaryLight),
                  hintText: "Teny ho tadiavina",
                  hintStyle: const TextStyle(
                    color: primaryLight,
                    fontWeight: FontWeight.normal,
                  ),
                  constraints: const BoxConstraints(
                    maxHeight: 40.0,
                  ),
                  contentPadding: const EdgeInsets.only(left: 16.0),
                ),
              );
              setState(() {
                isSearching = true;
              });
            } else {
              setState(() {
                actionIcon = const Icon(Icons.search, color: primaryLight);
                appBarTitle = IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/ic_launcher1.png',
                    height: 52,
                  ),
                );
                isSearching = false;
              });
            }
            FocusScope.of(context).requestFocus(focusNode);
          },
        ),
      ],
      backgroundColor: primary,
    );
  }
}
