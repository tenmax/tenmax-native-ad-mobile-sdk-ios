//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "ServiceLoader.h"
#import "ContentAdLoadedListener.h"
#import "AdImageDto.h"
#import "AdLinkDto.h"
#import "AdDto.h"
#import "AdSponsorDto.h"

@interface ServiceLoader()
@property (nonatomic, readonly, strong) NSString* adUnitID;
@end

@implementation ServiceLoader

- (instancetype) initWithAdUnitID:(NSString*) adUnitID {
  self = [super init];
  if (self) {
    _adUnitID = adUnitID;
  }

  return self;
}

- (void) loadAd {
  if (!self.contentAdLoadedListener) {
    NSLog(@"Delegate does not conform to the required protocol, OysterContentAdLoaderDelegate to ViewController's protocol list.");
    return;
  }

  [self httpGetRequest];
}

- (void) httpGetRequest {
  NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];

  [request setURL:[self getOysterUrl]];
  [request setHTTPMethod:@"GET"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request setValue:[NSString stringWithFormat:@"%@ %@",
                                               [[UIDevice currentDevice] name],
                                               [[UIDevice currentDevice] systemVersion]]
      forHTTPHeaderField:@"User-agent"];

  NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  [[session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
    if (!error && [data length] > 0) {
      AdDto* adDto = [self getReceivedData:data];
      if (adDto) {
        [self impressionEventCallback:adDto];
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.contentAdLoadedListener onSuccess:[adDto createAdViewModel]];
        });
      }
    } else {
      [self.contentAdLoadedListener onAdFailedToLoad:error];
    }
  }] resume];
}

- (void) impressionEventCallback:(AdDto*) adDto {
  NSArray<NSString*>* impressionEvents = adDto.impressionEvents;
  for (int i = 0; i < impressionEvents.count; ++i) {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[[NSURL alloc] initWithString:impressionEvents[(NSUInteger) i]]];
    [request setHTTPMethod:@"GET"];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
    }] resume];
  }
}

- (NSURL*) getOysterUrl {

  NSURLComponents* components = [NSURLComponents new];
  [components setScheme:@"https"];
  [components setHost:@"ssp.tenmax.io"];
  [components setPath:@"/supply/mobile/native/rmax-ad/"];
  NSURLQueryItem* rmaxSpaceId = [NSURLQueryItem queryItemWithName:@"rmaxSpaceId" value:self.adUnitID];
  NSURLQueryItem* dpid = [NSURLQueryItem queryItemWithName:@"dpid" value:[[NSUUID UUID] UUIDString]];
  NSURLQueryItem* v = [NSURLQueryItem queryItemWithName:@"v" value:[[UIDevice currentDevice] systemVersion]];
  components.queryItems = @[rmaxSpaceId, dpid, v];

  return components.URL;

}

- (AdDto*) getReceivedData:(NSData*) data {
  NSError* error = nil;
  NSDictionary* receivedData = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
  if (error) {
    [self.contentAdLoadedListener onAdFailedToLoad:error];
    return nil;
  }
  return [self convertToNativeAdDto:receivedData];
}

- (AdDto*) convertToNativeAdDto:(NSDictionary*) receivedData {
  NSDictionary* nativeDic = [[NSDictionary alloc] initWithDictionary:receivedData[@"native"]];
  NSArray* assets = [[NSArray alloc] initWithArray:nativeDic[@"assets"]];

  NSMutableDictionary* assetsDic = [NSMutableDictionary new];
  for (int i = 0; i < assets.count; ++i) {
    NSDictionary* asset = assets[(NSUInteger) i];
    if (!asset) {
      continue;
    }
    assetsDic[[NSString stringWithFormat:@"%@", asset[@"id"]]] = asset;
  }

  return [[AdDto alloc]
      initWithTitle:[self getTitle:assetsDic[@"1"]]
            summary:[self getDataValue:assetsDic[@"4"]]
               link:[self getLink:nativeDic]
         middleIcon:[self getImage:assetsDic[@"2"]]
        middleImage:[self getImage:assetsDic[@"3"]]
            sponsor:[[AdSponsorDto alloc]
                initWithLink:[self getLink:assetsDic[@"5"]] title:[self getDataValue:assetsDic[@"5"]]]
         largeImage:[self getImage:assetsDic[@"6"]]
         smallImage:[self getImage:assetsDic[@"7"]]
          largeIcon:[self getImage:assetsDic[@"8"]]
          smallIcon:[self getImage:assetsDic[@"9"]]
   impressionEvents:[self getEvent:[[NSArray alloc] initWithArray:nativeDic[@"impressionEvent"]]]
         viewEvents:[self getEvent:[[NSArray alloc] initWithArray:nativeDic[@"viewEvent"]]]];
}

- (NSString*) getTitle:(NSDictionary*) dic {
  return dic[@"title"][@"text"];
}

- (AdImageDto*) getImage:(NSDictionary*) dic {
  NSDictionary* imgDic = dic[@"img"];
  return [[AdImageDto alloc]
      initWithWidth:[imgDic[@"w"] longValue] height:[imgDic[@"h"] longValue] url:[self revertUrl:imgDic[@"url"]]];
}

- (NSString*) getDataValue:(NSDictionary*) dic {
  return dic[@"data"][@"value"];
}

- (AdLinkDto*) getLink:(NSDictionary*) dic {
  NSDictionary* linkDic = dic[@"link"];
  NSString* url = [self revertUrl:linkDic[@"url"]];

  NSArray* array = [[NSArray alloc] initWithArray:linkDic[@"clicktrackers"]];
  NSMutableArray* clickTrackers = [NSMutableArray array];
  for (int i = 0; i < array.count; ++i) {
    [clickTrackers addObject:array[(NSUInteger) i]];
  }
  return [[AdLinkDto alloc] initWithUrl:url clickTrackers:clickTrackers];
}

- (NSArray<NSString*>*) getEvent:(NSArray*) eventArray {
  NSMutableArray<NSString*>* events = [NSMutableArray array];
  for (int i = 0; i < eventArray.count; ++i) {
    [events addObject:[self revertUrl:eventArray[(NSUInteger) i]]];
  }
  return events;
}

- (NSString*) revertUrl:(NSString*) similarUrl {
  if ([similarUrl hasPrefix:@"//"]) {
    return [NSString stringWithFormat:@"https:%@", similarUrl];
  } else if (![similarUrl containsString:@"://"]) {
    return [NSString stringWithFormat:@"https://%@", similarUrl];
  }
  return similarUrl;
}
@end