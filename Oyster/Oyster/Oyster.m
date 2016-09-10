//
//  Oyster.m
//  Oyster
//
//  Created by liq on 9/8/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Oyster.h"

@implementation Oyster

+ (void) initInstance {
  [OysterAdView _keepAtLinkTime];
  [OysterContentAdView _keepAtLinkTime];
}

@end