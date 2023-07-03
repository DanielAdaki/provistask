import React from "react";

import Woman from "../../images/woman-looking-at-mobile.png";
import Help from "../../images/help.png";

import IconList from "../../images/list.png";
import IconWorker from "../../images/worker.png";
import IconIdea from "../../images/idea.png";
import ProgressiveImg from "../reusable/ProgressiveImg";

const HowItWorks = () => {
  return (
    <section className="how-it-works">
      <ProgressiveImg src={Woman} alt="Woman" />
      <button className="help-btn">
        <img src={Help} className="help" alt="Help" />
        <span>Help!</span>
      </button>
      <div className="content">
        <h2>How ProviTask Works</h2>
        <div className="container">
          <div className="block">
            <div className="text">
              <h3>What do you need</h3>
              <p>
                Give us a description of what you need to do, when you want us
                to do your task, the particular characteristics and the place to
                do it.
              </p>
            </div>
            <div className="img-container">
              <img src={IconList} alt="List" />
            </div>
          </div>
          <div className="block">
            <div className="text">
              <h3>Choose a Provider</h3>
              <p>
                Identify the optimal professional according to your needs. The
                description in their profile will help you compare their prices,
                skills, and experience. Talk to them live through our chat.
              </p>
            </div>
            <div className="img-container">
              <img src={IconWorker} className="worker" alt="Worker" />
            </div>
          </div>
          <div className="block">
            <div className="text">
              <h3>Live Smarter</h3>
              <p>
                You will have no worries, your chosen professional will do the
                task, you will approve it with your recommendations and reviews,
                and you will pay safely through our platform.
              </p>
            </div>
            <div className="img-container">
              <img src={IconIdea} alt="Idea" />
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default HowItWorks;
