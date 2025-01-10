var rows = [...document.querySelectorAll(".Results-table-row")]
    .filter(x => x.querySelector(".Results-table-td--time .compact"))
    .map(x => {
        return {
            "name": x.querySelector(".Results-table-td--name .compact").innerText,
            "time": x.querySelector(".Results-table-td--time .compact").innerText,
            }
        }
    );

// Get lastWeek...

var bothWeeks = rows.filter(x => lastWeek.find(y => y.name === x.name));
var finalResults = bothWeeks.map(x => { return {...x, "lastTime": lastWeekResults.find(l => l.name === x.name).time}});