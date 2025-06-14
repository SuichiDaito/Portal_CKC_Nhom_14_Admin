import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarNavigationHomePage extends StatefulWidget {
  final Widget child;
  AppBarNavigationHomePage({super.key, required this.child});
  @override
  State<AppBarNavigationHomePage> createState() => _AppBarNavigationHomePage();
}

class _AppBarNavigationHomePage extends State<AppBarNavigationHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBarHomePage(),
      body: widget.child,
    );
  }

  PreferredSizeWidget _buildAppBarHomePage() {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      toolbarHeight: 75,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade600],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info section
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white, size: 24),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nguyễn Văn B',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Trưởng khoa CNTT',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
