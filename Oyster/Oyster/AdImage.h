//
// Created by liq on 8/23/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdImage : NSObject
@property (nonatomic, readonly, strong) NSString* url;
@property (nonatomic, readwrite, strong) UIImage* image;

- (instancetype) initWithUrl:(NSString*) url;

@end