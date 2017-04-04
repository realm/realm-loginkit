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
