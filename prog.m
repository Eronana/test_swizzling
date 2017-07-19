#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCryptor.h>
#import <objc/runtime.h>
#include <stdio.h>

@interface Test : NSObject
- (int) test:(int) x;
@end

@implementation Test
int a=10;
- (int) test:(int) x
{
    NSLog(@"[Test test:]\n");
    return x+a;
}
@end

int main(void)
{
    NSLog(@"------ [ prog ] ------\n");
    NSLog(@"Test: %p\n",[Test class]);

    Test *test=[Test new];
    do
    {
        NSLog(@"[test test:2]: %i\n",[test test:2]);
    }while(~getchar());

    return 0;
}
