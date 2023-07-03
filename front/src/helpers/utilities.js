export const sortIntoPieces = (array, quantity = 3) => {
  let sortedArray = [];
  let tempArray = [];
  let n = 0;

  if (array.length > 3) {
    for (let i = 0; i < array.length; i++) {
      tempArray.push(array[i]);
      n++;

      if (n === quantity) {
        sortedArray.push(tempArray);
        tempArray = [];
        n = 0;
      }
    }

    if (tempArray.length > 0) {
      sortedArray.push(tempArray);
    }
  } else {
    for (let i = 0; i < array.length; i++) {
      tempArray.push(array[i]);
    }
    sortedArray.push(tempArray);
  }

  return sortedArray;
};

export const sortIntoGroupsByDate = (array = []) => {
  let sortedArray = [];
  let tempArray = [];

  let date = new Date();
  let nowYYYY = date.getFullYear();
  let nowMM = date.getMonth();
  let nowDD = date.getDate();

  let arrayTimestamp = null;

  for (let i = 0; i < array.length; i++) {
    let currentMsg = array[i];
    let msgDate = new Date(currentMsg.createdAt.seconds * 1000);

    let msgYYYY = msgDate.getFullYear();
    let msgMM = msgDate.getMonth();
    let msgDD = msgDate.getDate();

    let timestamp = "";

    if (msgYYYY === nowYYYY && msgMM === nowMM) {
      if (msgDD === nowDD) {
        //Today
        timestamp = "Today";
      } else if (msgDD === nowDD - 1) {
        //Yesterday
        timestamp = "Yesterday";
      } else {
        timestamp = `${msgYYYY}-${msgMM}-${msgDD}`;
      }
    } else {
      timestamp = `${msgYYYY}-${msgMM}-${msgDD}`;
    }

    // console.log(arrayTimestamp, timestamp);

    if (arrayTimestamp === null) {
      //First Message
      arrayTimestamp = timestamp;
      tempArray.push(currentMsg);
    } else if (arrayTimestamp === timestamp) {
      //Same day
      tempArray.push(currentMsg);
    } else {
      //Diferent Day
      sortedArray.push([arrayTimestamp, tempArray]);
      tempArray = [];
      tempArray.push(currentMsg);
      arrayTimestamp = timestamp;
    }

    if (i === array.length - 1) {
      sortedArray.push([arrayTimestamp, tempArray]);
    }
  }
  // console.log(sortedArray);

  return sortedArray;
};
