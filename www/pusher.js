/*global cordova, module*/

const PusherBeamsCDV = {
  getRegistrationState: (successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "getRegistrationState", []);
  },

  start: (instanceId, successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "start", [instanceId]);
  },

  setUserId: (userId, successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "setUserId", [userId]);
  },
  clear: (successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "clear", []);
  },
};

module.exports = PusherBeamsCDV;
