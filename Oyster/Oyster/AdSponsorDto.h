//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AdLinkDto;

@interface AdSponsorDto : NSObject
@property (nonatomic, readonly, strong) AdLinkDto* link;
@property (nonatomic, readonly, strong) NSString* title;

- (instancetype) initWithLink:(AdLinkDto*) link title:(NSString*) title;

@end