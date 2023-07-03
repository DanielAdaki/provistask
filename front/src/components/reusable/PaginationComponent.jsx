import React, { useEffect, useState } from "react";

import TaskProviderCard from "../task/TaskProviderCard";
import Chevron from "../../images/chevron-right.png";

const PaginationComponent = ({
  sortedData = [],
  service,
  vehiclesData,
  screen,
  executeScroll,
  nextProcess,
}) => {
  const [position, setPosition] = useState(0);
  const [maxPosition, setMaxPosition] = useState(1);
  const [simpleArray, setSimpleArray] = useState([]);

  useEffect(() => {
    setMaxPosition(sortedData.length - 1);
    setSimpleArray([...Array(sortedData.length).keys()]);
  }, [sortedData]);

  const scrollTime = 300;

  const goNext = () => {
    if (position < maxPosition) {
      executeScroll();

      setTimeout(() => {
        setPosition(position + 1);
      }, scrollTime);
    }
  };
  const goBack = () => {
    if (position > 0) {
      executeScroll();

      setTimeout(() => {
        setPosition(position - 1);
      }, scrollTime);
    }
  };

  const goTo = (position) => {
    executeScroll();

    setTimeout(() => {
      setPosition(position);
    }, scrollTime);
  };

  return (
    <div className="pagination-component">
      {sortedData.length > 0 && (
        <div
          className="container"
          style={{
            maxHeight: sortedData[position].length * 38 + "rem",
          }}
        >
          {sortedData.map((group, index) => {
            return (
              <div
                className={`group`}
                style={{ transform: `translateX(-${100 * position}%)` }}
                key={index}
              >
                {group.map((profile, index) => {
                  return (
                    <TaskProviderCard
                      profile={profile}
                      key={profile.id}
                      service={service}
                      vehiclesData={vehiclesData}
                      nextProcess={nextProcess}
                    />
                  );
                })}
              </div>
            );
          })}
        </div>
      )}

      <div className="controls">
        <button
          className={`previous ${position === 0 ? "disabled" : ""}`}
          disabled={position === 0 ? true : false}
          onClick={goBack}
        >
          <img src={Chevron} className="left" alt="Chevron" />
          <p>Previous</p>
        </button>
        <div className="numbers">
          {simpleArray.map((el, index) => {
            return (
              <span
                className={position === index ? "active" : ""}
                onClick={() => {
                  goTo(index);
                }}
                key={index + 1}
              >
                {index + 1}
              </span>
            );
          })}
        </div>
        <button
          className={`next ${position === maxPosition ? "disabled" : ""}`}
          disabled={position === maxPosition ? true : false}
          onClick={goNext}
        >
          <p>Next</p>
          <img src={Chevron} alt="Chevron" />
        </button>
      </div>
    </div>
  );
};

export default PaginationComponent;
