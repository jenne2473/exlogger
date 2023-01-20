using {com.company.exerciselogger as my} from '../db/schema';

@path     : 'service/lastperf'

service LastPerfService {

    entity LastPerfExec as 
        select from my.LoggedExercises {
            key ID,
                createdBy,
                max(date) as lastDate: Date
        }
        where createdBy = $user
        group by
            exercise;

}