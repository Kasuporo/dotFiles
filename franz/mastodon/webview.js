'use strict';

const path = require('path');

module.exports = Franz => {
  const getMessages = function getMessages() {
    const hasNotification = document.querySelectorAll(".SidebarTopNavLinks-notificationsButton--hasNewNotifications");
    let count = 0;
    if (hasNotification.length > 0) {
      count +=1;
    }

    // set Franz badge
    Franz.setBadge(count);
  };

  // inject franz.css stylesheet
  Franz.injectCSS(path.join(__dirname, 'service.css'));

  // check for new messages every second and update Franz badge
  Franz.loop(getMessages);
};
