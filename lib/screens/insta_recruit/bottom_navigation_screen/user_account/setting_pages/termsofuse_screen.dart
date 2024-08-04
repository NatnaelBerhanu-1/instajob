import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Instajob Terms of Use")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Introduction",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              Text("""Welcome to Instajob! Instajob is an all-in-one mobile app designed to streamline the hiring and payment processes for businesses and contractors within the United States. These Terms of Service ("Terms") govern your access to and use of our services, including our website, mobile applications, and any other services we provide (collectively, the "Services"). By downloading, installing, or using our Services, you agree to be bound by these Terms. If you do not agree to these Terms, do not use our Services.""", textAlign: TextAlign.justify,),
              SizedBox(height: 20),

        Text(
                "2. Services Provided",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              Text("""Instajob provides the following services to enhance the hiring and payment processes:
        ● Job Distribution Programmatic Exchange: We disseminate job listings across various
        platforms and learning module sites such as Canvas to attract a broad pool of candidates, particularly college students.
        ● AI-Generated Interview Questions: Our AI generates live interview questions during mobile interviews, updating every 3 minutes based on the video call transcript.
        ● Candidate Scoring: Candidates are scored with a percentage based on their resume and job description compatibility.
        ● Swipe Interface for Candidate Selection: Businesses can quickly swipe right or left on candidates to expedite the selection process.
        ● Automated Messaging: Automated messages are sent to candidates for screening, denial, and shortlisting.
        ● Tax Document Handling: We manage and send necessary tax documents at the end of the year for 1099 contractors.
        ● Payment Processing: Using Finix, we facilitate secure payments to 1099 contractors and ensure compliance with Know Your Customer (KYC) regulations.
        ● Resume Parsing and Job Applications: Resumes are parsed and sent with each job application to streamline the process.
        ● Career Search from O*NET: Candidates can explore various job types and create resumes within the app""", textAlign: TextAlign.justify,),

        SizedBox(height: 20),

        Text(
                "3. User Registration and Account Security",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              Text("""● Eligibility: By using our Services, you represent that you are at least 18 years old and
legally capable of entering into contracts. Our Services are only available to users within
the United States.
● Account Registration: To access certain features, you must create an account by
providing accurate and complete information. You are responsible for maintaining the
confidentiality of your account credentials.
● Account Security: You are responsible for all activities that occur under your account.
Notify us immediately of any unauthorized use or security breach.""", textAlign: TextAlign.justify,),
SizedBox(height: 20),
        Text(
                "4. Recruitment Fee and Charges",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              Text("""● Recruitment Fee: We charge a recruitment fee of 16% from the 1099 contractor that is hired through our platform. 
● Job Listing Charges: If an employee isn’t hired within one month, a fee of \$100 per job listing is applicable. If an employee is hired, there are no charges for unlimited job
listings.""", textAlign: TextAlign.justify,),
...section("5. Use of Services", """
● Compliance: You agree to use the Services in compliance with all applicable laws,regulations, and these Terms.
● Prohibited Conduct: You must not misuse our Services, including but not limited to:
  ○ Impersonating any person or entity.
  ○ Posting false, misleading, or unlawful information.
  ○ Interfering with or disrupting the Services or servers."""),
...section("6. Data Handling and Privacy", """
● Data Collection: We collect personal information, including Social Security Numbers (SSN), for KYC purposes and share it with Finix for payment processing.
● Resume Handling: We parse and store resumes and send them with each job
application.
● Data Deletion: Users can request data deletion, and we will permanently delete all user data upon such a request.
● Privacy: We prioritize user privacy and do not sell user information to third parties. For more details, please review our Privacy Policy."""),
...section("7. Intellectual Property", """
● Ownership: All content and materials available on the Services, including but not limited to text, graphics, website name, code, images, and logos, are the intellectual property of Instajob and are protected by applicable copyright and trademark law.
● Restrictions: Unauthorized use of any material may violate copyright, trademark, and other laws."""),
...section("8. Limitation of Liability", """
● No Warranty: The Services are provided "as is" without any warranties, express or implied.
● Limitation: Instajob is not liable for any direct, indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of the Services. This includes, but is not limited to, damages for loss of  profits, goodwill, use, data, or other intangible losses.
"""),
...section("9. Indemnification", """
You agree to indemnify, defend, and hold harmless Instajob , its affiliates, and their respective officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, and expenses, including reasonable attorneys' fees, arising out of or in any way connected with your access to or use of the Services.
"""),
...section("10. Termination", """
● Right to Terminate: We reserve the right to terminate or suspend your account and access to the Services at our sole discretion, without prior notice or liability, for any reason, including if you breach these Terms.
● Effect of Termination: Upon termination, your right to use the Services will immediately cease
"""),
...section("11. Modifications to Terms", """
● Changes: We may modify these Terms at any time. We will notify you of any changes by posting the new Terms on our website and/or through the app. Your continued use of the Services after the changes have been posted constitutes your acceptance of the new Terms.
● Review: It is your responsibility to review these Terms periodically for changes
"""),
...section("12. Governing Law", """
These Terms shall be governed and construed in accordance with the laws of the state of Michigan, without regard to its conflict of law provisions. Our Services are intended for use only within the United States.
"""),

...section("13. Dispute Resolution", """
● Arbitration: Any disputes arising out of or relating to these Terms or the Services will be resolved through binding arbitration in accordance with the rules of the American Arbitration Association.
● Jurisdiction: You agree to submit to the personal jurisdiction of the courts located within the state of Michigan for the purpose of litigating all such claims or disputes.
"""),

...section("14. Contact Us", """
If you have any questions about these Terms, please contact us at support@instajob.com. You can also reach us at our headquarters:
Instajob LLC
1234 Main Street
Ann Arbor, Michigan 48104
United States
"""),

...section("15. Additional Terms for Mobile Applications", """
● App Store and Google Play: These Terms are also supplemented by the respective terms and conditions of the App Store and Google Play Store. You agree to comply with those terms in addition to these Terms when using our mobile applications.
● Device Requirements: To use our mobile applications, you need a compatible device and internet connection. Instajob is not responsible for any charges from your mobile network provider for data usage or other costs associated with using our Services.
● Updates: We may provide updates to our mobile applications through the App Store or Google Play. You agree to download and install such updates as they become available. By using our Services, you acknowledge that you have read, understood, and agree to be bound by these Terms.
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