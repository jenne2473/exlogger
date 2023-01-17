using LoggerService from './logger-service';

annotate LoggerService.Exercises with {
    name     @title : 'Name';
    scoredby @title : 'Scored by';
};

annotate LoggerService.ScoreType with {
    ID          @(
        UI.Hidden,
        Common : {Text : description}
    );
    description @title : 'Scored by';
};

annotate LoggerService.LoggedExercises with {
    exercise    @title : 'Exercise';
    exercise_ID @title : 'Exercise';
    weight      @title : 'Weight (in kg)';
    reps        @title : 'Reps';
    time        @title : 'Time (in HH:MM:ss)';
    date        @title : 'Date';
    calc1rm     @title : 'Calc. 1 RM (in kg)';
    lastperf    @title : 'Last Perf.';
    createdBy   @title : 'Created by';
};

annotate LoggerService.Exercises with @(UI : {
    HeaderInfo       : {
        TypeName       : 'Exercise',
        TypeNamePlural : 'Exercises',
        Title          : {
            $Type : 'UI.DataField',
            Value : name
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : scoredby_ID
        }
    },
    SelectionFields  : [
        name,
        scoredby_ID
    ],
    LineItem         : [
        {Value : name},
        {Value : scoredby_ID}
    ],
    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Item',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {Data : [
        {Value : name},
        {Value : scoredby_ID}
    ]}
}, ) {

};

annotate LoggerService.Exercises with {
    scoredby @(Common : {
        //show text, not id for mitigation in the context of risks
        Text            : scoredby.description,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Score Types',
            CollectionPath : 'ScoreTypes',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : scoredby_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    });
};

annotate LoggerService.LoggedExercises with @(UI : {
    HeaderInfo       : {
        TypeName       : 'Logged Exercise',
        TypeNamePlural : 'Logged Exercises',
        Title          : {
            $Type : 'UI.DataField',
            Value : exercise.name
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : date
        }
    },
    SelectionFields  : [
        date,
        exercise_ID,
        lastperf
    ],
    LineItem         : [
        {Value : exercise_ID},
        {Value : date},
        {Value : weight},
        {Value : reps},
        {Value : time},
        {Value : calc1rm},
        {Value : lastperf},
        {Value : createdBy}
        
    ],
    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Item',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {Data : [
        {Value : exercise_ID},
        {Value : date},
        {Value : weight},
        {Value : reps},
        {Value : time},
        {Value : calc1rm},
        {Value : lastperf}
    ]}
}, ) {

};

annotate LoggerService.LoggedExercises with {
    exercise @(Common : {
        //show text, not id for mitigation in the context of risks
        Text            : exercise.name,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Exercise',
            CollectionPath : 'Exercises',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : exercise_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        }
    });
};
