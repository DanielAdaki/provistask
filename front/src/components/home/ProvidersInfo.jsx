import React from "react";

import Plumbing from "../../images/plumbing.png";

const ProvidersInfo = () => {
  return (
    <section className="providers-info">
      <div className="container">
        <div className="left">
          <h2>Providers</h2>
          <p>
            ProviTask is very pleased to have a group of professionals with
            verified backgrounds who provide a myriad of services to our
            satisfied customers. If you want to grow your business with the free
            possibility to increase your portfolio of potential clients, sign up
            with us today.
          </p>
          <p>
            You will have an interactive platform with a real-time communication
            system, and you will be able to position yourself according to the
            quality of the performance of your tasks or other indicators that we
            have in your favor.
          </p>

          <button>Read More</button>
        </div>
        <img src={Plumbing} alt="Plumbing" />
      </div>
    </section>
  );
};

export default ProvidersInfo;
