##WeChatHelper

####1.解析微信头文件
```
./class-dump -s -S -H ./WeChat.decrypted -o ./header6.3-arm64
```
####2.安装iOSOpenDev工具
建立Cocoa Touch Library工程，添加[CaptainHook.h](https://github.com/rpetrich/CaptainHook)

####3.安装重签名工具[sigh](https://github.com/fastlane/fastlane/tree/master/sigh)
```
 $ gem update --system
 $ sudo gem install sigh
 ```
####4.签名dylib文件
```
codesign -f -s "iPhone Developer: zexu du (95WX4JLF9D)" libWeChatHelper.dylib
```
####5.dylib注入可执行文件
```
./yololib WeChat libWeChatHelper.dylib
```
####6.拷贝进WeChat.app文件夹中，生成ipa
####7.用sigh重签名
```
sigh resign wx.ipa --signing_identity D125587E195E673583C2A9BC436DFE26398B7E74 -p com.tencent.xin.sharetimeline=WeChatToday.mobileprovision -p com.tencent.xin.watchapp.watchkitextension=WeChatWatchExtension.mobileprovision -p com.tencent.xin.watchapp=WeChatWatch.mobileprovision -p com.tencent.xin=WeChat.mobileprovision newwx.ipa
```

###参考
[一步一步实现iOS微信自动抢红包(非越狱)](http://www.jianshu.com/p/189afbe3b429)