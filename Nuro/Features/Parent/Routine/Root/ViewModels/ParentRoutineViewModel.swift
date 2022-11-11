//
//  ParentRoutineViewModel.swift
//  Nuro
//
//  Created by Samuel Dennis on 05/10/22.
//

import Foundation

class ParentRoutineViewModel {
    
    var routineHeaderRepo = RoutineHeaderLocalRepository.shared
    var routineDetailRepo = RoutineDetailLocalRepository.shared
    
    var morningActivities = [RoutineDetail]()
    var afternoonActivities = [RoutineDetail]()
    var eveningActivities = [RoutineDetail]()
    
    var routineHeaders = [RoutineHeader]()
    
    func loadAll(dayId: Int) {
        routineHeaders = routineHeaderRepo.getAll()
        
        loadActivities(dayId: dayId)
        
        // 1. load all activities
        // 2. Process to divide the data 3 section
    }
    
    func loadActivities(dayId: Int) {
        let startIndex = (dayId-1) * 3
        
        morningActivities = routineDetailRepo.getRoutineDetails(of: routineHeaders[startIndex])
        afternoonActivities = routineDetailRepo.getRoutineDetails(of: routineHeaders[startIndex+1])
        eveningActivities = routineDetailRepo.getRoutineDetails(of: routineHeaders[startIndex+2])
        
        //       let   allActivity = morningActivities + afternoonActivities + eveningActivities
        
        
        //        allActivity.sorted { $0.routineHeader.time > $1.routineHeader.timeID }
    }
    
    func getRoutineDetail(section:Int, row: Int) -> RoutineDetail {
        switch section {
        case 0: //Morning
            return morningActivities[row]
        case 1: //Afternoon
            return afternoonActivities[row]
        case 2: //Evening
            return eveningActivities[row]
        default:
            return RoutineDetail()
        }
    }
    
    func getActivityNameFromCell(section:Int, row: Int) -> String {
        switch section {
        case 0: //Morning
            return morningActivities[row].activity?.activityName ?? ""
        case 1: //Afternoon
            return afternoonActivities[row].activity?.activityName ?? ""
        case 2: //Evening
            return eveningActivities[row].activity?.activityName ?? ""
        default:
            return ""
        }
    }
    
    func moveRoutineDetail(source: IndexPath, dest: IndexPath){
        var sourceRoutine: RoutineDetail?
        switch source.section{
        case 0:
            sourceRoutine = morningActivities[source.row]
            morningActivities.remove(at: source.row)
        case 1:
            sourceRoutine = afternoonActivities[source.row]
            afternoonActivities.remove(at: source.row)
        case 2:
            sourceRoutine = eveningActivities[source.row]
            eveningActivities.remove(at: source.row)
        default:
            print("a")
        }
        
        switch dest.section{
        case 0:
            morningActivities.insert(sourceRoutine ?? RoutineDetail(), at: dest.row)
            routineDetailRepo
//
//            for (index, routine) in viewModel.morningActivities.enumerated() {
//                routineDetailLocalRepo.updatePosition(routineDetail: routine, newPosition: index+1)
//            }
        case 1:
            afternoonActivities.insert(sourceRoutine ?? RoutineDetail(), at: dest.row)
        case 2:
            eveningActivities.insert(sourceRoutine ?? RoutineDetail(), at: dest.row)
            
        default:
            print("a")
        }
    }
    
}
