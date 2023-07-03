import React, { useState } from "react";

import { Link } from "react-router-dom";

import Woman from "../../images/tasker-woman.png";
import Dude from "../../images/tasker-dude.png";
import ArrowDown from "../../images/chevron-down-purple.png";

const data = {
  services: ["Delivery", "Cleaning", "Maintenance"],
  areas: ["Atlanta", "Albuquerque", "Fresno", "Sacramento"],
};

const DropdownElement = ({ setValue, close, value }) => {
  const handleClick = () => {
    setValue(value);
    close();
  };
  return (
    <div className="option" onClick={handleClick}>
      {value}
    </div>
  );
};

const BasicDropdown = ({ data }) => {
  const [selected, setSelected] = useState(false);
  const [value, setValue] = useState(data[0]);

  const handleClick = () => {
    setSelected(!selected);
  };

  const handleBlur = () => {
    setTimeout(() => {
      setSelected(false);
    }, 100);
  };

  return (
    <div className="basic-dropdown">
      <button
        onClick={handleClick}
        onBlur={handleBlur}
        className={selected ? "active" : ""}
      >
        {value}
        <img src={ArrowDown} alt="" />
      </button>

      <div className={`options ${selected ? "unfolded" : ""}`}>
        {data.map((el, index) => {
          return (
            <DropdownElement
              setValue={setValue}
              close={handleClick}
              value={el}
              key={el + index}
            />
          );
        })}
      </div>
    </div>
  );
};

const TaskerHero = ({ step, setStep }) => {
  const handleClick = (e) => {
    e.preventDefault();

    if (step === 1) {
      setStep(2);
    }
  };

  return (
    <section className="tasker-hero">
      <div className="relative-container">
        <div className="background">
          <img src={Woman} className="woman" alt="Woman" />
          <img src={Dude} alt="Dude" />
        </div>

        <h1>Earn money your way</h1>
        <p className="increase">
          Increase your customer base and earn more money
        </p>

        <div className="card">
          <p>What services can you provide?</p>
          <BasicDropdown data={data.services} />
          <p>What is your area of work?</p>
          <BasicDropdown data={data.areas} />

          <button
            className="next-step"
            onClick={(e) => {
              handleClick(e);
            }}
          >
            Get Started
          </button>
          <p className="already">
            Already have an account? <Link to="/login"> Sign in</Link>
          </p>
        </div>
      </div>
    </section>
  );
};

export default TaskerHero;
