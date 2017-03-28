package io.realm.realmloginkit.example;

import android.app.Application;

import io.realm.Realm;

public class ExampleApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        Realm.init(this);
    }
}
