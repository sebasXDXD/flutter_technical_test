import 'package:flutter/material.dart';

class HeaderTabs extends StatelessWidget {
  final String currentRoute;

  const HeaderTabs({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.black.withValues(alpha: 0.3),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            _TabItem(
              label: 'API LIST',
              icon: Icons.public,
              isActive: currentRoute == '/api-list',
              onTap: () {
                if (currentRoute != '/api-list') {
                  Navigator.pushReplacementNamed(context, '/api-list');
                }
              },
            ),
            _TabItem(
              label: 'MIS GUARDADOS',
              icon: Icons.bookmark,
              isActive: currentRoute == '/prefs',
              onTap: () {
                if (currentRoute != '/prefs') {
                  Navigator.pushReplacementNamed(context, '/prefs');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
class _TabItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = Colors.greenAccent;

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: isActive
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              activeColor.withValues(alpha: 0.35),
              activeColor.withValues(alpha: 0.15),
            ],
          )
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: isActive
                        ? activeColor
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: isActive
                          ? activeColor
                          : Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
