#!/bin/bash

#获取目录
CURRENT_DIR=$(cd $(dirname $0); pwd)
num=$(find $CURRENT_DIR -name gradlew  | awk -F"/" '{print NF-1}'| head -1)
DIR=$(find $CURRENT_DIR -name gradlew  | cut -d \/ -f$num | head -1)
cd $DIR
#签名
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " $CURRENT_DIR/$DIR/app/build.gradle
cp -f $CURRENT_DIR/DIY2/TVBoxOSC.jks $CURRENT_DIR/$DIR/app/TVBoxOSC.jks
cp -f $CURRENT_DIR/DIY2/TVBoxOSC.jks $CURRENT_DIR/$DIR/TVBoxOSC.jks
echo "" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_FILE=./TVBoxOSC.jks" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_ALIAS=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
#xwalk修复
cp $CURRENT_DIR/DIY2/T/build.gradle     $CURRENT_DIR/$DIR/build.gradle

//搜索界面
cp $CURRENT_DIR/DIY2/T/SearchCheckboxDialog.java             $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/dialog/SearchCheckboxDialog.java

//设置界面
cp $CURRENT_DIR/DIY2/T/HomeActivity.java            $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
cp $CURRENT_DIR/DIY2/T/ModelSettingFragment.java    $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
cp $CURRENT_DIR/DIY2/T/fragment_model.xml           $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
cp $CURRENT_DIR/DIY2/T/dialog_api.xml               $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_api.xml

//首页界面
cp $CURRENT_DIR/DIY2/T/activity_home.xml            $CURRENT_DIR/$DIR/app/src/main/res/layout/activity_home.xml
cp $CURRENT_DIR/DIY2/T/fragment_user.xml            $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml

//播放界面
cp $CURRENT_DIR/DIY2/T/player_vod_control_view.xml    $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
cp $CURRENT_DIR/DIY2/T/VodController.java             $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#名称修改
sed -i 's/TVBox/影视One/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/影视One/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

//增加参数
cp $CURRENT_DIR/DIY2/J/dimens.xml         $CURRENT_DIR/$DIR/app/src/main/res/values/dimens.xml
cp $CURRENT_DIR/DIY2/J/colors.xml         $CURRENT_DIR/$DIR/app/src/main/res/values/colors.xml
cp $CURRENT_DIR/DIY2/J/strings.xml        $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#图标修改
mv $CURRENT_DIR/DIY2/图标3.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_icon.png

#背景修改
mv $CURRENT_DIR/DIY2/10.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_bg.png
#自定义epg
cp $CURRENT_DIR/DIY2/epg_data.json $CURRENT_DIR/$DIR/app/src/main/assets/epg_data.json

//播放文字修改
cp $CURRENT_DIR/DIY/PlayerHelper.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/PlayerHelper.java
#sed -i 's/播放器//g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/PlayerHelper.java
sed -i 's/TextureView/Texture/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/PlayerHelper.java
sed -i 's/SurfaceView/Surface/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/PlayerHelper.java

//按键背景颜色
sed -i 's/color_6A6A6A_95/color_DDDAC6/g' $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_dialog_bg_main.xml


# 默认设置
cp $CURRENT_DIR/DIY2/T/App.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java

#首页排版边框
sed -i 's/vs_30/vs_15/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_select.xml

#主界面首页文字颜色修改
sed -i 's/color_FFFFFF_70/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_FFFFFF_70/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

#版本号
sed -i 's/1.0.0/1.1.0/g' $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's/1.0.0/1.1.0/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
#共存
sed -i 's/com.github.tvbox.osc.tk/com.tvbox.T/g' $CURRENT_DIR/$DIR/app/build.gradle

#添加PY支持
wget --no-check-certificate -qO- "https://raw.githubusercontent.com/UndCover/PyramidStore/main/aar/pyramid-1011.aar" -O $CURRENT_DIR/$DIR/app/libs/pyramid.aar
sed -i "/thunder.jar/a\    implementation files('libs@pyramid.aar')" $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's#@#\\#g' $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's#pyramid#\\pyramid#g' $CURRENT_DIR/$DIR/app/build.gradle
echo "" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "#添加PY支持" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-keep public class com.undcover.freedom.pyramid.** { *; }" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-dontwarn com.undcover.freedom.pyramid.**" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-keep public class com.chaquo.python.** { *; }" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-dontwarn com.chaquo.python.**" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.undcover.freedom.pyramid.PythonLoader;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.github.catvod.crawler.SpiderNull;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/PlayerHelper.init/a\        PythonLoader.getInstance().setApplication(this);' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import android.util.Base64;/a\import com.github.catvod.crawler.SpiderNull;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/import android.util.Base64;/a\import com.undcover.freedom.pyramid.PythonLoader;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/private void parseJson(String apiUrl, String jsonStr)/a\        PythonLoader.getInstance().setConfig(jsonStr);' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Spider getCSP(SourceBean sourceBean)/a\        if (sourceBean.getApi().startsWith(\"py_\")) {\n        try {\n            return PythonLoader.getInstance().getSpider(sourceBean.getKey(), sourceBean.getExt());\n        } catch (Exception e) {\n            e.printStackTrace();\n            return new SpiderNull();\n        }\n    }' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Object\[\] proxyLoca/a\    try {\n        if(param.containsKey(\"api\")){\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"ck\"))\n                return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n            SourceBean sourceBean = ApiConfig.get().getSource(doStr);\n            return PythonLoader.getInstance().proxyLocal(sourceBean.getKey(),sourceBean.getExt(),param);\n        }else{\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"live\")) return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n        }\n    } catch (Exception e) {\n        e.printStackTrace();\n    }\n' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java

echo 'DIY end'
