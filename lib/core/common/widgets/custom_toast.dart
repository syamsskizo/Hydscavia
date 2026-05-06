// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// enum ToastType { success, warning, info, error }

// class CustomToast extends StatelessWidget {
//   final String title;
//   final String message;
//   final ToastType type;
//   final VoidCallback? onClose;

//   const CustomToast({
//     super.key,
//     required this.title,
//     required this.message,
//     required this.type,
//     this.onClose,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (type == ToastType.error) {
//       // Custom error toast style (matches provided design)
//       return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF5B5B5B),
//           borderRadius: BorderRadius.circular(32),
//         ), // BoxDecoration
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(width: 12),
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFF6B6B), // Red
//                 shape: BoxShape.circle,
//                 border: Border.all(color: const Color(0xFF313131), width: 5),
//               ), // BoxDecoration
//               child: const Center(
//             child: Icon(Icons.close, color: Color(0xFF313131), size: 32),
//           ), // Center
//         ), // Container
//         const SizedBox(width: 10),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 18),
//             child: Text(
//               message,
//               style: GoogleFonts.outfit(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w300,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ), // Text
//           ), // Padding
//         ), // Expanded
//         const SizedBox(width: 18),
//       ],
//     ), // Row
//   ); // Container
// }

// final Color mainColor;
// switch (type) {
//       case ToastType.success:
//         mainColor = const Color(0xFF31C440);
//       case ToastType.warning:
//         mainColor = const Color(0xFFEBC400);
//       case ToastType.info:
//         mainColor = const Color(0xFF417BE1);
//       default:
//         mainColor = Colors.red;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       margin: EdgeInsets.only(
//         top: MediaQuery.of(context).padding.top,
//         right: 16,
//         left: 16,
//         bottom: 16,
//       ), // EdgeInsets.only
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border(left: BorderSide(color: mainColor, width: 5)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ), // BoxShadow
//         ],
//       ), // BoxDecoration
//       child: Row(
//         children: [
//           _buildIcon(mainColor),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//               style: GoogleFonts.outfit(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ), // Text
//             const SizedBox(height: 4),
//             Text(
//               message,
//               style: GoogleFonts.outfit(
//                 fontSize: 14,
//                 color: Colors.black.withOpacity(0.6),
//               ),
//             ), // Text
//           ],
//         ), // Column
//       ), // Expanded
//       IconButton(
//         onPressed: onClose,
//         icon: Icon(Icons.close, color: Color(0xFF131C66), size: 20),
//         padding: EdgeInsets.zero,
//         constraints: const BoxConstraints(),
//       ), // IconButton
//     ],
//   ), // Row
// ); // Container
// }

// Widget _buildIcon(Color mainColor) {
//   final String imagePath;

//   switch (type) {
//     case ToastType.success:
//       // imagePath = ImageConstant.successIcon;
//       imagePath = '';
//     case ToastType.warning:
//       // imagePath = ImageConstant.warningIcon;
//       imagePath = '';
//       case ToastType.info:
//       // imagePath = ImageConstant.infoIcon;
//       imagePath = '';
//     default:
//       // imagePath = ImageConstant.warningIcon;
//       imagePath = '';
//   }

//   return Container(
//     width: 35,
//     height: 35,
//     padding: const EdgeInsets.all(8),
//     decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
//     child: Image.asset(imagePath, color: Colors.white),
//   ); // Container
// }

// // toast that shown at the bottom of the screen
// void showCustomToast(
//   BuildContext context, {
//   required String title,
//   required String message,
//   required ToastType type,
//   Duration? duration,
// }) {
//   final overlay = ScaffoldMessenger.of(context);

//   overlay.showSnackBar(
//     SnackBar(
//       content: CustomToast(
//         title: title,
//         message: message,
//         type: type,
//         onClose: () {
//           overlay.hideCurrentSnackBar();
//         },
//       ), // CustomToast
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       duration: duration ?? const Duration(seconds: 4),
//       behavior: SnackBarBehavior.floating,
//       margin: EdgeInsets.zero,
//       padding: EdgeInsets.zero,
//       dismissDirection: DismissDirection.up,
//     ), // SnackBar
//   );
// }

// // toast that shown at the bottom of the screen
// void showCustomToastOverlay(
//   BuildContext context, {
//   required String title,
//   required String message,
//   required ToastType type,
//   Duration duration = const Duration(seconds: 4),
// }) {
//   final overlay = Overlay.of(context);
//   if (overlay == null) return;

//   // Create an OverlayEntry
//   late OverlayEntry overlayEntry;
//   overlayEntry = OverlayEntry(
//     builder: (context) => SafeArea(
//       child: Align(
//         alignment: Alignment.topCenter,
//         child: Material(
//           color: Colors.transparent,
//           child: CustomToast(
//             title: title,
//             message: message,
//             type: type,
//             onClose: () {
//               overlayEntry.remove();
//             },
//           ), // CustomToast
//         ), // Material
//       ),
//     ),
//   );

//   // Insert the OverlayEntry into the overlay
//   overlay.insert(overlayEntry);

//   // Remove after duration
//   Future.delayed(duration, () {
//     if (overlayEntry.mounted) {
//       overlayEntry.remove();
//     }
//   });
// }
                

                import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ToastType { success, warning, info, error }

class CustomToast extends StatelessWidget {
  final String title;
  final String message;
  final ToastType type;
  final VoidCallback? onClose;

  const CustomToast({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    // Jika tipenya error, pakai desain khusus
    if (type == ToastType.error) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(
          color: const Color(0xFF5B5B5B),
          borderRadius: BorderRadius.circular(32),
        ), // BoxDecoration
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B), // Red
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF313131), width: 5),
              ), // BoxDecoration
              child: const Center(
                child: Icon(Icons.close, color: Color(0xFF313131), size: 32),
              ), // Center
            ), // Container
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  message,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ), // Text
              ), // Padding
            ), // Expanded
            const SizedBox(width: 18),
          ],
        ), // Row
      ); // Container
    }

    // Untuk tipe selain error, tentukan mainColor
    Color mainColor;
    switch (type) {
      case ToastType.success:
        mainColor = const Color(0xFF31C440);
        break;
      case ToastType.warning:
        mainColor = const Color(0xFFEBC400);
        break;
      case ToastType.info:
        mainColor = const Color(0xFF417BE1);
        break;
      default:
        mainColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: 16,
        left: 16,
        bottom: 16,
      ), // EdgeInsets.only
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: mainColor, width: 5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ), // BoxShadow
        ],
      ), // BoxDecoration
      child: Row(
        children: [
          _buildIcon(mainColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ), // Text
                const SizedBox(height: 4),
                Text(
                  message,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ), // Text
              ],
            ), // Column
          ), // Expanded
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Color(0xFF131C66), size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ), // IconButton
        ],
      ), // Row
    ); // Container
  }

  Widget _buildIcon(Color mainColor) {
    String imagePath = '';

    switch (type) {
      case ToastType.success:
        imagePath = 'assets/success.png'; // Sesuaikan path assetmu
        break;
      case ToastType.warning:
        imagePath = 'assets/warning.png';
        break;
      case ToastType.info:
        imagePath = 'assets/info.png';
        break;
      default:
        imagePath = 'assets/warning.png';
    }

    return Container(
      width: 35,
      height: 35,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
      child: imagePath.isEmpty 
        ? const Icon(Icons.info, color: Colors.white, size: 18)
        : Image.asset(imagePath, color: Colors.white),
    ); // Container
  }
}

// Fungsi showCustomToast & showCustomToastOverlay tetap seperti sebelumnya