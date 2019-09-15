##WeChatHelper

#####1.查看二进制文件是否加密
```
otool -l WeChat | grep crypt
```
####2.解析微信头文件
```
./class-dump -s -S -H ./WeChat.decrypted -o ./header6.3-arm64
```
####3.安装iOSOpenDev工具
建立Cocoa Touch Library工程，添加[CaptainHook.h](https://github.com/rpetrich/CaptainHook)

####4.安装重签名工具[sigh](https://github.com/fastlane/fastlane/tree/master/sigh)
```
 $ gem update --system
 $ sudo gem install sigh
 ```
####5.签名dylib文件
```
codesign -f -s "iPhone Developer: zexu du (95WX4JLF9D)" libWeChatHelper.dylib
```
####6.dylib注入可执行文件
```
./yololib WeChat libWeChatHelper.dylib
```
使用MachOView查看LoadCommend里面是否有刚加进去的dylib
####7.拷贝进WeChat.app文件夹中，生成ipa
####8.用sigh重签名
```
fastlane sigh resign WeChat.ipa --signing_identity D125587E195E673583C2A9BC436DFE26398B7E74 -p com.tencent.xin.sharetimeline=WeChatToday.mobileprovision -p com.tencent.xin.watchapp.watchkitextension=WeChatWatchExtension.mobileprovision -p com.tencent.xin.watchapp=WeChatWatch.mobileprovision -p com.tencent.xin=WeChat.mobileprovision newwx.ipa
```

###自动跳一跳
[自动跳一跳](./AutoJumpInWX/AutoJumpInWX.md)

###参考
[一步一步实现iOS微信自动抢红包(非越狱)](http://www.jianshu.com/p/189afbe3b429)
