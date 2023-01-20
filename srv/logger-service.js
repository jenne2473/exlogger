const cds = require('@sap/cds')
module.exports = function (srv) {

    function calcOneRm(weight, reps) {
        return weight / (1.0278 - (0.0278 * reps));
    }

    this.after('READ', 'LoggedExercises', req => {
        //console.log(req);
    })

    this.before(['CREATE', 'UPDATE'], 'LoggedExercises', req => {
        if (req.data.reps && req.data.weight) {
            req.data.calc1rm = Math.round(calcOneRm(req.data.weight, req.data.reps));
        } else {
            req.data.calc1rm = '';
        }
    })

    this.before(['CREATE', 'UPDATE'], 'LoggedExercises', async (req) => {
        const { LoggedExercises } = srv.entities;
        const loggedExercises = await srv.read(LoggedExercises).where({
            lastperf: true,
            exercise_ID: req.data.exercise_ID
        });
        var newLastperf = true;
        loggedExercises.forEach(async (eachExercise) => {
            if (eachExercise.date >= req.data.date) {
                newLastperf = false;
            }
        });
        if (newLastperf) {
            req.data.lastperf = true;
            const tx = cds.transaction(req)
            return tx.run([
                UPDATE(LoggedExercises).set({ lastperf: false }).where({ exercise_ID: req.data.exercise_ID }),
            ]).catch(() => req.reject(400, 'Error'))
        } else {
            req.data.lastperf = false;
        }
    })

    
    const { LoggedExercises } = this.entities('LoggedExercises');
    this.on('generateWod', async req => {
        const { LoggedExercises } = srv.entities;
         const loggedExercises = await srv.read(LoggedExercises).where({
             ID: req.params[0].ID
         });
        const tx = cds.transaction(req)
        const wodname = '... this is a WOD'; 
        return tx.run([
            UPDATE(LoggedExercises).set({ wod: wodname}).where({ ID: req.params[0].ID }),
        ]).catch(() => req.reject(400, 'Error'))
    })

    this.on('refresh', req => {
        console.log("----> Refresh triggered");
    });

}    