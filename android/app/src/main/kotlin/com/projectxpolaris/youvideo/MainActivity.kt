package com.projectxpolaris.youvideo

import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.Window
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.decorView.apply {
            javaClass.declaredFields
                    .firstOrNull { it.name == "mSemiTransparentBarColor" }
                    ?.apply { isAccessible = true }
                    ?.setInt(this, Color.TRANSPARENT)
        }
        flutterEngine?.plugins?.add(MXPlayerPlugin())
    }

}
