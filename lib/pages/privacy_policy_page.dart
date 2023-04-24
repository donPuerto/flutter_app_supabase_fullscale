import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: const [
          Text(
            'Our Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod bibendum enim vel elementum. Sed ultrices semper tellus, eu maximus velit aliquam non. Sed non urna erat. Proin efficitur arcu sed sollicitudin dignissim. Nulla facilisi. Praesent blandit tristique leo, ut consequat nibh elementum in. Duis ultricies, mauris ac maximus dignissim, velit lectus lobortis lacus, vel consectetur mauris ipsum nec metus. Mauris quis lorem eget metus bibendum facilisis quis vitae sapien. Aenean efficitur massa vitae ex scelerisque, quis aliquam tortor consectetur. Fusce lacinia erat velit, ut feugiat quam eleifend at. Curabitur vel consequat mauris.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Information Collection and Use',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod bibendum enim vel elementum. Sed ultrices semper tellus, eu maximus velit aliquam non. Sed non urna erat. Proin efficitur arcu sed sollicitudin dignissim. Nulla facilisi. Praesent blandit tristique leo, ut consequat nibh elementum in. Duis ultricies, mauris ac maximus dignissim, velit lectus lobortis lacus, vel consectetur mauris ipsum nec metus. Mauris quis lorem eget metus bibendum facilisis quis vitae sapien. Aenean efficitur massa vitae ex scelerisque, quis aliquam tortor consectetur. Fusce lacinia erat velit, ut feugiat quam eleifend at. Curabitur vel consequat mauris.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Log Data',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod bibendum enim vel elementum. Sed ultrices semper tellus, eu maximus velit aliquam non. Sed non urna erat. Proin efficitur arcu sed sollicitudin dignissim. Nulla facilisi. Praesent blandit tristique leo, ut consequat nibh elementum in. Duis ultricies, mauris ac maximus dignissim, velit lectus lobort is lacus, vel consectetur mauris ipsum nec metus. Mauris quis lorem eget metus bibendum facilisis quis vitae sapien. Aenean efficitur massa vitae ex scelerisque, quis aliquam tortor consectetur. Fusce lacinia erat velit, ut feugiat quam eleifend at. Curabitur vel consequat mauris.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Changes to This Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod bibendum enim vel elementum. Sed ultrices semper tellus, eu maximus velit aliquam non. Sed non urna erat. Proin efficitur arcu sed sollicitudin dignissim. Nulla facilisi. Praesent blandit tristique leo, ut consequat nibh elementum in. Duis ultricies, mauris ac maximus dignissim, velit lectus lobortis lacus, vel consectetur mauris ipsum nec metus. Mauris quis lorem eget metus bibendum facilisis quis vitae sapien. Aenean efficitur massa vitae ex scelerisque, quis aliquam tortor consectetur. Fusce lacinia erat velit, ut feugiat quam eleifend at. Curabitur vel consequat mauris.',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
