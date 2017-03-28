package io.realm.realmloginkit;

import android.content.Intent;

public class LogInHelper {

    public interface OnSuccess {
        void onSuccess();
    }

    public static void onActivityResult(int requestCode, int resultCode, Intent data, OnSuccess onSuccess) {
        if (requestCode == Constants.REQUEST_CODE_LOGIN_KIT && resultCode == Constants.RESULT_CODE_OK) {
            onSuccess.onSuccess();
        }
    }

    public String getValidAuthUri(String uri) {
        return uri;
    }
}
