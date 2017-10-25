//
//  NUStringCoder.m
//  Nursery
//
//  Created by P,T,A on 2013/11/16.
//
//

#import "NUStringCoder.h"
#import "NUCharacter.h"
#import "NUPlayLot.h"

@implementation NUStringCoder

- (id)new
{
	return [NSMutableString new];
}

- (void)encode:(id)anObject withAliaser:(NUAliaser *)anAliaser
{
    [self encodeIndexedIvarsOf:anObject withAliaser:anAliaser];
}

- (void)encodeIndexedIvarsOf:(id)anObject withAliaser:(NUAliaser *)anAliaser
{
	NSMutableString *aString = anObject;
	NSData *aStringData = [aString dataUsingEncoding:NSUTF8StringEncoding];
	[anAliaser encodeIndexedBytes:(NUUInt8 *)[aStringData bytes] count:[aStringData length]];
}

- (void)decode:(id)anObject withAliaser:(NUAliaser *)anAliaser
{
    [self decodeIndexedIvarsOf:anObject withAliaser:anAliaser];
}

- (void)decodeIndexedIvarsOf:(id)anObject withAliaser:(NUAliaser *)anAliaser
{
	NSMutableString *aString = anObject;
	[aString setString:[self decodeObjectWithAliaser:anAliaser]];
}

- (id)decodeObjectWithAliaser:(NUAliaser *)anAliaser
{
	NUUInt64 aLength = [anAliaser indexedIvarsSize];
	NSString *aString = nil;
	
	if (aLength)
	{
		NUUInt8 *aBytes = malloc(aLength);
		[anAliaser decodeBytes:aBytes count:aLength];
		aString = [[NSString alloc] initWithBytes:aBytes length:aLength encoding:NSUTF8StringEncoding];
		free(aBytes);
	}
	else
		aString = [NSString new];
    
	return [aString autorelease];
}

- (BOOL)canMoveUpObject:(id)anObject withAliaser:(NUAliaser *)anAliaser
{
    return [[anAliaser character] isMutable];
}

- (void)moveUpObject:(id)anObject withAliaser:(NUAliaser *)anAliaser
{
    if (![[anAliaser character] isMutable]) return;
    
    NSMutableString *aString = anObject;
    [aString setString:[self decodeObjectWithAliaser:anAliaser]];
    [[anAliaser playLot] unmarkChangedObject:aString];
}

@end