import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Instajob Privacy Policy")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...section("1. Introduction", """
Instajob ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our services, including our website, mobile applications, and any other services we provide (collectively, the "Services"). By using our Services, you agree to the collection and use of information in accordance with this Privacy Policy
"""),
...section("2. Information We Collect", """
We collect various types of information in connection with the Services, including:
● Personal Information: Information that identifies you or can be used to identify you, such as your name, email address, phone number, date of birth, Social Security Number (SSN), and payment information.
● Account Information: Information related to your account, including username, password, and account settings.
● Job Application Information: Information you provide when applying for jobs through our platform, including your resume, employment history, and education background. 
● Usage Data: Information about how you access and use the Services, such as your IP address, browser type, device type, operating system, pages visited, and the date and time of your visits.
● Location Information: Information about your location when you use our Services, if you choose to enable this feature.
"""),

...section("3. How We Use Your Information", """
We use the information we collect for various purposes, including to:
● Provide, maintain, and improve our Services.
● Process and manage your account and job applications.
● Facilitate payments to 1099 contractors through our payment processing partner, Finix.
● Verify your identity and comply with Know Your Customer (KYC) regulations.
● Communicate with you, including sending you updates, notifications, and promotional materials.
● Generate interview questions and score candidates using AI technology.
● Analyze usage trends and improve the functionality and user experience of our Services.
● Protect the security and integrity of our Services.
● Comply with legal and regulatory requirements.
"""),

...section("4. How We Share Your Information", """
We may share your information in the following ways:
● With Employers: We share your job application information with employers to facilitate the hiring process.
● With Payment Processors: We share your personal and payment information with Finix to process payments and comply with KYC regulations.
● With Service Providers: We may share your information with third-party service providers who perform services on our behalf, such as data hosting, analytics, and customer support.
● For Legal Reasons: We may disclose your information if required to do so by law or in response to valid requests by public authorities (e.g., a court or government agency).
● With Your Consent: We may share your information with your consent or at your direction.
"""),

...section("5. Data Security", """
We implement a variety of security measures to protect the safety of your personal information. These measures include encryption, access controls, and secure data storage. However, no method of transmission over the internet or method of electronic storage is completely secure, so we cannot guarantee absolute security.
"""),

...section("6. Data Retention", """
We retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, comply with legal obligations, resolve disputes, and enforce our agreements. When your information is no longer needed, we will securely delete or anonymize it.
"""),

...section("7. Your Rights", """
Depending on your jurisdiction, you may have the following rights regarding your personal
information:
● Access: You have the right to access the personal information we hold about you.
● Correction: You have the right to correct any inaccuracies in your personal information.
● Deletion: You have the right to request the deletion of your personal information.
● Restriction: You have the right to restrict the processing of your personal information.
● Objection: You have the right to object to the processing of your personal information.
● Portability: You have the right to receive your personal information in a structured, commonly used, and machine-readable format.

To exercise any of these rights, please contact us at support@instajob.com.
"""),

...section("8. Children's Privacy", """
Our Services are not intended for children under the age of 18. We do not knowingly collect or solicit personal information from children under 18. If we become aware that we have collected personal information from a child under 18, we will delete that information as quickly as possible. If you believe that we might have any information from or about a child under 18, please contact us at support@instajob.com.
"""),

...section("9. Changes to This Privacy Policy", """
We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on our website and/or through the app. Your continued use of the Services after the changes have been posted constitutes your acceptance of the new Privacy
Policy.
"""),

...section("10. Contact Us", """
If you have any questions about this Privacy Policy, please contact us at support@instajob.com.
You can also reach us at our headquarters:
Instajob
1234 Main Street
Ann Arbor, Michigan 48104
United States
By using our Services, you acknowledge that you have read, understood, and agree to be
bound by this Privacy Policy.
""")
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> section(String title, String description) {
    return [
      SizedBox(height: 20),
        Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              Text(description, textAlign: TextAlign.justify,),
    ];
  }
}