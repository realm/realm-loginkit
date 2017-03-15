package io.realm.realmloginkit.example;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import io.realm.realmloginkit.RealmLogoView;

public class ExampleActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_example);
        findViewById(R.id.first).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                RealmLogoView logoView = (RealmLogoView) v;
                boolean shouldMonoChromeLogo = logoView.isMonochromeLogo() ? false : true;
                ((RealmLogoView) v).setMonochromeLogo(shouldMonoChromeLogo);
            }
        });
    }
}
