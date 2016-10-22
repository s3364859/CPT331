//
//  EventSubcategory.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 8/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

/// Responsible for translating event subcategory id's into human-readable names and images to be used in the view
enum EventSubcategry {
    
    // -----------------------------
    // MARK: Subcategory cases
    // -----------------------------
    
    /// Unknown event category
    case Generic
    
    /// Subcategory for "Concerts & Gig Guide"
    case Acoustic, AvantGarde, BarDJs, Blues, Breaks, ChamberMusic, Country, Cover, DrumAndBass, DubRoots, Dubstep, Electro, Electronica, Folk, Funk, HardRock, HipHopAndRap, House, Jazz, Latin, MetalAndHardcore, MusicFestival, OpenMic, Pop, Punk, Karaoke, RnB, Reggae, RockAndPop, Soul, Swing, Techno, Trance, VarietyConert, World
    
    /// Subcategory for "Workshops, Convefences & Classes"
    case Professional, Creative, DanceClass, Education, FamilyAndLifestyle, MindAndBody
    
    /// Subcategory for "Sports & Outdoors"
    case Adventure, Atheltics, AustralianRules, Aviation, Basketball, Boating, Boxing, Cricket, Cycling, Dancesport, Diving, Equestrian, FishingTournament, Walking, Carnival, Golf, Gridiron, HikingAndCamping, HorseRacing, LawnBowls, Marathon, MartialArts, Motorsport, MountainBiking, Multisport, Netball, Orienteering, RodeoSports, Rowing, RugbyUnion, Sailing, Skating, Soccer, Sports, SurfingAndWaterSports, Swimming, Tennis, Triathlon, WindAndKiteSurfing, Wrestling, Yoga
    
    /// Subcategory for "Exhibitions"
    case Contemporary, Craft, Expos, FineArt, Museum, NaturalHistory, Photography, Sculpture, PoliticalHistory
    
    /// Subcategory for "Festivals & Lifestyle"
    case FieldDay, Association, Commemorations, Charity, Children, Environment, Multicultural, FamilyEntertainment, Fashion, Festival, FoodGourmetAndWine, FoodMarket, Hobby, LifestyleShow, MarketsAndFairs, PublicMeeting, Ball, SpringRacing
    
    /// Subcategory for "Performing Arts"
    case Ballet, Cabaret, Choir, ClassicalMusic, Comedy, Dance, Film, Lecture, Literary, Magic, Musical, Opera, Theatre
    
    
    
    // -----------------------------
    // MARK: Computed properties
    // -----------------------------
    
    /// Returns the parent category for which a subcategory belongs to.
    var parentCategory:EventCategory {
        get {
            return EventCategory.fromSubcategory(self)
        }
    }
    
    
    /// The name of the Event Subcategory.
    var name:String {
        get {
            switch self {
            // In case an unknown event identifier is provided
            case .Generic:              return "Event"
                
            // Concerts & Gig Guide
            case .Acoustic:             return "Acoustic, Instrumental"
            case .AvantGarde:           return "Avant-Garde, Experimental"
            case .BarDJs:               return "Bar DJs"
            case .Blues:                return "Blues"
            case .Breaks:               return "Breaks, Broken Beat"
            case .ChamberMusic:         return "Chamber Music"
            case .Country:              return "Country"
            case .Cover:                return "Covers, Tribute Bands"
            case .DrumAndBass:          return "Drum & Bass"
            case .DubRoots:             return "Dub, Roots"
            case .Dubstep:              return "Dubstep"
            case .Electro:              return "Electro"
            case .Electronica:          return "Electronica"
            case .Folk:                 return "Folk"
            case .Funk:                 return "Funk"
            case .HardRock:             return "Hard Rock"
            case .HipHopAndRap:         return "Hip Hop, Rap"
            case .House:                return "House"
            case .Jazz:                 return "Jazz"
            case .Latin:                return "Latin"
            case .MetalAndHardcore:     return "Metal, Hardcore"
            case .MusicFestival:        return "Music Festivals"
            case .OpenMic:              return "Open Mic, Jams"
            case .Pop:                  return "Pop"
            case .Punk:                 return "Punk"
            case .Karaoke:              return "Quiz, Karaoke"
            case .RnB:                  return "R&B, Soul"
            case .Reggae:               return "Reggae"
            case .RockAndPop:           return "Rock & Pop"
            case .Soul:                 return "Soul"
            case .Swing:                return "Swing, Big Bands"
            case .Techno:               return "Techno"
            case .Trance:               return "Trance"
            case .VarietyConert:        return "Variety Concerts"
            case .World:                return "World"
                
            // Workshops, Convefences & Classes
            case .Professional:         return "Business & Professional"
            case .Creative:             return "Creative"
            case .DanceClass:           return "Dance Classes"
            case .Education:            return "Education"
            case .FamilyAndLifestyle:   return "Family & Lifestyle"
            case .MindAndBody:          return "Mind & Body"
                
            // Sports & Outdoors
            case .Adventure:            return "Adventure, Extreme"
            case .Atheltics:            return "Athletics"
            case .AustralianRules:      return "Australian Rules"
            case .Aviation:             return "Aviation"
            case .Basketball:           return "Basketball"
            case .Boating:              return "Boating"
            case .Boxing:               return "Boxing"
            case .Cricket:              return "Cricket"
            case .Cycling:              return "Cycling"
            case .Dancesport:           return "Dancesport"
            case .Diving:               return "Diving"
            case .Equestrian:           return "Equestrian"
            case .FishingTournament:    return "Fishing Tournaments"
            case .Walking:              return "Fun Runs & Walks"
            case .Carnival:             return "Games, Carnivals"
            case .Golf:                 return "Golf"
            case .Gridiron:             return "Gridiron"
            case .HikingAndCamping:     return "Hiking, Camping"
            case .HorseRacing:          return "Horse Racing"
            case .LawnBowls:            return "Lawn Bowls"
            case .Marathon:             return "Marathon"
            case .MartialArts:          return "Martial Arts"
            case .Motorsport:           return "Motorsport"
            case .MountainBiking:       return "Mountain Biking"
            case .Multisport:           return "Multisport"
            case .Netball:              return "Netball"
            case .Orienteering:         return "Orienteering"
            case .RodeoSports:          return "Rodeo Sports"
            case .Rowing:               return "Rowing"
            case .RugbyUnion:           return "Rugby Union"
            case .Sailing:              return "Sailing"
            case .Skating:              return "Skating"
            case .Soccer:               return "Soccer"
            case .Sports:               return "Sports"
            case .SurfingAndWaterSports:return "Surf & Water Sports"
            case .Swimming:             return "Swimming"
            case .Tennis:               return "Tennis"
            case .Triathlon:            return "Triathlon"
            case .WindAndKiteSurfing:   return "Wind & Kite Surfing"
            case .Wrestling:            return "Wrestling"
            case .Yoga:                 return "Yoga"
                
            // Exhibitions
            case .Contemporary:         return "Contemporary"
            case .Craft:                return "Craft & Object Art"
            case .Expos:                return "Expos"
            case .FineArt:              return "Fine Art"
            case .Museum:               return "Museums"
            case .NaturalHistory:       return "Natural History"
            case .Photography:          return "Photography"
            case .Sculpture:            return "Sculpture"
            case .PoliticalHistory:     return "Social & Political History"
                
            // Festivals & Lifestyle
            case .FieldDay:             return "A&P Shows, Field Days"
            case .Association:          return "Alumni, Associations, Clubs"
            case .Commemorations:       return "Ceremonies, Commemorations"
            case .Charity:              return "Charity, Fundraisers"
            case .Children:             return "Children, Kids, Holidays"
            case .Environment:          return "Conservation, Environment"
            case .Multicultural:        return "Ethnic, Multicultural"
            case .FamilyEntertainment:  return "Family Entertainment"
            case .Fashion:              return "Fashion"
            case .Festival:             return "Festivals"
            case .FoodGourmetAndWine:   return "Food, Gourmet, Wine"
            case .FoodMarket:           return "Food/Produce Market"
            case .Hobby:                return "Games, Hobbies"
            case .LifestyleShow:        return "Lifestyle Shows, Expos"
            case .MarketsAndFairs:      return "Markets and Fairs"
            case .PublicMeeting:        return "Public Meetings, Politics"
            case .Ball:                 return "Socials and Balls"
            case .SpringRacing:         return "Spring Racing"
                
            // Performing Arts
            case .Ballet:               return "Ballet"
            case .Cabaret:              return "Cabaret, Burlesque"
            case .Choir:                return "Choir, Vocal Music"
            case .ClassicalMusic:       return "Classical Music"
            case .Comedy:               return "Comedy"
            case .Dance:                return "Dance"
            case .Film:                 return "Film"
            case .Lecture:              return "Forums, Lectures"
            case .Literary:             return "Literary"
            case .Magic:                return "Magic, Variety"
            case .Musical:              return "Musicals"
            case .Opera:                return "Opera"
            case .Theatre:              return "Theatre"
            }
        }
    }
    
    
    /// Image to be used for visually representing the event subcategory in the view
    var image:UIImage? {
        switch self {
            
        // In case an unknown event identifier is provided
        case .Generic:         return UIImage(named: "Event-Category-Generic.png")
            
        // Concerts & Gig Guide
        case .Acoustic:             return UIImage(named: "Event-Category-Acoustic.png")
        case .AvantGarde:           return UIImage(named: "Event-Category-Mask.png")
        case .BarDJs:               return UIImage(named: "Event-Category-DJ.png")
        case .Blues:                return UIImage(named: "Event-Category-Blues.png")
        case .Breaks:               return UIImage(named: "Event-Category-DJ.png")
        case .ChamberMusic:         return UIImage(named: "Event-Category-ChamberMusic.png")
        case .Country:              return UIImage(named: "Event-Category-Country.png")
        case .Cover:                return UIImage(named: "Event-Category-Cover.png")
        case .DrumAndBass:          return UIImage(named: "Event-Category-DrumAndBass.png")
        case .DubRoots:             return UIImage(named: "Event-Category-Reggae.png")
        case .Dubstep:              return UIImage(named: "Event-Category-Dubstep.png")
        case .Electro:              return UIImage(named: "Event-Category-Electro.png")
        case .Electronica:          return UIImage(named: "Event-Category-Electro.png")
        case .Folk:                 return UIImage(named: "Event-Category-Acoustic.png")
        case .Funk:                 return UIImage(named: "Event-Category-Funk.png")
        case .HardRock:             return UIImage(named: "Event-Category-HardRock.png")
        case .HipHopAndRap:         return UIImage(named: "Event-Category-HipHop.png")
        case .House:                return UIImage(named: "Event-Category-DJ.png")
        case .Jazz:                 return UIImage(named: "Event-Category-Jazz.png")
        case .Latin:                return UIImage(named: "Event-Category-Latin.png")
        case .MetalAndHardcore:     return UIImage(named: "Event-Category-Metal.png")
        case .MusicFestival:        return UIImage(named: "Event-Category-Concert.png")
        case .OpenMic:              return UIImage(named: "Event-Category-Karaoke.png")
        case .Pop:                  return UIImage(named: "Event-Category-Pop.png")
        case .Punk:                 return UIImage(named: "Event-Category-Punk.png")
        case .Karaoke:              return UIImage(named: "Event-Category-Karaoke.png")
        case .RnB:                  return UIImage(named: "Event-Category-Rnb.png")
        case .Reggae:               return UIImage(named: "Event-Category-Reggae.png")
        case .RockAndPop:           return UIImage(named: "Event-Category-Band.png")
        case .Soul:                 return UIImage(named: "Event-Category-Soul.png")
        case .Swing:                return UIImage(named: "Event-Category-Band.png")
        case .Techno:               return UIImage(named: "Event-Category-Trance.png")
        case .Trance:               return UIImage(named: "Event-Category-DJ.png")
        case .VarietyConert:        return UIImage(named: "Event-Category-Concert.png")
        case .World:                return UIImage(named: "Event-Category-World.png")
            
        // Workshops, Convefences & Classes
        case .Professional:         return UIImage(named: "Event-Category-Business.png")
        case .Creative:             return UIImage(named: "Event-Category-Creative.png")
        case .DanceClass:           return UIImage(named: "Event-Category-Dancing.png")
        case .Education:            return UIImage(named: "Event-Category-Education.png")
        case .FamilyAndLifestyle:   return UIImage(named: "Event-Category-Family.png")
        case .MindAndBody:          return UIImage(named: "Event-Category-Mind.png")
            
        // Sports & Outdoors
        case .Adventure:            return UIImage(named: "Event-Category-Adventure.png")
        case .Atheltics:            return UIImage(named: "Event-Category-Athletics.png")
        case .AustralianRules:      return UIImage(named: "Event-Category-Kangaroo.png")
        case .Aviation:             return UIImage(named: "Event-Category-Aviation.png")
        case .Basketball:           return UIImage(named: "Event-Category-Basketball.png")
        case .Boating:              return UIImage(named: "Event-Category-Boating.png")
        case .Boxing:               return UIImage(named: "Event-Category-Boxing.png")
        case .Cricket:              return UIImage(named: "Event-Category-Cricket.png")
        case .Cycling:              return UIImage(named: "Event-Category-Cycling.png")
        case .Dancesport:           return UIImage(named: "Event-Category-Dancing.png")
        case .Diving:               return UIImage(named: "Event-Category-Diving.png")
        case .Equestrian:           return UIImage(named: "Event-Category-Equestrian.png")
        case .FishingTournament:    return UIImage(named: "Event-Category-Fishing.png")
        case .Walking:              return UIImage(named: "Event-Category-Walking.png")
        case .Carnival:             return UIImage(named: "Event-Category-Carnival.png")
        case .Golf:                 return UIImage(named: "Event-Category-Golf.png")
        case .Gridiron:             return UIImage(named: "Event-Category-Football.png")
        case .HikingAndCamping:     return UIImage(named: "Event-Category-Camping.png")
        case .HorseRacing:          return UIImage(named: "Event-Category-Horse.png")
        case .LawnBowls:            return UIImage(named: "Event-Category-LawnBowls.png")
        case .Marathon:             return UIImage(named: "Event-Category-Running.png")
        case .MartialArts:          return UIImage(named: "Event-Category-Wrestling.png")
        case .Motorsport:           return UIImage(named: "Event-Category-Motorsport.png")
        case .MountainBiking:       return UIImage(named: "Event-Category-MountainBiking.png")
        case .Multisport:           return UIImage(named: "Event-Category-Sports.png")
        case .Netball:              return UIImage(named: "Event-Category-Basketball.png")
        case .Orienteering:         return UIImage(named: "Event-Category-Adventure.png")
        case .RodeoSports:          return UIImage(named: "Event-Category-Rodeo.png")
        case .Rowing:               return UIImage(named: "Event-Category-Rowing.png")
        case .RugbyUnion:           return UIImage(named: "Event-Category-Football.png")
        case .Sailing:              return UIImage(named: "Event-Category-Sailing.png")
        case .Skating:              return UIImage(named: "Event-Category-Skating.png")
        case .Soccer:               return UIImage(named: "Event-Category-Soccer.png")
        case .Sports:               return UIImage(named: "Event-Category-Sports.png")
        case .SurfingAndWaterSports:return UIImage(named: "Event-Category-Surfing.png")
        case .Swimming:             return UIImage(named: "Event-Category-Swimming.png")
        case .Tennis:               return UIImage(named: "Event-Category-Tennis.png")
        case .Triathlon:            return UIImage(named: "Event-Category-Triathlon.png")
        case .WindAndKiteSurfing:   return UIImage(named: "Event-Category-WindSurfing.png")
        case .Wrestling:            return UIImage(named: "Event-Category-Wrestling.png")
        case .Yoga:                 return UIImage(named: "Event-Category-Yoga.png")
            
        // Exhibitions
        case .Contemporary:         return UIImage(named: "Event-Category-Art.png")
        case .Craft:                return UIImage(named: "Event-Category-Craft.png")
        case .Expos:                return UIImage(named: "Event-Category-Museum.png")
        case .FineArt:              return UIImage(named: "Event-Category-Art.png")
        case .Museum:               return UIImage(named: "Event-Category-Museum.png")
        case .NaturalHistory:       return UIImage(named: "Event-Category-NaturalHistory.png")
        case .Photography:          return UIImage(named: "Event-Category-Photography.png")
        case .Sculpture:            return UIImage(named: "Event-Category-Sculpture.png")
        case .PoliticalHistory:     return UIImage(named: "Event-Category-PoliticalHistory.png")
            
        // Festivals & Lifestyle
        case .FieldDay:             return UIImage(named: "Event-Category-Pig.png")
        case .Association:          return UIImage(named: "Event-Category-Club.png")
        case .Commemorations:       return UIImage(named: "Event-Category-Commemorations.png")
        case .Charity:              return UIImage(named: "Event-Category-Charity.png")
        case .Children:             return UIImage(named: "Event-Category-Children.png")
        case .Environment:          return UIImage(named: "Event-Category-Environment.png")
        case .Multicultural:        return UIImage(named: "Event-Category-Multicultural.png")
        case .FamilyEntertainment:  return UIImage(named: "Event-Category-Family.png")
        case .Fashion:              return UIImage(named: "Event-Category-Fashion.png")
        case .Festival:             return UIImage(named: "Event-Category-Carnival.png")
        case .FoodGourmetAndWine:   return UIImage(named: "Event-Category-Wine.png")
        case .FoodMarket:           return UIImage(named: "Event-Category-Food.png")
        case .Hobby:                return UIImage(named: "Event-Category-Games.png")
        case .LifestyleShow:        return UIImage(named: "Event-Category-Lifestyle.png")
        case .MarketsAndFairs:      return UIImage(named: "Event-Category-Markets.png")
        case .PublicMeeting:        return UIImage(named: "Event-Category-Meetings.png")
        case .Ball:                 return UIImage(named: "Event-Category-Social.png")
        case .SpringRacing:         return UIImage(named: "Event-Category-Horse.png")
            
        // Performing Arts
        case .Ballet:               return UIImage(named: "Event-Category-Ballet.png")
        case .Cabaret:              return UIImage(named: "Event-Category-Mask.png")
        case .Choir:                return UIImage(named: "Event-Category-Choir.png")
        case .ClassicalMusic:       return UIImage(named: "Event-Category-ClassicalMusic.png")
        case .Comedy:               return UIImage(named: "Event-Category-Comedy.png")
        case .Dance:                return UIImage(named: "Event-Category-Dancing.png")
        case .Film:                 return UIImage(named: "Event-Category-Film.png")
        case .Lecture:              return UIImage(named: "Event-Category-Lectures.png")
        case .Literary:             return UIImage(named: "Event-Category-Literature.png")
        case .Magic:                return UIImage(named: "Event-Category-Magic.png")
        case .Musical:              return UIImage(named: "Event-Category-Musicals.png")
        case .Opera:                return UIImage(named: "Event-Category-Opera.png")
        case .Theatre:              return UIImage(named: "Event-Category-Theatre.png")
        }
    }
    
    // -----------------------------
    // MARK: Functions
    // -----------------------------
    
    /// Parses a string identifier (from API) into a EventSubcategory value
    static func fromString(string:String) -> EventSubcategry {
        
        // TODO: switch over to integers when the backend supports it
        
        switch string {
        // Concerts & Gig Guide
        case "Acoustic, Instrumental": return .Acoustic
        case "Avant-Garde, Experimental": return .AvantGarde
        case "Bar DJs": return .BarDJs
        case "Blues": return .Blues
        case "Breaks, Broken Beat": return .Breaks
        case "Chamber Music": return .ChamberMusic
        case "Country": return .Country
        case "Covers, Tribute Bands": return .Cover
        case "Drum & Bass": return .DrumAndBass
        case "Dub, Roots": return .DubRoots
        case "Dubstep": return .Dubstep
        case "Electro": return .Electro
        case "Electronica": return .Electronica
        case "Folk": return .Folk
        case "Funk": return .Funk
        case "Hard Rock": return .HardRock
        case "Hip Hop, Rap": return .HipHopAndRap
        case "House": return .House
        case "Jazz": return .Jazz
        case "Latin": return .Latin
        case "Metal, Hardcore": return .MetalAndHardcore
        case "Music Festivals": return .MusicFestival
        case "Open Mic, Jams": return .OpenMic
        case "Pop": return .Pop
        case "Punk": return .Punk
        case "Quiz, Karaoke": return .Karaoke
        case "R&B, Soul": return .RnB
        case "Reggae": return .Reggae
        case "Rock & Pop": return .RockAndPop
        case "Soul": return .Soul
        case "Swing, Big Bands": return .Swing
        case "Techno": return .Techno
        case "Trance": return .Trance
        case "Variety Concerts": return .VarietyConert
        case "World": return .World
            
        // Workshops, Convefences & Classes
        case "Business & Professional": return .Professional
        case "Creative": return .Creative
        case "Dance Classes": return .DanceClass
        case "Education": return .Education
        case "Family & Lifestyle": return .FamilyAndLifestyle
        case "Mind & Body": return .MindAndBody
            
        // Sports & Outdoors
        case "Adventure, Extreme": return .Adventure
        case "Athletics": return .Atheltics
        case "Australian Rules": return .AustralianRules
        case "Aviation": return .Aviation
        case "Basketball": return .Basketball
        case "Boating": return .Boating
        case "Boxing": return .Boxing
        case "Cricket": return .Cricket
        case "Cycling": return .Cycling
        case "Dancesport": return .Dancesport
        case "Diving": return .Diving
        case "Equestrian": return .Equestrian
        case "Fishing Tournaments": return .FishingTournament
        case "Fun Runs & Walks": return .Walking
        case "Games, Carnivals": return .Carnival
        case "Golf": return .Golf
        case "Gridiron": return .Gridiron
        case "Hiking, Camping": return .HikingAndCamping
        case "Horse Racing": return .HorseRacing
        case "Lawn Bowls": return .LawnBowls
        case "Marathon": return .Marathon
        case "Martial Arts": return .MartialArts
        case "Motorsport": return .Motorsport
        case "Mountain Biking": return .MountainBiking
        case "Multisport": return .Multisport
        case "Netball": return .Netball
        case "Orienteering": return .Orienteering
        case "Rodeo Sports": return .RodeoSports
        case "Rowing": return .Rowing
        case "Rugby Union": return .RugbyUnion
        case "Sailing": return .Sailing
        case "Skating": return .Skating
        case "Soccer": return .Soccer
        case "Sports": return .Sports
        case "Surf & Water Sports": return .SurfingAndWaterSports
        case "Swimming": return .Swimming
        case "Tennis": return .Tennis
        case "Triathlon": return .Triathlon
        case "Wind & Kite Surfing": return .WindAndKiteSurfing
        case "Wrestling": return .Wrestling
        case "Yoga": return .Yoga
            
        // Exhibitions
        case "Contemporary": return .Contemporary
        case "Craft & Object Art": return .Craft
        case "Expos": return .Expos
        case "Fine Art": return .FineArt
        case "Museums": return .Museum
        case "Natural History": return .NaturalHistory
        case "Photography": return .Photography
        case "Sculpture": return .Sculpture
        case "Social & Political History": return .PoliticalHistory
            
        // Festivals & Lifestyle
        case "A&P Shows, Field Days": return .FieldDay
        case "Alumni, Associations, Clubs": return .Association
        case "Ceremonies, Commemorations": return .Commemorations
        case "Charity, Fundraisers": return .Charity
        case "Children, Kids, Holidays": return .Children
        case "Conservation, Environment": return .Environment
        case "Ethnic, Multicultural": return .Multicultural
        case "Family Entertainment": return .FamilyEntertainment
        case "Fashion": return .Fashion
        case "Festivals": return .Festival
        case "Food, Gourmet, Wine": return .FoodGourmetAndWine
        case "Food/Produce Market": return .FoodMarket
        case "Games, Hobbies": return .Hobby
        case "Lifestyle Shows, Expos": return .LifestyleShow
        case "Markets and Fairs": return .MarketsAndFairs
        case "Public Meetings, Politics": return .PublicMeeting
        case "Socials and Balls": return .Ball
        case "Spring Racing": return .SpringRacing
            
        // Performing Arts
        case "Ballet": return .Ballet
        case "Cabaret, Burlesque": return .Cabaret
        case "Choir, Vocal Music": return .Choir
        case "Classical Music": return .ClassicalMusic
        case "Comedy": return .Comedy
        case "Dance": return .Dance
        case "Film": return .Film
        case "Forums, Lectures": return .Lecture
        case "Literary": return .Literary
        case "Magic, Variety": return .Magic
        case "Musicals": return .Musical
        case "Opera": return .Opera
        case "Theatre": return .Theatre
            
        // In case an unknown event identifier is provided
        default: return .Generic
        }
    }
}