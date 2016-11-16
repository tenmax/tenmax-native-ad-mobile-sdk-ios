
# Prerequisites
- iOS deployment target 至少 8.0 以上
- 從tenmax取得一個唯一廣告識別碼

# 步驟 1.Cocoapods環境建立

1. 安裝cocoapods 環境，可參考-> https://cocoapods.org/
2. podfile底下增加pod 'tenmax-native-ad-mobile-sdk-ios'
3. 執行pod install
4. 安裝完之後 TARGETS -> Build Phases -> Copy Bundle Resources -> add Oyster.framework

# 步驟 2.import Oyster
在有用到廣告的class匯入Oyster
```objc
#import <Oyster/Oyster.h>
```

# 步驟 3.init Oyster SDK
在appdelegate增加以下的code
```objc
#import <Oyster/Oyster.h>

@implementation AppDelegate
- (BOOL) application:(UIApplication*) application didFinishLaunchingWithOptions:(NSDictionary*) launchOptions {
  // Override point for customization after application launch.

  [Oyster initInstance];
  return YES;
}
@end
```

# 加入一個Native Ad
# 步驟 1.加入以下程式碼

```objc
  OysterAdLoaderOptions* options = [[OysterAdLoaderOptions alloc] init];
  options.imageSize = MIDDLE;

  self.adLoader = [[OysterAdLoader alloc]
      initWithAdUnitID:@"AD_UNIT_ID" rootViewController:rootViewController adTypes:@[kOysterAdLoaderAdTypeContent] options:options];

  self.adLoader.delegate = self;
  [self.adLoader loadRequest];

```
# 步驟 2.實作OysterContentAdLoaderDelegate
```objc

@interface YourController<OysterContentAdLoaderDelegate>
@end

@implementation YourController 

// 失敗回傳
- (void) adLoader:(OysterAdLoader*) adLoader didFailToReceiveAdWithError:(NSError*) error;

// 成功回傳
- (void) adLoader:(OysterAdLoader*) adLoader didReceiveNativeContentAd:(OysterContentAd*) oysterContentAd;

@end
```

# 步驟 3.製作 adView
先產生.xib 檔案，點選Utilities 出現Xcode右側邊欄，選擇左邊數來第三項的identity inspector
如下圖

![AdView of Step 1](http://imgur.com/AunRbh0.png)

確定Custom Class 有繼承 OysterContentAdView。



接著即可生成5個IBOutlet，如下圖。

![AdView of Step 2](http://imgur.com/bl24Pqa.png)

分別為 UILabel的 headerlineView作為廣告的標題， UIImageView的imageView作為廣告的內圖， UILabel的bodyView作為廣告的內文，UILable的advertiserView作為廣告的贊住商名稱，UIImageView的logoView作為廣告的 logo。

# 步驟 4.Coding放入廣告內容
在製作好xib layout之後，在要執行的ViewController部分實作下面部分

```objc
- (void) adLoader:(OysterAdLoader*) adLoader didReceiveNativeContentAd:(OysterContentAd*) oysterContentAd {

   OysterContentAdView* oysterContentAdView = [[[NSBundle mainBundle]
      loadNibNamed:@"NativeContentAdView" owner:nil options:nil]
      firstObject];
  [self setAdView:oysterContentAdView];

  oysterContentAdView.oysterContentAd = oysterContentAd;

  ((UILabel*) oysterContentAdView.headlineView).text = oysterContentAd.headline;
  ((UILabel*) oysterContentAdView.bodyView).text = oysterContentAd.headline;
  ((UILabel*) oysterContentAdView.advertiserView).text = oysterContentAd.advertiser;
  ((UIImageView*) oysterContentAdView.imageView).image = oysterContentAd.adImage.image;
  ((UIImageView*) oysterContentAdView.logoView).image = oysterContentAd.adLogo.image;
  [((UIButton*) oysterContentAdView.callToAction) setTitle:oysterContentAd.callToAction forState:UIControlStateNormal];


}
```

# 加入一個Banner Ad

# 步驟 1.storyboard 加入OysterAdView
![AdView of Step 2](http://imgur.com/Iy90SuX.png)

- phone height -> 50
- ipad height -> 90

# 步驟 2.加入以下程式碼

```objc

- (void) viewDidLoad {
  [super viewDidLoad];
  self.oysterAdView.adUnitID = @"c145f1cd389e49a5";
  self.oysterAdView.rootViewController = self;

  [self.oysterAdView loadAds];
}
  
```

### Version
1.0.9
