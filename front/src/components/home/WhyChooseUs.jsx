import React from "react";

import Check from "../../images/check.png";
import WhyDude from "../../images/why-dude.png";

const WhyChooseUs = () => {
  return (
    <section className="why-choose-us">
      <div className="container">
        <h2>Why Choose Us?</h2>
        <div className="content">
          <div className="block">
            <img src={Check} alt="Checkmark" />
            <div className="text">
              <strong>Meet new customers</strong>
              <p>
                Through our interactive platform, you will have the possibility
                to meet various professionals you need to perform any task in
                your home or work.
              </p>
            </div>
          </div>
          <div className="block">
            <img src={Check} alt="Checkmark" />
            <div className="text">
              <strong>Grow your revenue</strong>
              <p>
                As a client, you can grow your income by not having to spend
                time doing complicated tasks outside your work environment.
              </p>
            </div>
          </div>
          <div className="block">
            <img src={Check} alt="Checkmark" />
            <div className="text">
              <strong>Build your online reputation</strong>
              <p>
                You will be able to qualify your professionals taking into
                account effective communication, responsibility with the
                requested task and the quality of the work carried out.
              </p>
            </div>
          </div>
        </div>
      </div>
      <img src={WhyDude} alt="Why" />
    </section>
  );
};

export default WhyChooseUs;
