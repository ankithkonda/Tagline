/*
 
 File: AppSpecificValues.h
 Abstract: Basic introduction to GameCenter
 
 Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple Inc.
 ("Apple") in consideration of your agreement to the following terms, and your
 use, installation, modification or redistribution of this Apple software
 constitutes acceptance of these terms.  If you do not agree with these terms,
 please do not use, install, modify or redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and subject
 to these terms, Apple grants you a personal, non-exclusive license, under
 Apple's copyrights in this original Apple software (the "Apple Software"), to
 use, reproduce, modify and redistribute the Apple Software, with or without
 modifications, in source and/or binary forms; provided that if you redistribute
 the Apple Software in its entirety and without modifications, you must retain
 this notice and the following text and disclaimers in all such redistributions
 of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may be used
 to endorse or promote products derived from the Apple Software without specific
 prior written permission from Apple.  Except as expressly stated in this notice,
 no other rights or licenses, express or implied, are granted by Apple herein,
 including but not limited to any patent rights that may be infringed by your
 derivative works or by other works in which the Apple Software may be
 incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
 WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
 WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
 COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR
 DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
 CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF
 APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

//These constants are defined in iTunesConnect, and will function as long
//  as this sample is built/run with the existing bundle identifier
//  (com.appledts.GKTapper).  If you want to experiment with this sample and
//  iTunesConnect, you'll need to define you're own bundle ID and iTunes
//  Connect configurations.  This sample uses reverse DNS for Leaderboards
//  and Achievement IDs, but this is not a requirement.  Any string that
//  iTunes Connect will accept will work fine.

//Leaderboard Category IDs
#define kLeaderboardID_Score @"com.matchmovierelease.score.leadboard"
#define kLeaderboardID_Player @"com.matchmovierelease.playerLevel.leadboard"
#define kLeaderboardID_Streak @"com.matchmovierelease.streak.leadboard"







//Achievement IDs
#define kAchievementID_LevelTen @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelTwenty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelThirty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelFourty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelFifty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelSixty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelSeventy @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelEighty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelNinty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelHundred @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelHundredAndFifty @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelTwoHundred @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelThreeHundred @"com.matchmovierelease.achievements.levelten"
#define kAchievementID_LevelFiveHundred @"com.matchmovierelease.achievements.levelten"


#define kAchievementID_Streaker @"com.matchmovierelease.achievements.streakFive"
#define kAchievementID_StreakTen @"com.matchmovierelease.achievements.streakTen"
#define kAchievementID_StreakFifteen @"com.matchmovierelease.achievements.streakFifteen"
#define kAchievementID_StreakTwenty @"com.matchmovierelease.achievements.streakTwenty"
#define kAchievementID_StreakTwentyFive @"com.matchmovierelease.achievements.streakTwentyFive"
#define kAchievementID_StreakThirty @"com.matchmovierelease.achievements.streakThirty"
#define kAchievementID_StreakThirtyFive @"com.matchmovierelease.achievements.streakThirtyFive"
#define kAchievementID_StreakFourty @"com.matchmovierelease.achievements.streakFourty"
#define kAchievementID_StreakKing @"com.matchmovierelease.achievements.streakKing"


//#define kAchievement_GreenHorn_ID @"com.matchmovie.achievements.greenhorn"





//MatchMovie Values
#define TMDB_API_KEY @"ee360cd37e8eb5abf9ba51ead9a1b9b0"


#define IMAGE_URL_PATH_LOW_QUALITY @"http://cf2.imgobject.com/t/p/w92" 
//Small Image


#define IMAGE_URL_PATH_HIGH_QUALITY @"http://cf2.imgobject.com/t/p/w185" 
//Large Image

#define CORRECT_SCORE 50
#define INCORRECT_SCORE 20



//GenreIDs
#define D_GenreKey @"genreToUse"

#define G_All @"all"
#define G_Action @"28"          //  30
#define G_Adventure @"12"       //  20
#define G_Animation @"16"       //  5
#define G_Comedy @"35"          //  15
#define G_Crime @"80"           //  10
//#define G_Disaster @"105"       //  1
//#define G_Documentary @"99"     //  1 
#define G_Drama @"18"           //  23
//#define G_Eastern @"82"         //  1
#define G_Family @"10751"       //  8
//#define G_FanFilm @"10750"      //  0
#define G_Fantasy @"14"         //  10
//#define G_FilmNoir @"10753"     //  1
//#define G_Foreign @"10769"    // not relevant
#define G_History @"36"         //  2
//#define G_Holiday @"10595"      //  1
#define G_Horror @"27"          //  8
#define G_Indie @"10756"        // 2
//#define G_Music @"10402"        //  1
//#define G_Musical @"22"         //  1
#define G_Mystery @"9648"       //  6
//#define G_NeoNoir @"10754"      // 1
//#define G_RoadMovie @"1115"     //  1
#define G_Romance @"10749"      //  7
#define G_ScienceFiction @"878" //18
//#define G_Short @"10755"        //
//#define G_Sport @"9805"
//#define G_SportingEvent @"10758"
//#define G_SportsFilm @"10757"
#define G_Suspense @"10748"     //  2
//#define G_TVMovie @"10770"      //  
#define G_Thriller @"53"        //  26
#define G_War @"10752"          //  2
#define G_Western @"37"         




/*

{
    "id": 28,
    "name": "Action"
},
{
    "id": 12,
    "name": "Adventure"
},
{
    "id": 16,
    "name": "Animation"
},
{
    "id": 35,
    "name": "Comedy"
},
{
    "id": 80,
    "name": "Crime"
},
{
    "id": 105,
    "name": "Disaster"
},
{
    "id": 99,
    "name": "Documentary"
},
{
    "id": 18,
    "name": "Drama"
},
{
    "id": 82,
    "name": "Eastern"
},
{
    "id": 2916,
    "name": "Erotic"
},
{
    "id": 10751,
    "name": "Family"
},
{
    "id": 10750,
    "name": "Fan Film"
},
{
    "id": 14,
    "name": "Fantasy"
},
{
    "id": 10753,
    "name": "Film Noir"
},
{
    "id": 10769,
    "name": "Foreign"
},
{
    "id": 36,
    "name": "History"
},
{
    "id": 10595,
    "name": "Holiday"
},
{
    "id": 27,
    "name": "Horror"
},
{
    "id": 10756,
    "name": "Indie"
},
{
    "id": 10402,
    "name": "Music"
},
{
    "id": 22,
    "name": "Musical"
},
{
    "id": 9648,
    "name": "Mystery"
},
{
    "id": 10754,
    "name": "Neo-noir"
},
{
    "id": 1115,
    "name": "Road Movie"
},
{
    "id": 10749,
    "name": "Romance"
},
{
    "id": 878,
    "name": "Science Fiction"
},
{
    "id": 10755,
    "name": "Short"
},
{
    "id": 9805,
    "name": "Sport"
},
{
    "id": 10758,
    "name": "Sporting Event"
},
{
    "id": 10757,
    "name": "Sports Film"
},
{
    "id": 10748,
    "name": "Suspense"
},
{
    "id": 10770,
    "name": "TV movie"
},
{
    "id": 53,
    "name": "Thriller"
},
{
    "id": 10752,
    "name": "War"
},
{
    "id": 37,
    "name": "Western"
}

 */
