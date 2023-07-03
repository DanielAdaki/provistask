import { useEffect, useState } from "react";

//Firebase deps
import firebase from "firebase/compat/app";
import "firebase/compat/auth";
import "firebase/compat/firestore";

// Components
import Button from "./Button";
import Channel from "./Channel";
import Loader from "./Loader";
import SimpleHeader from "../basic/SimpleHeader";
import UsersList from "./UsersList";

firebase.initializeApp({
  apiKey: "AIzaSyA6dwcJFkGG_n5Bf1dI0ygW25AozDn5Yys",
  authDomain: "test-7ce96.firebaseapp.com",
  projectId: "test-7ce96",
  storageBucket: "test-7ce96.appspot.com",
  messagingSenderId: "767297349111",
  appId: "1:767297349111:web:64cf512eae7459920a3af2",
});

const auth = firebase.auth();
const db = firebase.firestore();

const APIEndpointChat = "./api/chat.json";

function ChatMain() {
  const [user, setUser] = useState(() => auth.currentUser);
  const [initializing, setInitializing] = useState(true);

  const [users, setUsers] = useState([]);

  const fetchResources = async () => {
    const usersResponse = await fetch(APIEndpointChat, {
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    });

    const usersJSON = await usersResponse.json();

    setUsers(usersJSON);
    console.log(usersJSON);
  };

  useEffect(() => {
    fetchResources();
  }, []);

  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged((user) => {
      if (user) {
        setUser(user);
      } else {
        setUser(null);
      }
      if (initializing) {
        setInitializing(false);
      }
    });

    //Cleanup subscription
    return unsubscribe;
    // eslint-disable-next-line
  }, []);

  const signInWithGoogle = async () => {
    // Retrieve Google provider object
    const provider = new firebase.auth.GoogleAuthProvider();
    // Set language to the default browser preference
    auth.useDeviceLanguage();
    // Start sign in process
    try {
      await auth.signInWithPopup(provider);
    } catch (error) {
      console.error(error.message);
    }
  };

  const signOut = async () => {
    try {
      await firebase.auth().signOut();
    } catch (error) {
      console.log(error.message);
    }
  };

  if (initializing) return <Loader />;

  return (
    <>
      <SimpleHeader shadow={true} />
      <div className="chat-main">
        {user ? (
          <>
            <UsersList users={users}>
              <Button onClick={signOut}>Sign Out</Button>
            </UsersList>
            <Channel user={user} db={db} />
          </>
        ) : (
          <Button onClick={signInWithGoogle}>Sign In With Google</Button>
        )}
      </div>
    </>
  );
}

export default ChatMain;
