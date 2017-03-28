package io.realm.realmloginkit;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

public class RealmRegisterActivity extends AppCompatActivity implements View.OnClickListener {

    private boolean isDarkMode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        isDarkMode = getIntent().getBooleanExtra(Constants.KEY_DARK_MODE, false);
        initTheme();
        setContentView(R.layout.activity_register);
        findViewById(R.id.log_in).setOnClickListener(this);
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
        finish();
    }
}
