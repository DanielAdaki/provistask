import React, { useState } from "react";

import { Link, useNavigate } from "react-router-dom";

import SimpleHeader from "../basic/SimpleHeader";
import Footer from "../basic/Footer";

import Background from "../../images/signup-bg.jpg";
import Logo from "../../images/logo-horizontal.png";
import Help from "../../images/help.png";
import Check from "../../images/big-check-white.png";
import { useMutation } from "@apollo/client";
import { REGISTER_CLIENT } from "../../graphql/mutations/register_client";

const SignupScreen = () => {
  const [checked, setChecked] = useState(false);

  const handleCheckmark = () => {
    setChecked(!checked);
  };

  let name, lastName, phone, postalCode, email, password, confirmPassword;

  const [register] = useMutation(REGISTER_CLIENT);

  const navigate = useNavigate();

  return (
    <div id="signup">
      <SimpleHeader />

      <div className="background">
        <img src={Background} alt="Background" />
      </div>
      <div className="container">
        <div className="main">
          <img src={Logo} className="logo" alt="Logo" />
          <form
            action=""
            onSubmit={(e) => {
              e.preventDefault();
              if (
                name &&
                lastName &&
                phone &&
                postalCode &&
                email &&
                password &&
                confirmPassword &&
                checked
              ) {
                try {
                  register({
                    variables: {
                      username: name.value + lastName.value + postalCode.value,
                      email: email.value,
                      password: password.value,
                      name: name.value,
                      last_name: lastName.value,
                      phone: phone.value,
                      postal_code: postalCode.value,
                      token: "",
                    },
                  }).then((result) => {
                    navigate("/", { replace: true });
                  });
                } catch (e) {
                  console.log(e.networkError.result.errors);
                }
              } else {
                alert("Please fill out all fields");
              }
            }}
          >
            <input
              type="text"
              id="name"
              name="name"
              autoComplete="true"
              placeholder="First Name"
              ref={(input) => (name = input)}
            />
            <input
              type="text"
              id="lastname"
              name="lastname"
              autoComplete="true"
              placeholder="Last Name"
              ref={(input) => (lastName = input)}
            />
            <input
              type="text"
              id="phone"
              name="phone"
              placeholder="Phone Number"
              ref={(input) => (phone = input)}
            />
            <input
              type="text"
              id="postalCode"
              name="postalCode"
              placeholder="Postal Code"
              ref={(input) => (postalCode = input)}
            />
            <input
              type="email"
              id="email"
              name="email"
              autoComplete="true"
              placeholder="Email Address"
              ref={(input) => (email = input)}
            />
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              ref={(input) => (password = input)}
            />
            <input
              type="password"
              id="confirm-password"
              name="confirm-password"
              placeholder="Confirm Password"
              ref={(input) => (confirmPassword = input)}
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
                By clicking below and creating an account, I agree to
                ProviTask’s <Link to="#">Terms of Service</Link> and{" "}
                <Link to="#">Privacy Policy</Link>
              </label>
            </div>

            <input type="submit" value="Create Account" />
          </form>
        </div>

        <button className="help-btn">
          <img src={Help} className="help" alt="Help" />
          <span>Help!</span>
        </button>
      </div>
      <Footer className="up" />
    </div>
  );
};

export default SignupScreen;
