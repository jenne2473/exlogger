namespace com.company.exerciselogger;

using {managed} from '@sap/cds/common';

entity Exercises : managed {
    key ID       : String(20);
        @mandatory
        name     : localized String;
        scoredby : Association to ScoreTypes;
        logged   : Association to many LoggedExercises
                       on logged.exercise = $self;
}

entity ScoreTypes {
    key ID          : UUID @(Core.Computed : true);
        description : String;
        excercises  : Association to many Exercises
                          on excercises.scoredby = $self;
}

entity LoggedExercises : managed {
    key ID       : UUID                      @(Core.Computed : true);
        @mandatory
        exercise : Association to Exercises;
        weight   : Integer;
        reps     : Integer;
        time     : String default '00:00:00' @assert.format : '^(?:([01]?\d|2[0-3]):([0-5]?\d):)?([0-5]?\d)$';
        distance : Integer;
        @mandatory
        date     : Date;
        @readonly
        calc1rm  : Integer;
        @readonly
        lastperf : Boolean default false;
        scaled   : String;
        wod : String;
}
