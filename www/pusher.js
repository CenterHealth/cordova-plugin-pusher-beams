/*global cordova, module*/

const PusherBeamsCDV = {
  getRegistrationState: (successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "getRegistrationState", []);
  },

  start: (instanceId, successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "start", [instanceId]);
  },

  setUserId: (tokenUrl, userId, authToken, successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "setUserId", [
      tokenUrl,
      userId,
      authToken,
    ]);
  },

  clear: (successCb, errorCb) => {
    cordova.exec(successCb, errorCb, "PusherBeams", "clear", []);
  },
};

module.exports = PusherBeamsCDV;
