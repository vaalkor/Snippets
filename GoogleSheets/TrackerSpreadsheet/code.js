let RED_COLOUR = '#f4cccc';
let GREEN_COLOUR = '#d9ead3';

function isSameDay(date1, date2) {
    return date1.getYear() === date2.getYear() &&
           date1.getMonth() === date2.getMonth() &&
           date1.getDate() === date2.getDate();
}

function daysBetweenDates(date1, date2) {
    var difference = date2.getTime() - date1.getTime();
    console.log(`Difference: ${difference}`);
    console.log(difference / (1000 * 60 * 60 * 24));
    return Math.floor(Math.abs(difference / (1000 * 60 * 60 * 24)));
}

function removeHoursMinutesSeconds(date){
    date.setHours(0);
    date.setMinutes(0);
    date.setSeconds(0);
}

function addOneDay(date) {
    var day = date.getDate();
    date.setDate(day + 1);

    return date;
}

function setRowColour(sheet, rowNumber, colour){
  var range = sheet.getRange(rowNumber, 2, 1, sheet.getLastColumn()-1);
  range.setBackground(colour);
}

function onOpen(e){
  let sheet = SpreadsheetApp.getActiveSheet();
  let mostRecentDayValue = sheet.getRange('A2').getValue();
  let currentDate = new Date();

  let numMissingDays = daysBetweenDates(currentDate, mostRecentDayValue); 
  for(var i=0; i<numMissingDays; i++){
    sheet.insertRowAfter(1);
    addOneDay(mostRecentDayValue);
    sheet.getRange('A2').setValue(mostRecentDayValue);
    setRowColour(sheet, 2, RED_COLOUR);
  }
}
  
