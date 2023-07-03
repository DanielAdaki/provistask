import React, { useState } from "react";
import { Link } from "react-router-dom";

import EEUU from "../../images/eeuu.png";
import Check from "../../images/big-check-white.png";
import Logo from "../../images/logo-house.png";

import CheckCircle from "../../images/check-circle.png";
import AppStore from "../../images/app-store-badge.png";
import PlayStore from "../../images/google-play-badge.png";
import { REGISTER_CLIENT } from "../../graphql/mutations/register_client";
import { useMutation } from "@apollo/client";

const Registration = ({ step, setStep, refRegis }) => {
  const [checked, setChecked] = useState(false);

  let name, lastName, phone, postalCode, email, password;

  const [register] = useMutation(REGISTER_CLIENT);
  const handleClick = (e) => {
    e.preventDefault();

    if (step === 2) {
      setStep(3);
    }
  };

  const handleCheckmark = () => {
    setChecked(!checked);
  };

  return (
    <>
      {step > 1 && (
        <div className="registration" ref={refRegis}>
          <div className="step-2">
            <div className="container">
              <form
                onSubmit={(e) => {
                  e.preventDefault();
                  if (
                    name &&
                    lastName &&
                    phone &&
                    postalCode &&
                    email &&
                    password &&
                    checked
                  ) {
                    try {
                      register({
                        variables: {
                          username:
                            name.value + lastName.value + postalCode.value,
                          email: email.value,
                          password: password.value,
                          name: name.value,
                          last_name: lastName.value,
                          phone: phone.value,
                          postal_code: postalCode.value,
                          token: "",
                        },
                      }).then((result) => {
                        console.log(result);
                      });
                    } catch (e) {
                      console.log(e.networkError.result.errors);
                    }
                  } else {
                    alert("Please fill out all fields");
                  }
                }}
              >
                <label htmlFor="tasker-email">E-Mail Address</label>
                <input
                  type="email"
                  id="tasker-email"
                  placeholder="Mat1998.D@gmail.com"
                  ref={(input) => (email = input)}
                />
                <label htmlFor="firstName">First Name</label>
                <input
                  type="text"
                  id="firstname"
                  placeholder="Mateo"
                  ref={(input) => (name = input)}
                />
                <label htmlFor="lastName">Last Name</label>
                <input
                  type="text"
                  id="lastName"
                  placeholder="Gómez"
                  ref={(input) => (lastName = input)}
                />
                <label htmlFor="names">Phone Number</label>
                <div className="phone-number-container">
                  <div className="code">
                    <img src={EEUU} alt="flag" />
                    <span>+1</span>
                  </div>
                  <input
                    type="tel"
                    id="number"
                    placeholder="3340198"
                    ref={(input) => (phone = input)}
                  />
                </div>
                <label htmlFor="zip">Zip Code</label>
                <input
                  type="text"
                  id="zip"
                  placeholder="33015"
                  ref={(input) => (postalCode = input)}
                />
                <label htmlFor="tasker-password">Password</label>
                <input
                  type="password"
                  id="tasker-password"
                  placeholder="1234567890"
                />
                <div className="checkmark-area" onClick={handleCheckmark}>
                  <input
                    type="checkbox"
                    name="checkbox"
                    id="checkbox"
                    checked={checked}
                    readOnly
                  />
                  <div className={`checkbox ${checked ? "checked" : ""}`}>
                    <img src={Check} alt="Check" />
                  </div>
                  <label>
                    By registering, you accept our
                    <Link to="#"> terms of use</Link> and our{" "}
                    <Link to="#">privacy policy</Link>
                  </label>
                </div>
                <p className="already-have">
                  Do you already have an account?{" "}
                  <Link to="/login"> Log In</Link>
                </p>

                <button
                  className="create"
                  onClick={(e) => {
                    handleClick(e);
                  }}
                >
                  Create
                </button>
              </form>
            </div>
          </div>

          <div className="step-3">
            {step === 2 ? (
              <div className="incomplete">
                <img src={Logo} alt="Logo" />

                <strong>Make sure you fill </strong>
                <strong>in all the blanks</strong>

                <p>In order to become a provider</p>
              </div>
            ) : (
              <div className="complete">
                <img src={CheckCircle} alt="Check" />

                <h2>Account Created</h2>
                <span>Next steps</span>
                <p>1. Download the ProviTask app and sign in to your account</p>
                <div className="stores">
                  <img src={PlayStore} alt="PlayStore" />
                  <img src={AppStore} alt="AppStore" />
                </div>
                <p>2. Complete and submit your profile for verification</p>
                <p>3. Once it's approved, start earning money your way!</p>
              </div>
            )}
          </div>
        </div>
      )}
    </>
  );
};

export default Registration;
