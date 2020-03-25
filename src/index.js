import './main.css';
import { Elm } from './Main.elm';

import iconPath from "./Resources/icon.png";
import margaretSmith from "./Resources/margaret_smith_55_f_lawyer.png";
import * as serviceWorker from './serviceWorker';

var storageKey = "aica_session";

function getStorageItems(jsonString) {
  if (jsonString == null) {
    var jsonObject = { "completed": [] };
    return jsonObject;
  } else {
    var jsonObject = JSON.parse(jsonString);
    return jsonObject;
  };
};

var app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    logo: iconPath,
    profiles: [
      { id: "margaret_smith_55_f_lawyer" , path: margaretSmith }
    ],
    storage: getStorageItems(localStorage.getItem(storageKey)),
  }
});

app.ports.cache.subscribe(function (data) {
  localStorage.setItem(storageKey, JSON.stringify(data));
})

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
