

// History Orders Fragment
import 'package:flutter/cupertino.dart';

import '../helper/FontsConstants.dart';
import '../helper/colors.dart' as Colors;

class HistoryOrdersFragment extends StatelessWidget {
  const HistoryOrdersFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'No history orders',
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
