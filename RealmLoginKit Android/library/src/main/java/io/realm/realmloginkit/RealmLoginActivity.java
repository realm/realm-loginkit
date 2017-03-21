package io.realm.realmloginkit;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class RealmLoginActivity extends AppCompatActivity implements View.OnClickListener {

    public static final String KEY_DARK_MODE = "DARK_MODE";
    private boolean isDarkMode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        isDarkMode = getIntent().getBooleanExtra(KEY_DARK_MODE, false);
        initTheme();
        setContentView(R.layout.activity_login);
        findViewById(R.id.login).setOnClickListener(this);
    }

    private void initTheme() {
        if (isDarkMode) {
            setTheme(android.support.v7.appcompat.R.style.Theme_AppCompat_NoActionBar);
        } else {
            setTheme(android.support.v7.appcompat.R.style.Theme_AppCompat_Light_NoActionBar);
        }
    }

    @Override
    public void onClick(View v) {
        final Intent intent = new Intent(this, RealmRegisterActivity.class);
        intent.putExtra(RealmLoginActivity.KEY_DARK_MODE, isDarkMode);
        startActivity(intent);
    }
}
