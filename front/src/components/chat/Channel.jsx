import React, { useEffect, useRef, useState } from "react";

import firebase from "firebase/compat/app";
import Message from "./Message";
import HammerBG from "../../images/hammer-bg.png";

import IconSend from "../../images/send.png";
import { sortIntoGroupsByDate } from "../../helpers/utilities";

const Avatar = "/back/provider-1.jpg";

const Channel = ({ user = null, db = null }) => {
  const [messages, setMessages] = useState([]);
  const [newMessage, setNewMessage] = useState("");
  const [sortedMessages, setSortedMessages] = useState([]);

  const { uid, displayName, photoURL } = user;

  useEffect(() => {
    if (db) {
      const unsubscribe = db
        .collection("messages")
        .orderBy("createdAt")
        .limit(100)
        .onSnapshot((querySnapshot) => {
          //Get all documents from collection - with IDs

          const data = querySnapshot.docs.map((doc) => ({
            ...doc.data(),
            id: doc.id,
          }));

          //Update state
          setMessages(data);
        });

      //Detach listener
      return unsubscribe;
    }
  }, [db]);

  const inputRef = useRef();
  const messagesRef = useRef();

  useEffect(() => {
    if (inputRef.current) {
      inputRef.current.focus();
    }
  }, [inputRef]);

  const handleOnChange = (e) => {
    setNewMessage(e.target.value);
  };

  const handleOnSubmit = (e) => {
    e.preventDefault();

    const trimmedMessage = newMessage.trim();

    if (db) {
      // Add new message in Firestore
      db.collection("messages").add({
        text: trimmedMessage,
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        uid,
        displayName,
        photoURL,
      });
      // Clear input field
      setNewMessage("");
    }
  };

  const scrollDown = () => {
    // Scroll down to the bottom of the list of messages
    messagesRef.current.scrollTop = messagesRef.current.scrollHeight;
  };

  const checkMessageAgain = () => {
    if (messages[messages.length - 1].createdAt) {
      setSortedMessages(sortIntoGroupsByDate(messages));
    } else {
      setTimeout(() => {
        checkMessageAgain();
      }, 100);
    }
  };

  useEffect(() => {
    scrollDown();

    if (messages.length > 0) {
      checkMessageAgain();
    }
    // eslint-disable-next-line
  }, [messages]);

  useEffect(() => {
    if (sortedMessages.length > 0) scrollDown();
  }, [sortedMessages]);

  return (
    <div className="channel">
      <img src={HammerBG} alt="BG" />
      <div className="header">
        <img src={Avatar} alt="Avatar" />
        <div className="text">
          <strong className="name">Dummy</strong>
          <p className="time">20:00</p>
        </div>
      </div>
      <div className="messages" ref={messagesRef}>
        {sortedMessages.map((block, index) => {
          return (
            <div className="block" key={index}>
              <strong>{block[0]}</strong>
              {block[1].map((msg) => {
                return (
                  <Message
                    key={msg.id}
                    {...msg}
                    userUID={uid}
                    scrollDown={scrollDown}
                  />
                );
              })}
            </div>
          );
        })}
      </div>
      <form onSubmit={handleOnSubmit}>
        <input
          ref={inputRef}
          type="text"
          value={newMessage}
          onChange={handleOnChange}
          placeholder="Type your message here..."
        />
        <button type="submit" disabled={!newMessage}>
          <img src={IconSend} alt="Send" />
        </button>
      </form>
    </div>
  );
};

export default Channel;
