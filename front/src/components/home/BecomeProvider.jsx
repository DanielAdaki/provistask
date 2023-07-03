import React from "react";
import { Link } from "react-router-dom";

import SureDude from "../../images/sure-dude.png";

const BecomeProvider = () => {
  return (
    <section className="become-provider">
      <img src={SureDude} alt="Sure" />
      <div className="text">
        <h2>Become a Provider</h2>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
          eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
          minim veniam, quis nostrud exercitation ullamco laboris nisi ut
          aliquip ex ea commodo consequat.
        </p>
        <p>
          Duis aute irure dolor in reprehenderit in voluptate velit esse cillum
          dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
          proident, sunt in culpa qui officia deserunt{" "}
        </p>
        <Link to={"/tasker"}>Send Form</Link>
      </div>
    </section>
  );
};

export default BecomeProvider;
