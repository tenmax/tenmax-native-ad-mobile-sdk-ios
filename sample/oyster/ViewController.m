//
//  ViewController.m
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()<OysterContentAdLoaderDelegate>
@property (nonatomic, readwrite, strong) OysterAdLoader* adLoader;
@property (strong, nonatomic) UIView* nativeAdView;

@end

@implementation ViewController {
}

- (void) viewDidLoad {
  [super viewDidLoad];

  [self loadNative];
  [self loadBanner];

}

- (void) loadNative {
  NSMutableArray* adType = [NSMutableArray array];
  [adType addObject:kOysterAdLoaderAdTypeContent];

  OysterAdLoaderOptions* options = [[OysterAdLoaderOptions alloc] init];
  options.imageSize = MIDDLE;

  self.adLoader = [[OysterAdLoader alloc]
      initWithAdUnitID:@"OYSTER_AD_UNIT_ID" rootViewController:self adTypes:adType options:options];

  self.adLoader.delegate = self;
  [self.adLoader loadRequest];
}

- (void) loadBanner {
  self.oysterAdView.adUnitID = @"OYSTER_AD_UNIT_ID";
  self.oysterAdView.rootViewController = self;

  [self.oysterAdView loadAds];
}

- (void) didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void) adLoader:(OysterAdLoader*) adLoader didFailToReceiveAdWithError:(NSError*) error {
  NSLog(@"%@ failed with error: %@", adLoader, [error localizedDescription]);
}

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

- (void) setAdView:(OysterContentAdView*) view {
  [self.nativeAdView removeFromSuperview];
  self.nativeAdView = view;

  [self.nativeAdPlaceholder addSubview:view];
  [self.nativeAdView setTranslatesAutoresizingMaskIntoConstraints:NO];

  NSDictionary* viewDictionary = NSDictionaryOfVariableBindings(_nativeAdView);
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nativeAdView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewDictionary]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nativeAdView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewDictionary]];
}

- (IBAction)clickBtn:(id) sender {
  [self.adLoader loadRequest];
}

@end
