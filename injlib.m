#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface Injection : NSObject
- (int) test:(int) x;
@end

@implementation Injection
+ (void) load
{
    NSLog(@"------ [ injlib ] ------\n");
    NSLog(@"injlib.dylib have already injected.");
    Class clsTest = NSClassFromString(@"Test");
    NSLog(@"clsTest: %p\n",clsTest);
    Method originalMethod = class_getInstanceMethod(clsTest,@selector(test:));
    Method newMethod = class_getInstanceMethod(self,@selector(test:));
    originalImp = method_getImplementation(originalMethod);
    IMP newImp = method_getImplementation(newMethod);
    method_setImplementation(originalMethod,newImp);
}

IMP originalImp;
int a=100;
- (int) test:(int) x
{
    NSLog(@"[Injection test:]\n");
    NSLog(@"original method returns: %i\n",(int)originalImp(self,@selector(test),x));
    return x+a;
}
@end
