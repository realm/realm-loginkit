package io.realm.realmloginkit;

import android.content.Intent;

public class Helper {

    public interface OnSuccess {
        void onSuccess();
    }

    public static void onActivityResult(int requestCode, int resultCode, Intent unused, OnSuccess onSuccess) {
        if (requestCode == Constants.REQUEST_CODE_LOGIN_KIT && resultCode == Constants.RESULT_CODE_OK) {
            onSuccess.onSuccess();
        }
    }

}
