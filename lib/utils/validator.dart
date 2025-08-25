// lib/utils/validators.dart

class Validators {
  static String? required(String? value) {
  
    if (value == null || value.isEmpty) {
      return '• Email is required';
    } 
    return null;
  }

  static String? email(String? value) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return '• Email is required';
    } else if (!regex.hasMatch(value)) {
      return '• Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '• Password is required';
    } else if (value.length < 8) {
      return '• Password must be at least 8 characters';
    }
    return null;
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '• Password is required';
    }

    List<String> errors = [];

    if (value.length < 8) {
      errors.add('• At least 8 characters');
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add('• At least one uppercase letter');
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      errors.add('• At least one lowercase letter');
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      errors.add('• At least one number');
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      errors.add('• At least one special character');
    }

    return errors.isEmpty ? null : errors.join('\n');
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return '• Confirm Password is required';
    } else if (value != password) {
      return '• Passwords do not match';
    }
    return null;
  }

  
  /// Validasi nomor telepon Indonesia
  /// - Tidak boleh kosong
  /// - Minimal 9 digit, maksimal 15 digit
  /// - Boleh diawali +62 atau 0
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    // Hapus spasi dan tanda -
    final phone = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Cek format: boleh +62 atau 0 di depan
    final regex = RegExp(r'^(?:\+62|0)[0-9]{8,14}$');
    if (!regex.hasMatch(phone)) {
      return "Phone number is not valid";
    }

    return null; // valid
  }

  // Tambahkan validator lain sesuai kebutuhan
}
