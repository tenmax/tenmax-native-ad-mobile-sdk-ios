//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdLinkDto : NSObject
@property (nonatomic, readonly, strong) NSString* url;
@property (nonatomic, readonly, strong) NSArray<NSString*>* clickTrackers;

- (instancetype) initWithUrl:(NSString*) url clickTrackers:(NSArray<NSString*>*) clickTrackers;

@end