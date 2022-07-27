package com.apsis_one.flutter

import android.content.Context
import com.apsis.android.apsisone.util.Logger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class ContextualViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        Logger.i("ApsisViewFactory")
        val creationParams = args as Map<String?, Any?>?
        context?.let {
            Logger.i("ApsisViewFactory create")
            return ContextualView(it, viewId, creationParams)
        } ?: run {
            throw Exception("Context required for this operation")
        }
    }

}