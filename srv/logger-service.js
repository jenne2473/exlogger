const cds = require('@sap/cds')
module.exports = function () {

    function calcOneRm(weight, reps) {
        return weight / (1.0278 - (0.0278 * reps));
    }

    this.after('READ', 'LoggedExercises', each => {
        if (!each.time) {
            each.time = '00:00:00';
        }
    })

    this.before(['CREATE', 'UPDATE'], 'LoggedExercises', each => {
        if (each.data.reps && each.data.weight) {
            each.data.calc1rm = Math.round(calcOneRm(each.data.weight, each.data.reps));
        } else {
            each.data.calc1rm = '';
        }
    })

}    