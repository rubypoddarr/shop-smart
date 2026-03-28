import 'package:flutter/material.dart';
import '../../widgets/title_text.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(label: "Admin Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // Profile Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? Colors.white30 : primaryColor, 
                            width: 2
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey.shade800 : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              color: isDark ? Colors.white70 : primaryColor, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Admin User",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "admin@shopsmart.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Info Tiles Section
            _buildInfoSection(
              context,
              title: "Personal Information",
              tiles: [
                _buildInfoTile(
                  context,
                  icon: Icons.person_outline,
                  label: "Name",
                  value: "Admin User",
                ),
                _buildInfoTile(
                  context,
                  icon: Icons.email_outlined,
                  label: "Email",
                  value: "admin@shopsmart.com",
                ),
                _buildInfoTile(
                  context,
                  icon: Icons.phone_outlined,
                  label: "Phone",
                  value: "+92 300 0000000",
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            _buildInfoSection(
              context,
              title: "App Settings",
              tiles: [
                _buildInfoTile(
                  context,
                  icon: Icons.admin_panel_settings_outlined,
                  label: "Role",
                  value: "Super Admin",
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context,
      {required String title, required List<Widget> tiles}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Column(
            children: tiles,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(
        icon, 
        color: isDark ? Colors.white70 : Theme.of(context).primaryColor, 
        size: 22
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.white38 : Colors.grey.shade600,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
    );
  }
}
