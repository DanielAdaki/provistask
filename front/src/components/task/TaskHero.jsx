import React from "react";

import HeroBG1 from "../../images/task-hero-bg-1.jpg";
import HeroBG2 from "../../images/task-hero-bg-2.jpg";
import HeroBG3 from "../../images/task-hero-bg-3.jpg";

const TaskHero = ({ process }) => {
  return (
    <div className="task-hero">
      <div className="container">
        <img
          src={process === 1 ? HeroBG1 : process === 4 ? HeroBG3 : HeroBG2}
          alt="Background"
        />
        <div className="text">
          <h1>
            {process === 1
              ? "Tell us about the task you're working on"
              : process === 2
              ? "Choose the time that suits you best"
              : process === 3
              ? "To find your Provider, filter and sort"
              : "You're almost finished!"}
          </h1>
          <p>
            {process === 1
              ? "These details are used to display Providers in your area who meet your requirements."
              : process === 2
              ? "Tell us the exact time and date of your task"
              : process === 3
              ? "Choose the provider that best suits you"
              : "To contact you with your provider we'll need a few additional details."}
          </p>
        </div>
      </div>
    </div>
  );
};

export default TaskHero;
