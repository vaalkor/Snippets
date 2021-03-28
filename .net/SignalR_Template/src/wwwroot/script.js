'use strict';

function addText(text)
{
    var liElement = document.createElement('li');
    liElement.innerHTML = `<strong>${text}</strong>`;
    document.getElementById('discussion').appendChild(liElement);
}

function clientMessage(message){
    addText(`Server: ${message}`);
}

var hubConnections = { clientMessage }; //Add more connections here...

document.addEventListener('DOMContentLoaded', function () {
    var connection = new signalR.HubConnectionBuilder().withUrl('/hub').build();

    Object.keys(hubConnections).forEach(x => connection.on(x, hubConnections[x]));

    document.getElementById('sendMessage').addEventListener('click', function (event) {
        let message = document.getElementById("message").value;
        if(message == null || message === '') return;
        connection.invoke('servermessage', message);
    });

    connection.start()
        .then(function () {
            console.log('connection started');
        })
        .catch(error => {
            console.error(error.message);
        });
});
