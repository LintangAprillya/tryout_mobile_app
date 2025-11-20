import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jenis_soal.dart';
import '../models/admin_user.dart';
import '../models/trans_user.dart';

class ApiService {
  // Backend API URL - direct file access
  static const String baseUrl = 'http://localhost:8000/api';
  
  // ==================== FILE UPLOAD ====================
  
  /// Upload image file
  Future<Map<String, dynamic>> uploadImage(List<int> imageBytes, String filename) async {
    try {
      print('Uploading image: $filename, size: ${imageBytes.length} bytes');
      
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload.php'));
      
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: filename,
        ),
      );
      
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      
      print('Upload response status: ${response.statusCode}');
      print('Upload response body: $responseData');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(responseData);
        return jsonResponse;
      } else {
        final Map<String, dynamic> jsonResponse = json.decode(responseData);
        throw Exception(jsonResponse['message'] ?? 'Failed to upload image: HTTP ${response.statusCode}');
      }
    } catch (e) {
      print('Upload error: $e');
      throw Exception('Error uploading image: $e');
    }
  }
  
  // ==================== JENIS SOAL ====================
  
  /// Get all jenis soal
  Future<List<JenisSoal>> getJenisSoal() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/jenis-soal.php'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((item) => JenisSoal.fromJson(item)).toList();
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to load jenis soal');
        }
      } else {
        throw Exception('Failed to load jenis soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Get single jenis soal by ID
  Future<JenisSoal> getJenisSoalById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/jenis-soal.php?id=$id'));
      
      if (response.statusCode == 200) {
        return JenisSoal.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load jenis soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Create new jenis soal
  Future<Map<String, dynamic>> createJenisSoal(JenisSoal jenisSoal) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/jenis-soal.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jenisSoal.toJson()),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to create jenis soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Update jenis soal
  Future<Map<String, dynamic>> updateJenisSoal(int id, JenisSoal jenisSoal) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/jenis-soal.php?id=$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jenisSoal.toJson()),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to update jenis soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Delete jenis soal
  Future<Map<String, dynamic>> deleteJenisSoal(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/jenis-soal.php?id=$id'));
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        }
        return {'success': true, 'message': 'Deleted successfully'};
      } else {
        throw Exception('Failed to delete jenis soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==================== USERS ====================
  
  /// Get all users
  Future<List<AdminUser>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdminUser.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Get user by ID
  Future<AdminUser> getUserById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$id'));
      
      if (response.statusCode == 200) {
        return AdminUser.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Create user
  Future<AdminUser> createUser(AdminUser user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return AdminUser.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Update user
  Future<AdminUser> updateUser(int id, AdminUser user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      
      if (response.statusCode == 200) {
        return AdminUser.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Delete user
  Future<void> deleteUser(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==================== TRANS USER ====================
  
  /// Get all transactions
  Future<List<TransUser>> getTransactions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/trans-user.php'));
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? jsonResponse;
        return data.map((item) => TransUser.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Get transactions by user ID
  Future<List<TransUser>> getTransactionsByUser(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/trans-user.php?id_user=$userId'),
      );
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? jsonResponse;
        return data.map((item) => TransUser.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Get transactions by jenis soal ID
  Future<List<TransUser>> getTransactionsByJenisSoal(int jenisSoalId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/trans-user.php?id_jenis_soal=$jenisSoalId'),
      );
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? jsonResponse;
        return data.map((item) => TransUser.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==================== DASHBOARD STATS ====================
  
  /// Get dashboard statistics
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/dashboard.php'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return jsonResponse['data'];
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to load dashboard stats');
        }
      } else {
        throw Exception('Failed to load dashboard stats');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==================== SOAL MANAGEMENT ====================
  
  /// Get list of soal with pagination, search, and filter
  Future<Map<String, dynamic>> getSoal({
    int page = 1,
    int limit = 20,
    String? search,
    int? jenisSoalId,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      
      if (jenisSoalId != null) {
        queryParams['jenis_soal_id'] = jenisSoalId.toString();
      }
      
      final uri = Uri.parse('$baseUrl/soal.php').replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return {
            'data': jsonResponse['data'],
            'pagination': jsonResponse['pagination'],
          };
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to load soal');
        }
      } else {
        throw Exception('Failed to load soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Get single soal by ID with opsi jawaban
  Future<Map<String, dynamic>> getSoalById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/soal.php?id=$id'),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return jsonResponse['data'];
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to load soal');
        }
      } else {
        throw Exception('Failed to load soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Create new soal with opsi jawaban
  Future<Map<String, dynamic>> createSoal({
    required int jenisSoalId,
    required String soal,
    String? gambar,
    String? pembahasan,
    required List<Map<String, dynamic>> opsiJawaban,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/soal.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'jenis_soal_id': jenisSoalId,
          'soal': soal,
          'gambar': gambar,
          'pembahasan': pembahasan,
          'opsi_jawaban': opsiJawaban,
        }),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return jsonResponse;
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to create soal');
        }
      } else {
        throw Exception('Failed to create soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Update existing soal
  Future<Map<String, dynamic>> updateSoal({
    required int id,
    required int jenisSoalId,
    required String soal,
    String? gambar,
    String? pembahasan,
    required List<Map<String, dynamic>> opsiJawaban,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/soal.php?id=$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'jenis_soal_id': jenisSoalId,
          'soal': soal,
          'gambar': gambar,
          'pembahasan': pembahasan,
          'opsi_jawaban': opsiJawaban,
        }),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return jsonResponse;
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to update soal');
        }
      } else {
        throw Exception('Failed to update soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Delete soal by ID
  Future<Map<String, dynamic>> deleteSoal(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/soal.php?id=$id'),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return jsonResponse;
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to delete soal');
        }
      } else {
        throw Exception('Failed to delete soal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
