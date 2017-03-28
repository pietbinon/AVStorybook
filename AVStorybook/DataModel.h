//
//  DataModel.h
//  AVStorybook
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@interface DataModel : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) int pageIndex;
@property (strong, nonatomic) NSURL *audioFileURL;

- (instancetype) initWithIndex: (int) index;

@end
