import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/jenis_soal.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';

class KelolaJenisSoalScreen extends StatefulWidget {
  const KelolaJenisSoalScreen({super.key});

  @override
  State<KelolaJenisSoalScreen> createState() => _KelolaJenisSoalScreenState();
}

class _KelolaJenisSoalScreenState extends State<KelolaJenisSoalScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<JenisSoal> _allJenisSoal = [];
  List<JenisSoal> _filteredJenisSoal = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _apiService.getJenisSoal();
      setState(() {
        _allJenisSoal = data;
        _filteredJenisSoal = List.from(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _filterJenisSoal(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredJenisSoal = List.from(_allJenisSoal);
      } else {
        _filteredJenisSoal = _allJenisSoal
            .where((item) =>
                item.jenisSoal.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showFormDialog({JenisSoal? jenisSoal}) {
    showDialog(
      context: context,
      builder: (context) => JenisSoalFormDialog(
        jenisSoal: jenisSoal,
        onSave: (JenisSoal data) async {
          Navigator.pop(context); // Close dialog first
          
          try {
            if (jenisSoal == null) {
              // Create new
              await _apiService.createJenisSoal(data);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Jenis soal berhasil ditambahkan!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            } else {
              // Update existing
              await _apiService.updateJenisSoal(jenisSoal.idJenisSoal, data);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Jenis soal berhasil diupdate!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            }
            // Reload data
            await _loadData();
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _deleteJenisSoal(JenisSoal jenisSoal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text(
            'Apakah Anda yakin ingin menghapus "${jenisSoal.jenisSoal}"?\n\nSemua soal yang terkait akan ikut terhapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              
              try {
                await _apiService.deleteJenisSoal(jenisSoal.idJenisSoal);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Jenis soal berhasil dihapus!'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
                // Reload data
                await _loadData();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kelola Jenis Soal'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: _filterJenisSoal,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Cari jenis soal...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              _searchController.clear();
                              _filterJenisSoal('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      Icons.list_alt,
                      'Total Paket',
                      '${_allJenisSoal.length}',
                    ),
                    _buildStatItem(
                      Icons.access_time,
                      'Aktif',
                      '${_allJenisSoal.where((item) => item.waktuBerakhir.isAfter(DateTime.now())).length}',
                    ),
                    _buildStatItem(
                      Icons.check_circle_outline,
                      'Selesai',
                      '${_allJenisSoal.where((item) => item.waktuBerakhir.isBefore(DateTime.now())).length}',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Data Table
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredJenisSoal.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Tidak ada data',
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await _loadData();
                          _filterJenisSoal(_searchController.text);
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount: _filteredJenisSoal.length,
                          itemBuilder: (context, index) {
                            final item = _filteredJenisSoal[index];
                            return _buildJenisSoalCard(item);
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFormDialog(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Paket'),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.heading2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildJenisSoalCard(JenisSoal item) {
    final isActive = item.waktuBerakhir.isAfter(DateTime.now());
    final statusColor = isActive ? AppColors.success : AppColors.textSecondary;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: () => _showFormDialog(jenisSoal: item),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Image/Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: item.gambar != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        child: Image.asset(
                          'assets/images/${item.gambar}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.quiz,
                              color: Colors.white,
                              size: 30,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.quiz,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.jenisSoal,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isActive ? Icons.circle : Icons.check_circle,
                                size: 12,
                                color: statusColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isActive ? 'Aktif' : 'Selesai',
                                style: AppTextStyles.caption.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${item.pengerjaan} menit',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            DateFormat('dd MMM yyyy, HH:mm')
                                .format(item.waktuMulai),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Actions
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'edit') {
                    _showFormDialog(jenisSoal: item);
                  } else if (value == 'delete') {
                    _deleteJenisSoal(item);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: AppColors.error),
                        SizedBox(width: 8),
                        Text('Hapus', style: TextStyle(color: AppColors.error)),
                      ],
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// Form Dialog Component
class JenisSoalFormDialog extends StatefulWidget {
  final JenisSoal? jenisSoal;
  final Function(JenisSoal) onSave;

  const JenisSoalFormDialog({
    super.key,
    this.jenisSoal,
    required this.onSave,
  });

  @override
  State<JenisSoalFormDialog> createState() => _JenisSoalFormDialogState();
}

class _JenisSoalFormDialogState extends State<JenisSoalFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  final ImagePicker _imagePicker = ImagePicker();
  late TextEditingController _namaController;
  late TextEditingController _durasiController;
  DateTime? _waktuMulai;
  DateTime? _waktuBerakhir;
  String? _gambarPath;
  XFile? _selectedImage;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.jenisSoal?.jenisSoal);
    _durasiController = TextEditingController(
        text: widget.jenisSoal?.pengerjaan.toString() ?? '');
    _waktuMulai = widget.jenisSoal?.waktuMulai;
    _waktuBerakhir = widget.jenisSoal?.waktuBerakhir;
    _gambarPath = widget.jenisSoal?.gambar;
  }

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_waktuMulai ?? DateTime.now())
          : (_waktuBerakhir ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          isStart
              ? (_waktuMulai ?? DateTime.now())
              : (_waktuBerakhir ?? DateTime.now()),
        ),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primary,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          final selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          if (isStart) {
            _waktuMulai = selectedDateTime;
          } else {
            _waktuBerakhir = selectedDateTime;
          }
        });
      }
    }
  }

  void _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
          _isUploading = true;
        });

        // Upload image to server
        try {
          final bytes = await image.readAsBytes();
          final result = await _apiService.uploadImage(bytes, image.name);
          
          if (result['success'] == true) {
            if (mounted) {
              setState(() {
                _gambarPath = result['data']['filename'];
                _isUploading = false;
              });
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gambar berhasil diupload: ${result['data']['filename']}'),
                  backgroundColor: AppColors.success,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          } else {
            throw Exception(result['message'] ?? 'Upload failed');
          }
        } catch (e) {
          if (mounted) {
            setState(() {
              _isUploading = false;
              _selectedImage = null;
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal upload gambar: $e'),
                backgroundColor: AppColors.error,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error memilih gambar: $e'),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.jenisSoal != null;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryDark],
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: const Icon(
                          Icons.quiz,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isEdit
                                  ? 'Edit Jenis Soal'
                                  : 'Tambah Jenis Soal',
                              style: AppTextStyles.heading3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              isEdit
                                  ? 'Perbarui informasi paket soal'
                                  : 'Buat paket soal baru',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Form Fields
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama Paket Soal *',
                      hintText: 'Contoh: UTBK SNBT 2024 - Saintek',
                      prefixIcon: const Icon(Icons.title),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama paket soal harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),

                  TextFormField(
                    controller: _durasiController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Durasi Pengerjaan (menit) *',
                      hintText: 'Contoh: 180',
                      prefixIcon: const Icon(Icons.timer),
                      suffixText: 'menit',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Durasi harus diisi';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Durasi harus berupa angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Waktu Mulai
                  InkWell(
                    onTap: () => _selectDateTime(context, true),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Waktu Mulai *',
                        prefixIcon: const Icon(Icons.event),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _waktuMulai != null
                                ? DateFormat('dd MMM yyyy, HH:mm')
                                    .format(_waktuMulai!)
                                : 'Pilih tanggal dan waktu',
                            style: TextStyle(
                              color: _waktuMulai != null
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Waktu Berakhir
                  InkWell(
                    onTap: () => _selectDateTime(context, false),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Waktu Berakhir *',
                        prefixIcon: const Icon(Icons.event_busy),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _waktuBerakhir != null
                                ? DateFormat('dd MMM yyyy, HH:mm')
                                    .format(_waktuBerakhir!)
                                : 'Pilih tanggal dan waktu',
                            style: TextStyle(
                              color: _waktuBerakhir != null
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Upload Gambar
                  OutlinedButton.icon(
                    onPressed: _isUploading ? null : _pickImage,
                    icon: _isUploading 
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.image),
                    label: Text(
                      _isUploading 
                          ? 'Uploading...'
                          : (_gambarPath != null
                              ? 'Gambar: $_gambarPath'
                              : 'Upload Gambar (Opsional)')
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_waktuMulai == null || _waktuBerakhir == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Waktu mulai dan berakhir harus diisi!'),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                              return;
                            }

                            if (_waktuBerakhir!.isBefore(_waktuMulai!)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Waktu berakhir harus setelah waktu mulai!'),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                              return;
                            }

                            final newData = JenisSoal(
                              idJenisSoal: widget.jenisSoal?.idJenisSoal ?? 0,
                              jenisSoal: _namaController.text,
                              pengerjaan: int.parse(_durasiController.text),
                              waktuMulai: _waktuMulai!,
                              waktuBerakhir: _waktuBerakhir!,
                              gambar: _gambarPath,
                              createdAt: widget.jenisSoal?.createdAt ??
                                  DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            // Call onSave (dialog will be closed in parent)
                            widget.onSave(newData);
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: Text(isEdit ? 'Update' : 'Simpan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                            vertical: AppSpacing.md,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _durasiController.dispose();
    super.dispose();
  }
}
