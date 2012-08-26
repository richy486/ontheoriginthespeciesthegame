//
//  Man.h
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "cocos2d.h"

@interface Man : CCNode
@property CGFloat speed;
@property BOOL lost;
- (void) setUp;
- (void) addedHead;
@end
