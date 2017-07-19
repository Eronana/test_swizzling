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
    // get class Test
    Class clsTest = NSClassFromString(@"Test");
    NSLog(@"clsTest: %p\n",clsTest);
    // get methods
    Method originalMethod = class_getInstanceMethod(clsTest,@selector(test:));
    Method newMethod = class_getInstanceMethod(self,@selector(test:));
    // get imps
    originalImp = method_getImplementation(originalMethod);
    IMP newImp = method_getImplementation(newMethod);
    // set new imp to original method
    method_setImplementation(originalMethod,newImp);
}

IMP originalImp;
int a=100;

- (int) test:(int) x
{
    NSLog(@"[Injection test:]\n");
    // call original method by original imp
    int ret = (int)originalImp(self,@selector(test),x);
    NSLog(@"original method returns: %i\n", ret);
    return x+a;
}
@end
