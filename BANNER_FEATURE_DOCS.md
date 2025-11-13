# Dokumentasi Banner Iklan Premium Exam

## 📢 Overview

Fitur banner carousel yang menampilkan iklan ujian-ujian premium dengan desain menarik, auto-play, dan animasi smooth untuk meningkatkan engagement dan konversi penjualan.

## ✨ Fitur Utama

### 1. **Auto-Playing Carousel**
- **Auto-play**: Banner berganti otomatis setiap 4 detik
- **Smooth Transition**: Animasi transisi dengan curve `fastOutSlowIn` (800ms)
- **Swipeable**: User bisa swipe manual untuk navigasi
- **Enlarged Center Page**: Card di tengah lebih besar (viewport fraction 0.9)

### 2. **Visual Design**

#### Banner Card Features:
- **Gradient Background**: Setiap card punya warna unik dengan gradient
  - Best Seller: Merah (#FF6B6B)
  - Hot Sale: Kuning (#FFB800)
  - Trending: Tosca (#4ECDC4)
- **Decorative Circles**: Background circles untuk efek depth
- **Shadow Effect**: Box shadow dengan opacity 0.4 untuk floating effect
- **Rounded Corners**: Border radius XL (16px)

#### Content Elements:
1. **Badge**: Label status (BEST SELLER, HOT SALE, TRENDING)
2. **Thumbnail Emoji**: Large icon ujian (🎯, 📋, 🇬🇧)
3. **Title**: Nama ujian dengan font bold (max 2 lines)
4. **Description**: Deskripsi singkat (max 1 line)
5. **Pricing Section**:
   - Harga diskon (bold, besar)
   - Harga asli (coret)
   - Discount badge (persentase)

### 3. **Smooth Page Indicator**
- **Expanding Dots Effect**: Dot aktif mengembang 3x
- **Color**: Primary blue dengan opacity 30% untuk inactive
- **Position**: Di bawah carousel dengan spacing

### 4. **Interactive Features**
- **Hover Effect**: Cursor pointer saat hover
- **Tap to Detail**: Klik banner langsung ke Exam Detail Screen
- **Responsive**: Auto-adjust untuk berbagai ukuran layar

## 🎨 Design Specifications

### Color Scheme per Banner:
```dart
// Banner 1 - UTBK (Best Seller)
Color: #FF6B6B (Red)
Badge: "BEST SELLER"
Discount: 30%
Price: Rp 150k → Rp 105k

// Banner 2 - CPNS (Hot Sale)
Color: #FFB800 (Yellow)
Badge: "HOT SALE"
Discount: 40%
Price: Rp 200k → Rp 120k

// Banner 3 - TOEFL (Trending)
Color: #4ECDC4 (Tosca)
Badge: "TRENDING"
Discount: 25%
Price: Rp 175k → Rp 131k
```

### Typography:
- **Badge Text**: Caption, Bold, 11px
- **Title**: Heading3, Bold, White
- **Description**: BodySmall, White 90% opacity
- **Price (Discounted)**: Heading3, Bold, White
- **Price (Original)**: BodySmall, White 70% opacity, Line-through

### Spacing:
- **Banner Height**: 200px
- **Margin**: Horizontal XS (4px)
- **Padding**: All sides LG (24px)
- **Top Margin**: LG (24px)
- **Bottom Margin**: MD (16px)
- **Indicator Spacing**: MD (16px)

## 🏗️ Implementation Details

### Dependencies:
```yaml
carousel_slider: ^4.2.1
smooth_page_indicator: ^1.1.0
```

### Data Structure:
```dart
final List<Map<String, dynamic>> _premiumExams = [
  {
    'exam': Exam(...),      // Exam model instance
    'discount': 30,         // Discount percentage (int)
    'badge': 'BEST SELLER', // Badge text (String)
    'color': Color(...),    // Banner color (Color)
  },
  // ... more items
];
```

### Carousel Options:
```dart
CarouselOptions(
  height: 200,                    // Fixed height
  viewportFraction: 0.9,          // 90% width
  enlargeCenterPage: true,        // Enlarge center
  autoPlay: true,                 // Auto-play enabled
  autoPlayInterval: 4 seconds,    // Change every 4s
  autoPlayAnimationDuration: 800ms, // Animation duration
  autoPlayCurve: Curves.fastOutSlowIn, // Smooth curve
)
```

### Indicator Effect:
```dart
ExpandingDotsEffect(
  dotHeight: 8,
  dotWidth: 8,
  activeDotColor: AppColors.primary,
  dotColor: AppColors.primary.withOpacity(0.3),
  expansionFactor: 3, // Active dot 3x larger
)
```

## 📱 User Flow

```
Home Screen Loaded
  ↓
Banner Auto-play Starts (4s interval)
  ↓
User Sees Premium Exams
  ↓
[Option A] Wait for auto-change
[Option B] Swipe manually
[Option C] Tap banner
  ↓
Navigate to Exam Detail Screen
  ↓
User can purchase exam
```

## 🎯 Marketing Strategy

### Banner Content Strategy:
1. **Banner 1 (Best Seller)**: Fokus pada popularitas dan kualitas
   - Badge: "BEST SELLER"
   - 5420 participants
   - Rating 4.9
   - Discount 30%

2. **Banner 2 (Hot Sale)**: Fokus pada discount besar
   - Badge: "HOT SALE"
   - Discount tertinggi (40%)
   - Bundle package value

3. **Banner 3 (Trending)**: Fokus pada trend dan relevance
   - Badge: "TRENDING"
   - Specific skill focus
   - Target score promise

### Conversion Optimization:
- ✅ Clear pricing (original + discount)
- ✅ Visible discount percentage
- ✅ Social proof (participants, rating)
- ✅ Urgency indicators (badge labels)
- ✅ One-tap access to detail

## 🚀 Performance Considerations

### Optimization:
- **Lazy Loading**: Only 3 banners loaded initially
- **Efficient Re-renders**: setState only updates indicator index
- **No Heavy Images**: Using emoji for thumbnails
- **Gradient Caching**: Gradient colors pre-defined

### Animation Performance:
- Hardware-accelerated transitions (GPU)
- Optimal duration (800ms - not too slow, not too fast)
- Smooth curve for natural feel

## 📊 Analytics Tracking (Future)

Recommended metrics to track:
- Banner view count per item
- Click-through rate (CTR)
- Average time spent per banner
- Conversion rate per banner
- Most popular exam from banner

## 🔮 Future Enhancements

### Phase 2:
1. **Dynamic Content**: Load banners from API
2. **A/B Testing**: Test different colors, discounts, messages
3. **Personalization**: Show relevant exams based on user history
4. **Time-based**: Show different banners for morning/evening
5. **Location-based**: Regional exam promotions

### Phase 3:
1. **Video Banners**: Short promo videos
2. **Interactive Elements**: Quiz preview, sample questions
3. **Countdown Timer**: Limited time offers
4. **User Reviews**: Show testimonials in banner
5. **Multi-language**: Localized content

## 🐛 Known Limitations

1. Data masih hardcoded (3 banner saja)
2. No analytics tracking yet
3. No admin panel untuk manage banners
4. Discount calculation manual (not from backend)
5. No banner scheduling system

## 🎓 Code Examples

### Adding New Banner:
```dart
// In _premiumExams list
{
  'exam': Exam(
    id: '4',
    title: 'New Exam Title',
    description: 'Description here',
    category: 'Category',
    duration: 120,
    totalQuestions: 100,
    difficulty: 'Sulit',
    participants: 1000,
    rating: 4.8,
    isFree: false,
    price: 150000,
    thumbnail: '📝',
  ),
  'discount': 35,
  'badge': 'NEW',
  'color': const Color(0xFF9B59B6), // Purple
},
```

### Customizing Carousel Speed:
```dart
// Change auto-play interval
autoPlayInterval: const Duration(seconds: 5), // 5 seconds

// Change animation duration
autoPlayAnimationDuration: const Duration(milliseconds: 1000), // 1 second
```

### Changing Indicator Style:
```dart
// Alternative: WormEffect
effect: WormEffect(
  dotHeight: 10,
  dotWidth: 10,
  activeDotColor: AppColors.primary,
  dotColor: AppColors.primary.withOpacity(0.3),
),

// Alternative: JumpingDotEffect
effect: JumpingDotEffect(
  dotHeight: 10,
  dotWidth: 10,
  activeDotColor: AppColors.primary,
  dotColor: AppColors.primary.withOpacity(0.3),
  jumpHeight: 15,
),
```

## 📚 References

- **carousel_slider**: https://pub.dev/packages/carousel_slider
- **smooth_page_indicator**: https://pub.dev/packages/smooth_page_indicator
- **Material Design**: https://m3.material.io/components/carousel

## ✅ Testing Checklist

- [ ] Banner auto-play working
- [ ] Manual swipe working
- [ ] Indicator updates correctly
- [ ] Tap navigates to detail
- [ ] Animations smooth (60fps)
- [ ] Responsive on different screens
- [ ] Colors match design
- [ ] Discount calculation correct
- [ ] Text overflow handled
- [ ] No memory leaks

---

**Created**: November 2024
**Last Updated**: November 2024
**Version**: 1.0.0
**Status**: ✅ Implemented
