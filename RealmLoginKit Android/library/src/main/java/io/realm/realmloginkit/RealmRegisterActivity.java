package io.realm.realmloginkit;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;

public class RealmRegisterActivity extends AppCompatActivity implements View.OnClickListener {

    private boolean isDarkMode;
    private String appTitle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle extras = getIntent().getExtras();
        isDarkMode = extras.getBoolean(Constants.KEY_DARK_MODE, false);
        appTitle = extras.getString(Constants.KEY_APP_TITLE, getResources().getString(R.string.default_app_title));

        initTheme();
        setContentView(R.layout.activity_register);

        TextView welcomeSignUp = (TextView) findViewById(R.id.welcome_sign_up);
        welcomeSignUp.setText(String.format(getResources().getString(R.string.welcome_sign_up), appTitle));

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
