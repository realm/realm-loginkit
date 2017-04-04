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

package io.realm.realmloginkit.example;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;
import android.widget.ToggleButton;

import io.realm.realmloginkit.util.Constants;
import io.realm.realmloginkit.ActivityHelper;
import io.realm.realmloginkit.LoginKit;
import io.realm.realmloginkit.widget.RealmLogoView;

public class ExampleActivity extends AppCompatActivity implements View.OnClickListener {

    public static final double LOGO_RATIO = 0.7;

    private boolean isDarkMode;
    private ToggleButton lightButton;
    private ToggleButton darkButton;
    private RealmLogoView logo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        isDarkMode = getIntent().getBooleanExtra(Constants.KEY_DARK_MODE, false);
        initTheme(); // it should be invoked before setContentView()
        setContentView(R.layout.activity_example);
        initThemeButtons(isDarkMode);
        initLogo();
        findViewById(R.id.log_in).setOnClickListener(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        delayedResizeLogo();
    }

    @Override
    public void onClick(View view) {
        final int viewId = view.getId();
        handleThemeIfNeeded(viewId);
        handleLogInIfNeeded(viewId);
    }

    private void initLogo() {
        logo = (RealmLogoView) findViewById(R.id.logo);
        logo.setMonochromeLogo(isDarkMode);
    }

    private void delayedResizeLogo() {
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                resizeLogo();
            }
        }, 100);
    }

    private void resizeLogo() {
        final int width = getWindow().getDecorView().getWidth();
        final int height = getWindow().getDecorView().getHeight();
        final int minWidth;
        if (width < height) {
            minWidth = (int) (width * LOGO_RATIO);
        } else {
            minWidth = (int) (height * LOGO_RATIO);
        }
        ViewGroup.LayoutParams layoutParams = logo.getLayoutParams();
        layoutParams.width = minWidth;
        layoutParams.height = minWidth;
        logo.setLayoutParams(layoutParams);
    }

    private void initThemeButtons(boolean isDarkMode) {
        final ActionBar actionBar = getSupportActionBar();
        actionBar.setCustomView(R.layout.theme_toggles);
        actionBar.setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        final View customView = actionBar.getCustomView();

        lightButton = (ToggleButton) customView.findViewById(R.id.light_button);
        lightButton.setOnClickListener(this);

        darkButton = (ToggleButton) customView.findViewById(R.id.dark_button);
        darkButton.setOnClickListener(this);

        if (isDarkMode) {
            darkButton.setChecked(true);
            lightButton.setChecked(false);
        } else {
            lightButton.setChecked(true);
            darkButton.setChecked(false);
        }
    }

    private void initTheme() {
        if (isDarkMode) {
            setTheme(android.support.v7.appcompat.R.style.Theme_AppCompat);
        } else {
            setTheme(android.support.v7.appcompat.R.style.Theme_AppCompat_Light);
        }
    }

    private void handleLogInIfNeeded(int viewId) {
        if (viewId == R.id.log_in) {
            LoginKit.loginKit(this)
                    .setDarkMode(isDarkMode)
                    .setAppTitle("Example App2")
                    .setServerUri("192.168.110.47", false)
                    .logIn();
        }
    }

    private void handleThemeIfNeeded(int viewId) {
        if (viewId == R.id.light_button) {
            if (!isDarkMode) {
                lightButton.setChecked(true);
                return;
            }
            darkButton.setChecked(false);
        } else if (viewId == R.id.dark_button) {
            if (isDarkMode) {
                darkButton.setChecked(true);
                return;
            }
            lightButton.setChecked(false);
        } else {
            return;
        }

        final Intent intent = new Intent(this, ExampleActivity.class);
        intent.putExtra(Constants.KEY_DARK_MODE, isDarkMode ? false : true);
        finish();
        startActivity(intent);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        ActivityHelper.onActivityResult(requestCode, resultCode, data, new ActivityHelper.OnSuccess() {
            @Override
            public void onSuccess() {
                Toast.makeText(ExampleActivity.this, "Success!", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
