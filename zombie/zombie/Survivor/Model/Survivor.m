//
//  Survivor.m
//  worldOfZombie
//
//  Created by Shingo on 13-7-22.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import "Survivor.h"
#import "UIColor+Additions.h"
//#import "ItemEffect.h"

static Survivor *_defaultSurvivor;

@implementation Survivor

+ (void)initKeys {
    
    [Utility addKeys:@[k_name, k_gender, k_age, k_health, k_stamina, k_hungry, k_thirsty, k_prestige, k_status, k_courage, k_strength, k_agility, k_strategy, k_eq, k_goodness, k_combat, k_shooting, k_survival, k_logistics, k_burden]
               texts:@[@"姓名", @"性别", @"年龄", @"健康", @"精力", @"饥饿", @"口渴", @"威望", @"状态", @"勇气", @"力气", @"灵活", @"谋略", @"情商", @"善良", @"战斗", @"射击", @"生存", @"后勤", @"负重"]];
}

+ (BOOL)allowSaveArray {
    
    return YES;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[NSString uniqueString] forKey:k_id];
        [self setProperty:@100 forKey:k_maxStamina];
        [self setProperty:@100 forKey:@"hungry_max"];
        [self setProperty:@100 forKey:@"thirsty_max"];
    }
    return self;
}

- (NSString *)genderText {
    
    if ([self intProperty:k_gender] == 1)
        return @"男";
    else
        return @"女";
}

- (NSString *)statusText {
    
    NSString *statusText = [self property:k_status];
    if (statusText)
        return statusText;
    else
        return @"空闲";
}

- (CGFloat)burden {
    
    return 20 + 0.5 * [self intProperty:k_strength];
}

//- (NSString *)workingOnText {
//    
//    _workingOnText = [NSString stringWithFormat:@"正在进行[%@]", _workingOnEvent.name];
//    
//    return _workingOnText;
//}
//
//- (void)setMaxHealth:(CGFloat)maxHealth {
//    
//    if (maxHealth < 0)
//        _maxHealth = 0;
//    else
//        _maxHealth = maxHealth;
//    
//    [self save];
//}
//
//- (void)setMaxStamina:(CGFloat)maxStamina {
//    
//    if (maxStamina < 0)
//        _maxStamina = 0;
//    else
//        _maxStamina = maxStamina;
//    
//    [self save];
//}
//
//- (void)setHealth:(CGFloat)health {
//    
//    if (health < 0)
//        _health = 0;
//    else if (health > 100)
//        _health = 100;
//    else
//        _health = health;
//    
//    [self save];
//}
//
//- (UIColor *)healthColor {
//    
//    return [UIColor colorWithValue:self.health max:self.maxHealth midp:0.6 lowp:0.3];
//}
//
//- (NSString *)healthText {
//    
//    if (self.health < self.maxHealth * 0.05)
//        _healthText = @"濒死";
//    else if (self.health < self.maxHealth * 0.3)
//        _healthText = @"重伤";
//    else if (self.health < self.maxHealth * 0.6)
//        _healthText = @"受伤";
//    else if (self.health < self.maxHealth * 0.8)
//        _healthText = @"轻伤";
//    else if (self.health < self.maxHealth * 0.9)
//        _healthText = @"擦伤";
//    else
//        _healthText = @"健康";
//    
//    return _healthText;
//}
//
//- (void)setStamina:(CGFloat)stamina {
//    
//    if (stamina < 0)
//        _stamina = 0;
//    else if (stamina > 100)
//        _stamina = 100;
//    else
//        _stamina = stamina;
//    
//    [self save];
//}
//
//- (UIColor *)staminaColor {
//    
//    return [UIColor colorWithValue:self.stamina max:self.maxStamina midp:0.6 lowp:0.3];
//}
//
//- (void)setHungry:(CGFloat)hungry {
//    
//    if (hungry < 0)
//        _hungry = 0;
//    else if (hungry > 100)
//        _hungry = 100;
//    else
//        _hungry = hungry;
//    
//    [self save];
//}
//
//- (UIColor *)hungryColor {
//    
//    return [UIColor colorWithValue:self.hungry mid:80 low:40 desc:YES];
//}
//
//- (void)setThirsty:(CGFloat)thirsty {
//    
//    if (thirsty < 0)
//        _thirsty = 0;
//    else if (thirsty > 100)
//        _thirsty = 100;
//    else
//        _thirsty = thirsty;
//    
//    [self save];
//}
//
//- (UIColor *)thirstyColor {
//    
//    return [UIColor colorWithValue:self.thirsty mid:70 low:40 desc:YES];
//}
//
//- (NSString *)personalityText {
//    
//    if (self.personality == PersonalityDanXiao)
//        _personalityText = @"胆小";
//    else if (self.personality == PersonalityGuoGan)
//        _personalityText = @"果敢";
//    else if (self.personality == PersonalityJinShen)
//        _personalityText = @"谨慎";
//    else if (self.personality == PersonalityLengXue)
//        _personalityText = @"冷血";
//    else if (self.personality == PersonalityLuMang)
//        _personalityText = @"鲁莽";
//    else if (self.personality == PersonalityYouAi)
//        _personalityText = @"友爱";
//    else if (self.personality == PersonalityZiSi)
//        _personalityText = @"自私";
//    
//    return _personalityText;
//}
//
//- (NSString *)statusText {
//    
//    if (self.status == PersonStatusNormal)
//        _statusText = @"正在休息";
//    else if (self.status == PersonStatusSleeping)
//        _statusText = @"正在睡觉";
//    else if (self.status == PersonStatusWorking)
//        _statusText = @"正在工作";
//    
//    return _statusText;
//}
//
//- (void)setMainHandItemId:(NSInteger)mainHandItemId {
//    
//    _mainHandItemId = mainHandItemId;
//    
//    _mainHandItem = nil;
//}
//
//- (Item *)mainHandItem {
//    
//    if (!_mainHandItem) {
//        
//        _mainHandItem = [Item baseItemWithId:_mainHandItemId];
//    }
//    
//    return _mainHandItem;
//}
//
//- (void)setOffHandItemId:(NSInteger)offHandItemId {
//    
//    _offHandItemId = offHandItemId;
//    
//    _offHandItem = nil;
//}
//
//- (Item *)offHandItem {
//    
//    if (!_offHandItem) {
//        
//        _offHandItem = [Item baseItemWithId:_offHandItemId];
//    }
//    
//    return _offHandItem;
//}
//
//- (void)setHeadItemId:(NSInteger)headItemId {
//    
//    _headItemId = headItemId;
//    
//    _headItem = nil;
//}
//
//- (Item *)headItem {
//    
//    if (!_headItem) {
//        
//        _headItem = [Item baseItemWithId:_headItemId];
//    }
//    
//    return _headItem;
//}
//
//- (void)setBodyItemId:(NSInteger)bodyItemId {
//    
//    _bodyItemId = bodyItemId;
//    
//    _bodyItem = nil;
//}
//
//- (Item *)bodyItem {
//    
//    if (!_bodyItem) {
//        
//        _bodyItem = [Item baseItemWithId:_bodyItemId];
//    }
//    
//    return _bodyItem;
//}
//
//- (void)setBackItemId:(NSInteger)backItemId {
//    
//    _backItemId = backItemId;
//    
//    _backItem = nil;
//}
//
//- (Item *)backItem {
//    
//    if (!_backItem) {
//        
//        _backItem = [Item baseItemWithId:_backItemId];
//    }
//    
//    return _backItem;
//}
//
//- (NSArray *)equipItems {
//    
//    NSMutableArray *equipItems = [[NSMutableArray alloc] init];
//    
//    if (self.mainHandItem)
//        [equipItems addObject:self.mainHandItem];
//    if (self.offHandItem)
//        [equipItems addObject:self.offHandItem];
//    if (self.headItem)
//        [equipItems addObject:self.headItem];
//    if (self.bodyItem)
//        [equipItems addObject:self.bodyItem];
//    if (self.backItem)
//        [equipItems addObject:self.backItem];
//    
//    _equipItems = [[NSArray alloc] initWithArray:equipItems];
//    
//    return _equipItems;
//}
//
//- (void)setPrestige:(CGFloat)prestige {
//    
//    if (prestige < 0)
//        _prestige = 0;
//    else
//        _prestige = prestige;
//    
//    [self save];
//}
//
//- (void)setCombat:(CGFloat)combat {
//    
//    if (combat < 0)
//        _combat = 0;
//    else
//        _combat = combat;
//    
//    [self save];
//}
//
//- (void)setShooting:(CGFloat)shooting {
//    
//    if (shooting < 0)
//        _shooting = 0;
//    else
//        _shooting = shooting;
//    
//    [self save];
//}
//
//- (void)setSurvival:(CGFloat)survival {
//    
//    if (survival < 0)
//        _survival = 0;
//    else
//        _survival = survival;
//    
//    [self save];
//}
//
//- (void)setLogistics:(CGFloat)logistics {
//    
//    if (logistics < 0)
//        _logistics = 0;
//    else
//        _logistics = logistics;
//    
//    [self save];
//}
//
//+ (Survivor *)defaultSurvivor {
//    
//    if (!_defaultSurvivor) {
//        
//        _defaultSurvivor = [Survivor survivorWithId:[GameSetting defaultSurvivorId]];
//    }
//    
//    return _defaultSurvivor;
//}
//
//+ (void)setDefaultSurvivor:(Survivor *)survivor {
//    
//    _defaultSurvivor = survivor;
//}
//
//+ (Survivor *)survivorWithId:(NSInteger)id {
//    
//    FMResultSet *results = [DB executeQuery:@"select * from Survivor where id = ?", @(id), nil];
//    while ([results next]) {
//        
//        Survivor *survivor = [[Survivor alloc] init];
//        survivor.id = [results intForColumn:@"id"];
//        survivor.baseSurvivorId = [results intForColumn:@"baseSurvivorId"];
//        survivor.baseSurvivor = [Survivor baseSurvivorWithId:survivor.baseSurvivorId];
//        survivor.name = [results stringForColumn:@"name"];
//        survivor.gender = survivor.baseSurvivor.gender;
//        survivor.age = [results intForColumn:@"age"];
//        survivor.personality = (Personality)[results intForColumn:@"personality"];
//        survivor.prestige = [results doubleForColumn:@"prestige"];
//        survivor.maxHealth = [results doubleForColumn:@"maxHealth"];
//        survivor.health = [results doubleForColumn:@"health"];
//        survivor.maxStamina = [results doubleForColumn:@"maxStamina"];
//        survivor.stamina = [results doubleForColumn:@"stamina"];
//        survivor.combat = [results doubleForColumn:@"combat"];
//        survivor.shooting = [results doubleForColumn:@"shooting"];
//        survivor.survival = [results doubleForColumn:@"survival"];
//        survivor.logistics = [results doubleForColumn:@"logistics"];
//        survivor.courage = [results doubleForColumn:@"courage"];
//        survivor.strength = [results doubleForColumn:@"strength"];
//        survivor.agility = [results doubleForColumn:@"agility"];
//        survivor.strategy = [results doubleForColumn:@"strategy"];
//        survivor.eq = [results doubleForColumn:@"eq"];
//        survivor.goodness = [results doubleForColumn:@"goodness"];
//        survivor.status = (PersonStatus)[results intForColumn:@"status"];
//        survivor.hungry = [results doubleForColumn:@"hungry"];
//        survivor.thirsty = [results doubleForColumn:@"thirsty"];
//        survivor.summary = [results stringForColumn:@"summary"];
//        survivor.mainHandItemId = [results intForColumn:@"mainHandItemId"];
//        survivor.offHandItemId = [results intForColumn:@"offHandItemId"];
//        survivor.headItemId = [results intForColumn:@"headItemId"];
//        survivor.bodyItemId = [results intForColumn:@"bodyItemId"];
//        survivor.backItemId = [results intForColumn:@"backItemId"];
//        
//        return survivor;
//    }
//    
//    return nil;
//}
//
//+ (Survivor *)baseSurvivorWithId:(NSInteger)id {
//    
//    FMResultSet *results = [DB executeQuery:@"select * from BaseSurvivor where id = ?", @(id), nil];
//    while ([results next]) {
//        
//        Survivor *survivor = [[Survivor alloc] init];
//        survivor.id = [results intForColumn:@"id"];
//        survivor.name = [results stringForColumn:@"name"];
//        survivor.gender = (Gender)[results intForColumn:@"gender"];
//        survivor.age = [results intForColumn:@"age"];
//        survivor.personality = (Personality)[results intForColumn:@"personality"];
//        survivor.prestige = [results doubleForColumn:@"prestige"];
//        survivor.maxHealth = [results doubleForColumn:@"maxHealth"];
//        survivor.maxStamina = [results doubleForColumn:@"maxStamina"];
//        survivor.combat = [results doubleForColumn:@"combat"];
//        survivor.shooting = [results doubleForColumn:@"shooting"];
//        survivor.survival = [results doubleForColumn:@"survival"];
//        survivor.logistics = [results doubleForColumn:@"logistics"];
//        survivor.courage = [results doubleForColumn:@"courage"];
//        survivor.strength = [results doubleForColumn:@"strength"];
//        survivor.agility = [results doubleForColumn:@"agility"];
//        survivor.strategy = [results doubleForColumn:@"strategy"];
//        survivor.eq = [results doubleForColumn:@"eq"];
//        survivor.goodness = [results doubleForColumn:@"goodness"];
//        survivor.status = (PersonStatus)[results intForColumn:@"status"];
////        survivor.hungry = [results doubleForColumn:@"hungry"];
////        survivor.thirsty = [results doubleForColumn:@"thirsty"];
//        survivor.summary = [results stringForColumn:@"summary"];
//        survivor.mainHandItemId = [results intForColumn:@"mainHandItemId"];
//        survivor.offHandItemId = [results intForColumn:@"offHandItemId"];
//        survivor.headItemId = [results intForColumn:@"headItemId"];
//        survivor.bodyItemId = [results intForColumn:@"bodyItemId"];
//        survivor.backItemId = [results intForColumn:@"backItemId"];
//        
//        return survivor;
//    }
//    
//    return nil;
//}
//
//+ (NSArray *)survivorsWithSpaceId:(NSInteger)spaceId {
//    
//    NSMutableArray *survivors = [[NSMutableArray alloc] init];
//    FMResultSet *results = [DB executeQuery:@"select * from SpaceSurvivor where spaceId = ?", @(spaceId), nil];
//    while ([results next]) {
//        
//        NSInteger survivorId = [results intForColumn:@"survivorId"];
//        [survivors addObject:[Survivor survivorWithId:survivorId]];
//    }
//    
//    return survivors;
//}
//
//+ (void)initializeData {
//    
//    //初始化幸存者存档数据
//    [DB executeUpdate:@"delete from Survivor", nil];
//    [DB executeUpdate:@"insert into Survivor(baseSurvivorId, name, health, maxHealth, stamina, maxStamina, combat, shooting, survival, logistics, courage, strength, agility, strategy, eq, goodness, prestige, personality, hungry, thirsty, status, age, summary, mainHandItemId, offHandItemId, headItemId, bodyItemId, backItemId, legItemId, footItemId) select id as baseSurvivorId, name, maxHealth as health, maxHealth, maxStamina as stamina, maxStamina, combat, shooting, survival, logistics, courage, strength, agility, strategy, eq, goodness, prestige, personality, 0 as hungry, 0 as thirsty, 0 as status, age, summary, mainHandItemId, offHandItemId, headItemId, bodyItemId, backItemId, legItemId, footItemId from BaseSurvivor", nil];
//    
//    //获取大本营和幸存者关系的元数据
//    NSInteger baseSpaceId = 0;
//    NSInteger baseSurvivorId = 0;
//    FMResultSet *baseSpaceSurvivorResults = [DB executeQuery:@"select spaceId, survivorId from BaseSpaceSurvivor where storyId = ?", @([Story defaultStory].id), nil];
//    while ([baseSpaceSurvivorResults next]) {
//        
//        baseSpaceId = [baseSpaceSurvivorResults intForColumn:@"spaceId"];
//        baseSurvivorId = [baseSpaceSurvivorResults intForColumn:@"survivorId"];
//    }
//    
//    //根据元数据查找大本营存档数据
//    NSInteger spaceId = 0;
//    FMResultSet *spaceResults = [DB executeQuery:@"select id from Space where baseSpaceId = ?", @(baseSpaceId), nil];
//    while ([spaceResults next]) {
//        
//        spaceId = [spaceResults intForColumn:@"id"];
//    }
//    
//    //根据元数据查找幸存者存档数据
//    NSInteger survivorId = 0;
//    FMResultSet *survivorResults = [DB executeQuery:@"select id from Survivor where baseSurvivorId = ?", @(baseSurvivorId), nil];
//    while ([survivorResults next]) {
//        
//        survivorId = [survivorResults intForColumn:@"id"];
//    }
//    
//    //清空大本营幸存者存档数据
//    [DB executeUpdate:@"delete from SpaceSurvivor", nil];
//    //初始化大本营和幸存者关系的存档数据
//    [DB executeUpdate:@"insert into SpaceSurvivor(spaceId, survivorId) values (?, ?)", @(spaceId), @(survivorId), nil];
//    
//    //根据元数据查找领袖存档数据
//    NSInteger leaderId = 0;
//    FMResultSet *leaderResults = [DB executeQuery:@"select id from Survivor where baseSurvivorId = ?", @([Base defaultBase].leaderId), nil];
//    while ([leaderResults next]) {
//        
//        leaderId = [leaderResults intForColumn:@"id"];
//    }
//    
//    //更新大本营领袖的存档数据
//    [Base defaultBase].leaderId = leaderId;
//    [[Base defaultBase] save];
//    
//    //根据元数据查找玩家控制幸存者存档数据
//    NSInteger defaultSurvivorId = 0;
//    FMResultSet *defaultSurvivorResults = [DB executeQuery:@"select id from Survivor where baseSurvivorId = ?", @([Story defaultStory].survivorId), nil];
//    while ([defaultSurvivorResults next]) {
//        
//        defaultSurvivorId = [defaultSurvivorResults intForColumn:@"id"];
//        [GameSetting setDefaultSurvivorId:defaultSurvivorId];
//    }
//}
//
//#pragma mark 成员方法
//
//- (void)addObserverForPersonProperties {
//    
//    [self addObserver:self forKeyPath:k_STATUS options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_HEALTH options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_STAMINA options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_COURAGE options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_STRENGTH options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_AGILITY options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_STRATEGY options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_EQ options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_GOODNESS options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_HUNGRY options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_THIRSTY options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_COMBAT options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_SHOOTING options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_SURVIVAL options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:k_LOGISTICS options:NSKeyValueObservingOptionNew context:NULL];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    
//    if ([keyPath isEqualToString:k_STATUS]) {
//        
//        NSInteger newValue = [[change objectForKey:@"new"] integerValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_STATUS_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_HEALTH]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_HEALTH_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_STAMINA]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_STAMINA_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_COURAGE]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_COURAGE_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_STRENGTH]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_STRENGTH_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_AGILITY]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_AGILITY_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_STRATEGY]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_STRATEGY_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_EQ]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_EQ_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_GOODNESS]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_GOODNESS_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_HUNGRY]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_HUNGRY_NOTIFICATION object:@(newValue)];
//        
//        //检查是否需要吃东西
//        if (newValue >= [CalculationServiceEngine hungryForEat:self]) {
//            
//            //检查基地里有没有食物
//            Item *item = [[Base defaultBase] itemForEffectId:1020];
//            
//            if (item) {
//                
//                //消耗一单位食物
//                [[Base defaultBase] dropItem:item number:1];
//                
//                //使用食物
//                [self useItem:item];
//            }
//        }
//    }
//    else if ([keyPath isEqualToString:k_THIRSTY]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_THIRSTY_NOTIFICATION object:@(newValue)];
//        
//        //检查是否需要喝水
//        if (newValue >= [CalculationServiceEngine thirstyForDrink:self]) {
//            
//            //检查基地里有没有水
//            Item *item = [[Base defaultBase] itemForEffectId:1022];
//            
//            if (item) {
//                
//                //消耗一单位水
//                [[Base defaultBase] dropItem:item number:1];
//                
//                //使用水
//                [self useItem:item];
//            }
//        }
//    }
//    else if ([keyPath isEqualToString:k_COMBAT]) {
//        
//        NSInteger newValue = [[change objectForKey:@"new"] integerValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_COMBAT_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_SHOOTING]) {
//        
//        NSInteger newValue = [[change objectForKey:@"new"] integerValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SHOOTING_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_SURVIVAL]) {
//        
//        NSInteger newValue = [[change objectForKey:@"new"] integerValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SURVIVAL_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_LOGISTICS]) {
//        
//        NSInteger newValue = [[change objectForKey:@"new"] integerValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_LOGISTICS_NOTIFICATION object:@(newValue)];
//    }
//}
//
//- (BOOL)isMySelf {
//    
//    return self.id == [Survivor defaultSurvivor].id;
//}
//
//- (BagItem *)bagItemForItemId:(NSInteger)itemId {
//    
//    return nil;
//}
//
//- (void)save {
//    
//    FMResultSet *results = [DB executeQuery:@"select count(*) from Survivor where id = ?", @(self.id), nil];
//    while ([results next]) {
//        
//        int count = [results intForColumnIndex:0];
//        if (count == 0) {
//            
//            [DB executeUpdate:@"insert into Survivor(id, name, gender, personality, maxHealth, health, maxStamina, stamina, courage, strength, agility, strategy, eq, goodness, status, hungry, thirsty) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);select last_insert_rowid()", @(self.id), self.name, @(self.gender), @(self.personality), @(self.maxHealth), @(self.health), @(self.maxStamina), @(self.stamina), @(self.courage), @(self.strength), @(self.agility), @(self.strategy), @(self.eq), @(self.goodness), @(self.status) , @(self.hungry), @(self.thirsty), nil];
//            self.id = (int)[DB lastInsertRowId];
//        }
//        else {
//            
//            [DB executeUpdate:@"update Survivor set maxHealth = ?, health = ?, maxStamina = ?, stamina = ?, courage = ?, strength = ?, agility = ?, strategy = ?, eq = ?, goodness = ?, status = ?, hungry = ?, thirsty = ? where id = ?", @(self.maxHealth), @(self.health), @(self.maxStamina), @(self.stamina), @(self.courage), @(self.strength), @(self.agility), @(self.strategy), @(self.eq), @(self.goodness), @(self.status) , @(self.hungry), @(self.thirsty), @(self.id), nil];
//        }
//    }
//    
//    [DB executeUpdate:@"update Survivor set prestige = ?, combat = ?, shooting = ?, survival = ?, logistics = ? where id = ?", @(self.prestige), @(self.combat), @(self.shooting), @(self.survival), @(self.logistics), @(self.id), nil];
//}
//
//#pragma mark 指令方法
//
////- (void)startWorkingOnEvent:(Event *)workingOnEvent {
////    
////    Error *error;
//////    if (_workingOn == WorkingOnInnerSearch) {
//////        
//////        NSInteger searchDuration = [CalculationServiceEngine searchDurationWithSurvivor:self base:[Base defaultBase]];
//////        self.workingProgress = 0;
//////        self.workingMaxProgress = searchDuration;
//////        
//////        CGFloat staminaForPatrol = [CalculationServiceEngine staminaForSearch] * searchDuration;
//////        if (self.stamina - staminaForPatrol < [CalculationServiceEngine staminaForStopWork:self])
//////            error = [Error errorWithDictionary:@{@"Status":@100, @"ExceptionMessage":@"耐力不足"}];
//////    }
////    
////    //开始工作计时
////    if (error == nil) {
////        
////        //停止正在做的工作
////        if (self.status == PersonStatusWorking)
////            [self stopWorking];
////        
////        self.status = PersonStatusWorking;
////        _workingOnEvent = workingOnEvent;
////        
////        workingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(workingTimerTicked:) userInfo:nil repeats:YES];
////        
////        //显示消息
//////        [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"交给我好了！"];
////    }
//////    else
//////        [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:error.message];
////}
////
////- (void)workingTimerTicked:(NSTimer *)timer {
////    
////    if (self.workingOn == WorkingOnFasten) {
////        
////        CGFloat staminaForFasten = [CalculationServiceEngine staminaForFasten];
////        if (self.stamina - staminaForFasten < [CalculationServiceEngine staminaForStopWork:self]) {
////            
////            [self stopWorking];
////            
//////            [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"呼～累死了，我必须要休息会了"];
////        }
////        else {
////            
////            //防御值增加
////            [Base defaultBase].defence += [CalculationServiceEngine fastenValueWithSurvivor:self];
////            
////            //耐力消耗
////            self.stamina -= staminaForFasten;
////            
////            //能力奖励
////            self.maxStamina += 0.0005;
////            self.strength += 0.0001;
////            
////            //判断是否完成工作
////            if ([Base defaultBase].defence >= [Base defaultBase].maxDefence) {
////                
////                [self stopWorking];
////                
//////                [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"看看这坚固的堡垒，那些邪恶的东西已经没法攻陷这里了！"];
////            }
////        }
////    }
////    else if (self.workingOn == WorkingOnPatrol) {
////        
////        CGFloat staminaForPatrol = [CalculationServiceEngine staminaForPatrol];
////        if (self.stamina - staminaForPatrol < [CalculationServiceEngine staminaForStopWork:self]) {
////            
////            [self stopWorking];
////            
//////            [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"呼～累死了，我必须要休息会了"];
////        }
////        else {
////            
////            //治安值增加
////            [Base defaultBase].peace += [CalculationServiceEngine patrolValueWithSurvivor:self base:[Base defaultBase]];
////            
////            //耐力消耗
////            self.stamina -= staminaForPatrol;
////            
////            //能力奖励
////            self.maxStamina += 0.0005;
////            self.prestige += 0.0002;
////            
////            //判断是否完成工作
////            if ([Base defaultBase].peace >= 100) {
////                
////                [self stopWorking];
////                
//////                [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"大家相处和睦，互帮互助"];
////            }
////        }
////    }
////    else if (self.workingOn == WorkingOnPack) {
////        
////        CGFloat staminaForPack = [CalculationServiceEngine staminaForPack];
////        if (self.stamina - staminaForPack < [CalculationServiceEngine staminaForStopWork:self]) {
////            
////            [self stopWorking];
////            
//////            [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"呼～累死了，我必须要休息会了"];
////        }
////        else {
////            
////            //整洁值增加
////            [Base defaultBase].nattiness += [CalculationServiceEngine packValueWithSurvivor:self base:[Base defaultBase]];
////            
////            //耐力消耗
////            self.stamina -= staminaForPack;
////            
////            //能力奖励
////            self.maxStamina += 0.0005;
////            self.logistics += 0.0002;
////            
////            //判断是否完成工作
////            if ([Base defaultBase].nattiness >= 100) {
////                
////                [self stopWorking];
////                
//////                [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"经过我的整理，这里最起码还能装下一辆坦克"];
////            }
////        }
////    }
////    else if (self.workingOn == WorkingOnClean) {
////        
////        CGFloat staminaForClean = [CalculationServiceEngine staminaForClean];
////        if (self.stamina - staminaForClean < [CalculationServiceEngine staminaForStopWork:self]) {
////            
////            [self stopWorking];
////            
//////            [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"呼～累死了，我必须要休息会了"];
////        }
////        else {
////            
////            //清洁值增加
////            [Base defaultBase].sanitation += [CalculationServiceEngine cleanValueWithSurvivor:self base:[Base defaultBase]];
////            
////            //耐力消耗
////            self.stamina -= staminaForClean;
////            
////            //能力奖励
////            self.maxStamina += 0.0005;
////            self.logistics += 0.0002;
////            
////            //判断是否完成工作
////            if ([Base defaultBase].sanitation >= 100) {
////                
////                [self stopWorking];
////                
//////                [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"这里简直可以用一尘不染来形容"];
////            }
////        }
////    }
////    else if (self.workingOn == WorkingOnExpand) {
////        
////        CGFloat staminaForExpand = [CalculationServiceEngine staminaForExpand];
////        if (self.stamina - staminaForExpand < [CalculationServiceEngine staminaForStopWork:self]) {
////            
////            [self stopWorking];
////            
//////            [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"呼～累死了，我必须要休息会了"];
////        }
////        else {
////            
////            //建筑面积增加
////            [Base defaultBase].hoursingArea += [CalculationServiceEngine expandValueWithSurvivor:self];
////            
////            //耐力消耗
////            self.stamina -= staminaForExpand;
////            
////            //能力奖励
////            self.maxStamina += 0.0005;
////            self.strength += 0.0001;
////            
////            //判断是否完成工作
////            if ([Base defaultBase].hoursingArea >= [Base defaultBase].structureArea) {
////                
////                [self stopWorking];
////                
//////                [[MessageBar sharedMessageBar] showWithIcon:[UIImage imageNamed:self.name] message:@"大本营已经没法再大了"];
////            }
////        }
////    }
////    else if (self.workingOn == WorkingOnInnerSearch) {
////        
////        self.workingProgress += 1;
////        
////        //判断是否完成工作
////        if (self.workingProgress >= self.workingMaxProgress) {
////            
////            [[Base defaultBase] search];
////            
////            //耐力消耗
////            self.stamina -= [CalculationServiceEngine staminaForSearch];
////            
////            //能力奖励
////            self.maxStamina += 0.02;
////            self.survival += 0.02;
////            
////            [self stopWorking];
////            [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_INNER_SEARCH_NOTIFICATION object:nil];
////        }
////    }
////    else if (self.workingOn == WorkingOnOuterSearch) {
////        
////        self.workingProgress += 1;
////        
////        //判断是否完成工作
////        if (self.workingProgress >= self.workingMaxProgress) {
////            
////            [[Base defaultBase] search];
////            
////            //耐力消耗
////            self.stamina -= [CalculationServiceEngine staminaForSearch];
////            
////            //能力奖励
////            self.maxStamina += 0.02;
////            self.survival += 0.02;
////            
////            [self stopWorking];
////            [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_OUTER_SEARCH_NOTIFICATION object:nil];
////        }
////    }
////}
////
////- (void)stopWorking {
////    
////    self.status = PersonStatusNormal;
////    
////    [workingTimer invalidate];
////    workingTimer = nil;
////    
////    if (self.workingOn == WorkingOnFasten)
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_FASTEN_NOTIFICATION object:nil];
////    else if (self.workingOn == WorkingOnPatrol)
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_PATROL_NOTIFICATION object:nil];
////    else if (self.workingOn == WorkingOnPack)
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_PACK_NOTIFICATION object:nil];
////    else if (self.workingOn == WorkingOnClean)
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_CLEAN_NOTIFICATION object:nil];
////    else if (self.workingOn == WorkingOnExpand)
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_EXPAND_NOTIFICATION object:nil];
////    else if (self.workingOn == WorkingOnInnerSearch)
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_INNER_SEARCH_NOTIFICATION object:nil];
////    else if (self.workingOn == WorkingOnOuterSearch)
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_FINISHED_OUTER_SEARCH_NOTIFICATION object:nil];
////}
//
//- (void)useItem:(Item *)item {
//    
//    for (ItemEffect *itemEffect in item.effects) {
//        
//        if (itemEffect.effectId == 2020) {
//            
//            //减少饥饿
//            self.hungry -= [itemEffect.value1 floatValue];
//        }
//        else if (itemEffect.effectId == 2030) {
//            
//            //减少口渴
//            self.thirsty -= [itemEffect.value1 floatValue];
//        }
//    }
//}

//- (void)staminaTimerTicked:(NSTimer *)timer {
//    
//    if (healthTimerEnabled) {
//        
//        if (_status == PersonStatusNormal || _status == PersonStatusSleeping || _status == PersonStatusWorking) {
//            
//            //TODO:生命自然增长的公式
//            self.health += 0.1;
//        }
//    }
//    
//    if (staminaTimerEnabled) {
//        
//        if (_status == PersonStatusNormal || _status == PersonStatusSleeping) {
//            
//            //TODO:耐力自然增长的公式
//            self.stamina += 0.5;
//        }
//    }
//    
//    if (hungryTimerEnabled) {
//        
//        self.hungry += [CalculationServiceEngine hungryPerTickWithPerson:self];
//    }
//    
//    if (thirstyTimerEnabled) {
//        
//        self.thirsty += [CalculationServiceEngine thirstyPerTickWithPerson:self];
//    }
//}

@end
