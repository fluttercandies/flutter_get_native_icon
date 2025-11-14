package com.example.flutter_get_native_icon

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Base64
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.ByteArrayOutputStream

/** FlutterGetNativeIconPlugin */
class FlutterGetNativeIconPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_get_native_icon")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "getAppIconPath" -> {
        val iconBase64 = getAppIconBase64()
        if (iconBase64 != null) {
          result.success(iconBase64)
        } else {
          result.error("UNAVAILABLE", "App icon not available", null)
        }
      }
      else -> result.notImplemented()
    }
  }

  private fun getAppIconBase64(): String? {
    return try {
      val drawable = applicationContext.packageManager.getApplicationIcon(applicationContext.packageName)
      val bitmap = drawable.toBitmap()
      val outputStream = ByteArrayOutputStream()
      bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream)
      Base64.encodeToString(outputStream.toByteArray(), Base64.NO_WRAP)
    } catch (e: Exception) {
      null
    }
  }

  private fun Drawable.toBitmap(): Bitmap {
    return if (this is BitmapDrawable && bitmap != null) {
      bitmap
    } else {
      val width = if (intrinsicWidth > 0) intrinsicWidth else 1
      val height = if (intrinsicHeight > 0) intrinsicHeight else 1
      val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
      val canvas = Canvas(bitmap)
      setBounds(0, 0, canvas.width, canvas.height)
      draw(canvas)
      bitmap
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
