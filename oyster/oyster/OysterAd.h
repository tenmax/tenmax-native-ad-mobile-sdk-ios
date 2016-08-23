//
//  OysterNativeAd.h
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OysterAd : NSObject

@property (nonatomic, weak) UIViewController* rootViewController;
@property (nonatomic, readonly, copy) NSDictionary* extraAssets;

@end
