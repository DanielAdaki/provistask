import React from "react";

import { Link } from "react-router-dom";

import Man from "../../images/home-community-man.png";
import Hammer from "../../images/home-community-hammer.png";

const Community = () => {
  return (
    <section className="section-community">
      <div className="text">
        <h2>Sign in and join our community</h2>
        <p>
          Veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex
          ea commodo consequat. Duis aute irure dolor in reprehenderit in
          voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur
          sint occaecat cupidatat non proident, sunt in culpa qui officia dese
        </p>
      </div>
      <div className="access">
        <img src={Hammer} alt="Hammer" className="hammer" />
        <img src={Man} alt="Man" className="man" />
        <div className="btn-container">
          <Link to={"/signup"}>Register as a Client</Link>
        </div>
      </div>
    </section>
  );
};

export default Community;
