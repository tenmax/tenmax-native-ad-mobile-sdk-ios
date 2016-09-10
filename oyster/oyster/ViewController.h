//
//  ViewController.h
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Oyster/Oyster.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *nativeAdPlaceholder;
@property (weak, nonatomic) IBOutlet OysterAdView *oysterAdView;

- (IBAction)clickBtn:(id)sender;


@end

