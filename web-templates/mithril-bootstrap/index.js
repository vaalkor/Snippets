const _data = [
    {
        "name": "Ziggy Zap",
        "height": "5ft 8in",
        "age": 28,
        "occupation": "Interstellar DJ",
        "numberOfArms": 4,
        "salary": "$120,000"
    },
    {
        "name": "Luna Lightfoot",
        "height": "6ft 2in",
        "age": 32,
        "occupation": "Moon Miner",
        "numberOfArms": 2,
        "salary": "$95,000"
    },
    {
        "name": "Marvin the Magnificent",
        "height": "4ft 9in",
        "age": 45,
        "occupation": "Magician",
        "numberOfArms": 3,
        "salary": "$150,000"
    },
    {
        "name": "Tina Twinkle",
        "height": "5ft 5in",
        "age": 26,
        "occupation": "Astral Navigator",
        "numberOfArms": 6,
        "salary": "$110,000"
    },
    {
        "name": "Gus Gearloose",
        "height": "5ft 11in",
        "age": 39,
        "occupation": "Robot Repairman",
        "numberOfArms": 1,
        "salary": "$75,000"
    },
    {
        "name": "Polly Pixel",
        "height": "5ft 4in",
        "age": 22,
        "occupation": "Digital Artist",
        "numberOfArms": 2,
        "salary": "$65,000"
    },
    {
        "name": "Felix Flash",
        "height": "6ft 1in",
        "age": 34,
        "occupation": "Speed Runner",
        "numberOfArms": 2,
        "salary": "$82,000"
    },
    {
        "name": "Wendy Warp",
        "height": "5ft 6in",
        "age": 29,
        "occupation": "Time Traveller",
        "numberOfArms": 4,
        "salary": "$200,000"
    },
    {
        "name": "Sammy Starlight",
        "height": "5ft 9in",
        "age": 31,
        "occupation": "Galactic Guide",
        "numberOfArms": 2,
        "salary": "$90,000"
    },
    {
        "name": "Oliver Omega",
        "height": "5ft 7in",
        "age": 37,
        "occupation": "Cosmic Chef",
        "numberOfArms": 8,
        "salary": "$130,000"
    }
]

const TableRow = {
    view: function ({ attrs }) {

        return m('tr',
            m('th', attrs.name),
            m('td', attrs.height),
            m('td', attrs.age),
            m('td', attrs.occupation),
            m('td', attrs.numberOfArms),
            m('td', attrs.salary)
        )
    }
}

const Table = {
    view: function ({ attrs }) {
        return m('table.table.table-striped',
            m('thead',
                m('tr',
                    m('th', { scope: "col" }, 'Name'),
                    m('th', { scope: "col" }, 'Height'),
                    m('th', { scope: "col" }, 'Age'),
                    m('th', { scope: "col" }, 'Occupation'),
                    m('th', { scope: "col" }, 'Number of Arms'),
                    m('th', { scope: "col" }, 'Salary')
                )
            ),
            m('tbody', attrs.data.map(x => m(TableRow, { ...x })))
        )
    }
}

const App = {
    view: function () {
        return m('div.container', [
            m('h1', {style: {"text-align": "center"}}, 'This is a template!'),
            m('hr'),
            m('h3', {style: {"text-align": "center"}}, 'Here\'s a table of ChatGPT generated garbage:'),
            m('hr'),
            m(Table, { data: _data })
        ])
    }
}

function initialise() {
    m.render(document.querySelector('#dynamic-content'), m(App))
}

window.addEventListener('load', initialise);
