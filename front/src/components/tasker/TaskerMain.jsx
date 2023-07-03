import React, { useEffect, useRef, useState } from "react";

import SimpleHeader from "../basic/SimpleHeader";
import Footer from "../basic/Footer";
import FAQ from "./FAQ";
import Fingertips from "./Fingertips";
import GettingStarted from "./GettingStarted";
import TaskerHero from "./TaskerHero";
import Phone from "./Phone";
import Ready from "./Ready";
import What from "./What";
import Registration from "./Registration";

const TaskerMain = () => {
  const [step, setStep] = useState(1);

  const refRegis = useRef(null);

  const executeScroll = () => {
    refRegis.current.scrollIntoView({ block: "start" });
  };

  useEffect(() => {
    if (step > 1) {
      setTimeout(() => {
        executeScroll();
      }, 100);
    }
  }, [step]);

  return (
    <div>
      <SimpleHeader noBG={true} />
      <TaskerHero step={step} setStep={setStep} />
      <Phone />
      <Registration step={step} setStep={setStep} refRegis={refRegis} />
      <Fingertips />
      <What />
      <div className="tasker-wrapper">
        <GettingStarted />
        <FAQ />
        <Ready />
        <Footer />
      </div>
    </div>
  );
};

export default TaskerMain;
