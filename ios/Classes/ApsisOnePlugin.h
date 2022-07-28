#import <Flutter/Flutter.h>
@import UIKit;
@import ApsisOne;

@interface FLNativeViewFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

@interface FLNativeView : NSObject <FlutterPlatformView>

@property (strong, nonatomic) UIView *view;

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;


@end

@interface ApsisOnePlugin : NSObject<FlutterPlugin>
@end

