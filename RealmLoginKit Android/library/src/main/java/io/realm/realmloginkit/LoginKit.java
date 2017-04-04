/*
 * Copyright 2017 Realm Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
