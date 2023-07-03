import React, { forwardRef, useEffect, useState } from "react";

import { sortIntoPieces } from "../../helpers/utilities";

import ChevronRight from "../../images/chevron-right.png";
import XW from "../../images/x-white.png";

const CarouselFile = forwardRef(({ imageURLs, deleteImage }, ref) => {
  const [imagesArray, setImagesArray] = useState([]);
  const [position, setPosition] = useState(0);
  const [maxPosition, setMaxPosition] = useState(0);

  useEffect(() => {
    if (imageURLs.length > 0) {
      setImagesArray(sortIntoPieces(imageURLs));
    } else {
      setImagesArray([]);
    }
  }, [imageURLs]);

  useEffect(() => {
    if (imagesArray.length > 0) {
      setMaxPosition(imagesArray.length - 1);
    }
  }, [imagesArray]);

  const goNext = () => {
    if (position < maxPosition) {
      setPosition(position + 1);
    }
  };
  const goBack = () => {
    if (position > 0) {
      setPosition(position - 1);
    }
  };

  return (
    <div className="carousel" ref={ref}>
      <button
        className={`carousel-btn left ${position === 0 ? "hidden" : ""}`}
        onClick={goBack}
      >
        <img src={ChevronRight} className="rotated" alt="Back" />
      </button>
      <div className="carousel-container">
        <div className="inner-container">
          {imagesArray &&
            imagesArray.map((group, index) => {
              return (
                <div
                  className={`group`}
                  style={{ transform: `translateX(-${100 * position}%)` }}
                  key={"g" + index}
                >
                  {group.map((imgURL, index) => {
                    return (
                      <div
                        className="img-container"
                        key={imgURL.preview + index}
                      >
                        <button
                          onClick={() => {
                            console.log(imgURL.file.name);
                            deleteImage(imgURL.file);
                          }}
                        >
                          <img src={XW} alt="X" />
                        </button>
                        <img src={imgURL.preview} alt={"Preview " + index} />
                      </div>
                    );
                  })}
                </div>
              );
            })}
        </div>
      </div>
      <button
        className={`carousel-btn right  ${
          position === maxPosition ? "hidden" : ""
        }`}
        onClick={goNext}
      >
        <img src={ChevronRight} alt="Next" />
      </button>
    </div>
  );
});

export default CarouselFile;
