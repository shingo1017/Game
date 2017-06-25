//
//  Person.m
//  destroy
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Person.h"

static Person *_me;
static Person *_partner;

@interface Person () {
    
    
}

@end

@implementation Person

+ (void)setMe:(Person *)me {
    
    _me = me;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ME_NOTIFICATION object:nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_GROUP_NOTIFICATION object:nil];
}

+ (Person *)me {
    
    return _me;
}

+ (void)setPartner:(Person *)partner {
    
    _partner = partner;
}

+ (Person *)partner {
    
    return _partner;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
//        [self addObserver:self forKeyPath:k_FEAR options:NSKeyValueObservingOptionNew context:NULL];
//        [self addObserver:self forKeyPath:k_SAD options:NSKeyValueObservingOptionNew context:NULL];
//        [self addObserver:self forKeyPath:k_ANGER options:NSKeyValueObservingOptionNew context:NULL];
//        [self addObserver:self forKeyPath:k_SHAME options:NSKeyValueObservingOptionNew context:NULL];
//        [self addObserver:self forKeyPath:k_HAPPY options:NSKeyValueObservingOptionNew context:NULL];
//        [self addObserver:self forKeyPath:k_LUST options:NSKeyValueObservingOptionNew context:NULL];
//        
//        [self addObserver:self forKeyPath:k_HUNGRY options:NSKeyValueObservingOptionNew context:NULL];
//        [self addObserver:self forKeyPath:k_THIRSTY options:NSKeyValueObservingOptionNew context:NULL];
//        [self addObserver:self forKeyPath:k_PEE options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    return self;
}

- (void)dealloc {
    
   
}

- (void)initialization {
    
    [self commonInitialization];
    
    [self initializationNonSave];
}

- (void)initializationNonSave {
    
    
}

- (void)commonInitialization {
    
}

- (BOOL)isSameSceneWithPerson:(Person *)person {
    
    if ([[self property:@"scene"] isEqualToString:[person property:@"scene"]])
        return YES;
    else
        return NO;
}

- (void)setProperty:(id)value forKey:(id)key save:(BOOL)save {
    
    [super setProperty:value forKey:key save:save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@.%@", @"Person", key] object:value];
}

- (NSInteger)consumeLevel {
    
    if ([self intProperty:@"hungry"] > 0)
        return 1;
    else if ([self intProperty:@"energy"] > 0)
        return 2;
    else
        return 3;
}

- (void)intProperty:(NSString *)key plus:(NSInteger)number {
    
    [self intProperty:key plus:number save:YES];
}

- (void)intProperty:(NSString *)key plus:(NSInteger)number save:(BOOL)save {
    
    if ([key isEqualToString:@"hungry"] || [key isEqualToString:@"energy"] || [key isEqualToString:@"life"]) {
        
        NSInteger hungry = [self intProperty:@"hungry"];
        NSInteger energy = [self intProperty:@"energy"];
        NSInteger life = [self intProperty:@"life"];
        NSInteger height = [self intProperty:@"height"];
        NSInteger weight = [self intProperty:@"weight"];
        CGFloat bmi = (float)weight / ((float)height * 0.01 * (float)height * 0.01);
        
        if (number > 0) {
            
            //恢复
            if (hungry > 0 || energy == 1000) {
                
                NSInteger recover = number / (bmi / 20);
                recover += recover * [[System system] intProperty:@"goodIntakeNutrientLevel"] * 0.1f;
                
                if (hungry + recover > 1000)
                    [self setProperty:@1000 forKey:@"hungry"];
                else
                    [super intProperty:@"hungry" plus:recover save:save];
            }
            else if (energy > 0 || life == 1000) {
                
                NSInteger recover = number * 1.5 / (bmi / 20);
                recover += recover * [[System system] intProperty:@"goodIntakeNutrientLevel"] * 0.1f;
                if (energy + recover > 1000) {
                    
                    [self setProperty:@1000 forKey:@"energy"];
                    [self intProperty:@"hungry" plus:energy + recover - 1000];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
                }
                else
                    [super intProperty:@"energy" plus:recover save:save];
            }
            else {
                
                NSInteger recover = number * 2 / (bmi / 20);
                recover += recover * [[System system] intProperty:@"goodIntakeNutrientLevel"] * 0.1f;
                if (life + recover > 1000) {
                    
                    [self setProperty:@1000 forKey:@"life"];
                    [self intProperty:@"energy" plus:life + recover - 1000];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
                }
                else
                    [super intProperty:@"life" plus:recover save:save];
            }
        }
        else {
            
            //消耗
            if (hungry > 0) {
                
                //消耗能量
                NSInteger consumption = number * (bmi / 20);
                consumption -= consumption * [[System system] intProperty:@"littleEatLevel"] * 0.05f;
                if (hungry + consumption <= 0) {
                    
                    [self setProperty:@0 forKey:@"hungry"];
                    [self intProperty:@"energy" plus:hungry + consumption];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
                }
                else
                    [super intProperty:@"hungry" plus:consumption save:save];
            }
            else if (energy > 0) {
                
                //消耗脂肪
                NSInteger consumption = (number * 0.4) / (bmi / 20);
                consumption -= consumption * [[System system] intProperty:@"littleEatLevel"] * 0.05f;
                if (energy + consumption <= 0) {
                    
                    [self setProperty:@0 forKey:@"energy"];
                    [self intProperty:@"life" plus:energy + consumption];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
                }
                else
                    [super intProperty:@"energy" plus:consumption save:save];
                //NSLog(@"consumption = %li", consumption);
            }
            else if (life > 0) {
                
                //消耗生命
                NSInteger reason = [self intProperty:@"reason"];
                NSInteger consumption = (number * 0.7) / (reason * 0.001);
                consumption -= consumption * [[System system] intProperty:@"littleEatLevel"] * 0.05f;
                if (life + consumption < 0) {
                    
                    //饿死
                    [Story beginStoryWithClassName:@"DieBecauseNoLifeStory"];
                }
                else
                    [super intProperty:@"life" plus:consumption save:save];
                //NSLog(@"consumption = %li", consumption);
            }
        }
    }
    else if ([key isEqualToString:@"thirsty"]) {
        
        //口渴
        NSInteger thirsty = [self intProperty:@"thirsty"];
        NSInteger dehydration = [self intProperty:@"dehydration"];
        
        if (number > 0) {
            
            //恢复
            if (thirsty > 0 || dehydration == 1000) {
                
                NSInteger recover = number;
                recover += recover * [[System system] intProperty:@"goodIntakeDurabilityLevel"] * 0.1f;
                if (thirsty + recover > 1000)
                    [self setProperty:@1000 forKey:@"thirsty"];
                else
                    [super intProperty:@"thirsty" plus:recover save:save];
            }
            else {
                
                NSInteger recover = number * 2;
                recover += recover * [[System system] intProperty:@"goodIntakeDurabilityLevel"] * 0.1f;
                if (dehydration + recover > 1000) {
                    
                    [self setProperty:@1000 forKey:@"dehydration"];
                    [self intProperty:@"thirsty" plus:dehydration + recover - 1000];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
                }
                else
                    [super intProperty:@"dehydration" plus:recover save:save];
            }
        }
        else {
            
            //消耗
            if (thirsty > 0) {
                
                //消耗水分
                NSInteger consumption = number;
                consumption -= consumption * [[System system] intProperty:@"littleDrinkLevel"] * 0.05f;
                if (thirsty + consumption <= 0) {
                    
                    [self setProperty:@0 forKey:@"thirsty"];
                    [self intProperty:@"dehydration" plus:thirsty + consumption];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldReloadMyStatusOnMainScreenGroup" object:nil];
                }
                else
                    [super intProperty:@"thirsty" plus:consumption save:save];
            }
            else {
                
                //消耗脱水
                NSInteger consumption = number * 0.5;
                consumption -= consumption * [[System system] intProperty:@"littleDrinkLevel"] * 0.05f;
                if (dehydration + consumption <= 0) {
                    
                    //渴死
                    [Story beginStoryWithClassName:@"DieBecauseNoThirstyStory"];
                }
                else
                    [super intProperty:@"dehydration" plus:consumption save:save];
            }
        }
    }
    else if ([key isEqualToString:@"sober"]) {
        
        //清醒
        NSInteger sober = [self intProperty:@"sober"];
        
        if (number > 0) {
            
            //恢复
            NSInteger recover = number;
            recover += recover * [[System system] intProperty:@"goodIntakeRestLevel"] * 0.1f;
            if (sober + recover > 1000)
                [self setProperty:@1000 forKey:@"sober"];
            else
                [super intProperty:@"sober" plus:recover save:save];
        }
        else {
            
            //消耗
            NSInteger consumption = number;
            if (sober + consumption < 0) {
                
                //困到极点
                [Story beginStoryWithClassName:@"FaintBecauseNoSoberStory"];
            }
            else
                [super intProperty:@"sober" plus:consumption save:save];
        }
    }
    else {
        
        [super intProperty:key plus:number save:save];
    }
}

- (NSDictionary *)dictionaryForSave {
    
    NSMutableDictionary *dictionaryForSave = [[NSMutableDictionary alloc] init];
    
    [dictionaryForSave setObject:NSStringFromClass([[Person me] class]) forKey:@"personClassName"];
    
    NSMutableDictionary *girDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.propertyDictionary.allKeys) {
        
        if (![key hasSuffix:@"_isSave"]) {
            
            BOOL isSave = [[self.propertyDictionary objectForKey:[NSString stringWithFormat:@"%@_isSave", key]] boolValue];
            
            if (isSave)
                [girDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
        else {
            
            [girDictionary setObject:[self.propertyDictionary objectForKey:key] forKey:key];
        }
    }
    [dictionaryForSave setObject:girDictionary forKey:@"personProperties"];
    
    return dictionaryForSave;
}

+ (void)loadMeWithSaveDictionary:(NSDictionary *)saveDictionary {
    
    NSString *personClassName = [saveDictionary objectForKey:@"personClassName"];
    if (personClassName.length > 0) {
        
        Person *person = [[NSClassFromString(personClassName) alloc] init];
        NSDictionary *propertyDictionary = [saveDictionary objectForKey:@"personProperties"];
        for (NSString *key in propertyDictionary.allKeys) {
            
            if ([propertyDictionary objectForKey:key])
                [person.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
        }
        
        [person initializationNonSave];
        [person commonInitialization];
        
        [Person setMe:person];
    }
}

+ (void)loadPartnerWithSaveDictionary:(NSDictionary *)saveDictionary {
    
    NSString *personClassName = [saveDictionary objectForKey:@"personClassName"];
    if (personClassName.length > 0) {
        
        Person *person = [[NSClassFromString(personClassName) alloc] init];
        NSDictionary *propertyDictionary = [saveDictionary objectForKey:@"personProperties"];
        for (NSString *key in propertyDictionary.allKeys) {
            
            if ([propertyDictionary objectForKey:key])
                [person.propertyDictionary setObject:[propertyDictionary objectForKey:key] forKey:key];
        }
        
        [person initializationNonSave];
        [person commonInitialization];
        
        [Person setPartner:person];
    }
}

@end
