import React, { useEffect, useRef, useState } from "react";

import CarouselFile from "../reusable/CarouselFile";

import GPSMarker from "../../images/gps-marker.png";
import Clock from "../../images/clock.png";
import Pen from "../../images/pen.png";
import Motorcycle from "../../images/motorcycle.png";
import MotorcycleW from "../../images/motorcycle-white.png";
import Car from "../../images/car.png";
import CarW from "../../images/car-white.png";
import Truck from "../../images/truck.png";
import TruckW from "../../images/truck-white.png";
import X from "../../images/x.png";
import XW from "../../images/x-white.png";
import Pic from "../../images/pic.png";

const TaskProcessOne = ({
  service,
  location,
  setLocation,
  locations,
  step,
  setStep,
  setProcess,
  variableSetOne,
}) => {
  const [addressIsReady, setAddressIsReady] = useState(false);

  const [durationIsReady, setDurationIsReady] = useState(false);

  const [transportationIsReady, setTransportationIsReady] = useState(false);

  const [taskDetailIsReady, setTaskDetailIsReady] = useState(false);

  const [filesReady, setFilesReady] = useState(false);
  const [imageURLs, setImageURLs] = useState([]);

  const previewCarousel = useRef(null);

  const nextStep = (num) => {
    if (num === 1) {
      if (variableSetOne.address !== "") {
        if (step === 1) {
          setStep(step + 1);
        }
        setAddressIsReady(true);
      }
    } else if (num === 2) {
      if (variableSetOne.durationOption !== 0) {
        if (step === 2) {
          setStep(step + 1);
        }
        setDurationIsReady(true);
      }
    } else if (num === 3) {
      if (variableSetOne.transportationOption !== 0) {
        if (step === 3) {
          setStep(step + 1);
        }
        setTransportationIsReady(true);
      }
    } else if (num === 4) {
      if (variableSetOne.taskDetail !== "") {
        if (step === 4) {
          setStep(step + 1);
        }
        setTaskDetailIsReady(true);
      }
    }
  };
  const nextProcess = () => {
    window.scrollTo({ top: 0, behavior: "smooth" });

    setTimeout(() => {
      setProcess(2);
    }, 600);
  };

  const editLocation = () => {
    setAddressIsReady(false);
    variableSetOne.setAddress("");
    setInputValue("");
  };
  const editDuration = () => {
    setDurationIsReady(false);
  };
  const editTransportation = () => {
    setTransportationIsReady(false);
  };
  const editTaskDetails = () => {
    setTaskDetailIsReady(false);
  };

  /*


  const updateAddress = (e) => {
    variableSetOne.setAddress(e.target.value);
  };





*/

  //Step 1

  const [inputValue, setInputValue] = useState("");
  const [sortedLocations, setSortedLocations] = useState([]);

  const updateInputLocationValue = (e) => {
    setInputValue(e.target.value);
  };

  const handleBlur = () => {
    setTimeout(() => {
      setSortedLocations([]);
    }, 100);
  };

  const handleFocus = () => {
    sortByValue();
  };

  const [easyLocations, setEasyLocations] = useState([]);

  useEffect(() => {
    if (locations.length > 0) {
      // console.log(locations);

      let tempArray = [];

      for (let i = 0; i < locations.length; i++) {
        for (let j = 0; j < locations[i].cities.length; j++) {
          // console.log(locations[i].cities[j]);
          let city = locations[i].cities[j].name;
          let state = locations[i].state;

          tempArray.push({ city, state });
        }
      }

      // console.log(tempArray);
      setEasyLocations(tempArray);
    }
  }, [locations]);

  const sortByValue = () => {
    if (easyLocations.length > 0) {
      let sortedArray = easyLocations.filter((location) => {
        if (location.state.toLowerCase().includes(inputValue.toLowerCase())) {
          return true;
        } else if (
          location.city.toLowerCase().includes(inputValue.toLowerCase())
        ) {
          return true;
        } else {
          return false;
        }
      });

      // console.log(sortedArray);
      setSortedLocations(sortedArray);
    }
  };

  const updateLocation = (location) => {
    setInputValue(`${location.city}, ${location.state}`);
    setLocation(location);
    variableSetOne.setAddress(`${location.city}, ${location.state}`);
  };

  useEffect(() => {
    // console.log(locations);
    sortByValue();

    // eslint-disable-next-line
  }, [inputValue]);

  useEffect(() => {
    if (location) {
      updateLocation(location);
    }
  }, [location]);

  /*







  */

  const changeDuration = (option) => {
    variableSetOne.setDurationOption(option);
  };
  const changeTransportation = (option) => {
    variableSetOne.setTransportationOption(option);
  };
  const changeTaskDetails = (e) => {
    variableSetOne.setTaskDetail(e.target.value);
  };

  const addFile = (e) => {
    const input = e.target;
    let newFiles = [];

    for (let i = 0; i < input.files.length; i++) {
      newFiles.push(input.files[i]);
    }

    if (variableSetOne.files.length === 0) {
      variableSetOne.setFiles(newFiles);
    } else {
      variableSetOne.setFiles([...variableSetOne.files, ...newFiles]);
    }
  };

  const deleteImage = (file) => {
    let newFiles = variableSetOne.files.filter((f) => f.name !== file.name);

    variableSetOne.setFiles(newFiles);
  };

  const clearURLs = () => {
    for (let i = 0; i < imageURLs.length; i++) {
      URL.revokeObjectURL(imageURLs[i]);
    }
  };

  useEffect(() => {
    if (variableSetOne.files.length > 0) {
      setFilesReady(true);
    } else {
      setFilesReady(false);
    }

    let previewsURLs = [];

    for (let i = 0; i < variableSetOne.files.length; i++) {
      let preview = URL.createObjectURL(variableSetOne.files[i]);
      let file = variableSetOne.files[i];
      previewsURLs.push({ preview, file });
    }

    clearURLs();
    setImageURLs(previewsURLs);
    // eslint-disable-next-line
  }, [variableSetOne.files]);

  return (
    <div
      className="task-process-one"
      style={{ maxHeight: 1200 + 100 * step * step + "px" }}
    >
      <h2>{service.name}</h2>

      <div className="steps-counter">
        <div className={`counter ${step > 0 ? "completed" : ""}`}>
          <strong>1</strong>
          <p>Your task location</p>
        </div>
        <div className={`counter ${step > 1 ? "completed" : ""}`}>
          <strong>2</strong>
          <p>How long is your task?</p>
        </div>
        <div className={`counter ${step > 2 ? "completed" : ""}`}>
          <strong>3</strong>
          <p>Any kind of transportation?</p>
        </div>
        <div className={`counter ${step > 3 ? "completed" : ""}`}>
          <strong>4</strong>
          <p>Tell us the details of your task</p>
        </div>
        <div className={`counter ${step > 4 ? "completed" : ""}`}>
          <strong>5</strong>
          <p>Show us more about your task</p>
        </div>
      </div>

      <div className="step step-1 visible">
        <h3>Your task location</h3>

        <div className="card">
          <div className={`incomplete  ${addressIsReady ? "hide" : ""}`}>
            <div className="input">
              <input
                type="text"
                className="address"
                placeholder="Enter your task location"
                value={inputValue}
                onChange={(e) => {
                  updateInputLocationValue(e);
                }}
                onBlur={handleBlur}
                onFocus={handleFocus}
              />
              <input
                className="unit"
                type="text"
                placeholder="Unit or Apt #"
              ></input>

              {sortedLocations.length > 0 && (
                <div className="locations">
                  {sortedLocations.map((location, index) => {
                    return (
                      <span
                        key={location.city + index}
                        onClick={() => {
                          updateLocation(location);
                        }}
                      >
                        {`${location.city}, ${location.state}`}
                      </span>
                    );
                  })}
                </div>
              )}
            </div>
            <button
              className="continue"
              onClick={() => {
                nextStep(1);
              }}
            >
              Continue
            </button>
            <div className="label"></div>
          </div>
          <div className={`complete ${!addressIsReady ? "hide" : ""}`}>
            <button className="edit" onClick={editLocation}>
              <img src={Pen} alt="Edit" />
            </button>
            <span>The location of your task</span>
            <div className="location">
              <img src={GPSMarker} alt="Marker" />
              <strong>{`${location.city}, ${location.state}, EE.UU.`}</strong>
            </div>
            <p>Good news! Provitask is available in your area.</p>
          </div>
        </div>
      </div>

      <div className={`step step-2 ${step > 1 ? "visible" : ""}`}>
        <h3>How long is your task?</h3>
        <div className="card">
          <div className={`incomplete  ${durationIsReady ? "hide" : ""}`}>
            <span>Select the duration that your task requires</span>

            <div className="selection-area">
              <button
                className="option"
                onClick={() => {
                  changeDuration(1);
                }}
              >
                <div
                  className={`mark ${
                    variableSetOne.durationOption === 1 ? "selected" : ""
                  }`}
                ></div>
                <span>Small - Est. 1 hr</span>
              </button>
              <button
                className="option"
                onClick={() => {
                  changeDuration(2);
                }}
              >
                <div
                  className={`mark ${
                    variableSetOne.durationOption === 2 ? "selected" : ""
                  }`}
                ></div>
                <span>Medium - Est. 2 - 4 hr</span>
              </button>
              <button
                className="option"
                onClick={() => {
                  changeDuration(3);
                }}
              >
                <div
                  className={`mark ${
                    variableSetOne.durationOption === 3 ? "selected" : ""
                  }`}
                ></div>
                <span>Large - Est. 5+ hr</span>
              </button>
            </div>

            <button
              className="continue"
              onClick={() => {
                nextStep(2);
              }}
            >
              Continue
            </button>
          </div>

          <div className={`complete ${!durationIsReady ? "hide" : ""}`}>
            <button className="edit" onClick={editDuration}>
              <img src={Pen} alt="Edit" />
            </button>

            <img src={Clock} alt="Marker" />
            <strong>
              {variableSetOne.durationOption === 1
                ? "Small - Est. 1hr"
                : variableSetOne.durationOption === 2
                ? "Medium - Est. 2 - 4 hr"
                : "Large - Est. 5+ hr"}
            </strong>
          </div>
        </div>
      </div>

      <div className={`step step-3 ${step > 2 ? "visible" : ""}`}>
        <h3>Any kind of transportation?</h3>
        <div className="card">
          <div className={`incomplete  ${transportationIsReady ? "hide" : ""}`}>
            <span>Select the type of transportation your task requires</span>

            <div className="selection-area">
              <button
                className="option"
                onClick={() => {
                  changeTransportation(1);
                }}
              >
                <div
                  className={`mark ${
                    variableSetOne.transportationOption === 1 ? "selected" : ""
                  }`}
                ></div>
                <span>Motorcycle</span>
              </button>
              <button
                className="option"
                onClick={() => {
                  changeTransportation(2);
                }}
              >
                <div
                  className={`mark ${
                    variableSetOne.transportationOption === 2 ? "selected" : ""
                  }`}
                ></div>
                <span>Car</span>
              </button>
              <button
                className="option"
                onClick={() => {
                  changeTransportation(3);
                }}
              >
                <div
                  className={`mark ${
                    variableSetOne.transportationOption === 3 ? "selected" : ""
                  }`}
                ></div>
                <span>Truck</span>
              </button>
              <button
                className="option"
                onClick={() => {
                  changeTransportation(4);
                }}
              >
                <div
                  className={`mark ${
                    variableSetOne.transportationOption === 4 ? "selected" : ""
                  }`}
                ></div>
                <span>Not needed</span>
              </button>
            </div>

            <button
              className="continue"
              onClick={() => {
                nextStep(3);
              }}
            >
              Continue
            </button>
          </div>

          <div className={`complete ${!transportationIsReady ? "hide" : ""}`}>
            <button className="edit" onClick={editTransportation}>
              <img src={Pen} alt="Edit" />
            </button>

            <div className="option">
              <div
                className={`img-container ${
                  variableSetOne.transportationOption === 1 ? "selected" : ""
                }`}
              >
                <img
                  src={
                    variableSetOne.transportationOption === 1
                      ? MotorcycleW
                      : Motorcycle
                  }
                  alt="Option"
                />
              </div>
              <p>Motorcycle</p>
            </div>
            <div className="option">
              <div
                className={`img-container ${
                  variableSetOne.transportationOption === 2 ? "selected" : ""
                }`}
              >
                <img
                  src={variableSetOne.transportationOption === 2 ? CarW : Car}
                  alt="Option"
                />
              </div>
              <p>Car</p>
            </div>
            <div className="option">
              <div
                className={`img-container ${
                  variableSetOne.transportationOption === 3 ? "selected" : ""
                }`}
              >
                <img
                  src={
                    variableSetOne.transportationOption === 3 ? TruckW : Truck
                  }
                  alt="Option"
                />
              </div>
              <p>Truck</p>
            </div>
            <div className="option">
              <div
                className={`img-container ${
                  variableSetOne.transportationOption === 4 ? "selected" : ""
                }`}
              >
                <img
                  src={variableSetOne.transportationOption === 4 ? XW : X}
                  alt="Option"
                />
              </div>
              <p>Not needed</p>
            </div>
          </div>
        </div>
      </div>

      <div className={`step step-4 ${step > 3 ? "visible" : ""}`}>
        <h3>Tell us the details of your task</h3>
        <div className="card">
          <div className={`incomplete  ${taskDetailIsReady ? "hide" : ""}`}>
            <span>
              Tell us in more detail what you need to do, how: space, how to get
              to the place or other information so that ProviTask can show you
              the most appropriate professionals for your needs.
            </span>

            <span>
              If you need two or more providers please post additional Tasks for
              each provider needed.
            </span>

            <textarea
              name="details"
              id="task-details"
              cols="30"
              rows="10"
              placeholder="Write here"
              value={variableSetOne.taskDetail}
              onChange={(e) => {
                changeTaskDetails(e);
              }}
            ></textarea>

            <button
              className="continue"
              onClick={() => {
                nextStep(4);
              }}
            >
              Continue
            </button>
          </div>

          <div className={`complete ${!taskDetailIsReady ? "hide" : ""}`}>
            <button className="edit" onClick={editTaskDetails}>
              <img src={Pen} alt="Edit" />
            </button>

            <span>
              Tell us in more detail what you need to do, how: space, how to get
              to the place or other information so that ProviTask can show you
              the most appropriate professionals for your needs.
            </span>

            <span>
              If you need two or more providers please post additional Tasks for
              each provider needed.
            </span>

            <p className="detail">{variableSetOne.taskDetail}</p>
          </div>
        </div>
      </div>

      <div className={`step step-5 ${step > 4 ? "visible" : ""}`}>
        <h3>Show us more about your task</h3>
        <div className="card">
          <span>
            Add images showing more details of your task to make it easier for
            the provider to understand what you need.
          </span>

          <label htmlFor="file">
            <img src={Pic} alt="Pic" />
          </label>
          <input
            type="file"
            name="file"
            id="file"
            multiple
            accept="image/*"
            onChange={addFile}
          />
        </div>

        <CarouselFile
          ref={previewCarousel}
          imageURLs={imageURLs}
          deleteImage={deleteImage}
        ></CarouselFile>
      </div>

      <button
        className={`next-process ${step > 4 ? "visible" : ""}`}
        disabled={
          filesReady &&
          taskDetailIsReady &&
          transportationIsReady &&
          durationIsReady &&
          addressIsReady
            ? false
            : true
        }
        onClick={nextProcess}
      >
        See Providers & Prices
      </button>
    </div>
  );
};

export default TaskProcessOne;
