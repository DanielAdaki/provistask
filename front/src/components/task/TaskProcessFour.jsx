import React, { useState } from "react";

import { useNavigate } from "react-router-dom";

import Crads from "../../images/cards.png";
import USA from "../../images/eeuu.png";
import ShieldOrange from "../../images/shield-orange.png";
import Calendar from "../../images/calendar.png";
import Marker from "../../images/gps-marker-white.png";
import Clock from "../../images/clock.png";
import Car from "../../images/car-white.png";
import Pen from "../../images/pen.png";

const TaskProcessFour = ({
  variableSetOne,
  variableSetTwo,
  selectedProviderProfile,
  service,
  location,
  editProcess,
}) => {
  const [editModeActivated, setEditModeActivated] = useState(false);

  const navigate = useNavigate();

  const toggleEditMode = () => {
    setEditModeActivated(!editModeActivated);
  };

  const FINISH = () => {
    alert("Confirmed!");
  };
  const goToChat = () => {
    // navigate(`/chat/${selectedProviderProfile.id}`);
    navigate(`/chat`);
  };

  return (
    <div className="task-process-four">
      <div className="left">
        <div className="container">
          <h2>Review your task description</h2>
          <p className="description">{variableSetOne.taskDetail}</p>
          <h2>Payment Method</h2>
          <p>
            A temporary hold on the amount of your Provider's rate may appear on
            your payment method. Don't worry, you'll only be charged once your
            task is finished.
          </p>
          <button className="card-btn">
            <img src={Crads} alt="Crads" />
            <p>Card Number</p>
            <p>MM/YY CVC</p>
          </button>
          <hr className="separator" />
          <div className="number-container">
            <button>
              <img src={USA} alt="Flag" />
              <span>+1</span>
            </button>
            <input type="tel" />
          </div>
        </div>
        <div className="safe-reminder">
          <img src={ShieldOrange} alt="shield" />
          <p>
            Please verify that your task adheres with all public health rules
            and legislation in force in your region to safeguard your community.
          </p>
        </div>

        <p className="reminder">
          Don't worry, you won't be charged until your task is finished. Once
          verified, you can update details by chatting with your Provider.
        </p>

        <button className="confirm" onClick={FINISH}>
          Confirm
        </button>
      </div>

      <div className="right">
        <div className="profile">
          <img src={selectedProviderProfile.image_url} alt="PFP" />
          <div className="text">
            <strong>{service.name}</strong>
            <p>{selectedProviderProfile.name}</p>
          </div>
        </div>
        <div className="elements-cont">
          <div className="element">
            <div className="img-container">
              <img src={Calendar} alt="Calendar" />
            </div>
            {editModeActivated ? (
              <button
                className="edit-btn"
                onClick={() => {
                  editProcess(1);
                }}
              >
                Edit time and date
              </button>
            ) : (
              <>
                <p>{`${variableSetTwo.month} ${variableSetTwo.day}, ${variableSetTwo.hour}:00${variableSetTwo.sufix}`}</p>
              </>
            )}
          </div>
          <div className="element">
            <div className="img-container">
              <img src={Marker} alt="Marker" />
            </div>
            {editModeActivated ? (
              <button
                className="edit-btn"
                onClick={() => {
                  editProcess(2);
                }}
              >
                Edit address
              </button>
            ) : (
              <>
                <p>{`${location.city}, ${location.state}`}</p>
              </>
            )}
          </div>
          <div className="element">
            <div className="img-container clock">
              <img src={Clock} alt="Clock" />
            </div>
            {editModeActivated ? (
              <button
                className="edit-btn"
                onClick={() => {
                  editProcess(3);
                }}
              >
                Edit task duration
              </button>
            ) : (
              <>
                <p>
                  {variableSetOne.durationOption === 1
                    ? "Small - Est. 1 hr"
                    : variableSetOne.durationOption === 2
                    ? "Medium - Est. 2 - 4 hr"
                    : "Large - Est. 5+ hr"}
                </p>
              </>
            )}
          </div>

          <div className="element">
            <div className="img-container">
              <img src={Car} alt="Car" />
            </div>
            {editModeActivated ? (
              <button
                className="edit-btn"
                onClick={() => {
                  editProcess(4);
                }}
              >
                Edit transport needed
              </button>
            ) : (
              <>
                <p>
                  {variableSetOne.transportationOption === 1
                    ? "Motorcycle"
                    : variableSetOne.transportationOption === 2
                    ? "Car"
                    : variableSetOne.transportationOption === 3
                    ? "Truck"
                    : "No needed for task"}
                </p>
              </>
            )}
          </div>
          <button className="element" onClick={toggleEditMode}>
            <div className="img-container ">
              <img src={Pen} alt="Pen" />
            </div>
            <p>{editModeActivated ? "Cancel" : "Edit Task"}</p>
          </button>
        </div>

        <button className="chat" onClick={goToChat}>
          Chat & Confirm Price
        </button>
      </div>
    </div>
  );
};

export default TaskProcessFour;
