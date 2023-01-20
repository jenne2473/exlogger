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
    exercise    @title : '{i18n>exercise}';
    exercise_ID @title : '{i18n>exercise}';
    weight      @title : '{i18n>weightinkg}';
    reps        @title : '{i18n>reps}';
    time        @title : '{i18n>time}';
    distance    @title : '{i18n>distance}';
    date        @title : '{i18n>date}';
    calc1rm     @title : '{i18n>calc1rm}';
    lastperf    @title : '{i18n>lastperf}';
    createdBy   @title : '{i18n>createdby}';
    scaled      @title : '{i18n>scaled}';
    wod         @title : '{i18n>wod}';
};

annotate LoggerService.Exercises with @(UI : {
    HeaderInfo       : {
        TypeName       : '{i18n>exercise}',
        TypeNamePlural : '{i18n>exercises}',
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
        Label  : '{i18n>item}',
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
            Label          : '{i18n>scoretypes}',
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
        TypeName       : '{i18n>loggedexercise}',
        TypeNamePlural : '{i18n>loggedexercises}',
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
        {
            $Type              : 'UI.DataFieldForAction',
            Action             : 'LoggerService.generateWod',
            Label              : '{i18n>generatewod}',
            InvocationGrouping : #ChangeSet
        },
        {
            $Type              : 'UI.DataFieldForAction',
            Action             : 'LoggerService.refresh',
            Label              : 'Refresh',
            InvocationGrouping : #ChangeSet
        },
        {Value : exercise_ID},
        {Value : date},
        {Value : weight},
        {Value : reps},
        {Value : distance},
        {Value : time},
        {Value : calc1rm},
        {Value : createdBy},
        {Value : lastperf},
        {Value : scaled},
        {Value : wod}

    ],
    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>item}',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {Data : [
        {Value : exercise_ID},
        {Value : date},
        {Value : weight},
        {Value : reps},
        {Value : distance},
        {Value : time},
        {Value : calc1rm},
        {Value : lastperf},
        {Value : scaled},
        {Value : wod}
    ]}
}, ) {

};

annotate LoggerService.LoggedExercises with {
    exercise @(Common : {
        //show text, not id for mitigation in the context of risks
        Text            : exercise.name,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>exercise}',
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
