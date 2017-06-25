//
//  Define.h
//  girl
//
//  Created by 尹楠 on 11-6-21.
//  Copyright 2011年 c2y. All rights reserved.
//

/***** 第三方组件设置 *****/

/*****  系统通用宏  *****/
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]
#define FILE_BUNDLE_PATH(fileName) [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], fileName]
#define FILE_SENDBOX_PATH(fileName) [NSString stringWithFormat:@"%@/%@", DOCUMENT_PATH, fileName]

#define Minutes(int)    int * 60
#define Hours(int)    int * 60 * 60
#define Int2String(int)  [NSString stringWithFormat:@"%li", int]
#define FLOAT02String(float)  [NSString stringWithFormat:@"%.0f", floor(float)]
#define FLOAT22String(float)  [NSString stringWithFormat:@"%.2f", float]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RANDOM(from, to)                from + (arc4random() % (to - from + 1))
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)


/*****  系统通用设置  *****/
#define VERSION                         @"1.0"
#define USE_TEST_DATA                   NO
#define DB                              ((AppDelegate *)[UIApplication sharedApplication].delegate).database
#define DB_NAME                         @"Database.sqlite"
#define MAIN_VIEW                       ((AppDelegate *)[UIApplication sharedApplication].delegate).mainView


/***** 用户缺省设置 *****/
#define DEFAULT_GAME_FILE_SLOT_NUMBER                       [[[NSUserDefaults standardUserDefaults] objectForKey:@"slotNumber"] integerValue]
#define SET_DEFAULT_GAME_FILE_SLOT_NUMBER(slotNumber)    [[NSUserDefaults standardUserDefaults] setObject:@(slotNumber) forKey:@"slotNumber"];[[NSUserDefaults standardUserDefaults] synchronize];

/*****  接口地址  *****/


/***** 应用内通知相关 *****/
#define K_SHOULD_PREPARE_GAME_NOTIFICATION                  @"k_ShouldPrepareGameNotification"
#define K_SHOW_SCENE_NOTIFICATION                           @"k_ShowSceneNotification"
#define K_SHOW_OFFLINE_TIME_MODE_SELECTION_NOTIFICATION     @"k_ShowOfflineTimeModeSelectionNotification"

#define K_TIME_CHANGED_NOTIFICATION                         @"k_TimeChnagedNotification"

#define K_SHOULD_RELOAD_ITEMS_NOTIFICATION                  @"k_ShouldReloadItemsNotification"
#define K_SHOULD_RELOAD_SURVIVOR_COUNT_NOTIFICATION         @"k_ShouldReloadSurvivorCountNotification"
#define K_SHOULD_RELOAD_DEFENCE_NOTIFICATION                @"k_ShouldReloadDefenceNotification"
#define K_SHOULD_RELOAD_PEACE_NOTIFICATION                  @"k_ShouldReloadPeaceNotification"
#define K_SHOULD_RELOAD_NATTINESS_NOTIFICATION              @"k_ShouldReloadNattinessNotification"
#define K_SHOULD_RELOAD_SANITATION_NOTIFICATION             @"k_ShouldReloadSanitationNotification"
#define K_SHOULD_RELOAD_THREAT_NOTIFICATION                 @"k_ShouldReloadThreatNotification"
#define K_SHOULD_RELOAD_HOURSING_AREA_NOTIFICATION          @"k_ShouldReloadHoursingAreaNotification"
#define K_SHOULD_RELOAD_AVAILABLE_HOURSING_AREA_NOTIFICATION          @"k_ShouldReloadAvailableHoursingAreaNotification"

#define K_SHOULD_RELOAD_ME_NOTIFICATION                     @"k_ShouldReloadMeNotification"
#define K_SHOULD_RELOAD_SCENE_NOTIFICATION                  @"k_ShouldReloadSceneNotification"
#define K_SHOULD_RELOAD_MAP_NOTIFICATION                    @"k_ShouldReloadMapNotification"
#define K_SHOULD_RELOAD_GROUP_NOTIFICATION                  @"k_ShouldReloadGroupNotification"
#define K_SHOULD_RELOAD_SCHEDULE_NOTIFICATION               @"k_ShouldReloadScheduleNotification"
#define K_SHOULD_RELOAD_MESSAGE_NOTIFICATION                @"k_ShouldReloadMessageNotification"
#define K_SHOULD_RELOAD_ACTION_NOTIFICATION                 @"k_ShouldReloadActionNotification"
#define K_SHOULD_RELOAD_HOME_MUTABLEACTIONS_NOTIFICATION    @"k_ShouldReloadHomeMutableActionsNotification"
#define K_SHOULD_BEGIN_STORY_NOTIFICATION                   @"k_ShouldBeginStoryNotification"

#define K_SHOULD_CLOSE_ITEMVIEW_NOTIFICATION                @"k_ShouldCloseItemViewNotification"
#define K_SHOULD_RELOAD_STORE_NOTIFICATION                  @"k_ShouldReloadStoreNotification"
#define K_SHOULD_RELOAD_BAG_NOTIFICATION                    @"k_ShouldReloadBagNotification"

#define K_SHOULD_RELOAD_FEAR_NOTIFICATION                   @"k_ShouldReloadFearNotification"
#define K_SHOULD_RELOAD_SAD_NOTIFICATION                    @"k_ShouldReloadSadNotification"
#define K_SHOULD_RELOAD_ANGER_NOTIFICATION                  @"k_ShouldReloadAngerNotification"
#define K_SHOULD_RELOAD_SHAME_NOTIFICATION                  @"k_ShouldReloadShameNotification"
#define K_SHOULD_RELOAD_HAPPY_NOTIFICATION                  @"k_ShouldReloadHappyNotification"
#define K_SHOULD_RELOAD_LUST_NOTIFICATION                   @"k_ShouldReloadLustNotification"

#define K_SHOULD_RELOAD_HUNGRY_NOTIFICATION                 @"k_ShouldReloadHungryNotification"
#define K_SHOULD_RELOAD_THIRSTY_NOTIFICATION                @"k_ShouldReloadThirstyNotification"
#define K_SHOULD_RELOAD_PEE_NOTIFICATION                    @"k_ShouldReloadPeeNotification"

#define K_FINISHED_FASTEN_NOTIFICATION                      @"k_FinishedFastenNotification"
#define K_FINISHED_PATROL_NOTIFICATION                      @"k_FinishedPatrolNotification"
#define K_FINISHED_PACK_NOTIFICATION                        @"k_FinishedPackNotification"
#define K_FINISHED_CLEAN_NOTIFICATION                       @"k_FinishedCleanNotification"
#define K_FINISHED_EXPAND_NOTIFICATION                      @"k_FinishedExpandNotification"
#define K_FINISHED_INNER_SEARCH_NOTIFICATION                @"k_FinishedInnerSearchNotification"
#define K_FINISHED_OUTER_SEARCH_NOTIFICATION                @"k_FinishedOuterSearchNotification"

/***** DMS *****/
#define K_SHOULD_RELOAD_DATA_NOTIFICATION                   @"k_ShouldReloadDataNotification"


/***** 资源通用相关 *****/
#define IOS7 ([[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0)
#define SCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                   [UIScreen mainScreen].bounds.size.height

/***** UI通用相关 *****/
#define BACKGROUND_COLOR                RGBA(30, 30, 30, 1)
#define BLACK_COLOR                     RGBA(51,51,51,1)
#define DARK_GRAY_COLOR                 RGBA(90,90,90,1)
#define GRAY_COLOR                      RGBA(150,150,150,1)
#define WHITE_COLOR                     RGBA(253,253,253,1)
#define RED_VALUE_COLOR                 RGBA(180,0,0,1)
#define YELLOW_VALUE_COLOR              RGBA(255,200,100,1)
#define GREEN_VALUE_COLOR               RGBA(100,200,0,1)
#define GROUP_CONTAINER_BORDER_COLOR    RGBA(150,150,150,1)
#define HUD_DISMISS_IN_SECOND           1.5f
#define TEXT_SPACING_FOR_LINE           4.5f    //文本行间距

/***** 游戏通用 *****/
#define MESSAGE_SPEED                   0.1f
#define BATTERY                         78
#define k_FEAR                          @"fear"
#define k_SAD                           @"sad"
#define k_ANGER                         @"anger"
#define k_SHAME                         @"shame"
#define k_HAPPY                         @"happy"
#define k_LUST                          @"lust"
#define k_HUNGRY                        @"hungry"
#define k_THIRSTY                       @"thirsty"
#define k_PEE                           @"pee"

/***** 游戏设置 *****/


enum {
    SceneTypeSplash = 1,                    //欢迎屏幕
    SceneTypeSpace = 2,                     //地点
    SceneTypeOutdoors = 3                   //户外
};
typedef NSUInteger SceneType;

enum {
    DisplayPropertyTypeText = 1,            //文字
    DisplayPropertyTypeBar = 2,             //数值条
};
typedef NSUInteger DisplayPropertyType;

enum {
    GameFileOperationCreate = 1,            //创建游戏存档
    GameFileOperationLoad = 2,              //读取游戏存档
};
typedef NSUInteger GameFileOperation;

enum {
    SeasonSpring = 1,                       //春
    SeasonSummer = 2,                       //夏
    SeasonAutumn = 3,                       //秋
    SeasonWinter = 4,                       //冬
};
typedef NSUInteger Season;

enum {
    WeatherFineDay = 1,                     //晴
    WeatherOvercast = 2,                    //阴
    WeatherRain = 3,                        //雨
    WeatherSnow = 4,                        //雪
};
typedef NSUInteger Weather;

enum {
    GenderMale = 1,                         //男
    GenderFemale = 2                        //女
};
typedef NSUInteger Gender;

enum {
    PersonStatusNormal = 1,                 //休息
    PersonStatusWorking = 2,                //正在工作
    PersonStatusSleeping = 3                //正在睡觉
};
typedef NSUInteger PersonStatus;

enum {
    WorkingOnFasten = 100,                  //正在加固
    WorkingOnPatrol = 110,                  //正在巡逻
    WorkingOnPack = 120,                    //正在整理
    WorkingOnClean = 130,                   //正在清洁
    WorkingOnExpand = 140,                  //正在扩张
    WorkingOnInnerSearch = 150,             //正在室内搜索
    WorkingOnOuterSearch = 160              //正在外出搜索
};
typedef NSUInteger WorkingOn;

enum {
    PersonalityJinShen = 1,                 //谨慎
    PersonalityDanXiao = 2,                 //胆小
    PersonalityGuoGan = 3,                  //果敢
    PersonalityLuMang = 4,                  //鲁莽
    PersonalityLengXue = 5,                 //冷血
    PersonalityZiSi = 6,                    //自私
    PersonalityYouAi = 7                    //友爱
};
typedef NSUInteger Personality;

//enum {
//    ItemTypeAll = 0,                        //全部
//    ItemTypeFood = 1,                       //食物
//    ItemTypeFoodMaterial = 2,               //食材
//    ItemTypeBuildingMaterial = 3,           //建材
//    ItemTypeComponent = 4,                  //零件
//    ItemTypeGasoline = 5,                   //汽油
//    ItemTypeMedicine = 6,                   //药物
//    ItemTypeDrink = 7,                      //饮料
//    ItemTypeContainer = 10,                 //容器
//    ItemTypeWaterContainer = 11,            //液体容器
//    ItemTypeFacility = 20,                  //设施
//    ItemTypeWeapon = 100,                   //武器
//    ItemTypeAmmo = 101,                     //弹药
//    ItemTypeCap = 102,                      //帽子
//    ItemTypeClothing = 103,                 //衣服
//    ItemTypePants = 105,                    //裤子
//    ItemTypeShoes = 106,                    //鞋
//};
//typedef NSUInteger ItemType;

enum {
    
    MessageTypeAside = 0,
    MessageTypeMe = 1,
    MessageTypePerson = 2,
};
typedef NSUInteger MessageType;

enum {
    EffectTypeNone = 0,                     //无
    EffectTypeHealthRecovery = 10,          //恢复生命
    EffectTypeStaminaRecovery = 20,         //恢复耐力
    EffectTypeHungryRecovery = 30,          //减少饥饿
    EffectTypeThirstyRecovery = 40,         //减少口渴
    EffectTypeEquipOnMainHand = 1000,       //可装备在主手
    EffectTypeEquipOnOffHand = 1001,        //可装备在副手
    EffectTypeEquipOnHead = 1002,           //可穿戴在头部
    EffectTypeEquipOnBody = 1003,           //可穿戴在身体
    EffectTypeEquipOnBack = 1004,           //可穿戴在后背
    EffectTypeEquipOnLeg = 1005,            //可穿戴在腿部
    EffectTypeEquipOnFoot = 1006,           //可穿戴在脚部
    EffectTypeContainer = 1010,             //可作为容器
    EffectTypeWaterContainer = 1011,        //可作为液体容器
    EffectTypeIsFood = 1020,                  //可食用
    EffectTypeIsFoodMaterial = 1021,          //可作为食材
    EffectTypeIsDrink = 1022,                 //可饮用
    EffectTypeIsBuildingMaterial = 1023,      //可作为建材
    EffectTypeIsComponent = 1024,             //可作为零件
    EffectTypeIsGasoline = 1025,              //可作为汽油
//    EffectTypeRanLiao = 1026,                   //可作为燃料
    EffectTypeIsMedicine = 1027,              //可作为药物
    EffectTypeIsFacility = 1028,              //可作为设施
    EffectTypeIsWeapon = 1050,                //武器
    EffectTypeIsAmmo = 1051,                  //弹药
    EffectTypeIsProtection = 1052,            //护具
    EffectTypeDamage = 2000,                //增加伤害
    EffectTypeProtection = 2010,            //增加防护
};
typedef NSUInteger EffectType;

enum {
    ActionAimNone = 0,                      //无
    ActionAimSearchSupply = 1,              //寻找补给品
    ActionAimClearThreat = 2                //清剿威胁
};
typedef NSUInteger ActionAim;

enum {
    ActionStrategyNone = 0,                 //无
    ActionStrategyConservativelyAction = 1, //谨慎行动
    ActionStrategyQuicklyAction = 2         //快速行动
};
typedef NSUInteger ActionStrategy;

enum {
    ThreatStrategyNone = 0,                 //无
    ThreatStrategyAvoid = 1,                //避开威胁
    ThreatStrategyClear = 2                 //清剿威胁
};
typedef NSUInteger ThreatStrategy;

enum {
    OfflineTimeModeNoSetting = 0,           //未设置
    OfflineTimeModeTimeContinue = 1,        //时间继续
    OfflineTimeModeTimePause = 2            //时间暂停
};
typedef NSUInteger OfflineTimeMode;


#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif


