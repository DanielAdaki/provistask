import React, { useEffect, useRef, useState } from "react";

const TaskProcessTwo = ({
  setProcess,
  setStep,
  variableSetTwo,
  mainDate,
  setMainDate,
}) => {
  //Options
  const [timeOfDayOption, setTimeOfDayOption] = useState(0);
  const [dateForOption, setDateForOption] = useState(0);
  const [hourOption, setHourOption] = useState(0);

  const getActualDate = (date = new Date()) => {
    let dd = date.getUTCDate();
    let mm = date.getUTCMonth();
    let yyyy = date.getUTCFullYear();

    return new Date(yyyy, mm, dd);
  };

  //The date
  const [date, setDate] = useState(
    mainDate === null ? getActualDate() : mainDate
  );

  const simpleArray = [0, 1, 2, 3];
  const simpleArray2 = [0, 1, 2, 3, 4, 5];

  const inputDate = useRef(null);

  const handleInputCalendar = (e) => {
    let { valueAsDate } = e.target;

    if (valueAsDate !== null) setDate(getActualDate(valueAsDate));
    setDateForOption(3);
  };

  function sumDays(days) {
    let date = getActualDate();

    date.setDate(date.getDate() + days);
    date.setUTCHours(8);
    // console.log(date);
    return date;
  }

  const setDateForToday = () => {
    setDateForOption(0);
    setDate(sumDays(0));
  };
  const setDateWithin3Days = () => {
    setDateForOption(1);
    setDate(sumDays(3));
  };
  const setDateWithinAWeek = () => {
    setDateForOption(2);
    setDate(sumDays(7));
  };
  const chooseDate = () => {
    setDateForOption(3);
    inputDate.current.focus();
    setDate(getActualDate());
  };

  const changeTimeOfDayOption = (option) => {
    setTimeOfDayOption(option);
  };

  const [hour24, setHour24] = useState(
    mainDate === null ? 8 : mainDate.getUTCHours()
  );

  // console.log(date.getUTCHours());

  const pickHour = (hour) => {
    setHourOption(hour);
    setHour24(hour);
  };

  useEffect(() => {
    let newDate = new Date(date.setUTCHours(hour24));

    setDate(newDate);
    // eslint-disable-next-line
  }, [hour24]);

  const [invalidDate, setInvalidDate] = useState(false);

  useEffect(() => {
    setMainDate(date);

    let dd = date.getUTCDate();
    let mm = date.getUTCMonth();
    let yyyy = date.getUTCFullYear();
    let week = date.getUTCDay();
    let hh = date.getUTCHours();
    let sufix = "AM";

    let now = new Date();

    let nowyyyy = now.getUTCFullYear();
    let nowmm = now.getUTCMonth();
    let nowdd = now.getUTCDate();
    let nowhh = now.getUTCHours() - now.getTimezoneOffset() / 60;

    if (nowyyyy >= yyyy) {
      // console.log(nowyyyy >= yyyy, nowyyyy, yyyy);
      if (nowmm >= mm) {
        // console.log(nowmm >= mm, nowmm, mm);
        if (nowdd >= dd) {
          // console.log(nowdd >= dd, nowdd, dd);
          if (nowhh >= hh) {
            // console.log(nowhh >= hh, nowhh, hh);
            setInvalidDate(true);
          } else {
            setInvalidDate(false);
          }
        } else {
          setInvalidDate(false);
        }
      } else {
        setInvalidDate(false);
      }
    } else {
      setInvalidDate(false);
    }

    switch (mm) {
      case 0:
        mm = "Jan.";
        break;
      case 1:
        mm = "Feb.";
        break;
      case 2:
        mm = "March";
        break;
      case 3:
        mm = "April";
        break;
      case 4:
        mm = "May";
        break;
      case 5:
        mm = "June";
        break;
      case 6:
        mm = "July";
        break;
      case 7:
        mm = "Aug.";
        break;
      case 8:
        mm = "Sept.";
        break;
      case 9:
        mm = "Oct.";
        break;
      case 10:
        mm = "Nov.";
        break;
      case 11:
        mm = "Dec.";
        break;

      default:
        break;
    }

    switch (week) {
      case 0:
        week = "Sunday";
        break;
      case 1:
        week = "Monday";
        break;
      case 2:
        week = "Tuesday";
        break;
      case 3:
        week = "Wednesday";
        break;
      case 4:
        week = "Thursday ";
        break;
      case 5:
        week = "Friday";
        break;
      case 6:
        week = "Saturday";
        break;

      default:
        break;
    }

    if (hh > 12) {
      hh = hh - 12;
      sufix = "PM";
    }

    variableSetTwo.setDay(dd);
    variableSetTwo.setMonth(mm);
    variableSetTwo.setYear(yyyy);
    variableSetTwo.setDayOfWeek(week);
    variableSetTwo.setHour(hh);
    variableSetTwo.setSufix(sufix);

    // eslint-disable-next-line
  }, [date]);

  const [schedulerIsOpen, setSchedulerIsOpen] = useState(false);
  const [repeatDay, setRepeatDay] = useState(1);
  const [frequency, setFrequency] = useState(0);
  const [maxHoursOption, setMaxHoursOption] = useState(0);
  const [maxHours, setMaxHours] = useState(1);

  const toggleScheduler = () => {
    setSchedulerIsOpen(!schedulerIsOpen);
  };

  const changeRepeatDay = (day) => {
    setRepeatDay(day);
  };
  const changeFrequency = (freq) => {
    setFrequency(freq);
  };

  const changeMaxHoursOption = (option) => {
    setMaxHoursOption(option);

    if (option < 4) {
      setMaxHours(option + 1);
    }
  };

  const nextProcess = () => {
    window.scrollTo({ top: 0, behavior: "smooth" });

    setTimeout(() => {
      setProcess(3);
      setStep(1);
    }, 600);
  };

  return (
    <div className="task-process-two">
      <div className="mandatory-section">
        <h1>Choose your task date and start time:</h1>

        <div className="container">
          <div className="left">
            <div className="date">
              <h2>Date</h2>
              <div className="buttons uneven">
                <button
                  className={`border ${dateForOption === 0 ? "selected" : ""}`}
                  onClick={setDateForToday}
                >
                  Today
                </button>
                <button
                  className={`border ${dateForOption === 1 ? "selected" : ""}`}
                  onClick={setDateWithin3Days}
                >
                  Within 3 days
                </button>
                <button
                  className={`border ${dateForOption === 2 ? "selected" : ""}`}
                  onClick={setDateWithinAWeek}
                >
                  Within A Week
                </button>
                <button
                  className={`border ${dateForOption === 3 ? "selected" : ""}`}
                  onClick={chooseDate}
                >
                  Choose Date
                </button>
              </div>
            </div>
            <div className="calendar">
              <h2 className="gray">Or select a certain date</h2>

              <input
                type="date"
                name="date"
                required={"required"}
                id="input-date"
                min={getActualDate().toISOString().slice(0, 10)}
                ref={inputDate}
                valueasdate={date}
                onChange={handleInputCalendar}
              />
            </div>
          </div>
          <div className="right">
            <div className="time">
              <h2>Time of day</h2>
              <div className="options">
                <button
                  className={`option ${
                    timeOfDayOption === 0 ? "selected" : ""
                  }`}
                  onClick={() => {
                    changeTimeOfDayOption(0);
                  }}
                >
                  Morning (8am - 11pm)
                </button>
                <button
                  className={`option ${
                    timeOfDayOption === 1 ? "selected" : ""
                  }`}
                  onClick={() => {
                    changeTimeOfDayOption(1);
                  }}
                >
                  Afternoon (12pm - 5pm)
                </button>
                <button
                  className={`option ${
                    timeOfDayOption === 2 ? "selected" : ""
                  }`}
                  onClick={() => {
                    changeTimeOfDayOption(2);
                  }}
                >
                  Evening (6pm - 9pm)
                </button>
              </div>
            </div>

            <div className="select-time">
              <h2>Select time</h2>
              <div className="buttons grid">
                {timeOfDayOption === 0
                  ? simpleArray.map((el, index) => {
                      return (
                        <button
                          className={`gray ${
                            hourOption === 8 + index ? "selected" : ""
                          }`}
                          onClick={() => {
                            pickHour(8 + index);
                          }}
                          key={8 + index}
                        >{`${8 + index}:00 AM`}</button>
                      );
                    })
                  : timeOfDayOption === 1
                  ? simpleArray2.map((el, index) => {
                      return (
                        <button
                          className={`gray ${
                            hourOption === 12 + index ? "selected" : ""
                          }`}
                          onClick={() => {
                            pickHour(12 + index);
                          }}
                          key={12 + index}
                        >{`${12 + index === 12 ? 12 : index}:00 PM`}</button>
                      );
                    })
                  : simpleArray.map((el, index) => {
                      return (
                        <button
                          className={`gray ${
                            hourOption === 18 + index ? "selected" : ""
                          }`}
                          onClick={() => {
                            pickHour(18 + index);
                          }}
                          key={18 + index}
                        >{`${6 + index}:00 PM`}</button>
                      );
                    })}
              </div>
              <span className="reminder">
                You can chat with your `Provider, adjust task details or change
                task time after booking
              </span>
            </div>

            <div className="request">
              <h2 className="italic">Request for:</h2>

              <strong>{`${variableSetTwo.month} ${variableSetTwo.day}, ${variableSetTwo.hour}:00${variableSetTwo.sufix}`}</strong>

              {invalidDate && <p className="invalid-date">Invalid date</p>}
            </div>
          </div>
        </div>
      </div>
      <div className="programmatic-section">
        <button className="open-btn" onClick={toggleScheduler}>
          <span className="icon">{schedulerIsOpen ? "-" : "+"}</span>
          <span>Task Time</span>
        </button>

        <div className={`container ${schedulerIsOpen ? "open" : ""}`}>
          <p className="sub">
            If your task requires more than one day of work, we need you to
            modify the following settings to ensure you have a successful task
          </p>
          <h3>Select the day of the week</h3>
          <p>
            The day you select will be fixed with the provider so that you go
            every week to carry out the task. You can choose a maximum of one
            day a week.
          </p>
          <div className="selection">
            <button
              className={`gray ${repeatDay === 1 ? "selected" : ""}`}
              onClick={() => {
                changeRepeatDay(1);
              }}
            >
              Monday
            </button>
            <button
              className={`gray ${repeatDay === 2 ? "selected" : ""}`}
              onClick={() => {
                changeRepeatDay(2);
              }}
            >
              Tuesday
            </button>
            <button
              className={`gray ${repeatDay === 3 ? "selected" : ""}`}
              onClick={() => {
                changeRepeatDay(3);
              }}
            >
              Wednesday
            </button>
            <button
              className={`gray ${repeatDay === 4 ? "selected" : ""}`}
              onClick={() => {
                changeRepeatDay(4);
              }}
            >
              Thursday
            </button>
            <button
              className={`gray ${repeatDay === 5 ? "selected" : ""}`}
              onClick={() => {
                changeRepeatDay(5);
              }}
            >
              Friday
            </button>
            <button
              className={`gray ${repeatDay === 6 ? "selected" : ""}`}
              onClick={() => {
                changeRepeatDay(6);
              }}
            >
              Saturday
            </button>
            <button
              className={`gray ${repeatDay === 0 ? "selected" : ""}`}
              onClick={() => {
                changeRepeatDay(0);
              }}
            >
              Sunday
            </button>
          </div>
          <h3>Select the frequency</h3>
          <div className="selection">
            <button
              className={`gray ${frequency === 0 ? "selected" : ""}`}
              onClick={() => {
                changeFrequency(0);
              }}
            >
              Weekly
            </button>
            <button
              className={`gray ${frequency === 1 ? "selected" : ""}`}
              onClick={() => {
                changeFrequency(1);
              }}
            >
              Every two weeks
            </button>
            <button
              className={`gray ${frequency === 2 ? "selected" : ""}`}
              onClick={() => {
                changeFrequency(2);
              }}
            >
              Every three weeks
            </button>
            <button
              className={`gray ${frequency === 3 ? "selected" : ""}`}
              onClick={() => {
                changeFrequency(3);
              }}
            >
              Each month
            </button>
          </div>
          <h3>Select the maximum time to perform the task per day</h3>
          <div className="selection">
            <button
              className={`gray ${maxHoursOption === 0 ? "selected" : ""}`}
              onClick={() => {
                changeMaxHoursOption(0);
              }}
            >
              1 hours
            </button>
            <button
              className={`gray ${maxHoursOption === 1 ? "selected" : ""}`}
              onClick={() => {
                changeMaxHoursOption(1);
              }}
            >
              2 hours
            </button>
            <button
              className={`gray ${maxHoursOption === 2 ? "selected" : ""}`}
              onClick={() => {
                changeMaxHoursOption(2);
              }}
            >
              3 hours
            </button>
            <button
              className={`gray ${maxHoursOption === 3 ? "selected" : ""}`}
              onClick={() => {
                changeMaxHoursOption(3);
              }}
            >
              4 hours
            </button>
            <button
              className={`gray ${maxHoursOption === 4 ? "selected" : ""}`}
              onClick={() => {
                changeMaxHoursOption(4);
              }}
            >
              Edit your ideal time
            </button>
          </div>

          <div
            className={`input-container ${
              maxHoursOption === 4 ? "visible" : ""
            }`}
          >
            <input
              type="number"
              min={1}
              max={24}
              value={maxHours}
              onChange={(e) => {
                setMaxHours(e.target.value);
              }}
            />
            <span>Hours</span>
          </div>
        </div>
      </div>

      <button
        className="next-process"
        onClick={nextProcess}
        disabled={invalidDate ? true : false}
      >
        Let's find your providers
      </button>
    </div>
  );
};

export default TaskProcessTwo;
