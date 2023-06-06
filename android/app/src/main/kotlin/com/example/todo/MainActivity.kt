package com.example.todo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.HomeWidgetMessageApi

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        HomeWidgetMessageApi.setUp(flutterEngine.dartExecutor.binaryMessenger, HomeWidget())
    }
    private class HomeWidget:HomeWidgetMessageApi{
        override fun addHomeWidget(listTodo: List<Any>) {
            TODO("Not yet implemented")
        }

    }
}



