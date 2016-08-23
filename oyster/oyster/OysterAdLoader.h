//
// Created by liq on 8/19/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OysterAdLoaderDelegate;

@interface OysterAdLoader : NSObject

@property (nonatomic, weak, nullable) id<OysterAdLoaderDelegate> delegate;
@property (nonatomic, readonly) NSString* adUnitID;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

- (instancetype) initWithAdUnitID:(NSString*) adUnitID
               rootViewController:(UIViewController* __nullable) rootViewController
                          adTypes:(NSArray*) adTypes
                          options:(NSArray* __nullable) options;

#pragma clang diagnostic pop

- (void) loadRequest;
@end

@interface OysterAdLoaderOptions : NSObject
@end