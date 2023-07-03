import React from "react";

import CircularCheck from "../../images/check-circle.png";

const TaskProcess = ({ process, step1, step2, step3 }) => {
  const maxStepsProcess1 = 5;
  const maxStepsProcess2 = 1;
  const maxStepsProcess3 = 1;

  return (
    <div className="task-process">
      <div className="container">
        <div className="process">
          <img
            src={CircularCheck}
            className={process > 0 ? "visible" : ""}
            alt="Complete"
          />
          <p>
            <span>Tell us what</span>
            <span>you need </span>
          </p>
        </div>
        <div className="line-container">
          <div
            className={`line`}
            style={{
              width: (100 / maxStepsProcess1) * step1 + "%",
            }}
          ></div>
        </div>
        <div className="process">
          <img
            src={CircularCheck}
            className={process > 1 ? "visible" : ""}
            alt="Complete"
          />
          <p>
            <span>Browse your date</span>
            <span>and time</span>
          </p>
        </div>
        <div className="line-container">
          <div
            className={`line`}
            style={{
              width: process > 1 ? (100 / maxStepsProcess2) * step2 + "%" : 0,
            }}
          ></div>
        </div>
        <div className="process">
          <img
            src={CircularCheck}
            className={process > 2 ? "visible" : ""}
            alt="Complete"
          />
          <p>
            <span>Choose your</span>
            <span>best provider</span>
          </p>
        </div>
        <div className="line-container">
          <div
            className={`line`}
            style={{
              width: process > 2 ? (100 / maxStepsProcess3) * step3 + "%" : 0,
            }}
          ></div>
        </div>
        <div className="process">
          <img
            src={CircularCheck}
            className={process > 3 ? "visible" : ""}
            alt="Complete"
          />
          <p>
            <span>Confirm your</span>
            <span>task</span>
          </p>
        </div>
      </div>
    </div>
  );
};

export default TaskProcess;
