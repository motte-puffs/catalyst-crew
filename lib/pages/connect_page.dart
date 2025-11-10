import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/Util/colors.dart';

class LetsConnectPage extends StatefulWidget {
  const LetsConnectPage({super.key});

  @override
  State<LetsConnectPage> createState() => _LetsConnectPageState();
}

class _LetsConnectPageState extends State<LetsConnectPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool isLoading = false;

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade700),
  );

  /// Save message directly to Firebase Firestore
  Future<void> sendMessage() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields!')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Add document to Firestore collection "contacts"
      await FirebaseFirestore.instance.collection('contacts').add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending message: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      appBar: AppBar(
        backgroundColor: CustomColor.scaffoldBg,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Let's Connect",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 600 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Get in Touch",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: isDesktop ? 40 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "Email",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SelectableText(
                      "namanvarur1@proton.me",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(height: 40),

                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: inputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: inputBorder,
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: inputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: inputBorder,
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Message",
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: inputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: inputBorder,
                      ),
                    ),
                    const SizedBox(height: 30),

                    TextButton(
                      onPressed: isLoading ? null : sendMessage,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Send Message",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 1,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
