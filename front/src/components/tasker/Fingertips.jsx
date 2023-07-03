import React from "react";

import Drill from "../../images/drill.png";
import Boss from "../../images/fingertips-boss.png";
import Hands from "../../images/fingertips-hands.png";
import Money from "../../images/fingertips-money.png";
import Dots from "../../images/dots.png";

const Fingertips = () => {
  return (
    <div className="fingertips">
      <div className="left">
        <h2>Flexible work, at your fingertips</h2>
        <p>
          Find local jobs that fit your skills and schedule. With ProviTask, you
          have the freedom and support to be your own boss.
        </p>
        <img src={Drill} alt="Drill" />
      </div>
      <div className="right">
        <div className="card">
          <img src={Boss} alt="Boss" />
          <strong>Set your own rates</strong>
          <p>
            You keep 100% of what you charge, plus tips! Invoice and get paid
            directly through our secure payment system.
          </p>
        </div>
        <div className="card">
          <img src={Hands} alt="Hands" />
          <strong>Grow your business</strong>
          <p>
            We connect you with clients in your area, and ways to market
            yourself — so you can focus on what you do best.
          </p>
        </div>
        <div className="card">
          <img src={Money} alt="Money" />
          <strong>Be your own boss</strong>
          <p>
            Work how, when, and where you want. Offer services in 50+ categories
            and set a flexible schedule and work area.
          </p>
        </div>
      </div>
      <img src={Dots} className="dots" alt="Decoration" />
    </div>
  );
};

export default Fingertips;
