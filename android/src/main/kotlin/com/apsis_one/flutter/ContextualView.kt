package com.apsis_one.flutter

import android.content.Context
import android.view.View
import io.flutter.plugin.platform.PlatformView
import com.apsis.android.apsisone.integration.ContextualMessagePlaceholder
import com.apsis.android.apsisone.util.Logger

internal class ContextualView(context: Context, id: Int, creationParams: Map<String?, Any?>?) :
    PlatformView {
    private val placeholderView: ContextualMessagePlaceholder

    override fun getView(): View {
        return placeholderView
    }

    override fun dispose() {}

    init {
        Logger.i("Create Contextual View")
        placeholderView = ContextualMessagePlaceholder(context)
        if (creationParams?.containsKey("discriminator") == true) {
            (creationParams["discriminator"] as? String)?.let { discriminator ->
                placeholderView.embedContextualMessage(discriminator)
            }
        } else {
            Logger.w("No discriminator for contextual view! Creation params: $creationParams")
        }
    }
}