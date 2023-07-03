import React from "react";

import Item1 from "../../images/item-1.png";
import Item2 from "../../images/item-2.png";
import Item3 from "../../images/item-3.png";
import Item4 from "../../images/item-4.png";
import Item5 from "../../images/item-5.png";
import Item6 from "../../images/item-6.png";
import Dots from "../../images/dots-left.png";

const GettingStarted = () => {
  return (
    <div className="getting-started">
      <h2>Getting Started</h2>

      <div className="items-section">
        <div className="item">
          <img src={Item1} alt="Item" />
          <div className="card">
            <strong>1. Sign Up</strong>
            <p>
              Create your account. Then download the Tasker app to continue
              registration.
            </p>
          </div>
        </div>
        <div className="item">
          <img src={Item2} alt="Item" />
          <div className="card">
            <strong>2. Build your profile</strong>
            <p>Select what services you want to offer and where.</p>
          </div>
        </div>
        <div className="item">
          <img src={Item3} alt="Item" />
          <div className="card">
            <strong>3. Verify your eligibility to task</strong>
            <p>
              Confirm your identity and submit business verifications, as
              required.
            </p>
          </div>
        </div>
        <div className="item">
          <img src={Item4} alt="Item" />
          <div className="card">
            <strong>4. Pay registration fee</strong>
            <p>
              In applicable cities, we charge a $25 registration fee that helps
              us provide the best service to you.
            </p>
          </div>
        </div>
        <div className="item">
          <img src={Item5} alt="Item" />
          <div className="card">
            <strong>5. Set your schedule and work area</strong>
            <p>
              Set your weekly availability and opt in to receive same-day jobs.
            </p>
          </div>
        </div>
        <div className="item">
          <img src={Item6} alt="Item" />
          <div className="card">
            <strong>6. Start getting jobs</strong>
            <p>Grow your business on your own terms.</p>
          </div>
        </div>
      </div>

      <img src={Dots} className="started-dots" alt="Dots" />
    </div>
  );
};

export default GettingStarted;
