//
//  UINavigationController+Flatten.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 13/05/06.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Flatten)
- (id)initWithRootViewController:(UIViewController *)rootViewController flattenColor:(UIColor *)color;
@end
