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

package io.realm.realmloginkit.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.View;

import io.realm.realmloginkit.R;

public class RealmLogoView extends View {

    private Paint paint1, paint2, paint3, paint4, paint5, paint6, paint7, paint8, backgroundPaint, strokePaint;
    private Path path1, path2, path3, path4, path5, path6, path7, path8;
    private DisplayMetrics displayMetrics;
    private float strokeWidth = -1;
    private boolean isMonochromeLogo = false;
    private int strokeColor = 0xff000000;

    public RealmLogoView(Context context) {
        this(context, null);
    }

    public RealmLogoView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public RealmLogoView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);

        displayMetrics = getResources().getDisplayMetrics();
        if (strokeWidth < 0) {
            strokeWidth = displayMetrics.density * 2;
        }

        TypedArray typedArray = context.getTheme().obtainStyledAttributes(attrs, R.styleable.RealmLogoView, 0, 0);
        try {
            strokeWidth = typedArray.getDimension(R.styleable.RealmLogoView_strokeWidth, strokeWidth);
            isMonochromeLogo = typedArray.getBoolean(R.styleable.RealmLogoView_monochromeLogo, isMonochromeLogo);
            strokeColor = typedArray.getColor(R.styleable.RealmLogoView_strokeColor, strokeColor);
        } finally {
            typedArray.recycle();
        }
    }

    private void initPathsForPaints() {
        // If we use only one path, we cannot use 8 paints.
        path1 = new Path();
        path2 = new Path();
        path3 = new Path();
        path4 = new Path();
        path5 = new Path();
        path6 = new Path();
        path7 = new Path();
        path8 = new Path();
    }

    private Paint makeAntiAliasPaint(int a, int r, int g, int b) {
        Paint paint = new Paint();
        paint.setARGB(a, r, g, b);
        paint.setAntiAlias(true);
        return paint;
    }

    private void initPaints() {
        paint1 = makeAntiAliasPaint(255, 252, 195, 151);
        paint2 = makeAntiAliasPaint(255, 252, 160, 149);
        paint3 = makeAntiAliasPaint(255, 247, 124, 136);
        paint4 = makeAntiAliasPaint(255, 242, 81, 146);
        paint5 = makeAntiAliasPaint(255, 211, 76, 163);
        paint6 = makeAntiAliasPaint(255, 154, 80, 165);
        paint7 = makeAntiAliasPaint(255, 89, 86, 158);
        paint8 = makeAntiAliasPaint(255, 57, 71, 127);

        TypedValue typedValue = new TypedValue();
        getContext().getTheme().resolveAttribute(android.R.attr.windowBackground, typedValue, true);
        if (typedValue.type >= TypedValue.TYPE_FIRST_COLOR_INT && typedValue.type <= TypedValue.TYPE_LAST_COLOR_INT) {
            int color = typedValue.data;
            backgroundPaint = new Paint();
            backgroundPaint.setColor(color);
            backgroundPaint.setAntiAlias(true);
        } else {
            backgroundPaint = makeAntiAliasPaint(255, 255, 255, 255);
        }

        strokePaint = new Paint();
        strokePaint.setAntiAlias(true);
        strokePaint.setColor(strokeColor);
        strokePaint.setStrokeWidth(strokeWidth);
        strokePaint.setStyle(Paint.Style.STROKE);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        final int widthMode = MeasureSpec.getMode(widthMeasureSpec);
        final int widthSize = MeasureSpec.getSize(widthMeasureSpec);
        final int heightMode = MeasureSpec.getMode(heightMeasureSpec);
        final int heightSize = MeasureSpec.getSize(heightMeasureSpec);

        int width, height;

        switch(widthMode) {
            case MeasureSpec.EXACTLY:
                width = widthSize;
                break;
            default:
                super.onMeasure(widthMeasureSpec, heightMeasureSpec);
                return;
        }

        switch(heightMode) {
            case MeasureSpec.EXACTLY:
                height = heightSize;
                break;
            default:
                super.onMeasure(widthMeasureSpec, heightMeasureSpec);
                return;
        }

        width = Math.min(width, height);
        height = width;
        setMeasuredDimension(width, height);
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        initPaints();
        initPathsForPaints();

        int t, l, outline;
        if (isMonochromeLogo) {
            t = (int) Math.floor(strokeWidth / 2.0);
            l = t;
            outline = t;
        } else {
            t = 0;
            l = 0;
            outline = 0;
        }

        int w = getWidth();
        int h = getHeight();
        final int measuredWidth = getMeasuredWidth();
        final int measuredHeight = getMeasuredHeight();
        l += ((w - measuredWidth) / 2);
        t += ((h - measuredHeight) / 2);
        drawFace1(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
        drawFace2(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
        drawFace3(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
        drawFace4(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
        drawFace5(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
        drawFace6(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
        drawFace7(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
        drawFace8(canvas, t, l, measuredWidth - outline * 2, measuredHeight - outline * 2);
    }

    private void drawPath(Canvas canvas, Path path, Paint paint) {
        if (isMonochromeLogo) {
            canvas.drawPath(path, backgroundPaint);
            canvas.drawPath(path, strokePaint);
        } else {
            canvas.drawPath(path, paint);
        }
    }

    private void drawFace1(Canvas canvas, int t, int l, int w, int h) {
        path1.moveTo(l + w * 0.71438f, t + h * 0.04816f);
        path1.cubicTo(l + w * 0.64941f, t + h * 0.01728f, l + w * 0.57672f, t + h * 0.00000f, l + w * 0.50000f, t + h * 0.00000f);
        path1.cubicTo(l + w * 0.36616f, t + h * 0.00000f, l + w * 0.24459f, t + h * 0.05259f, l + w * 0.15485f, t + h * 0.13823f);
        path1.cubicTo(l + w * 0.05944f, t + h * 0.22929f, l + w * 0.88326f, t + h * 0.12843f, l + w * 0.71438f, t + h * 0.04816f);
        path1.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path1, paint1);
    }

    private void drawFace2(Canvas canvas, int t, int l, int w, int h) {
        path2.moveTo(l + w * 0.89062f, t + h * 0.18785f);
        path2.cubicTo(l + w * 0.89119f, t + h * 0.18856f, l + w * 0.84984f, t + h * 0.24383f, l + w * 0.72555f, t + h * 0.25952f);
        path2.cubicTo(l + w * 0.47470f, t + h * 0.29119f, l + w * 0.04403f, t + h * 0.29454f, l + w * 0.04467f, t + h * 0.29312f);
        path2.cubicTo(l + w * 0.07132f, t + h * 0.23457f, l + w * 0.10892f, t + h * 0.18207f, l + w * 0.15485f, t + h * 0.13823f);
        path2.cubicTo(l + w * 0.20898f, t + h * 0.15513f, l + w * 0.26789f, t + h * 0.15934f, l + w * 0.32362f, t + h * 0.14907f);
        path2.cubicTo(l + w * 0.41563f, t + h * 0.13224f, l + w * 0.49750f, t + h * 0.07907f, l + w * 0.58851f, t + h * 0.05741f);
        path2.cubicTo(l + w * 0.62891f, t + h * 0.04770f, l + w * 0.67292f, t + h * 0.04487f, l + w * 0.71438f, t + h * 0.04816f);
        path2.cubicTo(l + w * 0.78326f, t + h * 0.08090f, l + w * 0.84346f, t + h * 0.12892f, l + w * 0.89062f, t + h * 0.18785f);
        path2.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path2, paint2);
    }

    private void drawFace3(Canvas canvas, int t, int l, int w, int h) {
        path3.moveTo(l + w * 0.99390f, t + h * 0.42168f);
        path3.cubicTo(l + w * 0.99422f, t + h * 0.42369f, l + w * 0.42823f, t + h * 0.47689f, l + w * 0.15246f, t + h * 0.46139f);
        path3.cubicTo(l + w * 0.06261f, t + h * 0.45633f, l + w * 0.00959f, t + h * 0.40201f, l + w * 0.01020f, t + h * 0.39905f);
        path3.cubicTo(l + w * 0.01777f, t + h * 0.36208f, l + w * 0.02943f, t + h * 0.32661f, l + w * 0.04468f, t + h * 0.29311f);
        path3.cubicTo(l + w * 0.12435f, t + h * 0.24951f, l + w * 0.21808f, t + h * 0.22434f, l + w * 0.30896f, t + h * 0.22533f);
        path3.cubicTo(l + w * 0.42294f, t + h * 0.22650f, l + w * 0.53475f, t + h * 0.26450f, l + w * 0.64873f, t + h * 0.26167f);
        path3.cubicTo(l + w * 0.73338f, t + h * 0.25951f, l + w * 0.81869f, t + h * 0.23250f, l + w * 0.89062f, t + h * 0.18785f);
        path3.cubicTo(l + w * 0.94362f, t + h * 0.25409f, l + w * 0.98013f, t + h * 0.33411f, l + w * 0.99390f, t + h * 0.42168f);
        path3.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path3, paint3);
    }

    private void drawFace4(Canvas canvas, int t, int l, int w, int h) {
        path4.moveTo(l + w * 1.00000f, t + h * 0.50000f);
        path4.cubicTo(l + w * 1.00000f, t + h * 0.50277f, l + w * 0.99993f, t + h * 0.50830f, l + w * 0.99993f, t + h * 0.50830f);
        path4.cubicTo(l + w * 0.99993f, t + h * 0.50830f, l + w * 0.84273f, t + h * 0.54795f, l + w * 0.64027f, t + h * 0.54558f);
        path4.cubicTo(l + w * 0.35669f, t + h * 0.54227f, l + w * 0.00001f, t + h * 0.49653f, l + w * 0.00002f, t + h * 0.49569f);
        path4.cubicTo(l + w * 0.00030f, t + h * 0.46251f, l + w * 0.00381f, t + h * 0.43011f, l + w * 0.01025f, t + h * 0.39877f);
        path4.cubicTo(l + w * 0.07819f, t + h * 0.44069f, l + w * 0.16059f, t + h * 0.46123f, l + w * 0.23989f, t + h * 0.45258f);
        path4.cubicTo(l + w * 0.30295f, t + h * 0.44575f, l + w * 0.36285f, t + h * 0.42242f, l + w * 0.42126f, t + h * 0.39758f);
        path4.cubicTo(l + w * 0.47966f, t + h * 0.37275f, l + w * 0.53773f, t + h * 0.34608f, l + w * 0.59946f, t + h * 0.33175f);
        path4.cubicTo(l + w * 0.69014f, t + h * 0.31075f, l + w * 0.78715f, t + h * 0.31808f, l + w * 0.87383f, t + h * 0.35225f);
        path4.cubicTo(l + w * 0.91601f, t + h * 0.36888f, l + w * 0.95785f, t + h * 0.39279f, l + w * 0.99389f, t + h * 0.42162f);
        path4.cubicTo(l + w * 0.99791f, t + h * 0.44716f, l + w * 1.00000f, t + h * 0.47334f, l + w * 1.00000f, t + h * 0.50000f);
        path4.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path4, paint4);
    }

    private void drawFace5(Canvas canvas, int t, int l, int w, int h) {
        path5.moveTo(l + w * 0.43295f, t + h * 0.66235f);
        path5.cubicTo(l + w * 0.28294f, t + h * 0.69005f, l + w * 0.02550f, t + h * 0.65810f, l + w * 0.02486f, t + h * 0.65612f);
        path5.cubicTo(l + w * 0.00873f, t + h * 0.60700f, l + w * 0.00000f, t + h * 0.55452f, l + w * 0.00000f, t + h * 0.50000f);
        path5.cubicTo(l + w * 0.00000f, t + h * 0.49856f, l + w * 0.00001f, t + h * 0.49712f, l + w * 0.00002f, t + h * 0.49568f);
        path5.cubicTo(l + w * 0.02279f, t + h * 0.47763f, l + w * 0.04939f, t + h * 0.46153f, l + w * 0.07536f, t + h * 0.44901f);
        path5.cubicTo(l + w * 0.13959f, t + h * 0.41785f, l + w * 0.21246f, t + h * 0.40485f, l + w * 0.28351f, t + h * 0.41185f);
        path5.cubicTo(l + w * 0.35373f, t + h * 0.41885f, l + w * 0.42078f, t + h * 0.44485f, l + w * 0.48568f, t + h * 0.47285f);
        path5.cubicTo(l + w * 0.54035f, t + h * 0.49644f, l + w * 0.59466f, t + h * 0.52192f, l + w * 0.65141f, t + h * 0.53953f);
        path5.cubicTo(l + w * 0.65697f, t + h * 0.54125f, l + w * 0.59808f, t + h * 0.63185f, l + w * 0.43295f, t + h * 0.66235f);
        path5.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path5, paint5);
    }

    private void drawFace6(Canvas canvas, int t, int l, int w, int h) {
        path6.moveTo(l + w * 0.98196f, t + h * 0.63356f);
        path6.cubicTo(l + w * 0.97149f, t + h * 0.65126f, l + w * 0.87186f, t + h * 0.71085f, l + w * 0.73682f, t + h * 0.72106f);
        path6.cubicTo(l + w * 0.55801f, t + h * 0.73457f, l + w * 0.34678f, t + h * 0.68052f, l + w * 0.41685f, t + h * 0.65301f);
        path6.cubicTo(l + w * 0.52717f, t + h * 0.60968f, l + w * 0.62284f, t + h * 0.53185f, l + w * 0.73682f, t + h * 0.49935f);
        path6.cubicTo(l + w * 0.82196f, t + h * 0.47496f, l + w * 0.91635f, t + h * 0.47881f, l + w * 0.99993f, t + h * 0.50829f);
        path6.cubicTo(l + w * 0.99923f, t + h * 0.55161f, l + w * 0.99302f, t + h * 0.59359f, l + w * 0.98196f, t + h * 0.63356f);
        path6.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path6, paint6);
    }

    private void drawFace7(Canvas canvas, int t, int l, int w, int h) {
        path7.moveTo(l + w * 0.93357f, t + h * 0.74920f);
        path7.cubicTo(l + w * 0.84724f, t + h * 0.89909f, l + w * 0.22106f, t + h * 0.93668f, l + w * 0.12958f, t + h * 0.83585f);
        path7.cubicTo(l + w * 0.08302f, t + h * 0.78452f, l + w * 0.04697f, t + h * 0.72348f, l + w * 0.02486f, t + h * 0.65612f);
        path7.cubicTo(l + w * 0.10175f, t + h * 0.61217f, l + w * 0.19177f, t + h * 0.59350f, l + w * 0.27829f, t + h * 0.60533f);
        path7.cubicTo(l + w * 0.39027f, t + h * 0.62067f, l + w * 0.49060f, t + h * 0.68317f, l + w * 0.60109f, t + h * 0.70750f);
        path7.cubicTo(l + w * 0.69027f, t + h * 0.72717f, l + w * 0.78478f, t + h * 0.72100f, l + w * 0.87064f, t + h * 0.69000f);
        path7.cubicTo(l + w * 0.90945f, t + h * 0.67588f, l + w * 0.94793f, t + h * 0.65695f, l + w * 0.98196f, t + h * 0.63356f);
        path7.cubicTo(l + w * 0.97066f, t + h * 0.67444f, l + w * 0.95429f, t + h * 0.71323f, l + w * 0.93357f, t + h * 0.74920f);
        path7.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path7, paint7);
    }

    private void drawFace8(Canvas canvas, int t, int l, int w, int h) {
        path8.moveTo(l + w * 0.93429f, t + h * 0.74794f);
        path8.cubicTo(l + w * 0.84814f, t + h * 0.89853f, l + w * 0.68592f, t + h * 1.00000f, l + w * 0.50000f, t + h * 1.00000f);
        path8.cubicTo(l + w * 0.35311f, t + h * 1.00000f, l + w * 0.22101f, t + h * 0.93666f, l + w * 0.12953f, t + h * 0.83580f);
        path8.cubicTo(l + w * 0.14471f, t + h * 0.84160f, l + w * 0.16169f, t + h * 0.84662f, l + w * 0.17725f, t + h * 0.85100f);
        path8.cubicTo(l + w * 0.26428f, t + h * 0.87500f, l + w * 0.35795f, t + h * 0.87433f, l + w * 0.44448f, t + h * 0.84883f);
        path8.cubicTo(l + w * 0.49988f, t + h * 0.83250f, l + w * 0.55196f, t + h * 0.80650f, l + w * 0.60637f, t + h * 0.78683f);
        path8.cubicTo(l + w * 0.71020f, t + h * 0.74939f, l + w * 0.82447f, t + h * 0.73621f, l + w * 0.93429f, t + h * 0.74794f);
        path8.lineTo(l + w * 0.93429f, t + h * 0.74794f);
        path8.setFillType(Path.FillType.EVEN_ODD);
        drawPath(canvas, path8, paint8);
    }

    public boolean isMonochromeLogo() {
        return isMonochromeLogo;
    }

    public void setMonochromeLogo(boolean isMonochromeLogo) {
        if (isMonochromeLogo == this.isMonochromeLogo) {
            return;
        }
        this.isMonochromeLogo = isMonochromeLogo;
        invalidate();
    }

    public float getStrokeWidth() {
        return strokeWidth;
    }

    public void setStrokeWidth(float strokeWidth) {
        if (strokeWidth == this.strokeWidth) {
            return;
        }
        this.strokeWidth = strokeWidth;
        invalidate();
    }
}
