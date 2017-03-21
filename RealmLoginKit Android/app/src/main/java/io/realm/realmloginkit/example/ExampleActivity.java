package io.realm.realmloginkit.example;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ToggleButton;

import io.realm.realmloginkit.RealmLoginActivity;
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
        isDarkMode = getIntent().getBooleanExtra(RealmLoginActivity.KEY_DARK_MODE, false);
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
        handleLogIn(viewId);
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

    private void handleLogIn(int viewId) {
        if (viewId == R.id.log_in) {
            final Intent intent = new Intent(this, RealmLoginActivity.class);
            intent.putExtra(RealmLoginActivity.KEY_DARK_MODE, isDarkMode);
            startActivity(intent);
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
        intent.putExtra(RealmLoginActivity.KEY_DARK_MODE, isDarkMode ? false : true);
        finish();
        startActivity(intent);
    }
}
