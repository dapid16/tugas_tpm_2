import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui'; 

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  static const _grad1 = Color(0xFF004D40); 
  static const _grad2 = Color(0xFF00695C);
  static const _accent = Color(0xFF1DE9B6); 

  final int _demoJam = 0;    
  final int _demoMenit = 0; 
  final int _demoDetik = 0; 

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<String> _laps = [];

  int get _offsetMilliseconds => (_demoJam * 3600000) + (_demoMenit * 60000) + (_demoDetik * 1000);
  int get _totalMilliseconds => _offsetMilliseconds + _stopwatch.elapsedMilliseconds;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    _stopwatch.start();
  }

  void _stopTimer() {
    _timer?.cancel();
    _stopwatch.stop();
    setState(() {});
  }

  void _resetTimer() {
    _stopwatch.reset();
    _laps.clear(); 
    setState(() {});
  }

  void _catatLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _formatWaktu(_totalMilliseconds));
      });
    }
  }

  String _formatWaktu(int milliseconds) {
    int ratusan = (milliseconds / 10).truncate() % 100;
    int detik = (milliseconds / 1000).truncate() % 60;
    int menit = (milliseconds / (1000 * 60)).truncate() % 60;
    int jam = (milliseconds / (1000 * 60 * 60)).truncate();

    String jamStr = jam.toString().padLeft(2, '0');
    String menitStr = menit.toString().padLeft(2, '0');
    String detikStr = detik.toString().padLeft(2, '0');
    String ratusanStr = ratusan.toString().padLeft(2, '0');

    return "$jamStr:$menitStr:$detikStr.$ratusanStr";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgPage,
      appBar: AppBar(
        backgroundColor: _bgPage,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white60, size: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Stopwatch',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Material(
          color: _bgCard,
          borderRadius: BorderRadius.circular(28),
          elevation: 8,
          shadowColor: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [_grad1, _grad2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _grad2.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.timer_rounded, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Digital Timer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ukur waktumu dengan presisi dan catat riwayat putaranmu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white54),
                ),
                const SizedBox(height: 32),
                
                // --- KOTAK LAYAR DIGITAL ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                  decoration: BoxDecoration(
                    color: _bgPage, 
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _accent.withOpacity(0.2), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: _accent.withOpacity(0.05),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _formatWaktu(_totalMilliseconds),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w300,
                        color: _accent, 
                        letterSpacing: 3,
                        fontFeatures: [FontFeature.tabularFigures()], 
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // --- BARIS BUTTON START & STOP ---
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            elevation: _stopwatch.isRunning ? 0 : 4,
                            shadowColor: Colors.green.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _stopwatch.isRunning ? null : _startTimer,
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Start', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            foregroundColor: Colors.white,
                            elevation: _stopwatch.isRunning ? 0 : 4,
                            shadowColor: Colors.red.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _stopwatch.isRunning ? _stopTimer : null,
                          icon: const Icon(Icons.stop_rounded),
                          label: const Text('Stop', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // --- BUTTON TOMBOL LAP & RESET ---
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            shadowColor: _grad1.withOpacity(0.4),
                          ),
                          onPressed: _stopwatch.isRunning ? _catatLap : null,
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _stopwatch.isRunning 
                                    ? [_grad1, _grad2] 
                                    : [Colors.white10, Colors.white10], 
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.flag_rounded, color: _stopwatch.isRunning ? Colors.white : Colors.white30),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Lap', 
                                    style: TextStyle(
                                      color: _stopwatch.isRunning ? Colors.white : Colors.white30, 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white10, 
                            foregroundColor: Colors.white70,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _resetTimer,
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Reset', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),

                if (_laps.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  const Divider(color: Colors.white10, height: 1),
                  const SizedBox(height: 24),
                  const Text(
                    'RIWAYAT LAP',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200, 
                    decoration: BoxDecoration(
                      color: _bgPage,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10)
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _laps.length,
                      itemBuilder: (context, index) {
                        int lapNumber = _laps.length - index;
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: _grad2.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                            leading: Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: _grad2.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "#$lapNumber", 
                                style: const TextStyle(fontWeight: FontWeight.bold, color: _accent, fontSize: 13)
                              ),
                            ),
                            title: Text(
                              _laps[index],
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white, fontFeatures: [FontFeature.tabularFigures()]),
                            ),
                            trailing: const Icon(Icons.timer_outlined, color: Colors.white38, size: 20),
                          ),
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}