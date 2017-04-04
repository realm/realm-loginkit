package io.realm.realmloginkit;

import android.app.Activity;
import android.content.Intent;

import io.realm.realmloginkit.activity.RealmLoginActivity;
import io.realm.realmloginkit.util.Constants;

public class LoginKit {
    private Activity context;
    private Intent intent;

    private LoginKit() {
    }

    public LoginKit setDarkMode(boolean darkMode) {
        intent.putExtra(Constants.KEY_DARK_MODE, darkMode);
        return this;
    }

    public LoginKit setAppTitle(String appTitle) {
        intent.putExtra(Constants.KEY_APP_TITLE, appTitle);
        return this;
    }

    public LoginKit setServerUri(String serverUri, boolean hideUri) {
        intent.putExtra(Constants.KEY_SERVER_URI, serverUri);
        intent.putExtra(Constants.KEY_HIDE_SERVER_URI, hideUri);
        return this;
    }

    public void logIn() {
        context.startActivityForResult(intent, Constants.REQUEST_CODE_LOGIN);
    }

    public static LoginKit loginKit(Activity context) {
        LoginKit loginKit = new LoginKit();
        loginKit.context = context;
        loginKit.intent = new Intent(context, RealmLoginActivity.class);
        return loginKit;
    }
}
