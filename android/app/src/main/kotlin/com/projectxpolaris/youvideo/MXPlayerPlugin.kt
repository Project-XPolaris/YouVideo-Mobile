package com.projectxpolaris.youvideo

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import androidx.core.content.ContextCompat.startActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MXPlayerPlugin : FlutterPlugin,MethodChannel.MethodCallHandler {
    private var methodChannel: MethodChannel? = null
    private var context : Context? = null
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        methodChannel = MethodChannel(binding.binaryMessenger, CHANNEL_NAME)
        methodChannel?.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel?.setMethodCallHandler(null)
        methodChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method) {
            METHOD_NAME -> play(call,result)
            "playWithSubtitles" -> playWithSubtitles(call, result)
        }
    }
    private fun play(call: MethodCall, result: MethodChannel.Result){
        val playUrl = call.argument<String>("playUrl") ?: return
        val token = call.argument<String>("token")
        val headers = arrayListOf<String>()
        if (token != null) {
            headers.add("Authorization")
            headers.add("Bearer $token")
        }
        launch(playUrl,headers){

        }
    }
    private fun playWithSubtitles(call: MethodCall, result: MethodChannel.Result){
        val playUrl = call.argument<String>("playUrl")
        val subtitlesUrl = call.argument<String>("subtitlesUrl")
        val token = call.argument<String>("token")
        if (playUrl == null || subtitlesUrl == null) {
            return
        }
        val headers = arrayListOf<String>()
        if (token != null) {
            headers.add("Authorization")
            headers.add("Bearer $token")
        }
        launch(playUrl,headers) {
            with(it) {
                putExtra("subs", arrayOf(Uri.parse(subtitlesUrl)))
            }
        }
    }
    private fun launch(playUrl : String,headers:ArrayList<String>?,applyContent: (intent:Intent) -> Unit) {
        if (context == null) {
            return
        }
        val packageManager: PackageManager = context!!.packageManager;
        try {
            packageManager.getLaunchIntentForPackage("com.mxtech.videoplayer.pro")
            val intent = Intent().apply {
                action = Intent.ACTION_VIEW
                setDataAndType(Uri.parse(playUrl),"video/*")
                `package` = "com.mxtech.videoplayer.pro"
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                putStringArrayListExtra("headers",headers)
            }
            applyContent(intent)
            if (context != null) {
                startActivity(context!!,intent,null)
            }
        } catch (e: ActivityNotFoundException) {
            //MX Player pro isn't installed
            try {
                packageManager.getLaunchIntentForPackage("com.mxtech.videoplayer.ad")
                val intent = Intent().apply {
                    action = Intent.ACTION_VIEW
                    setDataAndType(Uri.parse(playUrl),"video/*")
                    `package` = "com.mxtech.videoplayer.ad"
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    putStringArrayListExtra("headers",headers)
                }
                applyContent(intent)
                startActivity(context!!,intent,null)
            } catch (er: ActivityNotFoundException) {
                //No version of MX Player is installed.You should let the user know
            }
        }
    }
    companion object {
        const val CHANNEL_NAME  = "mxplugin"
        const val METHOD_NAME  = "play"
    }

}