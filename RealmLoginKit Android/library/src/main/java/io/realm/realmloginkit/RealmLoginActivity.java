package io.realm.realmloginkit;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import io.realm.ObjectServerError;
import io.realm.SyncCredentials;
import io.realm.SyncUser;


public class RealmLoginActivity extends AppCompatActivity implements View.OnClickListener, SyncUser.Callback {

    private static final String TAG = RealmLoginActivity.class.getName();

    private boolean isDarkMode;
    private String appTitle;
    private RelativeLayout logInPanel;
    private ProgressBar progressBar;
    private Button registerButton;
    private Button loginButton;
    private EditText serverUrlEdit;
    private EditText emailAddressEdit;
    private EditText passwordEdit;
    private CheckBox rememberCheckBox;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle extras = getIntent().getExtras();
        isDarkMode = extras.getBoolean(Constants.KEY_DARK_MODE, false);
        appTitle = extras.getString(Constants.KEY_APP_TITLE, "Object Server");

        initTheme();
        setContentView(R.layout.activity_login);

        TextView logInTitle = (TextView) findViewById(R.id.log_in_title);
        logInTitle.setText("Log Into " + appTitle);

        logInPanel = (RelativeLayout) findViewById(R.id.log_in_panel);
        progressBar = (ProgressBar) findViewById(R.id.progress_bar);

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
        logInPanel.setVisibility(View.GONE);
        progressBar.setVisibility(View.VISIBLE);
        SyncUser.loginAsync(syncCredentials, serverUrl, this);
    }

    private void handleRegister() {
        final Intent intent = new Intent(this, RealmRegisterActivity.class);
        intent.putExtra(Constants.KEY_DARK_MODE, isDarkMode);
        startActivity(intent);
    }

    @Override
    public void onSuccess(SyncUser user) {
        setResult(Constants.RESULT_CODE_OK);
        finish();
    }

    @Override
    public void onError(ObjectServerError error) {
        logInPanel.setVisibility(View.VISIBLE);
        progressBar.setVisibility(View.GONE);
        Toast.makeText(this, "Fail!", Toast.LENGTH_SHORT).show();
        Log.e(TAG, "error: " +error);
    }
}
