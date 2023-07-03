import React from "react";
import ReactDOM from "react-dom/client";
import { HashRouter as Router, Routes, Route } from "react-router-dom";

import "./index.scss";

import ScrollToTop from "./components/reusable/ScrollToTop";
import App from "./App";
import AccessScreen from "./components/access/AccessScreen";
import LoginScreen from "./components/access/LoginScreen";
import SignupScreen from "./components/access/SignupScreen";
import TaskerMain from "./components/tasker/TaskerMain";
import TaskMain from "./components/task/TaskMain";
import ServicesMain from "./components/services/ServicesMain";
import LocationsMain from "./components/locations/LocationsMain";
import ChatMain from "./components/chat/ChatMain";
import { ApolloProvider } from "@apollo/client";
import {client } from "./config/apolloConfig";

const root = ReactDOM.createRoot(document.getElementById("root"));

root.render(
  <ApolloProvider client={client}>
  <React.StrictMode>
    <Router>
      <ScrollToTop />
      <Routes>
        <Route path="/" element={<App />} />

        <Route path="access" element={<AccessScreen />} />
        <Route path="login" element={<LoginScreen />} />
        <Route path="signup" element={<SignupScreen />} />

        <Route path="locations" element={<LocationsMain />} />
        <Route path="services" element={<ServicesMain />} />

        <Route path="task" element={<TaskMain />} />
        <Route path="tasker" element={<TaskerMain />} />

        <Route path="chat" element={<ChatMain />} />
      </Routes>
    </Router>
    </React.StrictMode>
    </ApolloProvider>
);
