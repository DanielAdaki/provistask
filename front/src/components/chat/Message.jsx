import React from "react";

const Message = ({
  createdAt = null,
  text = "",
  displayName = "",
  uid = "",
  userUID = "",
  scrollDown,
}) => {
  if (!text) return null;

  let elm;

  function isValidURL(u) {
    if (u !== "") {
      if (!elm) {
        elm = document.createElement("input");
        elm.setAttribute("type", "url");
      }
      elm.value = u;
      if (elm.validity.valid) {
        let ext = u.slice(-4);
        if (ext === ".png" || ext === ".gif" || ext === ".jpg") {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  return (
    <div className={`message ${userUID === uid ? "sender" : ""}`}>
      {isValidURL(text) ? (
        <img src={text} alt="url" minwidth="4rem" onLoad={scrollDown} />
      ) : (
        <p>{text}</p>
      )}

      {createdAt?.seconds ? (
        <span className="text-gray-500 text-xs">
          {`${new Date(createdAt.seconds * 1000).getHours()}:${new Date(
            createdAt.seconds * 1000
          ).getMinutes()}`}
        </span>
      ) : null}
    </div>
  );
};

export default Message;
