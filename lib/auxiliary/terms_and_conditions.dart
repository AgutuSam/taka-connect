import 'dart:io';

import 'package:flutter/material.dart';
import 'package:takaconnect/auth/signUp.dart';
import 'package:takaconnect/modules/categories.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  // By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    Color? getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.orange[600];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('TakaConnect'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  // padding: const EdgeInsets.fromLTRB(20.0, 24.0, 0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      height: 100,
                      width: 100,
                      image:
                          Image.asset('assets/appIcons/ic_launcher.png').image,
                    ),
                  ),
                ),
                Center(
                  // padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'TakaConnect mobile application\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900)),
                                TextSpan(text: '\n'),
                                TextSpan(
                                    text: 'PRIVACY POLICY\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ])),
                      RichText(
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'TakaConnect',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    )),
                                TextSpan(
                                    text:
                                        ', mobile application software (App), once you have downloaded or streamed a copy of the App onto your mobile telephone or handheld device (Device).\n'),
                                TextSpan(
                                    text:
                                        'This Privacy Policy applies to any of the services accessible through the App (Services) that are available on the App Site or other sites of ours (Services Sites).\n'),
                                TextSpan(
                                    text:
                                        'This privacy policy describes the way we treat and use personal data that we collect about any child or adult that uses our services. We believe that it is important that children also understand how we look after their personal data and what their privacy rights are, so we have created a dedicated privacy policy for children.\n'),
                                TextSpan(
                                    text:
                                        'Please note that as a parent or guardian of a child who has signed up to use our services, you are responsible for your child’s use of our services.\n'),
                                TextSpan(
                                    text:
                                        'This Privacy Policy explains what personal data is collected when you use the'),
                                TextSpan(
                                    text: 'TakaConnect',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: ' any '),
                                TextSpan(
                                    text: 'TakaConnect',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' mobile application and the services provided through it (together with the “Service”), how such personal data will be used, shared.\n'),
                                TextSpan(
                                    text:
                                        'BY USING THE SERVICE, YOU PROMISE US THAT (I) YOU HAVE READ, UNDERSTAND AND AGREE TO THIS PRIVACY POLICY, AND (II) YOU ARE OVER 16 YEARS OF AGE (OR HAVE HAD YOUR PARENT OR GUARDIAN READ AND AGREE TO THIS PRIVACY POLICY FOR YOU). If you do not agree, or are unable to make this promise, you must not use the Service. In such a case, you must contact the support team via email to request deletion of your account and data.\n'),
                                TextSpan(
                                    text:
                                        '“Process”, in respect of personal data, includes to collect, store, and disclose to others.\n'),
                                TextSpan(
                                    text: '1. Personal Data Controller\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text: 'TakaConnect',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' is a mobile app initiative by the Kenya Marine and Fisheries Research Institute (KMFRI) which is a State Corporation established in 1979 by the Science and Technology Act, Cap 250 of the Laws of Kenya, which has since been repealed by the Science, Technology and Innovation Act No. 28 of 2013 which has recognized KMFRI as a national research institution under section 56, fourth schedule. KMFRI will be the controller of your personal data.\n'),
                                TextSpan(
                                    text:
                                        '2. Categories of personal data we collect\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We collect data you give us voluntarily (for example, an email address). We also collect data automatically (for example, your IP address).\n'),
                                TextSpan(
                                    text: '2.1. Data you give us\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'You may be asked to provide us information about yourself when you register for and/or use the Service. This information includes: first name, last name, phone number, email, gender, (together “Required Information”), as well as your photo, address details, working hours.\n'),
                                TextSpan(
                                    text:
                                        'To use our Service and register an account, you will need to provide Required Information. You will be able to use the Service even if you do not give this data to us, but some Service’s functionality may be limited to you (for example, if you do not register an account, you will not be able to chat with other users, post ads, see contact details of other users).\n'),
                                TextSpan(
                                    text:
                                        'Sometimes you may also need to provide us additional information in the communication with our Support Team in order to fulfill your request (for example, if your account was previously blocked, we may ask you to confirm your identity by providing an ID document).\n'),
                                TextSpan(
                                    text:
                                        'While posting an announcement, you can decide to provide additional personal information on yourself. For example, you can decide to make your CV available. You acknowledge that by providing your personal data in announcement you are making such data publicly available. In addition, you acknowledge and agree that we will make public some personal data from your profile to provide the Service, - it will enable us to facilitate communication and transactions between the users.\n'),
                                TextSpan(
                                    text:
                                        'You should carefully consider risks associated with the fact that you make certain information – in particular, your phone number, address or exact location – publicly available.\n'),
                                TextSpan(
                                    text:
                                        '2.3. Data we collect automatically:\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text: '2.3.2. Device and Location data.\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We collect data from your device. Examples of such data include: language settings, IP address, time zone, type and model of a device, device settings, operating system, Internet service provider, mobile carrier, and hardware ID.\n'),
                                TextSpan(
                                    text: '2.3.3. Usage data\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We record how you interact with our Service. For example, we log the features, and content you interact with, how often you use the Service, how long you are on the Service, and what sections you use.\n'),
                                TextSpan(
                                    text: '2.3.5. Transaction data\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We will collect and keep logs of user transaction history including volumes traded and final agreed amount among users.\n'),
                                TextSpan(
                                    text: '2.3.6. Cookies\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We use cookies to distinguish you from other users of the App. This helps us to provide you with a good experience when you use the App and also allows us to improve the App. Cookies help to automatically recognize you the next time you use our App. As a result, the information, which you have earlier entered in certain fields on the App may automatically appear the next time when you use the App. Cookie data will be stored on your device and most of the time only for a limited time period.\n'),
                                TextSpan(
                                    text:
                                        '3. For what purposes we process your personal data\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text: 'We process your personal data:\n'),
                                TextSpan(
                                    text:
                                        '3.1. To research and analyse your use of the Service\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'This helps us to better understand our business, analyse our operations, maintain, improve, innovate, plan, design, and develop TakaConnect and our new products. We also use such data for statistical analysis purposes, to test and improve our offers. This enables us to better understand what features and sections of TakaConnect our users like more, and what categories of users use our Service. As a consequence, we often decide how to improve TakaConnect based on the results obtained from this process.\n'),
                                TextSpan(
                                    text:
                                        'Browsers: It is also possible to stop your browser from accepting cookies altogether by changing your browser’s cookie settings. You can usually find these settings in the “options” or “preferences” menu of your browser. The following links may be helpful, or you can use the “Help” option in your browser.\n'),
                                TextSpan(
                                    text:
                                        'Cookie settings in Internet Explorer\n'),
                                TextSpan(text: 'Cookie settings in Firefox\n'),
                                TextSpan(text: 'Cookie settings in Chrome\n'),
                                TextSpan(
                                    text:
                                        'Cookie settings in Safari web and iOS\n'),
                                TextSpan(
                                    text:
                                        'Google allows its users to opt out of Google’s personalized ads and to prevent their data from being used by Google Analytics.\n'),
                                TextSpan(
                                    text:
                                        'Facebook also allows its users to influence the types of ads they see on Facebook. To find how to control the ads you see on Facebook, please go here or adjust your ads settings on Facebook.\n'),
                                TextSpan(
                                    text:
                                        '3.2. To enforce our Terms and Conditions of Use and to prevent and combat fraud\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We use personal data to enforce our agreements and contractual commitments, to detect, prevent, and combat fraud. As a result of such processing, we may share your information with others, including law enforcement agencies (in particular, if a dispute arises in connection with our Terms of Use).\n'),
                                TextSpan(
                                    text:
                                        '3.3. To comply with legal obligations\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We may process, use, or share your data when the law requires it, in particular, if a law enforcement agency requests your data by available legal means.\n'),
                                TextSpan(
                                    text: '3.4. To process your payments\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We provide paid products and/or services within the Service. For this purpose, we use third-party services for payment processing (for example, payment processors). As a result of this processing, you will be able to make a payment and use the paid features of the Service.\n'),
                                TextSpan(
                                    text:
                                        '4. Under what legal bases we process your personal data\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We process your personal data, in particular, under the following legal bases:\n'),
                                TextSpan(
                                    text:
                                        'Your consent to perform our contract with you for our (or others`) legitimate interests; Under this legal basis we, in particular:\n'),
                                TextSpan(
                                    text:
                                        '4.1 Communicate with you regarding your use of our Service\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'This includes, for example, sending you push notifications reminding you that you have unread messages. The legitimate interest we rely on for this purpose is our interest to encourage you to use our Service more often. We also take into account the potential benefits to you.\n'),
                                TextSpan(
                                    text:
                                        '4.2 Research and analyse your use of the Service\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'Our legitimate interest for this purpose is our interest in improving our Service so that we understand users’ preferences and are able to provide you with a better experience (for example, to make the use of our mobile application easier and more enjoyable, or to introduce and test new features).\n'),
                                TextSpan(
                                    text:
                                        'Send you marketing communications\n'),
                                TextSpan(
                                    text:
                                        'The legitimate interest we rely on for this processing is our interest to promote our Service in a measured and appropriate way.\n'),
                                TextSpan(text: 'Personalize our ads\n'),
                                TextSpan(
                                    text:
                                        'The legitimate interest we rely on for this processing is our interest to promote our Service in a reasonably targeted way.\n'),
                                TextSpan(
                                    text:
                                        'Enforce our Terms of Use and to prevent and combat fraud\n'),
                                TextSpan(
                                    text:
                                        'Our legitimate interests for this purpose are enforcing our legal rights, preventing and addressing fraud and unauthorised use of the Service, and non-compliance with our Terms of Use.\n'),
                                TextSpan(
                                    text:
                                        '5. With whom we share your personal data to comply with legal obligations\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We share information with third parties that help us operate, provide, improve, integrate, customize, support, and market our Service. We may share some sets of personal data, in particular, for purposes and with parties indicated in Section 2 of this Privacy Policy. The types of third parties we share information with include, in particular:\n'),
                                TextSpan(
                                    text: '5.1. Service providers\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We share personal data with third parties that we hire to provide services or perform business functions on our behalf, based on our instructions. We may share your personal information with the following types of service providers:\n'),
                                TextSpan(
                                    text:
                                        'Department of Water, Environment, Minerals & Natural Resources- Kilifi and Mombasa County\n'),
                                TextSpan(
                                    text:
                                        'payment processing service providers (M-Pesa)\n'),
                                TextSpan(
                                    text:
                                        'delivery service providers (Licensed waste transporters Uber, Bolt)\n'),
                                TextSpan(
                                    text:
                                        'data analytics providers (Facebook, Google, Appsflyer)\n'),
                                TextSpan(
                                    text:
                                        'marketing partners (in particular, social media networks, marketing agencies, email delivery services; such as Facebook, Google, Elastic email)\n'),
                                TextSpan(
                                    text:
                                        '5.2. Law enforcement agencies and other public authorities\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    )),
                                TextSpan(
                                    text:
                                        'We may use and disclose personal data to enforce our Terms of Use, to protect our rights, privacy, safety, or property, and/or that of our affiliates, you or others, and to respond to requests from courts, law enforcement agencies, regulatory agencies, and other public and government authorities, or in other cases provided for by law.\n'),
                                TextSpan(
                                    text:
                                        '6. How you can exercise your rights\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'To be in control of your personal data, you have the following rights:\n'),
                                TextSpan(
                                    text:
                                        '1)	Accessing / reviewing / updating / correcting your personal data. You may review, edit, or change the personal data that you had previously provided to '),
                                TextSpan(
                                    text: 'TakaConnect',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' in the settings section on the Website.\n'),
                                TextSpan(
                                    text:
                                        '2)	You may also request a copy of your personal data collected during your use of the Service at takaconnectke@gmail.com/ takaconnect@kmfri.go.ke.\n'),
                                TextSpan(
                                    text:
                                        '3)	Deleting your personal data/ account profile information. You can request erasure of your personal data by sending us an email at takaconnectke@gmail.com/ takaconnect@kmfri.go.ke.\n'),
                                TextSpan(
                                    text:
                                        '4)	When you request deletion of your personal data, we will use reasonable efforts to honour your request. In some cases, we may be legally required to keep some of the data for a certain time; in such an event, we will fulfill your request after we have complied with our obligations.\n'),
                                TextSpan(
                                    text:
                                        '5)	Objecting to or restricting the use of your personal data (including for direct marketing purposes). You can ask us to stop using all or some of your personal data or limit our use thereof by sending an email at takaconnectke@gmail.com/ takaconnect@kmfri.go.ke\n'),
                                TextSpan(
                                    text:
                                        '6)	If you wish to raise a complaint on how we have handled your Information, please contact us at the email address above to have the matter investigated.\n'),
                                TextSpan(
                                    text:
                                        '7)	If you are not satisfied with our response or believe we are processing your Information not in accordance with the law you have the right to complain to the email provided above.\n'),
                                TextSpan(
                                    text:
                                        'TakaConnect may, from time to time, contain links to and from the websites of our partner networks, advertisers and affiliates (including, but not limited to, websites on which the App or the Services are advertised). If you follow a link to any of these websites, please note that these websites and any services that may be accessible through them have their own privacy policies and that we do not accept any responsibility or liability for these policies or for any personal data that may be collected through these websites or services, such as contact and location data. Please check these policies before you submit any personal data to these websites or use these services.\n'),
                                TextSpan(
                                    text: '7. Age limitation\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We do not knowingly process personal data from persons under 18 years of age. If you learn that anyone younger than 18 years has provided us with personal data, please email us at takaconnectke@gmail.com/ takaconnect@kmfri.go.ke.\n'),
                                TextSpan(
                                    text: '8. Changes to this privacy policy\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We may modify this Privacy Policy from time to time. If we decide to make material changes to this Privacy Policy, you will be notified through our Service or by other available means and will have an opportunity to review the revised Privacy Policy. By continuing to access or use the Service after those changes become effective, you agree to be bound by the revised Privacy Policy.\n'),
                                TextSpan(
                                    text: '9. Data retention\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We will store your personal data for as long as it is reasonably necessary for achieving the purposes set forth in this Privacy Policy (including providing the Service to you), which includes (but is not limited to) the period during which you have a TakaConnect account. We will also retain and use your personal data as necessary to comply with our legal obligations, resolve disputes, and enforce our agreements.\n'),
                                TextSpan(
                                    text: '10.No liability\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'To the maximum extent permitted by applicable law, in no event shall we become liable to you, or to any other party, for any loss or damages, whether indirect, consequential, punitive, special, incidental or otherwise, arising from your use of or inability to use this software, including, but not limited to damages for loss of time, money, data or goodwill, even if we had been advised of the possibility of such damages.\n'),
                                TextSpan(
                                    text: '11.Disclaimer of warranties\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'EXCEPT FOR THE LIMITED WARRANTY SET FORTH ABOVE, THIS SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND. THE LIMITED WARRANTY CONTAINED IN THIS AGREEMENT IS IN LIEU OF ALL OTHER WARRANTIES, STATUTORY, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THOSE CONCERNING MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, OR ARISING AS A RESULT OF CUSTOM OR USAGE IN THE TRADE OR BY COURSE OF DEALING.\n'),
                                TextSpan(
                                    text:
                                        'TakaConnect (we) is committed to protecting and respecting your privacy.\n'),
                                TextSpan(
                                    text:
                                        'This policy (Privacy Policy) applies to your use of:\n'),
                                TextSpan(
                                    text:
                                        'TakaConnect, mobile application software (App), once you have downloaded or streamed a copy of the App onto your mobile telephone or handheld device (Device).\n'),
                                TextSpan(
                                    text:
                                        'This Privacy Policy applies to any of the services accessible through the App (Services) that are available on the App Site or other sites of ours (Services Sites).\n'),
                                TextSpan(
                                    text:
                                        'This privacy policy describes the way we treat and use personal data that we collect about any child or adult that uses our services. We believe that it is important that children also understand how we look after their personal data and what their privacy rights are, so we have created a dedicated privacy policy for children.\n'),
                                TextSpan(
                                    text:
                                        'For the purpose of Data Protection, The Kenya Personal Data Protection Act 2019 gives you the right to access information held about you. Your right of access can be exercised in accordance with that Act. the data controller (Kenya Marine and Fisheries Research Institute) will provide you with such information free of charge.\n'),
                                TextSpan(
                                    text:
                                        '12.Information we collect from you\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We will collect and process the following data about you:\n'),
                                TextSpan(
                                    text:
                                        'Information you provide when you register to use the App or Site, download or register the App, subscribe to any of our Services, share data via an App’s social media functions, or connect with your friends on our app and when you report a problem with an App, our Services, or any of our Sites. If you contact us, we will keep a record of that correspondence. The information you give us may include your full name, e-mail address, age, username, password and other registration information, personal description and photograph.\n'),
                                TextSpan(
                                    text:
                                        'Information we collect about you and your device include:\n'),
                                TextSpan(
                                    text:
                                        'Technical information, including the type of mobile device you use, the mobile phone number, mobile network information and your mobile operating system.\n'),
                                TextSpan(
                                    text:
                                        'Information stored on your Device associated with the '),
                                TextSpan(
                                    text: 'TakaConnect',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' App, login information and GPS location.\n'),
                                TextSpan(
                                    text:
                                        'Details of your use of any of your visits to Our Site includes, but not limited to communication data and the resources that you access (Log Information).\n'),
                                TextSpan(
                                    text:
                                        'You can withdraw your consent at any time by going to your Settings and turning off your location services on your device either for all our apps or for our app specifically.\n'),
                                TextSpan(
                                    text: '13. Uses made of the information\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'We use information held about you in the following ways:\n'),
                                TextSpan(
                                    text:
                                        'Submitted Information: to create an account with us and allow us to understand more about you so we can make better and more personalised class recommendations to you. When you join, your account details will be visible to the '),
                                TextSpan(
                                    text: 'TakaConnect',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' community in the app. We will not share, sell, or distribute any of the information you provide us without your explicit consent.\n'),
                                TextSpan(
                                    text:
                                        'Device information: to understand more about the different bugs and fixes required on different devices, how the content can be presented better and for continuous improvement of our app.\n'),
                                TextSpan(
                                    text:
                                        'Log information: to understand how you interact with our app, which features you use most and understand more about what we can do to improve the app and the experience we give to you.\n'),
                                TextSpan(
                                    text:
                                        'Location information: to enable us to show you what events are taking place near and around you.\n'),
                                TextSpan(
                                    text: '14. Changes to privacy policy\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        'Any changes we may make to our privacy policy in the future will be posted on this page and, where appropriate, notified to you when you next start the App or log onto one of the Services Sites or via email. The new terms may be displayed on-screen and you may be required to read and accept them to continue your use of the App or the Services.\n'),
                                TextSpan(text: '\n'),
                                TextSpan(
                                    text: 'CONTACT US\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18)),
                                TextSpan(
                                    text:
                                        'You may contact us at any time for details regarding this Privacy Policy and its previous versions. For any questions concerning your account or your personal data please contact us at takaconnectke@gmail.com/ takaconnect@kmfri.go.ke.\n'),
                                TextSpan(
                                    text: 'Effective as of: 1 August 2021\n'),
                              ])),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Material(
                  child: Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value!;
                      });
                    },
                  ),
                ),
                Text(
                  'I have read and accepted these terms and conditions',
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: agree
                      ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage('default')))
                      : null,
                  child: Text('Continue')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getColor)),
                  onPressed: () => exit(0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
