import React, { useEffect, useState } from "react";

import Feature1 from "../../images/feature-1.png";
import Feature2 from "../../images/feature-2.png";
import Feature3 from "../../images/feature-3.png";

const TaskProviderCard = ({
  profile,
  service,
  vehiclesData = [],
  nextProcess,
}) => {
  const [extended, setExtended] = useState(false);
  const [vehiclesNames, setVehiclesNames] = useState([]);
  const [completedTasks, setCompletedTasks] = useState(0);

  // console.log(vehiclesData);

  const {
    id,
    name,
    image_url,
    reliability,
    vehicles,
    online,
    description,
    services,
  } = profile;

  useEffect(() => {
    if (vehiclesData.length > 0) {
      let vehiclesArray = [];

      for (let i = 0; i < vehicles.length; i++) {
        for (let j = 0; j < vehiclesData.length; j++) {
          if (vehicles[i] === vehiclesData[j].id) {
            vehiclesArray.push(vehiclesData[j].name);
          }
        }
      }

      setVehiclesNames(vehiclesArray);
    }
    // eslint-disable-next-line
  }, [vehiclesData]);

  useEffect(() => {
    if (service) {
      // console.log(services);
      let num = 0;

      for (let i = 0; i < services.length; i++) {
        if (services[i].id === service.id) {
          // console.log(services[i].id);
          num = services[i].completed_tasks;
        }
      }

      // console.log(num);

      setCompletedTasks(num);
    }
    // eslint-disable-next-line
  }, [service]);

  const viewProfile = () => {
    alert("Profile ID: " + id);
  };

  const readMore = () => {
    setExtended(!extended);
  };

  return (
    <div className="task-provider-card">
      <div className="left">
        <img src={image_url} alt="PFP" />
        <div className="online-status">
          <span className={`online ${online ? "selected" : ""}`}>Online</span>
          <span className={`offline ${online ? "" : "selected"}`}>Offline</span>
        </div>
        <button className="profile" onClick={viewProfile}>
          View Profile
        </button>
        <p className="reminder">
          You can chat with your Provider, adjust task details or change task
          time after booking
        </p>
      </div>
      <div className="right">
        <strong>{name}</strong>
        <div className="feature">
          <div className="img-container">
            <img src={Feature1} alt="Check" />
          </div>
          <p>{`${completedTasks} ${service.name} tasks completed`}</p>
        </div>
        <div className="feature">
          <div className="img-container">
            <img src={Feature2} alt="Secure" />
          </div>
          <p>{reliability}% Reliable</p>
        </div>
        <div className="feature">
          <div className="img-container">
            <img src={Feature3} alt="Transport" />
          </div>
          <p>
            Vehicles:{" "}
            {vehiclesNames.length > 0 &&
              vehiclesNames.map((name, index) => {
                if (index === 0) {
                  return name;
                } else {
                  return ", " + name;
                }
              })}
          </p>
        </div>
        <div className="description">
          <strong>What can I do for you?</strong>
          <div className="text">
            <p className={extended ? "open" : ""}>{description}</p>
            <button
              className={`read-more ${extended ? "less" : "extended"}`}
              onClick={readMore}
            >
              Read {extended ? "less" : "more"}
            </button>
          </div>
        </div>
      </div>

      <button
        className="hire"
        onClick={() => {
          nextProcess(profile);
        }}
      >
        Hire
      </button>
    </div>
  );
};

export default TaskProviderCard;
