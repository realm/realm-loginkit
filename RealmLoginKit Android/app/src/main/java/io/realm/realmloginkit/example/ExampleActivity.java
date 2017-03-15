package io.realm.realmloginkit.example;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import io.realm.realmloginkit.RealmLogoView;

public class ExampleActivity extends AppCompatActivity {

    public static final String KEY_DARK_MODE = "DARK_MODE";
    private boolean isDarkMode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setTheme();
        setContentView(R.layout.activity_example);
        final RealmLogoView firstLogoView = (RealmLogoView) findViewById(R.id.first);
        firstLogoView.setMonochromeLogo(isDarkMode);
        firstLogoView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                firstLogoView.setStrokeWidth(firstLogoView.getStrokeWidth() * 2);
                toggleTheme();
            }
        });
    }

    private void setTheme() {
        isDarkMode = getIntent().getBooleanExtra(KEY_DARK_MODE, false);
        if (isDarkMode) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                setTheme(android.R.style.Theme_Material);
            } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                setTheme(android.R.style.Theme_Holo);
            } else {
                setTheme(android.R.style.Theme);
            }
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                setTheme(android.R.style.Theme_Material_Light);
            } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                setTheme(android.R.style.Theme_Holo_Light);
            } else {
                setTheme(android.R.style.Theme_Light);
            }
        }
    }

    private void toggleTheme() {
        final Intent intent = new Intent(this, ExampleActivity.class);
        intent.putExtra(KEY_DARK_MODE, isDarkMode ? false : true);
        finish();
        startActivity(intent);
    }
}
