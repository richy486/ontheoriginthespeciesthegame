//
//  Score.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "Score.h"
#import "GameConfig.h"

@interface Score()
{
    int _evolutions;
}
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) CCLabelTTF *title;
@end

@implementation Score
- (id) init
{
    self = [super init];
    if (self)
    {
        _evolutions = 0;
        self.startDate = [NSDate date];
        
        NSString *str = [self currentScoreString];
        CCLabelTTF *title = [CCLabelTTF labelWithString:str fontName:@"Helvetica" fontSize:17];
		//title.position = ccp(WIDTH /2 , HEIGHT - 50.0);
        title.color = (ccColor3B){64, 64, 64};
		[self addChild: title];
        self.title = title;
        
        [self schedule: @selector(updateTitle) interval:60];
    }
    return self;
}

- (NSString*) currentScoreString
{
    NSTimeInterval difference = [[NSDate date] timeIntervalSinceDate:self.startDate];
    int minutes = difference / 60;
    
    if (minutes <= 0)
    {
        minutes = 1;
    }
    
    int emp = _evolutions / minutes;
    
    NSString *string = [NSString stringWithFormat:@"%d evolutions per minute", emp];
    return string;
}

- (void) updateTitle
{
    NSString *str = [self currentScoreString];
    [self.title setString:str];
}

- (void) addToEveloutions
{
    _evolutions++;
    [self updateTitle];
}

- (void) dealloc
{
    [_startDate release];
    [super dealloc];
}
@end
