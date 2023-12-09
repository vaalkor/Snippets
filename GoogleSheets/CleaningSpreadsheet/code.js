var _masterTaskColumn = 'G';
var _masterTaskColumnIndex = 8;
var _masterHowOftenColumn = 'H';
var _masterLastCompletedColumn = 'I';
var _masterDaysSinceLast = ''

function sortTasks()
{
  let activeSheet = SpreadsheetApp.getActiveSheet();
  let range = activeSheet.getRange(`G4:K100`);
  let values = range.getValues();
  filteredValues = values.filter(x => x[0]);

  function sort_stuff(a,b){
    let aShitRating = a[4]/a[2];
    let bShitRating = b[4]/b[2];
    return bShitRating - aShitRating;
  }

  filteredValues.sort(sort_stuff);
  trimmedValues = filteredValues.map(x => [x[0], x[1], x[2], x[3]]);
  activeSheet.getRange(`A4:D${3+filteredValues.length}`).setValues(trimmedValues);
}

function completeSortedTask(){
  let activeSheet = SpreadsheetApp.getActiveSheet();
  let cell = activeSheet.getCurrentCell();
  let row = cell.getRow();
  let col = cell.getColumn();
  let val = cell.getValue();
  if(col !== 2) throw new Error('Select a TASK NAME in the sorted task list!');
  if(row < 4) throw new Error('Select a TASK NAME in the sorted task list!');
  if(!val) throw new Error('Select a TASK NAME in the sorted task list!');

  let categoryName = activeSheet.getRange(`A${row}`).getValue();

  let masterTaskValues = activeSheet.getRange(`G4:J100`).getValues().filter(x => x[0]);
  let masterTaskIndex = masterTaskValues.findIndex(x => x[0] === categoryName && x[1] === val);
  if(masterTaskIndex === -1) throw new Error(`Could not find master task with category ${categoryName} and task name ${val} in master task list!`);
  console.log(masterTaskIndex);
  
  activeSheet.getRange(`J${4+masterTaskIndex}`).setValue(new Date());

  sortTasks();
}

function completeMasterTask(){
  let activeSheet = SpreadsheetApp.getActiveSheet();
  let cell = activeSheet.getCurrentCell();
  let row = cell.getRow();
  let col = cell.getColumn();
  let val = cell.getValue();
  if(col !== _masterTaskColumnIndex) throw new Error('Select a TASK NAME in the master task list!');
  if(row < 4) throw new Error('Select a TASK NAME in the master task list!');
  if(!val) throw new Error('Select a TASK NAME in the master task list!');

  activeSheet.getRange(`J${row}`).setValue(new Date());

  sortTasks();
}

function completeSelected(){
  let ss = SpreadsheetApp.getActiveSpreadsheet();
  let sheet = SpreadsheetApp.getActiveSheet();
  let cell = sheet.getCurrentCell();
  let row = cell.getRow();
  let col = cell.getColumn();
  let val = cell.getValue();
  if(col !== 1) return;
  if(row < 4) return;
  if(!val) return;
  
  SpreadsheetApp
    .getActiveSheet()
    .getRange(`D${row}`)
    .setValue(new Date());
}

function onOpen(e){
  sortTasks();
}
