sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/loggedexercises/test/integration/FirstJourney',
		'ns/loggedexercises/test/integration/pages/LoggedExercisesList',
		'ns/loggedexercises/test/integration/pages/LoggedExercisesObjectPage'
    ],
    function(JourneyRunner, opaJourney, LoggedExercisesList, LoggedExercisesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/loggedexercises') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheLoggedExercisesList: LoggedExercisesList,
					onTheLoggedExercisesObjectPage: LoggedExercisesObjectPage
                }
            },
            opaJourney.run
        );
    }
);