//
//  NUNSString.h
//  Nursery
//
//  Created by P,T,A on 2013/11/16.
//
//

#import <Nursery/NUTypes.h>

@interface NSString (NUCharacter)

- (NUUInt64)indexedIvarsSize;

@end

@interface NUNSString : NSString
@end

@interface NUNSMutableString : NSMutableString
@end