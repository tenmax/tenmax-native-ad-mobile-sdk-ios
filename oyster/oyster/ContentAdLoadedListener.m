//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "ContentAdLoadedListener.h"
#import "OysterContentAd.h"
#import "OysterAdLoader.h"

@interface ContentAdLoadedListener()

@property (nonatomic, readonly, weak) id<OysterContentAdLoaderDelegate> delegate;
@property (nonatomic, readonly, strong) OysterAdLoader* adLoader;
@end

@implementation ContentAdLoadedListener
- (instancetype) initWithDelegate:(id<OysterContentAdLoaderDelegate>) delegate adLoader:(OysterAdLoader*) adLoader {

  self = [super init];
  if (self) {
    _delegate = delegate;
    _adLoader = adLoader;
  }

  return self;
}

- (void) onAdFailedToLoad:(NSError*) error {
  [self.delegate adLoader:self.adLoader didFailToReceiveAdWithError:error];
}

- (void) onSuccess {
  [self.delegate adLoader:self.adLoader didReceiveNativeContentAd:nil];
}

@end