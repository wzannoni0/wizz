import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WizzApp());
}

// Palette Wizz = MSN blu + WhatsApp moderno
const wizzBlue = Color(0xFF0A3D91);
const wizzLight = Color(0xFF00A2FF);
const wizzYellow = Color(0xFFFFDE00);
const wizzBg = Color(0xFFF2F7FB);

class WizzApp extends StatelessWidget {
  const WizzApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wizz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: wizzLight),
        scaffoldBackgroundColor: wizzBg,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

// ---------- SPLASH ----------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [wizzBlue, wizzLight, Color(0xFFB8E6FF)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
              ),
              child: const Center(
                child: Text('⚡', style: TextStyle(fontSize: 60)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Wizz',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1)),
            const Text('il WhatsApp con anima MSN',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 30),
            const CupertinoActivityIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// ---------- LOGIN TELEFONO ----------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneCtrl = TextEditingController(text: '+39 ');
  final nickCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  bool step2 = false;
  String demoCode = '123456';

  void richiediCodice() {
    if (phoneCtrl.text.trim().length < 6) {
      _msg('Inserisci un numero valido');
      return;
    }
    setState(() {
      demoCode = (100000 + Random().nextInt(900000)).toString();
      step2 = true;
    });
  }

  void verifica() {
    if (otpCtrl.text.trim() != demoCode) {
      _msg('Codice errato. Demo: $demoCode');
      return;
    }
    final nick = nickCtrl.text.trim().isEmpty ? 'xX_Ospite_Xx' : nickCtrl.text.trim();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeShell(phone: phoneCtrl.text, nick: nick),
      ),
    );
  }

  void _msg(String t) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [wizzBlue, wizzLight]),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text('👋 Benvenuto su Wizz',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Registrati con numero di telefono',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              if (!step2) ...[
                _field(phoneCtrl, 'Numero di telefono', Icons.phone, TextInputType.phone),
                _field(nickCtrl, 'Nickname MSN es. xX_DarkAngel_Xx', Icons.face, TextInputType.text),
                const SizedBox(height: 12),
                _bigButton('Ricevi codice via SMS', richiediCodice),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blue.shade100)),
                  child: Text(
                    'Ti abbiamo inviato un SMS.\nDEMO codice: $demoCode',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 12),
                _field(otpCtrl, 'Codice a 6 cifre', Icons.sms, TextInputType.number),
                const SizedBox(height: 12),
                _bigButton('Entra in Wizz 🚀', verifica),
                TextButton(
                    onPressed: () => setState(() => step2 = false),
                    child: const Text('Cambia numero')),
              ],
              const SizedBox(height: 20),
              const Text(
                'iOS + Android • Trilli • Stati • Winks • Musica condivisa',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String hint, IconData icon, TextInputType t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: TextField(
        controller: c,
        keyboardType: t,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: wizzBlue),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.blue.shade100)),
        ),
      ),
    );
  }

  Widget _bigButton(String label, VoidCallback onTap) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: wizzLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          textStyle:
              const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        child: Text(label),
      ),
    );
  }
}

// ---------- MODELLO ----------
class WContact {
  String nome;
  Color colore;
  String stato;
  String musica;
  String presence; // online busy away
  WContact(this.nome, this.colore, this.stato, this.musica, this.presence);
}

class WMsg {
  String from;
  String text;
  bool me;
  bool wink;
  bool sys;
  WMsg({required this.from, required this.text, this.me = false, this.wink = false, this.sys = false});
}

// ---------- HOME ----------
class HomeShell extends StatefulWidget {
  final String phone;
  final String nick;
  const HomeShell({super.key, required this.phone, required this.nick});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int tab = 0;
  late String nick;
  String stato = 'Online - Torno subito!';
  String musica = 'Vasco Rossi - Albachiara';

  late List<WContact> contacts;
  final Map<int, List<WMsg>> chats = {};

  @override
  void initState() {
    super.initState();
    nick = widget.nick;
    contacts = [
      WContact('Giulia ♡', const Color(0xFFE91E63), 'Online - a casa!!', 'Vasco Rossi - Albachiara', 'online'),
      WContact('xX_Marco_Xx', wizzBlue, 'Occupato - sto giocando', 'Linkin Park - Numb', 'busy'),
      WContact('Ale • Non al PC', Colors.grey, 'Non al computer 🖥️', '', 'away'),
    ];
    for (var i = 0; i < contacts.length; i++) {
      chats[i] = [
        if (i == 0)
          WMsg(from: 'Giulia ♡', text: 'ciaoooo ti ricordi i trilli?? 😂'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: wizzBlue,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nick,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            Text('$stato • ${widget.phone}',
                style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: _editProfilo, icon: const Icon(Icons.edit)),
        ],
      ),
      body: tab == 0 ? _buildContacts() : _buildProfilo(),
      bottomNavigationBar: isIOS
          ? CupertinoTabBar(
              currentIndex: tab,
              onTap: (i) => setState(() => tab = i),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                    label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_fill), label: 'Profilo'),
              ],
            )
          : NavigationBar(
              selectedIndex: tab,
              onDestinationSelected: (i) => setState(() => tab = i),
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.chat_bubble), label: 'Chat'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Profilo MSN'),
              ],
            ),
    );
  }

  Widget _buildContacts() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: contacts.length,
      itemBuilder: (_, i) {
        final c = contacts[i];
        Color dot = c.presence == 'online'
            ? Colors.green
            : c.presence == 'busy'
                ? Colors.red
                : Colors.orange;
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: c.colore.withValues(alpha: 0.15),
                  child: Text(c.nome.characters.first,
                      style: TextStyle(
                          color: c.colore, fontWeight: FontWeight.w900)),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                        color: dot,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)),
                  ),
                ),
              ],
            ),
            title: Text(c.nome,
                style: TextStyle(color: c.colore, fontWeight: FontWeight.w800)),
            subtitle: Text(
                '${c.stato}${c.musica.isNotEmpty ? '\n♫ ${c.musica}' : ''}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(
                        contactIndex: i,
                        contact: c,
                        myNick: nick,
                        messages: chats[i]!)),
              );
              setState(() {});
            },
          ),
        );
      },
    );
  }

  Widget _buildProfilo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
              radius: 44,
              backgroundColor: wizzLight,
              child: Text('⚡', style: TextStyle(fontSize: 44))),
          const SizedBox(height: 12),
          Text(nick,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          Text(widget.phone, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          _pField('Nickname MSN', nick, (v) => nick = v),
          _pField('Stato', stato, (v) => stato = v),
          _pField('Cosa stai ascoltando?', musica, (v) => musica = v),
          const SizedBox(height: 8),
          const Text(
            'Su iOS il Trillo usa vibrazione aptica.\nSu Android vibrazione + suono.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _pField(String label, String init, Function(String) onSaved) {
    final c = TextEditingController(text: init);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
        ),
        onChanged: onSaved,
      ),
    );
  }

  void _editProfilo() {
    setState(() => tab = 1);
  }
}

// ---------- CHAT CON TRILLO ----------
class ChatScreen extends StatefulWidget {
  final int contactIndex;
  final WContact contact;
  final String myNick;
  final List<WMsg> messages;
  const ChatScreen(
      {super.key,
      required this.contactIndex,
      required this.contact,
      required this.myNick,
      required this.messages});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final txt = TextEditingController();
  late AnimationController shakeCtrl;
  int tema = 0;

  @override
  void initState() {
    super.initState();
    shakeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    shakeCtrl.dispose();
    txt.dispose();
    super.dispose();
  }

  String emoticon(String t) {
    return t
        .replaceAll(':)', '😊')
        .replaceAll(':(', '😢')
        .replaceAll(':D', '😁')
        .replaceAll(':P', '😛')
        .replaceAll('<3', '❤️');
  }

  void invia() {
    final t = txt.text.trim();
    if (t.isEmpty) return;
    setState(() {
      widget.messages.add(WMsg(from: widget.myNick, text: t, me: true));
      txt.clear();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final r = [
        'ahahah mitico!! :)',
        'mandami un trillo dai!!',
        'che canzone stai ascoltando??',
        'questo Wizz spacca :D',
        '<3 <3'
      ];
      setState(() {
        widget.messages.add(WMsg(
            from: widget.contact.nome,
            text: r[Random().nextInt(r.length)]));
      });
    });
  }

  void trillo() {
    // Vibrazione nativa iOS + Android
    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.alert);
    shakeCtrl.forward(from: 0);
    setState(() {
      widget.messages.add(WMsg(
          from: widget.myNick,
          text: '🔔🔔 TRILLOOO!!! Hai ricevuto un trillo!',
          me: true));
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      setState(() {
        widget.messages.add(WMsg(
            from: widget.contact.nome,
            text: 'EHHH smettila!! :P (trillo di ritorno 🔔)'));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bg1 = Colors.white, bg2 = const Color(0xFFE8F4FF);
    if (tema == 1) {
      bg1 = const Color(0xFFFFF8E1);
      bg2 = const Color(0xFFFFE0B2);
    }
    if (tema == 2) {
      bg1 = const Color(0xFF1A1A2E);
      bg2 = const Color(0xFF16213E);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: wizzBlue,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.contact.nome,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(widget.contact.stato,
                style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: shakeCtrl,
        builder: (_, child) {
          final s = sin(shakeCtrl.value * pi * 6) * 10 * (1 - shakeCtrl.value);
          return Transform.translate(offset: Offset(s, 0), child: child);
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [bg1, bg2])),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: widget.messages.length,
                  itemBuilder: (_, i) {
                    final m = widget.messages[i];
                    if (m.wink) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        alignment:
                            m.me ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(m.text,
                            style: const TextStyle(fontSize: 44)),
                      );
                    }
                    final isMe = m.me;
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(context).size.width * 0.72),
                        decoration: BoxDecoration(
                          color: isMe
                              ? const Color(0xFFD9F0FF)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 16 : 4),
                            bottomRight: Radius.circular(isMe ? 4 : 16),
                          ),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 2)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.from,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: isMe
                                        ? wizzBlue
                                        : widget.contact.colore)),
                            const SizedBox(height: 2),
                            Text(emoticon(m.text),
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: const Color(0xFFEEF6FF),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: [
                    _tool('🔔 TRILLO', trillo, highlight: true),
                    _tool('😘', () => _wink('😘')),
                    _tool('💃', () => _wink('💃')),
                    _tool('🎨', () => setState(() => tema = (tema + 1) % 3)),
                  ],
                ),
              ),
              SafeArea(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: txt,
                          onSubmitted: (_) => invia(),
                          decoration: InputDecoration(
                            hintText: 'Scrivi... usa :) :( :D',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: wizzLight,
                        child: IconButton(
                            onPressed: invia,
                            icon: const Icon(Icons.send,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tool(String label, VoidCallback onTap, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: highlight ? wizzYellow : Colors.white,
          foregroundColor: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
      ),
    );
  }

  void _wink(String e) {
    setState(() {
      widget.messages.add(WMsg(from: widget.myNick, text: e, me: true, wink: true));
    });
  }
}
