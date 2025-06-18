import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? rightIcon;
  final VoidCallback? onRightPressed;
  final bool showMonth;
  final String monthText;


  const TopAppBar({
    super.key,
    this.rightIcon,
    this.onRightPressed,
    this.showMonth = false,
    this.monthText = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        children: const [
          Text('Всі рахунки', style: TextStyle(fontSize: 12, color: Colors.black54)),
          Text('0 ₴', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
      centerTitle: true,
      leading: const Icon(Icons.account_circle_outlined, color: Colors.black87),
      actions: [
        IconButton(
          icon: rightIcon ?? const Icon(Icons.edit, color: Colors.black87),
          onPressed: onRightPressed,
        ),
      ],
      bottom: showMonth
          ? PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 6),
                  Text(monthText,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight +                          // 56 px
        (showMonth ? 48 : 0),                     // высота блока месяца
  );

}
