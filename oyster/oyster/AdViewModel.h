//
// Created by liq on 8/23/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OysterAdImage;
@class AdImage;

@interface AdViewModel : NSObject

@property (nonatomic, readonly, strong) NSString*  title;
@property (nonatomic, readonly, strong) NSString*  summary;
@property (nonatomic, readonly, strong) NSString*  link;
@property (nonatomic, readonly, strong) NSString*  sponsor;
@property (nonatomic, readonly, strong) AdImage*  icon;
@property (nonatomic, readonly, strong) AdImage*  image;
@property (nonatomic, readonly, strong) NSArray<NSString*>*  impressionEvents;
@property (nonatomic, readonly, strong) NSArray<NSString*>*  viewEvents;

- (instancetype) initWithTitle:(NSString*) title
                       summary:(NSString*) summary
                          link:(NSString*) link
                       sponsor:(NSString*) sponsor
                          icon:(AdImage*) icon
                         image:(AdImage*) image
              impressionEvents:(NSArray<NSString*>*) impressionEvents
                    viewEvents:(NSArray<NSString*>*) viewEvents;

@end