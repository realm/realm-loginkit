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

package io.realm.realmloginkit.util;

public class Constants {
    public static final String KEY_DARK_MODE = "DARK_MODE";
    public static final String KEY_APP_TITLE = "APP_TITLE";
    public static final String KEY_SERVER_URI = "SERVER_URI";
    public static final String KEY_HIDE_SERVER_URI = "HIDE_SERVER_URI";

    public static final String SHARED_PREFERENCES_NAME = "io.realm.realmloginkit";
    public static final String SHARED_KEY_SERVER_URI = "SHARED_KEY_SERVER_URI";
    public static final String SHARED_KEY_EMAIL = "SHARED_KEY_EMAIL";
    public static final String SHARED_KEY_PASSWORD = "SHARED_KEY_PASSWORD";

    public static final int REQUEST_CODE_LOGIN = 200;
    public static final int RESULT_CODE_LOGIN_OK = 1;

    public static final int REQUEST_CODE_REGISTER = 300;
    public static final int RESULT_CODE_REGISTER = 1;
    public static final int RESULT_CODE_EXIT = 2;
}
