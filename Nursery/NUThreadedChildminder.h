//
//  NUThreadedChildminder.h
//  Nursery
//
//  Created by Akifumi Takata on 2013/03/16.
//
//

@class NUGarden;

@interface NUThreadedChildminder : NSObject
{
    NUGarden *garden;
	NSConditionLock *conditionLock;
	BOOL shouldStop;
	BOOL shouldTerminate;
    BOOL isTerminated;
}

+ (id)threadedChildminderWithGarden:(NUGarden *)aGarden;

- (id)initWithGarden:(NUGarden *)aGarden;

- (NUGarden *)garden;
- (void)setGarden:(NUGarden *)aGarden;

- (void)prepare;
- (void)start;
- (void)startWithoutWait;
- (void)stop;
- (void)terminate;
- (void)startThread:(id)anArgument;
- (void)process;

- (BOOL)shouldStop;
- (void)setShouldStop:(BOOL)aShouldStop;

@end
