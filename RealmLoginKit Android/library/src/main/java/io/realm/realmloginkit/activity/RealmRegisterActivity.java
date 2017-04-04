package io.realm.realmloginkit.activity;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;

import io.realm.realmloginkit.util.Constants;
import io.realm.realmloginkit.R;

public class RealmRegisterActivity extends AppCompatActivity implements View.OnClickListener, TextWatcher {

    private boolean isDarkMode;
    private String appTitle;
    private EditText serverUrlEdit;
    private EditText emailAddressEdit;
    private EditText passwordEdit;
    private EditText confirmPasswordEdit;
    private Button signUpButton;
    private CheckBox rememberCheckBox;

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
        signUpButton = (Button) findViewById(R.id.sign_up);

        serverUrlEdit = (EditText) findViewById(R.id.server_url);
        emailAddressEdit = (EditText) findViewById(R.id.email_address);
        passwordEdit = (EditText) findViewById(R.id.password);
        confirmPasswordEdit = (EditText) findViewById(R.id.confirm_password);
        rememberCheckBox = (CheckBox) findViewById(R.id.remember);

        serverUrlEdit.addTextChangedListener(this);
        emailAddressEdit.addTextChangedListener(this);
        passwordEdit.addTextChangedListener(this);
        confirmPasswordEdit.addTextChangedListener(this);
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

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {
    }

    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {
        final String serverUrl = serverUrlEdit.getText().toString();
        final String emailAddress = emailAddressEdit.getText().toString();
        final String password = passwordEdit.getText().toString();
        final String confirmPassword = confirmPasswordEdit.getText().toString();
        if (serverUrl.isEmpty() || emailAddress.isEmpty() || password.isEmpty() || !password.equals(confirmPassword) || !emailAddress.contains("@")) {
            signUpButton.setEnabled(false);
        } else {
            signUpButton.setEnabled(true);
        }
    }

    @Override
    public void afterTextChanged(Editable s) {
    }
}
