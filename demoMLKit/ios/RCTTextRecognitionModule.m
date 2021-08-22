//
//  RCTTextRecognitionModule.m
//  demoMLKit
//
//  Created by Trinh Thanh Phuong on 21/08/2021.
//

// RCTTextRecognitionModule.m
#import "RCTTextRecognitionModule.h"
#import <React/RCTLog.h>

@import MLKit;

@implementation RCTTextRecognitionModule

// To export a module named RCTMLKitModule
RCT_EXPORT_MODULE();

- (NSMutableDictionary *)getFrameDictionary: (CGRect)frame {
  NSMutableDictionary *rect = [NSMutableDictionary dictionary];
  [rect setValue:[NSNumber numberWithFloat:frame.origin.x] forKey:@"left"];
  [rect setValue:[NSNumber numberWithFloat:frame.origin.y] forKey:@"top"];
  [rect setValue:[NSNumber numberWithFloat:frame.size.width] forKey:@"width"];
  [rect setValue:[NSNumber numberWithFloat:frame.size.height] forKey:@"height"];
  
  return rect;
}

RCT_EXPORT_METHOD(recognizeImage:(NSString *)url
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
 RCTLogInfo(@"URL %@", url);
  NSURL *_url = [NSURL URLWithString:url];
  NSData *imageData = [NSData dataWithContentsOfURL:_url];
  UIImage *image = [UIImage imageWithData:imageData ];
  
  MLKTextRecognizer *textRecognizer = [MLKTextRecognizer textRecognizer];

  MLKVisionImage *visionImage = [[MLKVisionImage alloc] initWithImage: image];
  
  [textRecognizer processImage:visionImage
                    completion:^(MLKText *_Nullable result,
                                 NSError *_Nullable error) {
    if (error != nil || result == nil) {
      reject(@"text_recognition", @"text recognition in failed", nil);
      return;
    }
    NSMutableDictionary *response = [NSMutableDictionary dictionary];
    
    [response setValue:[NSNumber numberWithInt:image.size.width] forKey: @"width"];
    [response setValue:[NSNumber numberWithInt:image.size.height] forKey: @"height"];
    
    NSMutableArray *blocks = [NSMutableArray array];
    NSString *resultText = result.text;
    for (MLKTextBlock *block in result.blocks) {
      NSMutableDictionary *blockDict = [NSMutableDictionary dictionary];
      [blockDict setValue:block.text forKey:@"text"];
      [blockDict setValue:[self getFrameDictionary:block.frame] forKey:@"rect"];
    
      NSMutableArray *lines = [NSMutableArray array];
      for (MLKTextLine *line in block.lines) {
        NSMutableDictionary *lineDict = [NSMutableDictionary dictionary];
        [lineDict setValue:line.text forKey:@"text"];
        [lineDict setValue:[self getFrameDictionary:line.frame] forKey:@"rect"];
        
        [lines addObject:lineDict];
        
      }
      [blockDict setValue:lines forKey:@"lines"];
      [blocks addObject:blockDict];
    }
    
    [response setValue: blocks forKey:@"blocks"];
    resolve(response);
  }];
}



RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getName)
{
return [[UIDevice currentDevice] name];
}

@end
