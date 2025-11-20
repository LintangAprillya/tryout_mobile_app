import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/jenis_soal.dart';

class KelolaSoalScreen extends StatefulWidget {
  const KelolaSoalScreen({Key? key}) : super(key: key);

  @override
  State<KelolaSoalScreen> createState() => _KelolaSoalScreenState();
}

class _KelolaSoalScreenState extends State<KelolaSoalScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  
  List<dynamic> _soalList = [];
  List<JenisSoal> _jenisSoalList = [];
  int? _selectedJenisSoalId;
  bool _isLoading = false;
  
  // Pagination
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 0;
  final int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadJenisSoal();
    _loadSoal();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadJenisSoal() async {
    try {
      final jenisSoalList = await _apiService.getJenisSoal();
      setState(() {
        _jenisSoalList = jenisSoalList;
      });
    } catch (e) {
      print('Error loading jenis soal: $e');
    }
  }

  Future<void> _loadSoal() async {
    setState(() => _isLoading = true);
    
    try {
      final result = await _apiService.getSoal(
        page: _currentPage,
        limit: _itemsPerPage,
        search: _searchController.text.isNotEmpty ? _searchController.text : null,
        jenisSoalId: _selectedJenisSoalId,
      );
      
      setState(() {
        _soalList = result['data'] ?? [];
        final pagination = result['pagination'];
        _currentPage = pagination['current_page'];
        _totalPages = pagination['total_pages'];
        _totalItems = pagination['total'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _onSearch() {
    setState(() => _currentPage = 1);
    _loadSoal();
  }

  void _onFilterChanged(int? jenisSoalId) {
    setState(() {
      _selectedJenisSoalId = jenisSoalId;
      _currentPage = 1;
    });
    _loadSoal();
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() => _currentPage--);
      _loadSoal();
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages) {
      setState(() => _currentPage++);
      _loadSoal();
    }
  }

  Future<void> _deleteSoal(int id, String soalText) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus soal ini?\n\n"${soalText.length > 100 ? soalText.substring(0, 100) + '...' : soalText}"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _apiService.deleteSoal(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Soal berhasil dihapus')),
          );
          _loadSoal();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }
  }

  void _showSoalDialog({Map<String, dynamic>? soal}) {
    showDialog(
      context: context,
      builder: (context) => SoalFormDialog(
        soal: soal,
        jenisSoalList: _jenisSoalList,
        onSaved: () {
          _loadSoal();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Soal'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search & Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari soal...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _onSearch();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                  onSubmitted: (_) => _onSearch(),
                ),
                const SizedBox(height: 12),
                // Filter Dropdown
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<int>(
                        value: _selectedJenisSoalId,
                        decoration: InputDecoration(
                          labelText: 'Filter Jenis Soal',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Semua Jenis Soal', 
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ..._jenisSoalList.map((jenis) {
                            return DropdownMenuItem(
                              value: jenis.idJenisSoal,
                              child: Text(
                                jenis.jenisSoal,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ],
                        onChanged: _onFilterChanged,
                        isExpanded: true,
                        isDense: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton.icon(
                        onPressed: _onSearch,
                        icon: const Icon(Icons.search, size: 20),
                        label: const Text('Cari'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Info Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: $_totalItems soal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Halaman $_currentPage dari $_totalPages',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          
          // Soal List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _soalList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.quiz_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Belum ada soal',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadSoal,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _soalList.length,
                          itemBuilder: (context, index) {
                            final soal = _soalList[index];
                            return _buildSoalCard(soal);
                          },
                        ),
                      ),
          ),
          
          // Pagination
          if (_totalPages > 1)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _currentPage > 1 ? _previousPage : null,
                    icon: const Icon(Icons.chevron_left),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Halaman $_currentPage dari $_totalPages',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: _currentPage < _totalPages ? _nextPage : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSoalDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Soal'),
      ),
    );
  }

  Widget _buildSoalCard(Map<String, dynamic> soal) {
    final soalText = soal['soal'] ?? '';
    final jenisSoalName = soal['jenis_soal_name'] ?? 'Unknown';
    final opsiJawaban = soal['opsi_jawaban'] as List<dynamic>? ?? [];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showSoalDialog(soal: soal),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Jenis Soal & Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.category,
                            size: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              jenisSoalName,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showSoalDialog(soal: soal),
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteSoal(
                          soal['id'],
                          soalText,
                        ),
                        tooltip: 'Hapus',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Soal Text
              Text(
                soalText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              
              // Image Preview (if exists)
              if (soal['gambar'] != null && soal['gambar'].toString().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      Icon(Icons.image, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Memiliki gambar',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              
              // Opsi Jawaban Summary
              Row(
                children: [
                  Icon(Icons.list, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${opsiJawaban.length} opsi jawaban',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.check_circle, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    '${opsiJawaban.where((o) => o['is_kunci_jawaban'] == 1).length} kunci jawaban',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== FORM DIALOG ====================

class SoalFormDialog extends StatefulWidget {
  final Map<String, dynamic>? soal;
  final List<JenisSoal> jenisSoalList;
  final VoidCallback onSaved;

  const SoalFormDialog({
    Key? key,
    this.soal,
    required this.jenisSoalList,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<SoalFormDialog> createState() => _SoalFormDialogState();
}

class _SoalFormDialogState extends State<SoalFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  
  late TextEditingController _soalController;
  late TextEditingController _gambarController;
  late TextEditingController _pembahasanController;
  late TextEditingController _essayAnswerController;
  
  int? _selectedJenisSoalId;
  List<OpsiJawabanInput> _opsiList = [];
  bool _isLoading = false;
  String _soalType = 'multiple_choice'; // 'multiple_choice' or 'essay'

  @override
  void initState() {
    super.initState();
    
    final soal = widget.soal;
    
    _soalController = TextEditingController(text: soal?['soal'] ?? '');
    _gambarController = TextEditingController(text: soal?['gambar'] ?? '');
    _pembahasanController = TextEditingController(text: soal?['pembahasan'] ?? '');
    _essayAnswerController = TextEditingController();
    
    _selectedJenisSoalId = soal?['jenis_soal_id'];
    
    // Load opsi jawaban if editing
    if (soal != null && soal['opsi_jawaban'] != null) {
      final opsiJawaban = soal['opsi_jawaban'] as List<dynamic>;
      
      // Check if this is essay type (only 1 option with status 'Benar')
      if (opsiJawaban.length == 1 && opsiJawaban[0]['status'] == 'Benar') {
        _soalType = 'essay';
        _essayAnswerController.text = opsiJawaban[0]['opsi_jawaban'] ?? '';
      } else {
        _soalType = 'multiple_choice';
        _opsiList = opsiJawaban.map((opsi) {
          return OpsiJawabanInput(
            opsi: opsi['opsi_jawaban'] ?? '',
            isKunci: opsi['is_kunci_jawaban'] == 1,
          );
        }).toList();
      }
    }
    
    // Add default 4 options if creating new
    if (_opsiList.isEmpty) {
      _opsiList = List.generate(4, (index) => OpsiJawabanInput());
    }
  }

  @override
  void dispose() {
    _soalController.dispose();
    _gambarController.dispose();
    _pembahasanController.dispose();
    _essayAnswerController.dispose();
    // Dispose all opsi controllers
    for (var opsi in _opsiList) {
      opsi.controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveSoal() async {
    if (!_formKey.currentState!.validate()) return;
    
    // Validate based on soal type
    if (_soalType == 'essay') {
      if (_essayAnswerController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jawaban essay tidak boleh kosong')),
        );
        return;
      }
    } else {
      // Validate at least one kunci jawaban for multiple choice
      final hasKunci = _opsiList.any((opsi) => opsi.isKunci);
      if (!hasKunci) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Minimal harus ada 1 kunci jawaban')),
        );
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      List<Map<String, dynamic>> opsiJawabanData;
      
      if (_soalType == 'essay') {
        // For essay, create single option with the answer
        opsiJawabanData = [
          {
            'opsi': _essayAnswerController.text.trim(),
            'is_kunci_jawaban': 1,
          }
        ];
      } else {
        // For multiple choice, use the opsi list
        opsiJawabanData = _opsiList
            .where((opsi) => opsi.controller.text.isNotEmpty)
            .map((opsi) => {
                  'opsi': opsi.controller.text,
                  'is_kunci_jawaban': opsi.isKunci ? 1 : 0,
                })
            .toList();
      }

      if (widget.soal == null) {
        // Create new
        await _apiService.createSoal(
          jenisSoalId: _selectedJenisSoalId!,
          soal: _soalController.text,
          gambar: _gambarController.text.isNotEmpty ? _gambarController.text : null,
          pembahasan: _pembahasanController.text.isNotEmpty ? _pembahasanController.text : null,
          opsiJawaban: opsiJawabanData,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Soal berhasil ditambahkan')),
          );
        }
      } else {
        // Update existing
        await _apiService.updateSoal(
          id: widget.soal!['id'],
          jenisSoalId: _selectedJenisSoalId!,
          soal: _soalController.text,
          gambar: _gambarController.text.isNotEmpty ? _gambarController.text : null,
          pembahasan: _pembahasanController.text.isNotEmpty ? _pembahasanController.text : null,
          opsiJawaban: opsiJawabanData,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Soal berhasil diupdate')),
          );
        }
      }

      widget.onSaved();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _addOpsi() {
    setState(() {
      _opsiList.add(OpsiJawabanInput());
    });
  }

  void _removeOpsi(int index) {
    if (_opsiList.length > 2) {
      setState(() {
        _opsiList[index].controller.dispose();
        _opsiList.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimal harus ada 2 opsi jawaban')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.soal == null ? Icons.add : Icons.edit,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.soal == null ? 'Tambah Soal' : 'Edit Soal',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Form Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Jenis Soal Dropdown
                      DropdownButtonFormField<int>(
                        value: _selectedJenisSoalId,
                        decoration: const InputDecoration(
                          labelText: 'Jenis Soal *',
                          prefixIcon: Icon(Icons.category),
                          border: OutlineInputBorder(),
                        ),
                        items: widget.jenisSoalList.map((jenis) {
                          return DropdownMenuItem(
                            value: jenis.idJenisSoal,
                            child: Text(jenis.jenisSoal),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedJenisSoalId = value);
                        },
                        validator: (value) {
                          if (value == null) return 'Pilih jenis soal';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Soal Text
                      TextFormField(
                        controller: _soalController,
                        decoration: const InputDecoration(
                          labelText: 'Soal *',
                          prefixIcon: Icon(Icons.quiz),
                          border: OutlineInputBorder(),
                          hintText: 'Masukkan pertanyaan soal...',
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Soal tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Gambar URL
                      TextFormField(
                        controller: _gambarController,
                        decoration: const InputDecoration(
                          labelText: 'URL Gambar (opsional)',
                          prefixIcon: Icon(Icons.image),
                          border: OutlineInputBorder(),
                          hintText: 'https://...',
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Pembahasan
                      TextFormField(
                        controller: _pembahasanController,
                        decoration: const InputDecoration(
                          labelText: 'Pembahasan (opsional)',
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(),
                          hintText: 'Penjelasan jawaban...',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      
                      // Tipe Soal Section
                      const Text(
                        'Tipe Soal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Pilihan Ganda'),
                              value: 'multiple_choice',
                              groupValue: _soalType,
                              onChanged: (value) {
                                setState(() {
                                  _soalType = value!;
                                  if (_soalType == 'multiple_choice' && _opsiList.isEmpty) {
                                    _opsiList = List.generate(4, (index) => OpsiJawabanInput());
                                  }
                                });
                              },
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Essay'),
                              value: 'essay',
                              groupValue: _soalType,
                              onChanged: (value) {
                                setState(() {
                                  _soalType = value!;
                                });
                              },
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Conditional: Essay Answer or Multiple Choice Options
                      if (_soalType == 'essay') ...[
                        const Text(
                          'Jawaban Essay',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _essayAnswerController,
                          decoration: const InputDecoration(
                            labelText: 'Jawaban yang Benar *',
                            border: OutlineInputBorder(),
                            hintText: 'Masukkan jawaban essay yang benar...',
                            helperText: 'Jawaban akan dicocokkan secara case-insensitive',
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (_soalType == 'essay' && (value == null || value.isEmpty)) {
                              return 'Jawaban essay tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ] else ...[
                        // Opsi Jawaban Section for Multiple Choice
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Opsi Jawaban',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton.icon(
                            onPressed: _addOpsi,
                            icon: const Icon(Icons.add),
                            label: const Text('Tambah Opsi'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Opsi List
                      ...List.generate(_opsiList.length, (index) {
                        final opsi = _opsiList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: opsi.controller,
                                  decoration: InputDecoration(
                                    labelText: 'Opsi ${String.fromCharCode(65 + index)}',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(
                                          value: opsi.isKunci,
                                          onChanged: (value) {
                                            setState(() {
                                              opsi.isKunci = value ?? false;
                                            });
                                          },
                                        ),
                                        const Text('Kunci'),
                                      ],
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Opsi tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeOpsi(index),
                              ),
                            ],
                          ),
                        );
                      }),
                      ], // Close the else bracket for multiple choice options
                    ],
                  ),
                ),
              ),
            ),
            
            // Footer Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _saveSoal,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: Text(widget.soal == null ? 'Simpan' : 'Update'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class for opsi jawaban input
class OpsiJawabanInput {
  final TextEditingController controller;
  bool isKunci;

  OpsiJawabanInput({String? opsi, this.isKunci = false})
      : controller = TextEditingController(text: opsi ?? '');
}
