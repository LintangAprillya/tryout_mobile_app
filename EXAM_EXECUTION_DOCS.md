# Dokumentasi Fitur Ujian (Exam Feature)

## 📝 Overview

Fitur ujian lengkap dengan soal pilihan ganda dan isian, timer countdown, navigasi soal, dan hasil ujian dengan pembahasan.

## ✨ Fitur Utama

### 1. **Exam Screen** (`exam_screen.dart`)

Screen untuk mengerjakan ujian dengan berbagai tipe soal.

#### Features:
- ✅ **Dua Tipe Soal**:
  - **Pilihan Ganda** (Multiple Choice) - 4 opsi A, B, C, D
  - **Isian** (Fill in Blank) - Input text field

- ⏱️ **Timer Countdown**:
  - Display format HH:MM:SS
  - Warning merah jika < 5 menit
  - Auto-submit saat waktu habis

- 📊 **Progress Tracking**:
  - Progress bar linear
  - Percentage completion
  - Counter soal terjawab

- 🎯 **Question Navigation**:
  - Next/Previous buttons
  - Grid navigator (modal bottom sheet)
  - Color-coded status:
    - 🟢 Hijau: Sudah dijawab
    - 🟡 Kuning: Ditandai untuk review
    - ⚪ Abu-abu: Belum dijawab
    - 🔵 Biru: Soal aktif

- 🚩 **Mark for Review**:
  - Flag soal untuk review nanti
  - Visual indicator di navigator

- 💾 **Auto-Save Answers**:
  - Jawaban tersimpan otomatis
  - Tidak hilang saat pindah soal

- ⚠️ **Exit Confirmation**:
  - Dialog konfirmasi saat keluar
  - Warning jawaban akan hilang

#### UI Components:

**Top Bar:**
- Close button (merah)
- Exam title
- Question counter (X dari Y)
- Timer dengan icon ⏱️

**Progress Bar:**
- Linear progress indicator
- Percentage text
- Answered counter

**Question Card:**
- Question type badge (Pilihan Ganda/Isian)
- Points indicator
- Question text
- Answer options/input field
- Mark for review button

**Bottom Navigation:**
- Grid navigator button
- Previous button (if applicable)
- Next/Submit button

### 2. **Question Types**

#### A. **Multiple Choice** (Pilihan Ganda)

**Display:**
- 4 options dengan label A, B, C, D
- Circular checkbox design
- Hover effect
- Selected state dengan warna primary
- Check icon saat dipilih

**Interaction:**
- Tap opsi untuk memilih
- Visual feedback instant
- Bisa ganti jawaban kapan saja

#### B. **Fill in Blank** (Isian)

**Display:**
- Text input field dengan hint
- Background abu-abu muda
- Border focus biru
- Check icon saat sudah diisi

**Interaction:**
- Ketik langsung di field
- Auto-save on change
- Support semua karakter

**Answer Checking:**
- Case insensitive
- Trim whitespace
- Exact match dengan jawaban benar

### 3. **Exam Result Screen** (`exam_result_screen.dart`)

Screen untuk menampilkan hasil ujian.

#### Features:

**Score Card:**
- Nilai besar di tengah (0-100)
- Grade letter (A, B, C, D, E)
- Congratulations message
- Gradient background sesuai grade:
  - 🟢 Hijau: 80-100 (A-B)
  - 🟡 Kuning: 60-79 (C-D)
  - 🔴 Merah: 0-59 (E)

**Statistics Grid:**
- ✅ Benar: X/Y soal
- ❌ Salah: Z soal
- ⭐ Poin: earned/max
- ⏱️ Waktu: HH:MM:SS

**Review Button:**
- Link ke pembahasan soal
- Icon visibility

**Bottom Actions:**
- Kembali ke Home
- Share Hasil (coming soon)

### 4. **Exam Review Screen** (`exam_result_screen.dart`)

Screen untuk melihat pembahasan setiap soal.

#### Features:

**Question Card:**
- Question number dengan status icon
- Question text
- User's answer (hijau jika benar, merah jika salah)
- Correct answer (jika salah)
- Explanation/Pembahasan (opsional)

**Color Coding:**
- 🟢 Hijau: Jawaban benar
- 🔴 Merah: Jawaban salah
- 💡 Biru: Pembahasan

## 🎨 Design System

### Color Scheme:
```dart
// Question status
Answered: AppColors.success (#4CAF50)
Marked: AppColors.warning (#FFC107)
Unanswered: AppColors.divider (#E0E0E0)
Current: AppColors.primary (#2260FF)

// Answer status
Correct: AppColors.success
Wrong: AppColors.error (#F44336)

// Timer warning
< 5 minutes: AppColors.error
Normal: AppColors.primary
```

### Typography:
- **Title**: Heading3, Bold
- **Question Text**: 16px, Semi-bold, height 1.6
- **Options**: 14px, Normal (Bold when selected)
- **Points**: 12px, Bold

## 🏗️ Data Structure

### Question Model:
```dart
enum QuestionType {
  multipleChoice,
  fillInBlank,
}

class Question {
  final String id;
  final String examId;
  final String text;
  final QuestionType type;
  final List<String>? options;      // For multiple choice
  final String correctAnswer;
  final String? explanation;
  final int points;
}
```

### Sample Questions:
```dart
// Multiple Choice Example
Question(
  id: '1',
  examId: 'exam_1',
  text: 'Berapakah hasil dari 15 × 8 + 12?',
  type: QuestionType.multipleChoice,
  options: ['120', '132', '142', '152'],
  correctAnswer: '132',
  points: 10,
)

// Fill in Blank Example
Question(
  id: '2',
  examId: 'exam_1',
  text: 'Ibu kota Indonesia adalah...',
  type: QuestionType.fillInBlank,
  correctAnswer: 'Jakarta',
  points: 10,
)
```

## 🎯 User Flow

```
Exam Detail Screen
  ↓ (Tap "Mulai Ujian")
Confirmation Dialog
  ↓ (Tap "Mulai")
Exam Screen
  ├─ Answer questions
  ├─ Navigate between questions
  ├─ Mark for review
  └─ Submit exam
       ↓
Exam Result Screen
  ├─ View score & stats
  ├─ Review answers
  └─ Share result
       ↓
Exam Review Screen
  └─ See correct answers & explanations
```

## ⏱️ Timer Logic

### Time Format:
```dart
// More than 1 hour: "HH:MM:SS"
// 1-59 minutes: "MM:SS"
// Less than 1 minute: "SS detik"

String _formatTime(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int secs = seconds % 60;
  return '${hours.toString().padLeft(2, '0')}:'
         '${minutes.toString().padLeft(2, '0')}:'
         '${secs.toString().padLeft(2, '0')}';
}
```

### Timer Behavior:
- Starts automatically when exam screen loads
- Updates every second
- Shows warning (red) when < 5 minutes
- Auto-submits when reaches 0

## 📊 Scoring System

### Calculation:
```dart
totalPoints = Sum of all question points
earnedPoints = Sum of points for correct answers
score = (earnedPoints / totalPoints) * 100
```

### Grade System:
- **A**: 90-100
- **B**: 80-89
- **C**: 70-79
- **D**: 60-69
- **E**: 0-59

### Answer Checking:
```dart
bool isCorrect(userAnswer, correctAnswer) {
  return userAnswer.trim().toLowerCase() == 
         correctAnswer.toLowerCase();
}
```

## 🎮 Interactive Features

### 1. **Question Navigator Grid**
- Modal bottom sheet
- Draggable (0.5 - 0.9 screen height)
- 5 columns grid
- Tap to jump to question
- Close navigator after selection

### 2. **Answer Selection**
- Instant visual feedback
- Animated container (200ms)
- Hover cursor pointer
- Check icon on selected

### 3. **Exit Confirmation**
- WillPopScope for back button
- Custom dialog
- Warning message
- Two buttons: Batal / Keluar

### 4. **Submit Confirmation**
- Show answered/unanswered count
- Time remaining
- Two buttons: Batal / Submit

## 🚀 Performance

### Optimizations:
- Lazy loading questions
- Efficient answer storage (Map)
- Minimal rebuilds (setState scope)
- Timer cleanup on dispose

### State Management:
```dart
_currentQuestionIndex: int          // Current question
_remainingSeconds: int              // Timer
_answers: Map<int, dynamic>         // User answers
_isMarkedForReview: Map<int, bool>  // Marked questions
```

## 📱 Sample Questions Included

8 sample questions dengan variasi:
1. Matematika (Multiple Choice) - 10 poin
2. Geografi (Fill in Blank) - 10 poin
3. Teknologi (Multiple Choice) - 10 poin
4. Pengetahuan Umum (Fill in Blank) - 10 poin
5. Sejarah (Fill in Blank) - 10 poin
6. Komputer (Multiple Choice) - 10 poin
7. Matematika Advance (Fill in Blank) - 15 poin
8. Pemrograman (Multiple Choice) - 10 poin

**Total**: 85 poin

## 🔮 Future Enhancements

### Phase 2:
1. **More Question Types**:
   - Multiple answers (checkbox)
   - True/False
   - Matching pairs
   - Essay/Long text

2. **Advanced Features**:
   - Image in questions
   - Math equations (LaTeX)
   - Audio questions
   - Video explanations

3. **Analytics**:
   - Time per question
   - Difficulty analysis
   - Performance history
   - Progress tracking

### Phase 3:
1. **Offline Support**:
   - Download exam for offline
   - Sync answers when online
   - Cached questions

2. **Adaptive Testing**:
   - Adjust difficulty based on performance
   - AI-powered question selection
   - Personalized recommendations

## 🐛 Known Limitations

1. Questions are hardcoded (not from API)
2. No image/media support yet
3. No offline mode
4. Single attempt only
5. No pause feature
6. Basic answer checking (exact match)

## 📚 Dependencies

```yaml
# Already included in project
google_fonts: ^6.1.0
flutter_staggered_animations: ^1.1.1
```

## ✅ Testing Checklist

- [ ] Timer countdown working
- [ ] Auto-submit at 0:00
- [ ] Multiple choice selection
- [ ] Fill in blank input
- [ ] Answer persistence when navigating
- [ ] Mark for review toggle
- [ ] Question navigator grid
- [ ] Previous/Next buttons
- [ ] Submit confirmation dialog
- [ ] Exit confirmation dialog
- [ ] Score calculation correct
- [ ] Result screen display
- [ ] Review screen with answers
- [ ] Back navigation working

---

**Created**: November 2024
**Last Updated**: November 2024
**Version**: 1.0.0
**Status**: ✅ Implemented
