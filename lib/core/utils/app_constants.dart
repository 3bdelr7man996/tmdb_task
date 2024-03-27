import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_rated_movies/extensions/media_query_extension.dart';

import 'app_colors.dart';
import 'app_font.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationType {
  final String key;
  final String value;

  const NotificationType({required this.key, required this.value});
}

class AppConstants {
  static Map<String, String> libHeader = {
    'Accept': 'application/json',
    'Connection': 'keep-alive',
    // 'ValidationToken': AppStrings.staticToken,
    "Accept-Language": 'ar', //todo
  };

  static customButton(BuildContext context,
      {required void Function()? onPressed,
      required String title,
      double widthRatio = 0.8,
      double hightRatio = 0.06,
      backgroundColor,
      Color? sideColor,
      textColor,
      isBoldedText = true,
      String iconUrl = "",
      double elevation = 0,
      bool isSide = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(elevation),
        enableFeedback: true,
        side: MaterialStateProperty.all(isSide
            ? BorderSide(color: sideColor!, width: 1)
            : const BorderSide(color: Colors.transparent)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shadowColor: MaterialStateProperty.all(AppColors.primaryColor),
        fixedSize: MaterialStateProperty.all(
          Size(context.width * widthRatio, context.height * hightRatio),
        ),
      ),
      child: iconUrl.isEmpty
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: sBigBlackFont().copyWith(
                color: textColor,
                fontWeight: isBoldedText ? FontWeight.bold : FontWeight.normal,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: sBigBlackFont().copyWith(
                      color: textColor,
                      fontWeight:
                          isBoldedText ? FontWeight.bold : FontWeight.normal),
                ),
                const SizedBox(
                  width: 5,
                ),
                customAssetImage(
                  imagePath: "assets/icons/$iconUrl",
                  width: 35.0,
                  height: 35.0,
                ),
              ],
            ),
    );
  }

  static customAssetImage({
    required String imagePath,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    height,
    width,
    Color? color,
    BoxFit? fit = BoxFit.cover,
  }) {
    return Padding(
      padding: padding,
      child: Image.asset(
        imagePath,
        height: height?.toDouble(),
        color: color,
        width: width?.toDouble(),
        fit: fit,
      ),
    );
  }

  static customFileImage({
    required File file,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    height,
    width,
    Color? color,
    BoxFit? fit = BoxFit.cover,
  }) {
    return Padding(
      padding: padding,
      child: Image.file(
        file,
        height: height?.toDouble(),
        color: color,
        width: width?.toDouble(),
        fit: fit,
      ),
    );
  }

  static customNetworkImage({
    required String imagePath,
    String errorImg = 'assets/icons/tmdb_logo.jpg',
    double? height,
    double? width,
    BoxFit? fit = BoxFit.fill,
  }) {
    return Image.network(
      imagePath,
      fit: fit,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, x, u) => customAssetImage(
        imagePath: errorImg,
        height: height,
        width: width,
      ),
    );
  }

  static memoryNetworkImage({
    required String imagePath,
    required String placeholder,
    String errorImg = 'assets/images/app_icon.png',
    double? height,
    double? width,
    BoxFit? fit = BoxFit.fill,
  }) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) => const CupertinoActivityIndicator(
        color: Colors.grey,
      ), // Display a placeholder while the image loads
      errorWidget: (context, url, error) => customAssetImage(
        imagePath: errorImg,
        height: height,
        width: width,
      ), // Display an error icon if the image fails to load
    );
  }

  static PreferredSizeWidget customAppBar(BuildContext context,
      {Widget? actionIcon,
      Widget? leadingIcon,
      required Widget title,
      PreferredSizeWidget? bottom,
      bool? centerTitle = false,
      bool backButton = true,
      // bool search = false,
      double titleSpacing = 0,
      double elevation = 0}) {
    return AppBar(
        centerTitle: centerTitle,
        bottom: bottom,
        titleSpacing: titleSpacing,
        toolbarHeight: MediaQuery.of(context).size.height * .07,
        actions: actionIcon != null ? [actionIcon] : null,
        // automaticallyImplyLeading: false,
        leading: leadingIcon,
        backgroundColor: Colors.white,
        elevation: elevation,
        iconTheme: const IconThemeData(color: Colors.black),
        title: title);
  }

  static customListTile(
      {required String imgName,
      required String title,
      void Function()? onTap}) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Image.asset(
            "assets/icons/$imgName.png",
            color: AppColors.primaryColor,
            width: 25,
            height: 25,
          ),
          title: Text(title,
              style: sBigBlackFont().copyWith(
                color: AppColors.primaryColor,
              )),
          style: ListTileStyle.list,
          onTap: onTap,
        ),
      ),
    );
  }

  static customFormField({
    bool obscureText = false,
    TextEditingController? controller,
    String label = '',
    Widget? prefixIcon,
    Widget? suffixIcon,
    double? height,
    String? validationMsg,
    void Function()? onSuffixPressed,
    void Function(String)? onChanged,
  }) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: AppColors.primaryColor),
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 12,
            color: AppColors.primaryColor,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: suffixIcon,
                  onPressed: onSuffixPressed,
                )
              : null,
          suffixIconColor: Colors.black54,
        ),
        validator: validationMsg != null
            ? (text) {
                if (text!.isEmpty) {
                  return validationMsg;
                }
                return null;
              }
            : null,
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }

  static navigatePush(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static navigatePushRemoveUntil(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  static navigatePushReplace(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: screen.toString()),
            builder: (context) => screen));
  }

  /// BUILD SPECIFIC NUMBER OF COLUMNS WITH SPECIFIC TEXT
  static List<DataColumn> dynamicDataColumn({
    int numberOfColumns = 0,
    required List<String> columnTexts,
    Color? textColor = AppColors.whiteColor,
  }) {
    return List<DataColumn>.generate(numberOfColumns, (int index) {
      return DataColumn(
        label: Expanded(
          child: Text(
            columnTexts[index],
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      );
    });
  }

  /// BUILD SPECIFIC NUMBER OF Rows CELL WITH SPECIFIC WIDGET
  static List<DataCell> dynamicDataCell({
    int numberOfColumns = 0,
    required List<Widget> columnWidget,
    //Color? textColor = AppColors.blueColor,
  }) {
    return List<DataCell>.generate(numberOfColumns, (int index) {
      return DataCell(
        columnWidget[index],
      );
    });
  }

  /// BUILD SPECIFIC NUMBER OF Rows AND CELLS OF ROW WITH THEIR CELL
  static List<DataRow> dynamicDataRow({
    int numberOfColumns = 0,
    int numberOfRows = 0,
    required List<List<Widget>> columnWidget,
    //Color? textColor = AppColors.blueColor,
  }) {
    return List<DataRow>.generate(numberOfRows, (int index) {
      return DataRow(
        color: MaterialStateColor.resolveWith(
          (states) => index % 2 == 0
              ? AppColors.lightTable
              : AppColors.darkTable, // Change data row color
        ),
        cells: AppConstants.dynamicDataCell(
          numberOfColumns: numberOfColumns,
          columnWidget: columnWidget[index],
        ),
      );
    });
  }
}
