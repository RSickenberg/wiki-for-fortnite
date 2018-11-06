//
//  WeaponsLevels.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 07.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import ChameleonFramework

class FormatLevels {

    let shadows = ShadowLayers()
    let color0 = [HexColor("969696")!, HexColor("4A4A4A")!]
    let color1 = [HexColor("69E41A")!, HexColor("037E00")!]
    let color2 = [HexColor("00BFFF")!, HexColor("005999")!]
    let color3 = [HexColor("D257FF")!, HexColor("530080")!]
    let color4 = [HexColor("FFD528")!, HexColor("805600")!]

    func formatUIBackgroundViewFromLevel(view: UIView, level: Int) {

        switch level {
        case 0:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color0)
            break
        case 1:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color1)
            break
        case 2:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color2)
            break
        case 3:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color3)
            break
        case 4:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color4)
            break
        default:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color1)
            break
        }

        view.layer.borderWidth = 8.5
        view.layer.borderColor = UIColor.flatWhite.cgColor
        shadows.setShadow(view: view)

        view.layer.cornerRadius = 6.5
    }

    func formatCellGradients(cell: UICollectionViewCell, levels: [Int]) {
        switch levels {
        case [0, 1]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("969696")!, HexColor("4FCA00")!])
            break
        case [0, 1, 2]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("969696")!, HexColor("969696")!, HexColor("4FCA00")!, HexColor("00BFFF")!, HexColor("00BFFF")!])
            break
        case [1, 2]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("4FCA00")!, HexColor("00BFFF")!])
            break
        case [1, 2, 3]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("4FCA00")!, HexColor("00BFFF")!, HexColor("B83DF2")!])
            break
        case [2, 3]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("00BFFF")!, HexColor("B83DF2")!])
            break
        case [2, 3, 4] :
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("00BFFF")!, HexColor("B83DF2")!, HexColor("E6BB0E")!])
            break
        case [3]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("530080")!, HexColor("D257FF")!])
            break
        case [3, 4]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("B83DF2")!, HexColor("E6BB0E")!])
            break
        default:
            cell.backgroundColor = UIColor.black
            break
        }

        shadows.setShadow(cell: cell)
    }

    func formatCellGradient(cell: UICollectionViewCell, level: Int) {
        switch level {
        case 0:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("4A4A4A")!, HexColor("969696")!])
            break
        case 1:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("037E00")!, HexColor("69E41A")!])
            break
        case 2:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("004080")!, HexColor("00BFFF")!])
            break
        case 3:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("530080")!, HexColor("D257FF")!])
            break
        case 4:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("805600")!, HexColor("FFD528")!])
            break
        default:
            cell.backgroundColor = UIColor.black
            break
        }

        shadows.setShadow(cell: cell)
    }
    
    func formatCellGradients(cell: UITableViewCell, levels: [Int]) {
        switch levels {
        case [0, 1]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("969696")!,  HexColor("969696")!, HexColor("4FCA00")!])
            break
        case [0, 1, 2]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("969696")!, HexColor("969696")!, HexColor("969696")!, HexColor("4FCA00")!, HexColor("00BFFF")!])
            break
        case [1, 2]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("4FCA00")!, HexColor("00BFFF")!])
            break
        case [1, 2, 3]:
             cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("4FCA00")!, HexColor("4FCA00")!, HexColor("00BFFF")!, HexColor("B83DF2")!])
             break
        case [2, 3]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("00BFFF")!, HexColor("B83DF2")!])
            break
        case [2, 3, 4] :
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("00BFFF")!, HexColor("00BFFF")!, HexColor("B83DF2")!, HexColor("E6BB0E")!])
            break
        case [3, 4]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("B83DF2")!, HexColor("B83DF2")!, HexColor("E6BB0E")!])
            break
        default:
            cell.backgroundColor = UIColor.black
            break
        }
    }
    
    func formatCellGradient(cell: UITableViewCell, level: Int) {
        switch level {
        case 0:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("4A4A4A")!, HexColor("969696")!])
            break
        case 1:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("037E00")!, HexColor("69E41A")!])
            break
        case 2:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("004080")!, HexColor("00BFFF")!])
            break
        case 3:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("530080")!, HexColor("D257FF")!])
            break
        case 4:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("805600")!, HexColor("FFD528")!])
            break
        default:
            cell.backgroundColor = UIColor.black
            break
        }
    }
}
