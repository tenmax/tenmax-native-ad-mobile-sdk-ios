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

@interface ViewController() <OysterContentAdLoaderDelegate>
@property (nonatomic, readwrite, strong) OysterAdLoader* adLoader;
@end

@implementation ViewController {
}

- (void) viewDidLoad {
  [super viewDidLoad];

  NSMutableArray* adType = [NSMutableArray array];
  [adType addObject:kOysterAdLoaderAdTypeContent];

  self.adLoader = [[OysterAdLoader alloc]
      initWithAdUnitID:@"c145f1cd389e49a5"
    rootViewController:self
               adTypes:adType
               options:nil];

  self.adLoader.delegate = self;
  [self.adLoader loadRequest];

}


- (void) didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)adLoader:(OysterAdLoader *)adLoader didFailToReceiveAdWithError:(NSError *)error {
  NSLog(@"%@ failed with error: %@", adLoader, [error localizedDescription]);
}

- (void) adLoader:(OysterAdLoader*) adLoader didReceiveNativeContentAd:(OysterContentAd*) nativeContentAd {

}

@end
