using {com.company.exerciselogger as my} from '../db/schema';

@path     : 'service/logger'
@requires : 'authenticated-user'
service LoggerService {
    entity Exercises     as projection on my.Exercises;
    annotate Exercises with @odata.draft.enabled;
    entity ScoreTypes    as projection on my.ScoreTypes;
    annotate ScoreTypes with @odata.draft.enabled;

    entity LoggedExercises @(restrict : [{
        grant : [
            'READ',
            'WRITE',
            'generateWod',
            'refresh'
        ],
        where : 'createdBy = $user'
    }, ])                as projection on my.LoggedExercises actions {
        @(Common.SideEffects.TargetEntities: ['/LoggerService.EntityContainer/LoggedExercises'])
        action generateWod();
        action refresh();
    };

    annotate LoggedExercises with @odata.draft.enabled;

}
