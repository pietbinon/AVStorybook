//
//  PageDataModel.h
//  AVStorybook
//
//  Created by Enoch Ng on 2016-05-22.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PageDataModel : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) int pageIndex;
@property (strong, nonatomic) NSURL *audioFileURL;

-(instancetype)initWithIndex:(int)index;

@end
