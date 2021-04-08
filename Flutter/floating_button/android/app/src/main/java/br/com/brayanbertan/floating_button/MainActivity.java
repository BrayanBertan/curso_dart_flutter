package br.com.brayanbertan.floating_button;

import android.Manifest;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.Toast;
import android.view.View;
import android.widget.Button;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.yhao.floatwindow.FloatWindow;
import com.yhao.floatwindow.Screen;

import java.util.Set;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "fb";


    private MethodChannel.Result myResult;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel channel =    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(
                        (call, result) -> {
                            class  teste{
                                 public void func(){


                                     final AlertDialog dialog = new AlertDialog.Builder(MainActivity.this)
                                             .setTitle("Title")
                                             .setMessage("Example Message")
                                             .setPositiveButton("Ok", null)
                                             .setNegativeButton("Cancel", null)
                                             .show();
                                }


                            }

                            switch (call.method){
                                case "create":
                                    ImageView imageView = new ImageView(getApplicationContext());
                                    imageView.setImageResource(R.drawable.plus);

                                    FloatWindow.with(getApplicationContext())
                                            .setView(imageView)
                                            .setWidth(Screen.width,0.15f)
                                            .setHeight(Screen.width,0.15f)
                                            .setX(Screen.width,0.8f)
                                            .setY(Screen.height,0.3f)
                                            .setDesktopShow(true)
                                            .build();
                                        imageView.setOnClickListener(view -> {
                                        channel.invokeMethod("touch",null);
                                        });
                                    break;
                                case "show":
                                    FloatWindow.get().show();
                                    break;
                                case "hide":
                                    FloatWindow.get().hide();
                                    break;
                                case "isShowing":
                                    new teste().func();
                                   break;
                                default:
                                    result.notImplemented();
                            }

                        }

                );
    }




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    protected void onDestroy() {
        FloatWindow.destroy();
        super.onDestroy();
    }
}
