package io.realm.realmloginkit;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class RealmLoginActivity extends AppCompatActivity {

    public static final String KEY_DARK_MODE = "DARK_MODE";
    private boolean isDarkMode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        isDarkMode = getIntent().getBooleanExtra(RealmLoginActivity.KEY_DARK_MODE, false);
        initTheme();
        setContentView(R.layout.activity_login);
    }

    private void initTheme() {
        if (isDarkMode) {
            setTheme(android.support.v7.appcompat.R.style.Theme_AppCompat_NoActionBar);
        } else {
            setTheme(android.support.v7.appcompat.R.style.Theme_AppCompat_Light_NoActionBar);
        }
    }
}
