import { Vnode } from "mithril"
import { Data } from "./data"
import { CharacterInfo } from "./types"

const TableRow = {
    view: function ({ attrs }: Vnode<CharacterInfo>) {

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
    view: function ({ attrs }: Vnode<{data: CharacterInfo[]}>) {
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
            m(Table, { data: Data })
        ])
    }
}

function initialise() {
    m.render(document.querySelector('#dynamic-content'), m(App))
}

window.addEventListener('load', initialise);
