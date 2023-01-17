namespace com.company.exerciselogger;

using {managed} from '@sap/cds/common';

entity Exercises : managed {
    key ID       : UUID @(Core.Computed : true);
        @mandatory
        name     : localized String;
        @mandatory
        scoredby : Association to ScoreTypes;
        logged : Association to many LoggedExercises on logged.exercise = $self;
}

entity ScoreTypes {
    key ID          : UUID @(Core.Computed : true);
        description : String;
        excercises  : Association to many Exercises
                          on excercises.scoredby = $self;
}

entity LoggedExercises : managed {
    key ID      : UUID @(Core.Computed : true);
        @mandatory
        exercise : Association to Exercises;
        weight  : Integer;
        reps    : Integer;
        time    : String @assert.format: '^(?:([01]?\d|2[0-3]):([0-5]?\d):)?([0-5]?\d)$';
        @mandatory
        date    : Date;
        @readonly
        calc1rm : Integer;
        @readonly
        lastperf : Boolean;
}
