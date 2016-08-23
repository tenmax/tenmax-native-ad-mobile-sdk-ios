//
//  ViewController.m
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//



#import "ViewController.h"
#import "OysterAdType.h"
#import "OysterAdLoader.h"
#import "OysterContentAd.h"
#import "OysterContentAdView.h"
#import "OysterAdImage.h"

@interface ViewController()<OysterContentAdLoaderDelegate>
@property (nonatomic, readwrite, strong) OysterAdLoader* adLoader;
@property (strong, nonatomic) UIView* nativeAdView;

@end

@implementation ViewController {
}

- (void) viewDidLoad {
  [super viewDidLoad];

  NSMutableArray* adType = [NSMutableArray array];
  [adType addObject:kOysterAdLoaderAdTypeContent];

  self.adLoader = [[OysterAdLoader alloc]
      initWithAdUnitID:@"c145f1cd389e49a5" rootViewController:self adTypes:adType options:nil];

  self.adLoader.delegate = self;
  [self.adLoader loadRequest];

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
  ((UIImageView*) oysterContentAdView.imageView).image = oysterContentAd.adImage.image;
  ((UIImageView*) oysterContentAdView.logoView).image = oysterContentAd.adLogo.image;
  ((UILabel*) oysterContentAdView.advertiserView).text = oysterContentAd.advertiser;

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
