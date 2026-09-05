import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:record/record.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 runApp(KazikaziApp());
 }

class KazikaziApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KAZIKAZI',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
  }
  class _WelcomePageState extends State<WelcomePage> {
    String? selectedCounty;
  
  final List<String> Counties = [
    "Mombasa","Kwale","Kilifi","Tana River","Lamu","Taita-Taveta",
    "Garisa","Wajir","Mandera","Marsabit","Isiolo","Meru","Tharaka-Nithi",
    "Embu","Kitui","Machakos","Makueni","Nyandarua","Nyeri","Kirinyaga",
    "Muranga","Kiambu","Turukana","West Pokot","Samburu","Trans Nzoia","Uasin Gishu","Elgeyo Marakwet","Nandi","Baringo","Laikipia","Nakuru",
    "Narok","Kajiado","Kericho","Bomet","Kakamega","Vihiga","Bungoma","Busia","Siaya","Kisumu","Homa Bay","Migori","Kisii","Nyamira","Nairobi"
  ];

  List<Map<String,String>> kaziZinazotolewa = [
    {"Jina": "Wafula - Mwajiri", "title": "Mama Fua needed", "county": "Kisumu", "pesa": "500"},
    {"Jina": "Akinyi - Mwajiri", "title": "Fundi wa umeme needed", "county": "Kisumu", "pesa": "1000"},
    {"Jina": "Wafula - Mwajiri", "title": "Shamba boy needed", "county": "Nairobi", "pesa": "700"},



  ];

  List<Map<String,String>>watuWanaotafutaKazi = [
    {"Jina": "Otieno - Fundi", "county": "Kisumu", "skill": "Umeme, Plumbing - Ksh 800/day"},
 {"Jina": "Achieng - Mama Fua", "county": "Kisumu", "skill": "Kufua, House cleaning - Ksh 500"},
 {"Jina": "Kamau - Driver", "county": "Kiambu", "skill": "Boda, Pickup - Ksh 1000"},
 {"Jina": "Fatuma - Cook", "county": "Taita-Taveta", "skill": "Chapati, Pilau - Ksh 700"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A7D2E), Color(0xFFB9E769)],
            begin: Alignment.topCenter, end: Alignment.bottomCenter
          )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Icon(Icons.work_history_rounded, size: 80, color: Colors.white),
                Text("KAZIKAZI", style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                Text("Ona Nani Anaajiri - Countrywide", style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      _bigButton(context, "Natafuta Kazi", "Tafuta Kazi karibu nawe", Icons.search, Colors.green),
                      SizedBox(height: 12),
                      _bigButton(context, "Natoa kazi", "Post kazi - Clip 20sec - Lipa na Mpesa", Icons.videocam, Colors.orange),

                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("Chagua County Yako", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
               child:  DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(" All 47 Counties"),
                    isExpanded: false,
                    items: Counties.map((c) => DropdownMenuItem(value: c, child: Text(c))). toList(),
                    value: selectedCounty,
                    onChanged: (v){
                      setState(() {
                        selectedCounty = v;
                      });
                    },
                  ),
                ),
                ),
                ),
                SizedBox(height: 15),
                if (selectedCounty != null)
                Text("Kazi za $selectedCounty:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

                Text("Kazi zinazotolewa - ${selectedCounty ?? 'All Counties'}:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                SizedBox(
                  height: 120,
                   child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: ListView(
                      children: kaziZinazotolewa.where((kazi) {
                        if (selectedCounty == null) return true;
                        return kazi['county'] == selectedCounty;

                      }).map((kazi) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.work, color: Colors.green),
                              title: Text(kazi['title'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("${kazi['Jina']} - ${kazi['county']} - Ksh ${kazi['pesa']} - OTP Secured"),
                              trailing: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                 child: Text("Omba", style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                            ),
                            Divider(),
                          ],
                        );
                      }).toList()
                      ),
                      ),
                      ),
                    
                   
      
                   SizedBox(height: 10),
                   Text("Watu wanaotafuta kazi - ${selectedCounty ?? 'All Counties'}:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                   SizedBox(height: 5),
                   SizedBox(
                    height: 400,
                     child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: (watuWanaotafutaKazi ?? []).where((w) => selectedCounty == null || w['county'] == selectedCounty).map((person){
                          return Column(children: [
                            ListTile(
                              leading: Icon(Icons.person, color: Colors.green),
                              title: Text(person['Jina'] ?? 'No name'),
                              subtitle: Text((person['skill'] ?? '') + ' - ' + (person['county'] ?? '')),
                              trailing: ElevatedButton(onPressed: (){}, child: Text("Ajiri"), style: ElevatedButton.styleFrom(backgroundColor: Colors.green)),
                            ),
                            Divider()
                          ]);
                        }).toList(),
                        ),
                      ),
                      ),
                     
                Text("Secured by OTP . Encrypted . Mpesa to 0794542450", style: TextStyle(color: Colors.white70, fontSize: 11)),

              ],
            ),
          ),
        ),
      ),
),
    );
  }

  Widget _bigButton(BuildContext ctx, String title, String sub, IconData icon, Color color){
    return InkWell(
      onTap: (){
        if(title == "Natafuta Kazi"){
          Navigator.push(ctx,MaterialPageRoute(builder: (_) => ApplicantForm()));
          } else {
            Navigator.push(ctx,MaterialPageRoute(builder: (_) => NatoaKaziForm()));
        }
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(border: Border.all(color: color, width: 2), borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(icon, color: color, size: 40),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(sub,style: TextStyle(fontSize: 12, color: Colors.black54)),
            ])
          ],
        ),
      ),
    );
  }
}
class ApplicantForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("jisajili"), backgroundColor: Colors.green),
      body: ListView(padding: EdgeInsets.all(20), children: [
        Text("Applicant Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: "Jina kamili", border: OutlineInputBorder())),

   SizedBox(height: 12),
        TextField(decoration: InputDecoration(labelText: "County - Umetoka wapi", border: OutlineInputBorder())),

   SizedBox(height: 12),
        TextField(decoration: InputDecoration(labelText: "Sub-County / Village", border: OutlineInputBorder())),

   SizedBox(height: 12),
        TextField(decoration: InputDecoration(labelText: "simu - Nambari", border: OutlineInputBorder())),

   SizedBox(height: 12),
        TextField(decoration: InputDecoration(labelText: "Kazi Unayojua (Mama Fua, Fundi...)", border: OutlineInputBorder())),

   SizedBox(height: 20),
        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 50
         )), child: Text("Tuma", style: TextStyle(color: Colors.white))),

      ]),
    );
  }
}

class NatoaKaziForm extends StatefulWidget {
  @override
  State<NatoaKaziForm> createState() => _NatoaKaziFormState();
  
}

class _NatoaKaziFormState extends State<NatoaKaziForm> {
  final nameCtrl = TextEditingController();
 final phoneCtrl = TextEditingController();
 final jobCtrl = TextEditingController();
 final descCtrl = TextEditingController();
 final pesaCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final AudioRecorder _recorder = AudioRecorder();
  String? _recordedPath;
   bool isRec = false; 
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Natoa Kazi - Post Kazi"), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Maelezo ya Mwajiri", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 )),
          SizedBox(height: 10),
          TextField(controller: nameCtrl, decoration: InputDecoration(labelText: "Jina lako kamili", border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
 SizedBox(height: 12),
          TextField(controller: phoneCtrl, decoration: InputDecoration(labelText: "Namba ya simu", border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone)), keyboardType: TextInputType.phone),
 SizedBox(height: 20),
 Text("Maelezo ya kazi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
 SizedBox(height: 12),
          TextField(controller: jobCtrl, decoration: InputDecoration(labelText: "Aina ya kazi (e.g. Fundi, Mama fua, boda...)", border: OutlineInputBorder(), prefixIcon: Icon(Icons.work))),
 SizedBox(height: 10),
          TextField(controller: descCtrl, maxLines: 4, decoration: InputDecoration(labelText: "Eleza kazi - What should be done?", border: OutlineInputBorder(), alignLabelWithHint: true)),
 SizedBox(height: 12),
          Row(children: [
            Expanded(child: TextField(controller: locationCtrl, decoration: InputDecoration(labelText: "County / Mahali", border: OutlineInputBorder(), prefixIcon: Icon(Icons.location_on)))),
            SizedBox(width: 10),
            Expanded(child: TextField(controller: pesaCtrl, decoration: InputDecoration(labelText: "Malipo (ksh)", border: OutlineInputBorder(), prefixIcon: Icon(Icons.money)), keyboardType: TextInputType.number)),

          ]),
          SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: "Muda wa kazi", border: OutlineInputBorder()),
            items: ["Siku 1", "Wiki 1", "Mwezi", "kazi ya kudumu"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v){},
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade50, border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              Icon(Icons.videocam, color: Colors.red),
              SizedBox(width: 10),
              Expanded(child: Text("Clip 20sec (Optionl) - Recodi kazi kwa sauti yako", style: TextStyle(fontSize: 13))),
              
              ElevatedButton(
                onPressed: () async {
                  
                  if (await _recorder.hasPermission()) {
                    final tempDir = await Directory.systemTemp.createTemp();
                    final path = '${tempDir.path}/kazi.m4a';
                    await _recorder.start(
                      const RecordConfig(),
                       path: path,
                       );
                       setState(() {
                         _recordedPath = path;
                         isRec = true;
                       });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Mic On - Recording ..."))
                        );
                        }
                        },
                        child: Text(isRec ? "REC..." : "REC"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                          String? path = await _recorder.stop();
                          setState(() {
                            _recordedPath = path;
                            isRec = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Sawa! Sauti imerekodiwa")),
                          );
                          },
                          child: const Text("STOP")
                          ),
                        ],
                        ),
                        ),


            
          
          SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              icon: Icon(Icons.check),
              label: Text("POST KAZI - Lipa na Mpesa Ksh 20"),

              onPressed: () async {
                if (jobCtrl.text.isEmpty || descCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Jaza maelezo ya kazi!")),
                    );
                    return;
                }
                String? voiceUrl;
                if (_recordedPath != null) {
                  try {
                    final file = File(_recordedPath!);
                    final ref = FirebaseStorage.instance
                      .ref()
                      .child('kazi_voices/${DateTime.now().millisecondsSinceEpoch}.m4a');
                      await ref.putFile(file);
                      voiceUrl = await ref.getDownloadURL();
                  } catch (e) {
                    print("Voice upload failed: $e");
                  }
                }

                await FirebaseFirestore.instance.collection('kazi').add({
                  'name': nameCtrl.text,
                  'phone': pesaCtrl.text,
                  'jobTitle': jobCtrl.text,
                  'description':descCtrl.text,
                  'pesa': pesaCtrl.text,
                  'location': voiceUrl,
                  'createdAt': FieldValue.serverTimestamp(),
                  'status': 'open',
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Kazi yako imepost! ${jobCtrl.text} -()")),
                  );
                Navigator.pop(context);
              },
          ),
          ),
          SizedBox(height: 10),
          Center(child: Text("Secured by OTP - Mpesa to 0794542450", style: TextStyle(fontSize: 11, color: Colors.grey))),

        ]),
      ),
    );
  } 
}