package io.realm.realmloginkit;

import android.content.Intent;

public class Helper {

    public interface OnSuccess {
        void onSuccess();
    }

    public static void onActivityResult(int requestCode, int resultCode, Intent data, OnSuccess onSuccess) {
        if (requestCode == Constants.REQUEST_CODE_LOGIN_KIT && resultCode == Constants.RESULT_CODE_OK) {
            onSuccess.onSuccess();
        }
    }

    public static String getValidAuthUri(String uri) {
        final String delimiter = "://";
        String scheme = "http";
        String host = uri;
        int port = 9080;
        int schemeEnd = uri.indexOf(delimiter);
        if (schemeEnd != -1) {
            if (uri.startsWith("https") || uri.startsWith("realms")) {
                port = 9443;
                scheme = "https";
            }
            host = host.substring(schemeEnd + delimiter.length());
        }
        return String.format("%1$s://%2$s:%3$d/auth", scheme, host, port);
    }
}
