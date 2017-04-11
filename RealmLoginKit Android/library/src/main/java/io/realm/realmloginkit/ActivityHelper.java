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

import android.content.Intent;

import io.realm.realmloginkit.util.Constants;

public class ActivityHelper {

    public interface OnSuccess {
        void onSuccess();
    }

    public static void onActivityResult(int requestCode, int resultCode, Intent unused, OnSuccess onSuccess) {
        if (requestCode == Constants.REQUEST_CODE_LOGIN && resultCode == Constants.RESULT_CODE_LOGIN_OK) {
            onSuccess.onSuccess();
        }
    }

}
