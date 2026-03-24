import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // ── Warna tema dark ──────────────────────────────────────────
  static const _bgPage    = Color(0xFF0F0F1A);
  static const _bgDisplay = Color(0xFF1A1A2E);
  static const _bgKeypad  = Color(0xFF16162A);
  static const _bgNum     = Color(0xFF1E1E32);
  static const _bgOp      = Color(0xFF1E2A3A);
  static const _bgClear   = Color(0xFF2D1F1F);
  static const _clrOp     = Color(0xFF6C9FE0);
  static const _clrEq1    = Color(0xFF3949AB);
  static const _clrEq2    = Color(0xFF5C6BC0);
  static const _clrClear  = Color(0xFFFF6B6B);

  String _equation = '0';
  String _result   = '0';
  String _operand1 = '';
  String _operand2 = '';
  String _operator = '';

  final List<String> _riwayat = [];

  void _buttonPressed(String btn) {
    setState(() {
      if (btn == 'C') {
        _equation = '0';
        _result   = '0';
        _operand1 = '';
        _operand2 = '';
        _operator = '';
      } else if (btn == '+' || btn == '−' || btn == '×' || btn == '÷') {
        if (_operand1.isNotEmpty) {
          _operator = btn;
          _equation = '$_operand1 $_operator ';
        }
      } else if (btn == '=') {
        _hitungHasil();
      } else {
        if (_operator.isEmpty) {
          if (_operand1 == '0' && btn != '.') _operand1 = '';
          _operand1 += btn;
          _equation  = _operand1;
        } else {
          _operand2 += btn;
          _equation  = '$_operand1 $_operator $_operand2';
        }
      }
    });
  }

  void _hitungHasil() {
    if (_operand1.isEmpty || _operand2.isEmpty || _operator.isEmpty) return;

    final num1 = double.tryParse(_operand1) ?? 0;
    final num2 = double.tryParse(_operand2) ?? 0;
    double res = 0;

    if (_operator == '+') res = num1 + num2;
    if (_operator == '−') res = num1 - num2;
    if (_operator == '×') res = num1 * num2;
    if (_operator == '÷') {
      if (num2 == 0) {
        setState(() { _result = 'Error'; _equation = 'Dibagi 0 tidak bisa'; });
        return;
      }
      res = num1 / num2;
    }

    setState(() {
      _result = res == res.toInt()
          ? res.toInt().toString()
          : res.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');

      _riwayat.insert(0, '$_operand1 $_operator $_operand2 = $_result');
      _operand1 = _result;
      _operand2 = '';
      _operator = '';
      _equation = _result;
    });
  }

  void _tampilkanRiwayat() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModal) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A2E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 12, 4),
                child: Row(
                  children: [
                    const Text('Riwayat',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        setState(() => _riwayat.clear());
                        setModal(() {});
                      },
                      icon: const Icon(Icons.delete_sweep_rounded, color: _clrClear, size: 18),
                      label: const Text('Hapus', style: TextStyle(color: _clrClear, fontSize: 13)),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white12, height: 1),
              Expanded(
                child: _riwayat.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history_toggle_off_rounded, size: 48, color: Colors.white24),
                            const SizedBox(height: 12),
                            const Text('Belum ada perhitungan',
                              style: TextStyle(color: Colors.white38, fontSize: 15)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        itemCount: _riwayat.length,
                        itemBuilder: (_, i) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: _bgNum,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _riwayat[i],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() => _riwayat.removeAt(i));
                                  setModal(() {});
                                },
                                child: const Icon(Icons.close_rounded, color: Colors.white30, size: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  // ── Builder tombol ─────────────────────────────────────────────
  Widget _buildKey(String label, {
    Color textColor = Colors.white,
    Color bg = _bgNum,
    bool isEquals = false,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => _buttonPressed(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          height: 64,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(18),
            gradient: isEquals
                ? const LinearGradient(
                    colors: [_clrEq1, _clrEq2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            boxShadow: isEquals
                ? [BoxShadow(color: _clrEq1.withOpacity(0.35), blurRadius: 14, offset: const Offset(0, 5))]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: isEquals ? 28 : 22,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

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
        title: const Text('Kalkulator',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.history_rounded, color: Colors.white60, size: 18),
            ),
            onPressed: _tampilkanRiwayat,
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [

          // ── DISPLAY ────────────────────────────────────────────
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                decoration: BoxDecoration(
                  color: _bgDisplay,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Equation
                    Text(
                      _equation,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Result
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _result,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── KEYPAD ─────────────────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(11, 16, 11, 16 + bottomPad),
            decoration: const BoxDecoration(
              color: _bgKeypad,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              children: [
                Row(children: [
                  _buildKey('C',  textColor: _clrClear, bg: _bgClear),
                  _buildKey('÷',  textColor: _clrOp,    bg: _bgOp),
                  _buildKey('×',  textColor: _clrOp,    bg: _bgOp),
                  _buildKey('−',  textColor: _clrOp,    bg: _bgOp),
                ]),
                Row(children: [
                  _buildKey('7'),
                  _buildKey('8'),
                  _buildKey('9'),
                  _buildKey('+', textColor: _clrOp, bg: _bgOp),
                ]),
                Row(children: [
                  _buildKey('4'),
                  _buildKey('5'),
                  _buildKey('6'),
                  _buildKey('=', isEquals: true),
                ]),
                Row(children: [
                  _buildKey('1'),
                  _buildKey('2'),
                  _buildKey('3'),
                  _buildKey('0'),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}