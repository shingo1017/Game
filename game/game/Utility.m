//
//  Utility.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Utility.h"
#import <objc/objc.h>
#import <objc/message.h>

static NSMutableDictionary *_sharedKeys;

@implementation Utility

+ (void)addKeys:(NSArray *)keys texts:(NSArray *)texts {
    
    if (!_sharedKeys)
        _sharedKeys = [NSMutableDictionary new];
    
    NSInteger i = 0;
    for (NSString *key in keys) {
        
        _sharedKeys[key] = texts[i];
        i++;
    }
}

+ (NSString *)textForKey:(NSString *)key {
    
    return _sharedKeys[key];
}

+ (id)objectForClassName:(NSString *)className {
    
    Class class = NSClassFromString(className);
    id object = [[class alloc] init];
    return object;
}

+ (Class)subClassForFatherClass:(Class)fatherClass {
    
    NSArray *subClasses = [Utility getSubclassesWithFatherClassName:NSStringFromClass(fatherClass)];
    if (subClasses.count > 0)
        return [subClasses firstObject];
    else
        return fatherClass;
}

+ (NSArray *)getSubclassesWithFatherClassName:(NSString *)fatherClassName {
    
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++)
    {
        Class superClass = classes[i];
        do
        {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != NSClassFromString(fatherClassName));
        
        if (superClass == nil)
        {
            continue;
        }
        
        [result addObject:classes[i]];
    }
    
    free(classes);
    
    return result;
}

+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

//+ (NSString *)textForFormat:(NSString *)string {
//    
//    NSString *text;
//    NSArray *keyPaths = [string componentsSeparatedByString:@"."];
//    
//    id object;
//    for (NSString *keyPath in keyPaths) {
//        
//        if ([keyPath isEqualToString:@"Girl"]) {
//            
//            object = [Girl defaultGirl];
//        }
//        else
//            object = [object property:keyPath];
//    }
//    
//    text = [NSString stringWithFormat:@"%@", object];
//    
//    return text;
//}
//
//+ (NSInteger)intForFormat:(NSString *)string {
//    
//    return [[Utility textForFormat:string] integerValue];
//}

+ (NSArray *)getSubClassesWithFatherClassName:(NSString *)fatherClassName respondsToSelector:(SEL)selector {
    
    NSMutableArray *classes = [[NSMutableArray alloc] init];
    
    NSArray *subClasses = [Utility getSubclassesWithFatherClassName:fatherClassName];
    for (Class class in subClasses) {
        
        if ([class respondsToSelector:selector]) {
            
            [classes addObject:class];
        }
    }
    
    return classes;
}

+ (NSArray *)getSubClassInstancesWithFatherClassName:(NSString *)fatherClassName belongToClassName:(NSString *)belongToClassName {
    
    NSMutableArray *instances = [[NSMutableArray alloc] init];
    
    NSArray *subClasses = [Utility getSubclassesWithFatherClassName:fatherClassName];
    for (Class class in subClasses) {
        
        id object = [[class alloc] init];
        NSArray *belongToClassNames = [object valueForKey:@"belongToClassNames"];
        
        for (NSString *oneOfBelongToClassNames in belongToClassNames) {
            
            if ([oneOfBelongToClassNames isEqualToString:belongToClassName])
                [instances addObject:object];
        }
    }
    
    return instances;
}

+ (void)reloadActions {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

+ (NSArray *)sortArray:(NSArray *)array {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *sort1 = [NSNumber numberWithInteger:[[obj1 valueForKey:@"sort"] integerValue]];
        NSNumber *sort2 = [NSNumber numberWithInteger:[[obj2 valueForKey:@"sort"] integerValue]];
        NSComparisonResult result = [sort1 compare:sort2];
        return result == NSOrderedDescending; // 升序
    }];
    
    return sortedArray;
}

@end
