//
// Created by liq on 8/19/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "OysterAdLoader.h"
#import "OysterAdLoaderDelegate.h"
#import "OysterContentAd.h"
#import "ContentAdLoadedListener.h"
#import "OysterAdType.h"
#import "ServiceLoader.h"

@interface OysterAdLoader()
@property (nonatomic, readonly, assign) UIViewController* rootViewController;
@property (nonatomic, readonly, strong) NSArray* adTypes;
@property (nonatomic, readonly, strong) OysterAdLoaderOptions* options;
@property (nonatomic, readonly, strong) ServiceLoader* serviceLoader;

@end

@implementation OysterAdLoader

- (instancetype) initWithAdUnitID:(NSString*) adUnitID
               rootViewController:(UIViewController* __nullable) rootViewController
                          adTypes:(NSArray*) adTypes
                          options:(OysterAdLoaderOptions*) options {

  _adUnitID = adUnitID;
  _rootViewController = rootViewController;
  _adTypes = [adTypes copy];
  _options = [options copy];

  _serviceLoader = [[ServiceLoader alloc] initWithAdUnitID:adUnitID options:options];

  return self;
}

- (void) setDelegate:(id<OysterAdLoaderDelegate>) delegate {
  _delegate = delegate;
  if ([delegate conformsToProtocol:@protocol(OysterContentAdLoaderDelegate)]) {
    self.serviceLoader.contentAdLoadedListener = [[ContentAdLoadedListener alloc]
        initWithDelegate:(id<OysterContentAdLoaderDelegate>) delegate adLoader:self];
  }
}

- (void) loadRequest {

  if (self.adTypes.count <= 0) {
    NSLog(@"Error: You must specify at least one ad type to load.");
    return;
  }

  if (![self.adTypes containsObject:kOysterAdLoaderAdTypeContent]) {
    NSLog(@"Error: Error type to load.");
  }

  [self.serviceLoader loadAd];
}

@end