function sheetLeft()
{
  changeSheet(-1);
}

function sheetRight()
{
  changeSheet(1);
}

function changeSheet(direction) {
  let ss = SpreadsheetApp.getActiveSpreadsheet();
  let sheet = SpreadsheetApp.getActiveSheet();
  let cell = sheet.getCurrentCell(); 
  let sheets = ss.getSheets();
  let newIndex = (((sheets.findIndex(x=>x.getName() === sheet.getName())) + sheets.length)+direction)%sheets.length;
  let newSheet = sheets[newIndex];
  ss.setActiveSheet(newSheet);
  newSheet.setCurrentCell( newSheet.getRange(cell.getRow(), cell.getColumn()));
}
