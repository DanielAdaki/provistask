import React, { useEffect, useState } from "react";

const ProgressiveImg = ({ src, ...props }) => {
  const [imgSrc, setImgSrc] = useState("placeholder");

  useEffect(() => {
    const img = new Image();
    img.src = src;
    img.onload = () => {
      setImgSrc(src);
    };
  }, [src]);

  const customClass = imgSrc === "placeholder" ? "loading" : "loaded";

  return (
    <img
      {...{ src: imgSrc, ...props }}
      alt={props.alt || ""}
      className={`image ${customClass}`}
    />
  );
};

export default ProgressiveImg;
