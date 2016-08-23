//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AdLinkDto;
@class AdImageDto;
@class AdSponsorDto;

@interface AdDto : NSObject
@property (nonatomic, readonly, strong) NSString *title;
@property (nonatomic, readonly, strong) NSString *summary;
@property (nonatomic, readonly, strong) AdLinkDto *link;
@property (nonatomic, readonly, strong) AdImageDto *middleIcon;
@property (nonatomic, readonly, strong) AdImageDto *middleImage;
@property (nonatomic, readonly, strong) AdSponsorDto *sponsor;
@property (nonatomic, readonly, strong) AdImageDto *largeImage;
@property (nonatomic, readonly, strong) AdImageDto *smallImage;
@property (nonatomic, readonly, strong) AdImageDto *largeIcon;
@property (nonatomic, readonly, strong) AdImageDto *smallIcon;
@property (nonatomic, readonly, strong) NSArray<NSString *> *impressionEvents;
@property (nonatomic, readonly, strong) NSArray<NSString *> *viewEvents;

- (instancetype) initWithTitle:(NSString*) title
                       summary:(NSString*) summary
                          link:(AdLinkDto*) link
                    middleIcon:(AdImageDto*) middleIcon
                   middleImage:(AdImageDto*) middleImage
                       sponsor:(AdSponsorDto*) sponsor
                    largeImage:(AdImageDto*) largeImage
                    smallImage:(AdImageDto*) smallImage
                     largeIcon:(AdImageDto*) largeIcon
                     smallIcon:(AdImageDto*) smallIcon
              impressionEvents:(NSArray<NSString*>*) impressionEvents
                    viewEvents:(NSArray<NSString*>*) viewEvents;

@end