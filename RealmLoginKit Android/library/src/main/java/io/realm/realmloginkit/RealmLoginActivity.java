package io.realm.realmloginkit;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Toast;

import io.realm.ObjectServerError;
import io.realm.SyncCredentials;
import io.realm.SyncUser;


public class RealmLoginActivity extends AppCompatActivity implements View.OnClickListener, SyncUser.Callback {

    private static final String TAG = RealmLoginActivity.class.getName();

    public static final String KEY_DARK_MODE = "DARK_MODE";

    private boolean isDarkMode;
    private Button registerButton;
    private Button loginButton;
    private EditText serverUrlEdit;
    private EditText emailAddressEdit;
    private EditText passwordEdit;
    private CheckBox rememberCheckBox;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        isDarkMode = getIntent().getBooleanExtra(KEY_DARK_MODE, false);
        initTheme();
        setContentView(R.layout.activity_login);

        registerButton = (Button) findViewById(R.id.register);
        registerButton.setOnClickListener(this);
        loginButton = (Button) findViewById(R.id.log_in);
        loginButton.setOnClickListener(this);

        serverUrlEdit = (EditText) findViewById(R.id.server_url);
        emailAddressEdit = (EditText) findViewById(R.id.email_address);
        passwordEdit = (EditText) findViewById(R.id.password);
        rememberCheckBox = (CheckBox) findViewById(R.id.remember);
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
        if (v.getId() == R.id.log_in) {
            handleLogIn();
        } else if (v.getId() == R.id.register) {
            handleRegister();
        }
    }

    private void handleLogIn() {
        final String serverUrl = serverUrlEdit.getText().toString();
        final String emailAddress = emailAddressEdit.getText().toString();
        final String password = passwordEdit.getText().toString();

        final SyncCredentials syncCredentials = SyncCredentials.usernamePassword(emailAddress, password);
        Log.d(TAG, "Start!");
        Toast.makeText(this, "Log in...", Toast.LENGTH_SHORT).show();
        SyncUser.loginAsync(syncCredentials, serverUrl, this);
    }

    private void handleRegister() {
        final Intent intent = new Intent(this, RealmRegisterActivity.class);
        intent.putExtra(RealmLoginActivity.KEY_DARK_MODE, isDarkMode);
        startActivity(intent);
    }

    @Override
    public void onSuccess(SyncUser user) {
        Toast.makeText(this, "Success!", Toast.LENGTH_SHORT).show();
        Log.d(TAG, "user: " +user);
    }

    @Override
    public void onError(ObjectServerError error) {
        Toast.makeText(this, "Fail!", Toast.LENGTH_SHORT).show();
        Log.e(TAG, "error: " +error);
    }
}
