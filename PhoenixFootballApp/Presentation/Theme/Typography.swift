//
//  Typography.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/16/25.
//
import SwiftUI

import SwiftUI

import Combine
import SUIRouter
import SwiftUI
import XSwiftUI
import APIFootball
import PhoenixUI

extension Text{
     func body2Medium() -> Text{
         return  self.font(.manrope(.medium, size: 12))
    }
    
    func body2Regular() -> Text{
        return  self.font(.manrope(.regular, size: 12))
   }
    
    func body1Medium() -> Text{
        return  self.font(.manrope(.medium, size: 14))
   }
    
    func body1Semebold() -> Text{
        return  self.font(.manrope(.semiBold, size: 14))
   }
   
    func body1Bold() -> Text{
        return  self.font(.manrope(.bold, size: 14))
   }
   
    
    func captionReguler() -> Text{
        return  self.font(.manrope(.regular, size: 10))
   }
    func captionMedium() -> Text{
        return  self.font(.manrope(.medium, size: 10))
   }
    
    func h3Medium() -> Text{
        return  self.font(.manrope(.medium, size: 24))
   }
    
    func h4Semibold() -> Text{
        return  self.font(.manrope(.semiBold, size: 20))
   }
    
    func h5Semibold() -> Text{
        return  self.font(.manrope(.semiBold, size: 18))
   }
    
    func h6Semibold() -> Text{
        return  self.font(.manrope(.semiBold, size: 16))
   }
}
