import 'package:flutter/material.dart';

/// Extension untuk memudahkan akses theme colors
extension ThemeExtension on BuildContext {
  /// Get current brightness (light or dark)
  Brightness get brightness => Theme.of(this).brightness;
  
  /// Check if current theme is dark
  bool get isDarkMode => brightness == Brightness.dark;
  
  /// Get appropriate color based on theme
  Color adaptiveColor({
    required Color light,
    required Color dark,
  }) {
    return isDarkMode ? dark : light;
  }
  
  /// Get card color from theme
  Color get cardColor => Theme.of(this).cardColor;
  
  /// Get background color from theme
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  
  /// Get primary color from theme
  Color get primaryColor => Theme.of(this).primaryColor;
  
  /// Get text color from theme
  Color get textColor => Theme.of(this).textTheme.bodyLarge?.color ?? Colors.black;
  
  /// Get secondary text color from theme
  Color get secondaryTextColor => Theme.of(this).textTheme.bodySmall?.color ?? Colors.grey;
  
  /// Get hint color from theme
  Color get hintColor => Theme.of(this).hintColor;
  
  /// Get divider color from theme
  Color get dividerColor => Theme.of(this).dividerColor;
  
  /// Get surface color from theme
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  
  /// Get on-surface color (text on surface) from theme
  Color get onSurfaceColor => Theme.of(this).colorScheme.onSurface;
}

/// Helper widget untuk container yang adaptif dengan theme
class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Color? lightColor;
  final Color? darkColor;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  
  const AdaptiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.lightColor,
    this.darkColor,
    this.boxShadow,
    this.border,
  });
  
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: isDark 
            ? (darkColor ?? context.cardColor)
            : (lightColor ?? context.cardColor),
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        border: border,
      ),
      child: child,
    );
  }
}

/// Helper widget untuk text yang adaptif dengan theme
class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? lightColor;
  final Color? darkColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  
  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.lightColor,
    this.darkColor,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });
  
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final Color color = isDark 
        ? (darkColor ?? context.textColor)
        : (lightColor ?? context.textColor);
    
    return Text(
      text,
      style: style?.copyWith(color: color) ?? TextStyle(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
