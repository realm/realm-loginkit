package io.realm.realmloginkit;

import android.app.Activity;
import android.content.Intent;

public class LoginKit {
    private Activity context;
    private Intent intent;

    private LoginKit() {
    }

    public static LoginKit loginKit(Activity context) {
        LoginKit loginKit = new LoginKit();
        loginKit.context = context;
        loginKit.intent = new Intent(context, RealmLoginActivity.class);
        return loginKit;
    }

    public LoginKit setDarkMode(boolean isDarkMode) {
        intent.putExtra(Constants.KEY_DARK_MODE, isDarkMode);
        return this;
    }

    public LoginKit setAppTitle(String appTitle) {
        intent.putExtra(Constants.KEY_APP_TITLE, appTitle);
        return this;
    }

    public void logIn() {
        context.startActivityForResult(intent, Constants.REQUEST_CODE_LOGIN_KIT);
    }
}
