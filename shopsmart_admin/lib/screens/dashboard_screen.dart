import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin_en/models/dashboard_button_model.dart';
import 'package:shopsmart_admin_en/widgets/dashboard_buttons.dart';
import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/title_text.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(label: "Admin Panel"),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.setDarkTheme(
                  themeValue: !themeProvider.getIsDarkTheme);
            },
            icon: Icon(themeProvider.getIsDarkTheme
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back,",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const Text(
                    "Admin Dashboard",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildSummaryCard(
                        context,
                        title: "Total Products",
                        value: "144",
                        icon: Icons.inventory_2_outlined,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 15),
                      _buildSummaryCard(
                        context,
                        title: "Total Orders",
                        value: "45",
                        icon: Icons.shopping_bag_outlined,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TitlesTextWidget(label: "Management"),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                DashboardButtonsModel.dashboardButtonList(context).length,
                (index) {
                  final button = DashboardButtonsModel.dashboardButtonList(context)[index];
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  // Tint User/Profile icon ONLY in dark mode
                  Color? iconColor;
                  if (isDark && button.imagePath == AssetsManager.user) {
                    iconColor = Colors.white;
                  }
                  return DashboardButtonsWidget(
                    text: button.text,
                    imagePath: button.imagePath,
                    onPressed: button.onPressed,
                    iconColor: iconColor,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context,
      {required String title,
      required String value,
      required IconData icon,
      required Color color}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
