import React from "react";

import { Link, useNavigate } from "react-router-dom";

import SimpleHeader from "../basic/SimpleHeader";
import Footer from "../basic/Footer";

import Background from "../../images/login-bg.jpg";
import Help from "../../images/help.png";
import Logo from "../../images/logo-horizontal.png";

import LogoGoogle from "../../images/google-plus.png";
import LogoFacebook from "../../images/logo-facebook.png";
import LogoApple from "../../images/apple.png";
import { useMutation } from "@apollo/client";
import { LOGIN_MUTATION } from "../../graphql/mutations/login_mutation";
// import Check from "../../images/login-check.png";

const LoginScreen = () => {
  let email, password;
  const navigate = useNavigate();
  const [login] = useMutation(LOGIN_MUTATION);
  return (
    <div id="login">
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
              if (email && password) {
                try {
                  login({
                    variables: {
                      email: email.value,
                      password: password.value,
                    },
                  }).then((result) => {
                    if (result["data"]["login"]["user"]["email"] == email) {
                      navigate("/", { replace: true });
                    }
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
              type="email"
              id="email"
              name="email"
              autoComplete="true"
              placeholder="Email address"
              ref={(input) => (email = input)}
            />
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              ref={(input) => (password = input)}
            />

            <Link to="#" className="forget">
              Did you forget your password?
            </Link>

            <input type="submit" value="Log In" />
          </form>

          <button className="hot-login">
            <img src={LogoGoogle} alt="Google" />
            <span>Continue with google</span>
          </button>
          <button className="hot-login">
            <img src={LogoFacebook} alt="Facebook" />
            <span>Continue with Facebook</span>
          </button>
          <button className="hot-login">
            <img src={LogoApple} alt="Apple" />
            <span>Continue with Apple</span>
          </button>
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

export default LoginScreen;
